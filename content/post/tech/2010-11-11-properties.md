---
categories: Objective-C
date: "2010-11-11T00:00:00Z"
description: Uma visão básica de properties e o modelo de gerência de memória em Objective-C.
keywords: objective-c, iphone, ios, cocoa, cocoatouch
---

# Properties

**Observação: existe grande possibilidade de eu estar falando alguma merda, sou
novo no Objective-C :-)**

## Gerenciamento de memória &mdash; o básico

Para alocar um objeto no Objective-C, é necessário basicamente
chamar dois métodos: o <code>alloc</code> e o <code>init</code>. Em
termos simples, o <code>alloc</code> é um método mais baixo nível
e serve para alocar memória para o objeto (parecido com a família
<code>*alloc</code> no C). O <code>init</code> e suas variações,
correspondem ao construtor:

{{< highlight objc >}}

NSString* coolString = [[NSString alloc] init];
NSString* anotherCoolString = [[NSString alloc] 
                                initWithString:@"Cool string!"];

[coolString release];
[anotherCoolString release];


{{< / highlight >}}

O controle de memória feito internamente pelo Objective-C é simples. No momento
que eu faço <code>alloc</code>, o número de referências para o objeto
é incrementado. Quando faço <code>release</code>, esse número é reduzido. Quando
o contador chega a zero, o objeto é liberado da memória:

