---
title: "How We Modularized Medium’s iOS codebase"
date: 2014-05-14 17:16:21.719 +0000 UTC
author: "Vinícius Baggio Fuentes"

---

## How We Modularized Medium’s iOS codebase

#### Without interrupting workflow

After we launched [the Medium iOS app](https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;ved=0CCYQFjAA&amp;url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmedium-everyones-stories%2Fid828256236%3Fmt%3D8&amp;ei=4_1jU_2_HofdoATTloDgDw&amp;usg=AFQjCNHTPTN0Z7t0v86FYYrF32Q57oE_UA&amp;bvm=bv.65788261,d.cGU), we wanted to make it easy for any engineer in the company to quickly experiment with, and contribute to, the codebase. Having a more modular codebase enables us to experiment more: for example, we could spin up a prototype that has the same core components for authentication and downloading posts, but explores different navigation or post displays.

We wanted a solution that would allow us to split up our codebase into modules without disrupting our workflow, which relies heavily on git feature branches and GitHub pull requests for code reviews. We looked at several different options and decided on using git subtrees. Here’s how we came to that decision.#### CocoaPods

[CocoaPods](http://cocoapods.org/) is the most well-known of the options we considered. It’s very easy to use—both as library consumer and writer—and is similar to other dependency management systems like Rubygems.

Our first attempt to modularize Medium’s iOS app was to split the codebase into a library (or “pod”) and use CocoaPods to manage the dependencies. Briefly, here’s what we did:

1.  Split the main project into separate git repositories, one for client code and one for a library and client code.
2.  Integrate CocoaPods in the library, by restructuring the workspace and the project files and creating its podspec.
3.  Remove the “vendored” libraries in the library workspace to use their CocoaPods version
4.  Restructure the client app project workspace to use the pod version of the library

There was a lot of upfront work in splitting up the codebase and preparing the podspec. Setting up the compilation steps was also a bit complicated, especially when you are new (as I am) to the many knobs and buttons of Xcode’s build configurations. But after that everything seemed to work smoothly.

However, we ran into trouble because we were using CocoaPods on a rapidly changing codebase rather than a seldom-changing library, which is perhaps not its intended usage. Xcode seems to heavily cache the state of config and file indexes, which caused a lot of confusion around files not being found during compilation time, and autocomplete not working properly. Adding new files to the library required a lot of ‘pod update’ commands. We decided that this was too disruptive to our workflow, and looked at other options.

#### **git submodules**

Using [git submodules](http://git-scm.com/book/en/Git-Tools-Submodules) requires learning how to use a different set of commands and incorporate them into your workflow and scripts. For example, whenever you checkout the repository for the first time, you will have to run ‘git submodules update’ to fetch all the dependencies.

Also, the programmer’s workflow needs to change so that every time you make changes to submodules, separate commits get created for all of them. Then, you need to update the references in the parent repository to point to the new commits.

Here at Medium we rely on GitHub’s pull request feature to do code reviews—so we only merge the feature branch into master when someone else has reviewed the code. Git submodules makes this process much more complicated, and a developer would have to create separate pull requests for each submodule and link them together in a code review process.

Again, the disruption to our familiar workflow eliminated this option.

#### git subtrees

In the end it turned out that the right answer was a more barebones solution, the lesser known [git subtrees](https://github.com/apenwarr/git-subtree/blob/master/git-subtree.txt). Git subtrees is, in essence, a script written on top of git (now a part of the [git-contrib](https://github.com/git/git/tree/master/contrib) package). It clones the subproject’s repository and merges it into the parent project’s repository. This means that either all commits from the library directory get copied into the parent directory or all the commits get squashed into one big merge commit.

To add a subproject, you execute these arcane-looking commands:
`git remote add my-lib-remote git@github.com:Medium/my-lib.git  
git subtree add —-prefix=my-lib-folder/ my-lib-remote master`

First, you add your library’s remote as if it was your own. Then, you use **subtree add** to add that repo’s code into a path in the parent’s project, specified by **prefix.** The last parameter, **master**, is the branch you are pulling code from.

These two commands will pull all the commits from the subproject repository and lay all the code into the prefix path. This has a significant advantage over git submodules—you can see the history of changes of all the files that matter to your project, which gives you much more visibility into the changes going into the project and overall code quality.

From there on out, you can resume your normal workflow disruption-free as if there were no subproject at all!

Synchronizing code between the client app codebase and the library is a tiny bit more complicated. For a more comprehensive walkthrough of the git subtree workflow, refer to [git subtrees: a tutorial](https://medium.com/p/6ff568381844/).As our codebase and team evolves, it’s possible that our needs and capacity for customizing our own development tools will change. But for now, git subtrees is serving us quite well.
