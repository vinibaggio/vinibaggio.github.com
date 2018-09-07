---
categories:
- Geral
date: "2013-03-13T00:00:00Z"
description: Novidades no call4paperz.com
keywords: call4paperz
---

# Novidades call4paperz.com

Recentemente o call4paperz.com passou por um período meio ruim. Depois que eu
tornei o projeto opensource, mal me dediquei ao projeto. Algumas pessoas
(obrigado Fabio Akita, Duke e Nando Vieira!) contribuíram para tornar o projeto
um pouco mais adequado, mas ainda faltavam muitas coisas a serem feitas.

O principal era a migração do ambiente do Heroku. Estávamos rodando
o call4paperz no stack bamboo, que é um pouco antigo, e alguma das mudanças
introduzidas no projeto não rodariam lá. Eu tentei várias vezes fazer
a migração para o cedar, mas nunca cheguei a terminar. Porém, alguns eventos
recentes deixaram o site de joelhos.

Para isso, tive que fazer algumas otimizações na maneira em que o site conta os
votos. Para fazer a atualização, tive que mudar a stack de qualquer maneira.
Enfim, ânimo renovado para o projeto e o stack migrado, recentemente tenho
tomado conta do call4paperz com mais cuidado, corrigindo diversos bugs, lendo
emails atrasados (eu não acessava a caixa de entrada do call4paperz havia
muitos meses, acho que até anos!).

Um projeto como esse não pode ficar abandonado. Portanto, até então, temos as
seguintes alterações no projeto:

* Adição do projeto no Travis-CI, com a ajuda do [@lucianosousa](https://twitter.com/lucianosousa);
* Correção no link "Esqueci a senha", que nunca funcionou direito;
* Correções no uso de slugs, no qual, ao colocar um slug que não existe, um
  evento qualquer seria exibido, ao invés de retornar erro;
* Abertura e fechamento de eventos para novas propostas, uma funcionalidade
  altamente requisitada;
* Correções diversas de estilo e atualização de diversas gems;
* Diversas otimizações de performance de todo o site, com a ajuda da gem bullet
  e do NewRelic;

## O que vem por aí

A primeira coisa que está na minha fila de desenvolvimento é algo que já me
incomoda faz muito tempo: a impossibilidade do criador do evento se comunicar
com as pessoas que enviaram propostas. Para isso, preciso tornar obrigatório
que o usuário cadastre um email para o seu perfil. Isso também irá guiar
o refactoring de todo o sistema de autorização usando Twitter e Facebook, que
possuem vários bugs e não é amplamente testado.

Em seguida, a correção do sistema de votação, que é bastante ingênuo: apenas
conta pontos positivos e negativos. Abri uma issue no projeto e tive feedback
excelente de alguns amigos (obrigado!). Vale a pena dar uma olhada na 
[Issue #18](https://github.com/vinibaggio/call4paperz/issues/18) para ver
a discussão e os algoritmos mencionados.

Infelizmente meu tempo é bastante limitado para trabalhar no call4paperz,
portanto toda ajuda é benvinda. Existe diversas outras maneiras de colaborar,
como ajudar na migração do site para o sistema de I18n do Rails, de modo que
possamos deixar o site completamente traduzido ao português, trocar a foto do
perfil, uma funcionalidade super fácil de fazer e bastante requisitada, entre
outras coisas.

Se você estiver afim de colaborar, por favor deixe uma mensagem ou me mande um
email (vinibaggio@gmail.com). Se você tiver ideias para o projeto, abra issues,
mande pull requests.
