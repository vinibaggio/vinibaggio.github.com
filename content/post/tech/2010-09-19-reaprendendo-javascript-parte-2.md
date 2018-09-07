---
categories:
- JavaScript
date: "2010-09-19T00:00:00Z"
description: Alguns conceitos avançados de JavaScript, como Closures e Orientação
  a Objetos.
keywords: javascript, closure, oop, module, prototype
---

# Reaprendendo JavaScript [parte 2]

Em [Reaprendendo JavaScript parte 1](/JavaScript/reaprendendo-javascript-parte-1), eu listei boas fontes para se aprender JavaScript e alguns trechos interessantes/bizarros de JavaScript.

Nesse artigo, meu objetivo é falar mais sobre como trabalhar na
linguagem que é baseada em protótipos, um conceito não muito familiar por aí. O
conceito é simples: basicamente você tem objetos que servirão de protótipos para
outros, ou seja, os novos objetos serão baseados nele. 

Vamos explorar esse conceito mais para frente, mas primeiro vamos a alguns detalhes relativo à primeira parte dessa série.

![JavaScript](/images/posts/reaprendendo-javascript-pt2/prototype.jpg)

## Closures como "namespace"

Algumas linguagens possuem namespace, tais como Java (via packages), C++, Ruby
(através de módulos), entre outras, mas JavaScript não. Um grande problema disso
é que toda variável que não fosse declarada dentro de uma função, ela
automaticamente torna-se global. Isso torna-se um problema sério principalmente
em scripts em páginas web.

Quando estamos desenvolvendo para Web, é comum separar alguns comportamentos em
arquivos .js separados, para organização. O problema é quando começamos a compor
páginas com mais de um desses módulos, começamos a sujar o escopo de variáveis
globais.

Uma maneira simples é usar Closures para organizar seus arquivos. Exemplo:

{{< highlight javascript >}}
var MyModule = function() {
    var myLocalVar = 'Hello!';

    // Isso é private
    var myFunction = function() {
        alert(myLocalVar);
    };

    return {
        init: function() {
            myFunction();
        }
    }
}();


MyModule.init(); // Alert: 'Hello!'

{{< / highlight >}}

Nesse caso, <code>myLocalVar</code> e <code>myFunction</code> não estarão acessíveis externamente,
protegendo o escopo. Se você quiser executar o código imediatamente, você pode
usar funções anônimas:

{{< highlight javascript >}}
(function() {
    var myLocalVar = 'Hello!';

    // Isso é private
    var myFunction = function() {
        alert(myLocalVar);
    };

    myFunction();
})();
{{< / highlight >}}

## Utilidade para arguments.callee

No post passado eu escrevi sobre o <code>arguments</code> possui o propriedade
<code>callee</code>, que retorna o próprio método. Uma coisa interessante sobre
funções é que podemos verificar o <code>caller</code>:

{{< highlight javascript >}}
function F() {
  console.log(arguments.callee.caller);
}

function G() {
 F();
}

G();    // function G() {
        //  F();
        // }


{{< / highlight >}}


## Object-Oriented JavaScript

Agora sim, chegamos em um assunto interessante. Como disse no início do artigo,
JavaScript é uma linguagem baseada em protótipo. Para criar objetos de uma
"classe", usaremos uma função para gerar uma nova instância. Para isso, basta
usar a palavra reservada <code>new</code> antes de uma função. Dessa forma,
dentro dessa função, <code>this</code> irá representar essa nova instância.
Nada melhor que um exemplo:

{{< highlight javascript >}}

function Car(manufacturer, model) {
    this.manufacturer = manufacturer;
    this.model = model;
}


var porsche = new Car('Porsche', 'Carrera');
var ferrari = new Car('Ferrari', 'Enzo');

porsche; // { manufacturer: 'Porsche', model: 'Carrera' }
ferrari; // { manufacturer: 'Ferrari', model: 'Enzo' }

{{< / highlight >}}

Note que eu não retornei nada nessa função! Por padrão, o retorno é
<code>this</code>.

Note que devemos usar o <code>new</code>, caso contrário, <code>this</code> será o objeto global. Exemplo deste código no browser, sem o <code>new</code>:

{{< highlight javascript >}}

function Car(manufacturer, model) {
    this.manufacturer = manufacturer;
    this.model = model;
}

var porsche = Car('Porsche', 'Carrera');

porsche;             // undefined. Hein?
window.manufacturer; // "Porsche". O QUE??

{{< / highlight >}}

Outros aspectos que temos que tomar cuidado com o <code>new</code>. Tudo que for
retornado que não seja um _object literal_ será ignorado, mas caso contrário,
ele será o objeto retornado!

{{< highlight javascript >}}

function Car(manufacturer, model) {
    this.manufacturer = manufacturer;
    this.model = model;
    return '1234';
}

var porsche = new Car('Porsche', 'Carrera');

porsche === '1234';   // false
porsche;              // { manufacturer: 'Porsche', model: 'Carrera' }

function Hello() {
    this.english = 'Hello!';
    return { 
        japanese: 'Konichiwa!'
    }
}

var salute = new Hello();
salute.english;             // undefined
salute.japanese;            // 'Konichiwa!'

{{< / highlight >}}

Pois é. Toma cuidado!

## Prototype

O <code>prototype</code> é um nível hierárquivo acima dos objetos em si. Métodos e
propriedades são compartilhados entre todas as instâncias, e quando um método ou
propriedade não é encontrado, procura-se um nível hierárquico acima:

{{< highlight javascript >}}

function Car(manufacturer, model) {
    this.manufacturer = manufacturer;
    this.model = model;
}

var porsche = new Car('Porsche', 'Carrera');
var ferrari = new Car('Ferrari', 'Enzo');

Car.prototype.price = 50000;

porsche.price;      // 50000;
ferrari.price;      // 50000;

// Vamos escrever a nível de objeto
porsche.price = 500;
porsche;            //  { manufacturer: 'Porsche'
                    //  , model: 'Carrera'
                    //  , price: 500
                    //  }


ferrari.price;      // 50000;
ferrari;            // { manufacturer: 'Ferrari', model: 'Enzo' }

ferrari.hasOwnProperty('price'); // false
porsche.hasOwnProperty('price'); // true


{{< / highlight >}}

Existe muito mais a ser explorado com <code>prototype</code>, como sobrescrita,
acesso ao construtor, etc. mas isso vai ficar para a parte 3.

UPDATE 1: Corrigindo texto.
