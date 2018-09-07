---
categories:
- JavaScript
date: "2010-10-05T00:00:00Z"
description: Aprendendo a fazer herança em JavaScript
keywords: javascript, herança, closure, oop, module, prototype
title: Reaprendendo JavaScript - Herança
---

# Reaprendendo JavaScript &mdash; Herança 

Na [segunda parte](/JavaScript/reaprendendo-javascript-parte-2), começamos
a ver como funciona orientação a objetos em JavaScript. Também vimos a estrutura
chamada <code>prototype</code> e o que podemos fazer com ela.

Na parte três, veremos mais sobre essa importante propriedade de
objetos em JavaScript para entender como, por exemplo, podemos adicionar
métodos a classes já existentes (e é uma prática sempre presente
no [prototype.js](http://wwww.prototypejs.org)) e uma das maneiras de se
implementar herança.

## Incorporando funcionalidades

Podemos alterar qualquer objeto presente no JavaScript. Funções e
propriedades não são exceção, como já vimos anteriormente. Nada
impede então de adicionarmos comportamento a classes <em>built-in</em>.
Basta lembrar que, quando um método não é encontrado no objeto em si,
o lookup é feito no <code>prototype</code>:

{{< highlight javascript >}}
Array                                      // [Function]
Array.prototype.sayHello = function() {
    console.log('Hello!');
};

[1,2,3].sayHello();                        // Hello!

{{< / highlight >}}

Esse exemplo é bem simples (para não dizer idiota), mas dá para
entender o que podemos fazer. Podemos, por exemplo, implementar
um método <code>shuffle</code> (sem entrar no mérito de random
enviesado):

{{< highlight javascript >}}
Array.prototype.shuffle = function() {
    var newPosition, currentItem;

    for(var i = this.length - 1; i >= 0; i--) {
        newPosition = Math.floor(Math.random() * i+1) ;
        currentItem = this[i];
        this[i] = this[newPosition];
        this[newPosition] = currentItem;
    }

    return this;
};

console.log([1,2,3,4,5,6,7,8,9].shuffle());
{{< / highlight >}}

## Herança

Como visto na parte 2, a engine JavaScript usa o <code>prototype</code> para
procurar métodos e propriedades quando eles não se encontram no próprio objeto.
Vimos também logo acima que o <code>prototype</code> pode ser facilmente
alterado. 


### Alterando prototype

Então vamos aproveitar essas características para implementar uma
versão simples de herança:

{{< highlight javascript >}}

function Car() {
    this.wheels = 4;
    this.type = 'motor';
}

function SportsCar() {
    this.speed = '300km/h';
}

SportsCar.prototype = new Car();

{{< / highlight >}}

Lembre-se: usamos o new em Car para obter um objeto com as propriedades.
Com isso declarado, podemos fazer:


{{< highlight javascript >}}

ferrari = new SportsCar();         // { speed: '300km/h' }
ferrari.wheels;                    // 4
ferrari.type;                      // 'motor'

{{< / highlight >}}

Tudo parece certo, né? Errado. No node.js, tudo correto, mas no browser, temos:

{{< highlight javascript >}}

ferrari instanceof Car;          // true
ferrari instanceof SportsCar;    // false

{{< / highlight >}}

O <code>instanceof</code> usa o <code>constructor</code> para determinar
a classe. É sabido, em JavaScript, por essas e outras razões, que
devemos, sempre que sobreescrevermos o <code>prototype</code>, devemos
atualizar o <code>constructor</code>. Note que apenas
alterar não é problema, como fizemos com o <code>Array</code>.
Dessa forma, temos o seguinte:

{{< highlight javascript >}}

function Car() {
    this.wheels = 4;
    this.type = 'motor';
}

function SportsCar() {
    this.speed = '300km/h';
}

SportsCar.prototype = new Car();
SportsCar.prototype.constructor = SportsCar;

ferrari = new SportsCar();
ferrari instanceof Car;             // true
ferrari instanceof SportsCar;       // true

{{< / highlight >}}

## Reflexão

O que mostrei foi uma das maneiras de se implementar herança em
JavaScript, a maneira padrão recomendada pelo padrão ECMA. Mas,
existem *pelo menos outras onze maneiras* de se implementar herança em
JavaScript, todas com suas vantagens e desvantagens.

Existe [um artigo do Douglas
Cockford](http://www.crockford.com/javascript/inheritance.html)
mostrando alguns exemplos. [John
Resig](http://ejohn.org/blog/simple-javascript-inheritance/), um dos
criadores do jQuery, também escreveu sobre isso e você pode ver por
aí trocentos outros.

Mas antes de continuar falando sobre hierarquia em JavaScript,
vou tentar fazer um paralelo com Ruby. 

Em Ruby, usamos mais comumente um tipo de herança especial conhecido como
[Mixins](http://en.wikipedia.org/wiki/Mixins) e não apenas Herança
Clássica. É uma ótima maneira de se reaproveitar código e combina
bem com JavaScript, já que a linguagem não possui o conceito de classes. Por
isso, é o que vou explorar no próximo artigo.

Você já teve experiência nesse assunto? O que achou? Comente abaixo
e compartilhe sua experiência.
