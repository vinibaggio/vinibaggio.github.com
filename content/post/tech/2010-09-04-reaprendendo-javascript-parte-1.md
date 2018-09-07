---
categories:
- JavaScript
date: "2010-09-04T00:00:00Z"
description: Aprendendo JavaScript corretamente, livros, fontes e node.js
keywords: javascript, node.js, closure, undefined
---

# Reaprendendo JavaScript [parte 1]

Desde o colégio eu brinco com JavaScript, mesmo quando ela era uma linguagem meio
problemática, na Grande Guerra dos Browsers, ou sei lá, a fase medieval da Web.
O Iluminismo chegou, frameworks como
[prototype.js](http://www.prototypejs.org/), [jQuery](http://jquery.com/) e
muitos outros acabaram com o fardo de fazer aplicações ricas em client-side.

![JavaScript](/images/posts/reaprendendo-javascript/javascript_logo.png)

Nessa história toda, eu nunca realmente aprendi JavaScript, apenas "fiz funcionar" 
(e admito isso com vergonha). Resolvi mudar.

## Livros

Achei [um post muito bom](http://www.devcurry.com/2010/07/5-javascript-books-worth-every-cent.html) 
listando alguns livros de JavaScript para aqueles que querem levar a linguagem a sério.
Comprei dois, o 
[Object-Oriented JavaScript](http://www.amazon.com/Object-Oriented-JavaScript-high-quality-applications-libraries/dp/1847194141/ref=sr_1_1?s=books&ie=UTF8&qid=1283385235&sr=1-1) por Stoyan Stefanov, um pouco menos conhecido, e o famoso 
[JavaScript: The Good Parts](http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742/ref=pd_sim_b_2),
de Douglas Crockford, também autor do [JSLint](http://www.jslint.com/).

Até agora, estou mais ou menos na metade do Object-Oriented JavaScript e tenho
gostado bastante. Apesar de ser um livro voltado a iniciantes na programação,
o conteúdo será bem aproveitado por programadores um pouco mais experientes.
Descobri algumas coisas bem interessantes até agora, boas e ruins.


## Exemplos JavaScript

Todos os exemplos abaixo foram executados no terminal interativo do
[Node.JS](http://www.nodejs.org).
Para instalá-lo no OS X, basta:

    brew install node

### arguments.callee

Uma das primeiras coisas que aprendi é a palavra reservada
<code>arguments</code>. Ela retorna uma <code>Array</code>, que contém todos os
parâmetros de uma função:

{{< highlight javascript >}}
function E() {
    return arguments;
}

E([1,2], "Hello world!"); // { '0': [ 1, 2 ], '1': 'Hello world!' }
E();                      // {}
E(1);                     // { '0': 1 }
{{< / highlight >}}

Uma coisa curiosa é o <code>arguments.callee</code>

{{< highlight javascript >}}
function F() {
    return arguments.callee;
}

F(); // [Function]
F()()()()()()()()()()()(); // [Function]
{{< / highlight >}}

O que isso significa? <code>arguments.callee</code> é a própria função. Pra que
usar isso? Não sei. Mas veja o próximo exemplo, usando uma função anônima:


{{< highlight javascript >}}
    (function(i) {
        console.log(i);
        if(i < 5) {
            arguments.callee(i+1);
        }
    })(0);
    /*
     * Saída:
     * 0
     * 1
     * 2
     * 3
     * 4
     * 5
     */
{{< / highlight >}}

### Closures e escopos léxicos

Uma das coisas mais legais de JavaScript, e Ruby também, é o uso de funções de
primeira ordem (funções/métodos são dados) e closures. 

Estamos acostumados com o uso de closure no dia a dia, mas eu achei um exemplo
muito interessante de como observar como as closures tem seus escopos montados
em tempo de definição, mas não guarda os valores das variáveis. Veja:

{{< highlight javascript >}}
var a = [], i;
for(i = 0; i < 3; i++) {
    a[i] = function() {
        console.log(i);
    }
}
{{< / highlight >}}

Espera-se, por razões lógicas, que o seguinte aconteça:

{{< highlight javascript >}}
a[0]();  // Espera-se: 0, saída real: 3
a[1]();  // Espera-se: 1, saída real: 3
a[2]();  // Espera-se, 2, saída real: 3
{{< / highlight >}}

Qual a razão disso? Quando a função anônima é criada, cria-se o escopo apontado
para a variável <code>i</code>, mas não seu valor. E mais, o valor fica
<code>3</code>, pois é o valor de <code>i</code> quando foi feito o teste
<code>i < 3</code>, que falha e o <code>for</code> é interrompido. Para resolver
o problema, você é obrigado a introduzir um novo escopo, que só haja a
possibilidade de i assumir um valor:

{{< highlight javascript >}}
var a = [], i;
for(i = 0; i < 3; i++) {
    a[i] = (function(i) {
        return function() {
          console.log(i);
        }
    })(i);
}
a[0]();  //  0
a[1]();  //  1
a[2]();  //  2
{{< / highlight >}}


### undefined

Algumas coisas que eu não gosto de <code>undefined</code>:

{{< highlight javascript >}}
undefined == null;   // true
!!undefined;         // false
!!null;              // false
undefined == false   // false
{{< / highlight >}}

{{< highlight javascript >}}
var a;
a == undefined;      // true
typeof undefined;    // 'undefined'
undefined = '123';
typeof undefined;    // 'string'
a == undefined;      // false
{{< / highlight >}}

  
Bom, esses são alguns exemplos de código que eu vi até agora. Assim que eu der
continuidade no livro postarei mais sobre o que venho aprendendo.

## Pra finalizar...

Uma pequena dica. Quem trabalha com JavaScript com certeza conhece o JSLint. Ele
aponta vários problemas comuns em código JavaScript, que podem te atrapalhar
como desenvolvedor. Um exemplo clássico acontece com <code>object literals</code>
terminados com vírgula:

{{< highlight javascript >}}
    var a = {
        elem1: 1,
        elem2: 2,
    }
{{< / highlight >}}

Esse código acima é _inválido_, porém browsers como Firefox e baseados em
WebKit permite a existência desse tipo de código. Mas o Internet Explorer não.
Então, o JSLint daria o seguinte erro:

    trailing comma is not legal in ECMA-262 object initializers

Como já tive problemas por causa desse erro, seria muito interessante ter esse tipo
de checagem durante o tempo de desenvolvimento. Mas há um problema: como
executar o JSLint, que está rodando no browser?

Existem duas soluções:

 * [Um bundle de SpiderMonkey (engine JavaScript em C pela Mozilla)](http://www.javascriptlint.com/);
 * [Via Node.JS](http://github.com/reid/node-jslint);

A primeira opção é mais fácil de instalar (<code>brew install jslint</code>)
e o plugin [syntastic](http://www.vim.org/scripts/script.php?script_id=2736), do Vim, 
já possui integração para ele:

![JavaScript](/images/posts/reaprendendo-javascript/syntastic_jslint.png)

E como é sua experiência com JavaScript? Quais fontes de informação sobre o
assunto? Deixe um feedback nos comentários!
