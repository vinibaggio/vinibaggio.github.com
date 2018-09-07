---
title: "My operating principles"
date: 2017-08-16 01:15:44.454 +0000 UTC
author: "Vinícius Baggio Fuentes"

---

This is a list of operating principles I try to follow on my day-to-day as an Individual Contributor and as a Software Engineer. I have been following them during my career, but never encoded them anywhere. Writing them down is my attempt to remind myself of their existence and check in often, and hopefully, help others.

These ideas are not original but come from my experiences with peers and excellent managers I have had in the past. They come from books I read, from what I know about Buddhism and stoicism. I will try to add credit when it is due, but forgive me if I don’t — I have internalized these ideas over time and I may have forgotten the origin.

Let know what do you think. I would also love to hear your thoughts about what you agree or disagree with. Send me an email at [vinibaggio@gmail.com](http://vinibaggio@gmail.com), or on Twitter, [@vinibaggio](http://twitter.com/@vinibaggio).

**Note:** this is a document about what I believe to be tolerance, empathy, and respect to others, in a respectful environment. On the other hand, harmful behavior should not be tolerated and should be dealt differently than the ways this document refer to. This being said, please do let me know if you think this document can be harmful in any way.

**Note 2:** Apply with care and reason. Your environment and life experiences are different, so YMMV.

**Note 3:** There’s a terminology list at the end if something sounds weird to you.

Now to the list.

### Reasonable person principle (RPP)




![image](https://cdn-images-1.medium.com/max/800/0*XmfxvCUFYo9JPj80.png)

Alt text reads: “Fortunately, the charging one has been solved  
now that we’ve all standardized on mini-USB. Or is it micro-USB? Shit.” Source: XKCD [https://xkcd.com/927/](https://xkcd.com/927/). License: Creative Commons Attribution-NonCommercial 2.5 License



**Summary:** We are all in this together, we are reasonable people just trying to do our best given our abilities and context.

The reasonable person principle [1] is my favorite. This was widely shared in my time at Medium, and the ideas are:

*   Everyone will be reasonable.
*   Everyone expects everyone else to be reasonable.
*   No one is special.
*   Do not be offended if someone suggests you are not being reasonable.

There are times it feels impossible to agree with this principle, and you might be right. But in a work environment where I share some background with peers, I should expect they are reasonable.

The XKCD comic is a great way to boil down the RPP. It is common to see some piece of work and have some sort of negative reaction to it, for many reasons. Sometimes, it’s code that is not formatted well, or does not follow the standards of a company or does not reflect your mental model of the problem, or something that feels very hacky.

The answer so far for me is to avoid having an immediate reaction. “Reacting” to something is rarely the right way to do things when interacting with other people or their work. I remind myself that the person did the best they could at that moment with what they had. Time, information, emotional investment, “cognitive power” are all finite resources. It is easy for me to react thinking that there are better ways to do something, or that something missing is really important, but that is mostly false. In hindsight, many things seem trivial.

**How I apply it daily:**

1.  I see work that doesn’t look very good and seems hacky and think: “What a bad way to do X! You might just have done Y!”
2.  I think of saying to Engineer X “why didn’t you do Y instead of X?! So obvious, Engineer E is in bad faith”
3.  Instead, I apply the RPP and think that Engineer E might have a good reason for the way things were done that way.
4.  I then think I should learn why X was done that way and invite Engineer E into a quick conversation
5.  I ask Engineer E: “Hey, can you tell me a little bit about X? I have to do some work related to that and I want to understand it better.”
6.  Engineer E: “Oh, I had to do X that way because we didn’t know Y was possible, but it’s outdated. Y is the way to go!”

This is very common. I often react thinking things are not done properly because people are inherently lazy, but that has never been the case in my career, thankfully. Instead, my arrogance is fueled by hindsight bias and talking through the context around a piece of work helps me tell the true story. I often end up learning very important pieces of context and break up my bad assumptions. I am able to provide more interesting feedback from then on.

We come back to the XKCD example. It’s common for me, as an engineer trying to do things in my way, after looking at all the 14 different standards, I assume I am able to do things better. I think I know more. But in the end, I will end up creating another 15th standard if I don’t understand the story behind things.

### “Ego reduction”

**Summary:** Given that my perception of self usually (an understatement at minimum) mismatches the perception of others unto me, the end result of projecting my status somehow is me sounding like an obnoxious person.

“Ego reduction” is a term I coined to name a thought process. It comes from analyzing the “ego output” of feedback. The ego output is, when I give a piece of feedback, I am trying to sound smarter, or make my peer feel less intelligent, intentionally or not. The idea is for the feedback to have zero “ego output.” This is not to be confused with no praising — elevating other people’s work is totally fine and encouraged. This idea comes from the “Ego is the Enemy” book [2].

This is a tricky one because I also don’t want to sound patronizing, which is very easy to do when trying to remove ego from the interaction. Here it is really important to understand the background of the person you are interacting with. One example of ego analysis gone wrong is in code reviews.

**How I apply it daily**: Let’s go through an example, with my thought process in a maybe-hypothetical-maybe-not example, reviewing code:

1.  I open the change request
2.  I think: “this code doesn’t look great, this person uses spaces instead of tabs in Bloop language 😱”
3.  I start typing something: “hey what’s up with this code, looks like 💩”
4.  I delete such comment because ego reduction triggers and I am not being helpful at all
5.  I type, removing my own ego or qualitative comment: “hey have you heard about the bloop-fmt tool that formats your code to our very rigorous standards”
6.  I remember that Engineer Z is a senior engineer and has done this stuff before, so I don’t want to be patronizing, so I erase the comment
7.  I write on the CR: “@engineer_z you forgot to run bloop-fmt but all else LGTM ship it”

In the case of Engineer Z being someone new, or I haven’t interacted before, I see it would be valid to ask whether the person knows about bloop-fmt. If the same happens to me and I have been working with bloop-fmt for a while, it is safe to assume the RPP and I would not be offended.

### Plussing

**Summary:** Don’t say no, say “yes, and”.

Someone I had the pleasure to work with once taught me indirectly about the concept of Plussing. It reads, simply:

*   No one says, “No, but…”
*   Only, “Yes, and…”
*   Instead of subtracting… plussing.

Not the source I heard from, but someone also wrote about it before [3].

**How I apply it daily**: The idea is quite simple. Instead of shutting other people down by saying “no,” to an idea, I say “yes and…”. In my anecdotal experience, this has helped myself and others more participative in a meeting — every time I am shut down or am not given the opportunity to speak in a meeting, the less likely I want to say anything again. Don’t do this to others.

### Completeness

**Summary:** Do your job and do not be sloppy about it.

Completeness is a fuzzy concept. Every time I do my work, I strive for it to be complete. It does not mean it does everything in the world (eg. over engineering) but everything I have committed to do, I will try to do. This means dealing with errors properly, updating the associated tickets appropriately, creating better tests, write the documentation, write proper commit messages. This kind of work does not take much time and makes the life of your peers much better, by making the project more robust or to transfer information better.

A way to sum up this concept: “for all the work I committed to doing, I will do it as well as I can.”

**How I apply it daily:**

*   Make sure I share interesting findings in my team’s chat room and my thought process
*   Write commit messages that explain the previous-to-commit context, why this commit is needed and what happens from that change on. This is especially useful on those 1-line-commits that took you hours to find out why that is needed. These usually have very big commit messages, sharing my findings.
*   Avoid sloppy code/writing/documentation/tests/etc, run a spellchecker.
*   Creating self-contained commits whose tests pass, so that they can be reviewed individually
*   Write in my notebook with all possible work that can be done in a change and evaluate if they’re worth doing (ie. out of code TODOs)
*   Make sure the engineering decisions I make are proper engineering decisions, given my understanding of the problem or time-constraints, and I try not to leak through the system.
*   A proper understanding of the problem — if I am reviewing a change request, I try to understand the underlying problem and the context so that, when I review the code, I am reviewing it in the best of my ability and knowledge.
*   Gather context as much as I can — many times I avoided having to do incomplete work by not having to do the work at all and sharing context.
*   Make sure the code is observable, metrics are in place and make the operator’s life better (which should also include you!)

### Value other people’s time

**Summary:** People have other stuff to do. Value their time.

I try to respect other people’s time, regardless of their position. For this reason, I try to do the most amount of work upfront, before calling one or more people’s attention. Pretty simple concept that is easier said than done.

**How I apply it daily:**

**Change requests:** I am known for being somewhat weird by reviewing my own change requests as if it was anybody’s. There is a strange feeling of talking about myself in the 3rd person. However, I find these extremely helpful — I catch most of my own TODOs or improper copy-pasted code this way. Using git add’s interactive mode is also helpful, but not as much. This avoids annoying your co-workers having to do the same thing over and over again. If this CR is a part of a set of CRs, make sure I state which is prior work and what is coming next, tagging a ticket that has the complete scope of the work.

**Meetings:** Whenever I call for a meeting (rarely the case), I try to make sure we have defined input-outputs. I ask if folks want to be a part of the meeting, and have anything to contribute to that. Ritualistic meetings lose their meaning, and I get upset when the reason that I have to be in a meeting is “because you have to.” Find a time in their calendar and drop the event yourself, and also ask if that’s ok.

**Asking questions:** Especially in the Slack world, I avoid just asking “hey”, “hi”, “good morning” and wait for the person to answer so I can actually ask my question. What I do instead is: “Hi! I hope you had a good weekend! So, I was playing with this tool and …”. I try to give as much context as needed.

**Emails/status sync:** I try to be friendly to managers and higher level folks to adding a “TL;DR” section to my emails so that emails can easily be actionable by people that only need a higher level scope of the issue. I add the actual details in a later section, allowing for interested folks to read that too.

### Avoiding frustration

**Summary:** frustration is often my fault for not seeing things as they truly are. Breaking situations into “things I have control” vs “things I have no control” vs “things I have full control” bring a new perspective.

I don’t think it is possible to completely avoid frustration. However, learning that most of the time, frustration is driven by a mismatch of how we see the world (the stories we make about the world to ourselves) and actual results. If frustration is happening often, it means I need to reevaluate my “stories” to pinpoint the source. In “A guide to good life: the ancient art of stoic joy,” [4] author William B. Irvine writes about the dichotomy of control:

1.  The things we have full control (goals we set for ourselves)
2.  Things we have zero control (the sun rising)

Frustration, in my experience, is when we do something and the outcome is something we have zero control, such as depending on a third party (interacting with a supplier, for instance) or even the work of your colleague.

However, continuing with the book, the author talks about a mental process of transforming the dichotomy into a trichotomy:

1.  The things we have full control (goals we set for ourselves)
2.  Things we have zero control (the sun rising)
3.  Things we have some control of (whether we can win at tennis).

Thinking of the trichotomy of control as a recursive process, when something frustrates me, I apply that and think: is there something I could have done to make it closer to my expectations in a productive way? If I do this process often and feel like I’ve done everything in my ability to fix the control issue, then I rest assured that there’s nothing else I could have done anyway, so there’s no point in being frustrated. Otherwise, I have a way to plan and mitigate the issue, or maybe rethink the whole process entirely.

**How I apply it daily:**

1.  I am reviewing some work and I feel frustrated, nothing is according to my specifications.
2.  The dichotomy of control says: “I have zero control over the output of a co-worker”.
3.  Then I unpack it into the trichotomy: “I actually have some control over the output of a co-worker, I wrote the specification.”
4.  I invite the co-worker to a conversation.
5.  In that conversation, I find out that the language I used is ambiguous and has room for improvement.
6.  I ask feedback from the co-worker on how to make the specification better.
7.  Next time, the end result of the work is as we both agreed on.

I almost always have something I can change to make sure the next time I have to go through a similar process, the end results are going to be better. Of course, there are cases that this is just not possible, whether due to difficult co-workers, to hierarchy or ownership of the process. In this case, if I truly believe I did everything I can do and nothing can be done, my frustration will go away regardless because my expectations will change. Sometimes, the answer is to just leave things as they are.

### Conclusion

It is important to remember that, in everything you do, you always have a choice on how you want to react to your environment. The world is a pretty messed up place already, so I try not to make it worse. I try to always choose kindness. It requires hard work, it is painful, it is exhausting. Sometimes I cave in and explode. I think this is part of the human experience and it is inevitable. But the good news is: after a lot of practice, choosing kindness becomes easier.

### Thank you

Thanks to Adrian Lee, Bernardo Coelho, Gianni Chen, Ikai Lan, Nina Liong, Paulo Margarido, Rodrigo Lopes, Sérgio Schezar, Vinícius Uzeda for feedback on this article.

### Terminology

*   CR: Change request. In Software Engineering, submitting Change Requests are ways to incorporate someone’s work into the main production source code. Also known as Pull Request.
*   LGTM: “Looks good to me,” a term often used in Change Requests that means approval of the changes to be incorporated into the main production line.
*   TL;DR: Too Long; Didn’t Read: a few statements summarizing the content of the whole document.
*   TODO: Literally to-do, often the way programmers refer to “to-dos” as comments in source code.

### References

All Amazon links are non-referral links:

[1]: [https://www.cs.cmu.edu/~weigand/staff/](https://www.cs.cmu.edu/~weigand/staff/)

[2]: [https://www.amazon.com/Ego-Enemy-Ryan-Holiday-ebook/dp/B015NTIXWE/](https://www.amazon.com/Ego-Enemy-Ryan-Holiday-ebook/dp/B015NTIXWE/)

[3]: [https://engineering.aweber.com/plussing-learning-and-working-in-a-collaborative-environment/](https://engineering.aweber.com/plussing-learning-and-working-in-a-collaborative-environment/).

[4]: [https://www.amazon.com/Guide-Good-Life-Ancient-Stoic-ebook/dp/B0040JHNQG/](https://www.amazon.com/Guide-Good-Life-Ancient-Stoic-ebook/dp/B0040JHNQG/)