![Reference Counting](/images/posts/properties/refcount.png)
**Fonte da imagem: [Cocoa Dev Central](http://cocoadevcentral.com)**

O <code>retain</code> usamos para uma situação um pouco diferente &mdash; usamos
quando queremos declaradamente aumentar a contagem de referência para um mesmo
objeto em memória, por exemplo, quando queremos guardar aquela referência em um
outro objeto.


> *Mas e o garbage collector?*
> 
> No Objective-C, é possível usar um dos parâmetros na compilação:
> 
> * -fobjc-gc-only: Há apenas Garbage Collector
> * -fobjc-gc: Suporta GC e <code>retain/release</code>
> 
> A questão é que eles não podem ser usados em aplicações iOS por enquanto,
> apenas no Snow Leopard.

> Mais detalhes em [Garbage Collection for Cocoa Essential](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/GarbageCollection/Articles/gcEssentials.html#//apple_ref/doc/uid/TP40002452-SW1)

## Getters e Setters

Vamos a um exemplo um pouco mais complexo, na nossa boa e velha classe
<code>Car</code>:

Car.h
{{< highlight objc >}}
#import <Cocoa/Cocoa.h>


@interface Car : NSObject 
{
    NSString* manufacturer;
    NSString* model;
}

- (NSString *)getManufacturer;
- (NSString *)getModel;

- (void)setManufacturer:(NSString *)input;
- (void)setModel:(NSString *)input;

@end
{{< / highlight >}}


Car.m
{{< highlight objc >}}


#import "Car.h"


@implementation Car

- (NSString *)getManufacturer
{
    return manufacturer;
}

- (NSString *)getModel
{
    return model;
}

- (void)setManufacturer:(NSString *)input
{
    if(input != manufacturer)
    {
        [manufacturer release];
        manufacturer = [input retain];
    }
}
- (void)setModel:(NSString *)input
{
    if(input != model)
    {
        [model release];
        model = [input retain];
    }
}

- (void)dealloc
{
    [model release];
    [manufacturer release];
}

@end

{{< / highlight >}}

Explicando o código, os dois primeiros métodos são apenas
*getters*, sem nada de especial. Já nos *setters*, eu faço primeiro
a verificação se os objetos tem a mesma referência. Isso deve-se
ao fato de que, se eu fizer <code>release</code> no objeto antigo
(<code>manufacturer</code>), eu também estou fazendo release no objeto novo
(<code>input</code>).

Quando eles forem diferentes, faço o <code>release</code> do objeto
antigo e faço o <code>retain</code> no novo, simples. Seguindo essa
ideia, podemos ver que gerência de memória nos vem de graça quando
usamos *getters* e *setters*, cabe ao programador gerenciar apenas o que
está em seu escopo, como vemos no exemplo:

{{< highlight objc >}}

    Car *car = [[Car alloc] init];

    // Exemplo apenas ilustrativo
    NSString* model = [[NSString alloc] initWithString:@"Carrera"];
    [car setModel:model];
    [model release];


    [car release];

{{< / highlight >}}


## Finalmente, properties

Properties são um jeito em Objective-C de se criar *getters* e *setters*,
e de graça ganhar um "syntax sugar". Vejamos o exemplo Car, reescrito:

Car.h
{{< highlight objc >}}
#import <Cocoa/Cocoa.h>


@interface Car : NSObject 
{
    NSString* manufacturer;
    NSString* model;
}

@property (retain) manufacturer;
@property (retain) model;

@end
{{< / highlight >}}


Car.m
{{< highlight objc >}}

#import "Car.h"

@implementation Car

@synthesize manufacturer, model;

- (void)dealloc
{
    [self setModel:nil];
    [self setManufacturer:nil];
    [super dealloc];
}

@end

{{< / highlight >}}

O <code>@property</code> serve para declarar a interface e também
comportamentos dessa propriedade. Nesse caso, estamos declarando o atributo
<code>retain</code> que define que os métodos *setters* usem
<code>retain</code>. Existem vários atributos possíveis:

* <code>retain</code>: Utiliza retain para associar, bem similar com o que
  fizemos anteriormente;
* <code>assign</code>: Faz simplesmente o assign simples, serve para tipos
  simples (NSInteger/int, por exemplo) ou quando tiver GC ligado;
* <code>nonatomic</code>: Bastante utilizado no iOS, não utiliza locks para
  para fazer associações (multi-thread);
* <code>copy</code>: Chama o método <code>copy</code> para criar um objeto clone
  do parâmetro.

Existem alguns outros, vale a pena ler a documentação oficial para saber mais:
[Declared properties attributes](http://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjectiveC/Articles/ocProperties.html#//apple_ref/doc/uid/TP30001163-CH17-SW2).


Na implementação, usamos o <code>@synthesize</code> para informar ao compilador
que ele deve sintetizar os métodos, caso você não o faça.

**Importante:** O <code>@synthesize</code> **não** implementa nada para
o <code>dealloc</code>, por isso você precisa fazer o <code>release</code>
manualmente, como feito no exemplo acima.

### Syntax Sugar

A property ainda introduz um sintax sugar mais familiar para os Rubistas. Ao
invés de ter que fazer:

Antigo:
{{< highlight objc >}}
    [car setModel:model];
{{< / highlight >}}

Novo:
{{< highlight objc >}}
    car.model = model;
{{< / highlight >}}

Para obter o valor é a mesma coisa. Isso facilita para pessoas que vem de outra
linguagem e diminui o "barulho" da sintaxe com colchetes, que algumas pessoas
não gostam. Compare:

Colchetes:
{{< highlight objc >}}
homeButton = ...
[[self getNavigationItem] setLeftBarButtonItem:homeButton];
{{< / highlight >}}

"Dot-syntax":
{{< highlight objc >}}
homeButton = ...
self.navigationItem.leftBarButtonItem = homeButton;
{{< / highlight >}}

Isso encerra o conteúdo sobre properties em Objective-C. Esse post foi
basicamente uma compilação das seguintes referências:

* [Learn Objective-C &mdash; Cocoa Dev Central](http://cocoadevcentral.com/d/learn_objectivec/)
* [Declared properties &mdash; Doc. oficial](http://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjectiveC/Articles/ocProperties.html#//apple_ref/doc/uid/TP30001163-CH17-SW1)
* [Memory Management Programming Guide &mdash; Doc. oficial](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/MemoryMgmt/MemoryMgmt.html#//apple_ref/doc/uid/10000011-SW1)

## Apêndice: Autorelease Pools

Uma coisa que eu não mencionei no artigo é a possibilidade de usar
<code>autorelease</code>, conforme demonstrado abaixo:


{{< highlight objc >}}
NSString* anotherCoolString = [[[NSString alloc] 
                                initWithString:@"Cool string!"]
                                autorelease];
{{< / highlight >}}


O <code>autorelease</code> coloca o objeto em um "autorelease pool", no qual vai
ser liberado automaticamente pelo sistema poucos momentos depois (mais detalhes
virão). Mas há de se pensar, qual a diferença de um garbage collector?

A diferença é que o autorelease pool não verifica se há referências ao
objeto. Uma vez que o autorelease pool decida que vai liberar a referência do 
objeto, outras referências automaticamente se tornarão inválidas. Em
contrapartida, o Garbage collector só vai liberar se não houver referências.

Os "autorelease pools" são criados no início de um event-loop e esvaziados no
final quando está sendo usado algum Kit, como iOS ou Mac. Quando se faz
programas de linha de comando, é necessário cria-las e esvazia-las manualmente.

Mas então quer dizer que eu posso simplesmente sair chamando
<code>:autorelease</code> nos objetos? Não. O problema de se usar o autorelease
pool é o alto consumo de memória se não for controlado e o fato do autorelease
pool ser constantemente esvaziado pode causar inconsistências na sua app &mdash;
objetos serem liberados da memória antes do previsto.

Mais detalhes na [documentação oficial](http://developer.apple.com/library/mac/#documentation/cocoa/Conceptual/MemoryMgmt/Articles/mmAutoreleasePools.html).
