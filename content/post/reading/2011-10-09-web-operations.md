---
categories:
- Livros
date: "2011-10-09T00:00:00Z"
description: Revisão do livro "Web Operations - keeping the data on time"
keywords: web operations, livros, reviews, revisão, leitura recomendada, devops, operações
---

# Revisão do livro Web Operations - Keeping the data on time

![Web Operations](/images/posts/web-operations/web-operations.png)

## TL;DR:

Bom livro para as pessoas que não tem contato com a área de operações.
Um ou outro capítulo chega a quase ser de auto-ajuda, mas o resto
vale totalmente a pena, como escalabilidade em banco de dados, introdução
a NOSQL, Cloud Computing e Continuous Deployment. Recomendado!

## O resto

Em minha curta vida profissional, eu só trabalhei em dois tipos de ambiente: um
ambiente que eu não tinha a oportunidade de verificar como eram as máquinas em
produção, e no outro que eu fazia o sistema de produção como eu bem entendia.
Dessa forma, nunca tive a oportunidade de ver como operações deve ser feito de
maneira mais profissional.

Essa era a minha esperança na leitura do livro [Web
Operations](http://www.amazon.com/Web-Operations-Keeping-Data-Time/dp/1449377440/ref=sr_1_1?ie=UTF8&qid=1318211313&sr=8-1)
&mdash; entender realmente como é a visão dos
profissinais de operações sobre operações. Este livro não é tanto uma receita de como
operações são ou deve ser feito como eu esperava, mas o resultado final
é ainda melhor e dá uma excelente visão sobre diversos assuntos.

## Estrutura do livro

O Web Operations é uma coleção de artigos editorados em um mesmo livro.
Diversos autores, diversas opiniões (algumas vezes conflitantes!) e diversos
assuntos são cobertos no livro, de deploy à NOSQL.

### Capitulo 1 - Web Operations - The Career

Theo Schlossnagle começa o livro sobre web operations dando uma definição sobre
o que é o profissional de Web Operations e como ele se desenvolve. Fala de uma
maneira bem abrangente, definindo processos como "Root-Cause Analysis" (RCA) e
Postmortems.

Depois fala sobre ferramentas, conhecimentos técnicos e ainda recomenda a leitura
de RFCs e do código do Kernel do Linux na parte de TCP (!) para
entender como o protocolo funciona. Depois fala também de ferramentas como
system call tracers. Hardcore.

### Capítulo 2 - How Picnik Uses Cloud Computing: Lessons learned

Justin Huff faz um capítulo bem interessante sobre Cloud Computing e dá
exemplos de como seria o "holy-grail" do Cloud Computing: auto-scaling e quando
não usar Cloud.

### Capítulo 4 - Continuous Deployment

Eric Ries, famoso pelo seu [blog sobre Lean Startup Lessons Learned](http://startuplessonslearned.com)
conta neste excelente capítulo como continuous deployment ligado
a uma excelente estratégia de monitoramento fazem com que
a vida da área de operações pode ser mais fácil e chegando até a eliminar a
necessidade de uma área de QA, deixando o processo de desenvolvimento bem mais enxuto.

Em uma parte do livro ele define dois tipos de desenvolvedores: os "Cowboys",
os que fazem hotfixes sem muito pudor pela qualidade, e os fazem rápido,
e os "Quality Defenders", programadores que pensam em qualidade acima de tudo,
reagindo de forma mais lenta a problemas. Fazendo uma tradução livre, ele chega a dizer:

    (...) Entretanto, eles [cowboys e quality defenders] são frutos de um
    processo de desenvolvimento em grandes pacotes que forçam desenvolvedores
    a fazer escolhas entre tempo e qualidade, usando a antiga falácia
    "tempo-qualidade-dinheiro, escolha dois".

É importante também lembrar que a ThoughtWorks fez bastante propaganda do livro
[Continuous Delivery](http://www.amazon.com/Continuous-Delivery-Deployment-Automation-Addison-Wesley/dp/0321601912/ref=sr_1_1?ie=UTF8&qid=1318211499&sr=8-1), por Jez Humble e David Farley, na QCon SP nesse ano.

### Capítulo 12 - Relational Database Strategy and Tactics for the Web

Baron Schwartz é um expert em MySQL. O cara é o autor do Maatkit, essencial
para administração de servidores MySQL. Ah sim, e também é Vice Presidente de
consultoria na Percona, ou seja, ele *sabe* MySQL.

Esse capítulo é um dos mais interessantes do livro, sem sobra de dúvidas. Ele
explica sobre diversas maneiras de se fazer réplicas master-master,
master-slave e etc., problemas sobre particionamento e sharding, fala sobre
o famoso teorema CAP (Consistency, Availability e Partition Tolerance),
caching, escalabilidade, arquiteturas, enfim, uma infinidade de coisas se tratando
da parte de banco de dados. E por final, ele também mostra como usar ferramentas
para analisar performance do MySQL. Fantástico.

### Capítulo 15 - Nonrelational Databases

Se você não sabe nada sobre NOSQL/Nonrelational Databases, esse capítulo é para
você. Ele explica os modelos mais famosos de NOSQL, como K/V, Grafo, Orientado
a documentos, altamente distribuível, e explica alguns em detalhes, como Redis,
Cassandra, HBase, Riak, etc.

*Nota:* É possível observar que eu deixei muitos capítulos de fora da revisão. Eles são
bons em geral, alguns trazem muita formalização de conhecimento, como
a definição de MTTR (Mean Time To Response/Repair) e etc., são coisas
interessantes, mas não são o destaque do livro. E outras coisas eu anotei sem
associá-los a capítulos.

### Outros aprendizados não categorizados

Uma das coisas mais interessantes desse livro que eu aprendi além do que já
escrevi acima foi sobre monitoramento. Eu sempre pensei em monitorar o clássico, como:

    Camada de aplicação | Latência, taxa de resposta, etc
    Camada de serviços  | Tempo de resposta, tipos de queries (banco de dados), etc.
    Camada física       | CPU load, memória, disco, rede

Mas ainda há uma camada muito importante a ser monitorada e que é extramemente
importante: monitorar cadastro de usuários, monitorar conversão/vendas,
monitorar acessos, e entender como o usuário se sente sobre seu site.
É possível contornar downtimes e direcionar recursos de maneira mais
inteligente quando se tem uma visão mais completa.

Outra coisa sobre sistemas de monitoração é capítulo que há a formalização dos conceitos de
sistema de coleta de métricas e sistema de alertas e enfatiza-se *nunca* utilizar um
sistema que faz os dois ao mesmo tempo. Isso me deu vários insights sobre a minha
gem de monitação em Ruby, o [Outpost](http://www.github.com/vinibaggio/outpost/).

O autor do livro também escreveu o [The Art of Capacity Planning](http://www.amazon.com/Art-Capacity-Planning-Scaling-Resources/dp/0596518579/ref=sr_1_1?s=books&ie=UTF8&qid=1318211593&sr=1-1),
tá na fila de leitura. Além disso, o [Phil Calçado](http://philcalcado.com/2011/01/29/book_review_web_operations.html) recomenda o [Release
It!](http://www.amazon.com/Release-Production-Ready-Software-Pragmatic-Programmers/dp/0978739213/ref=sr_1_1?s=books&ie=UTF8&qid=1318211636&sr=1-1).
