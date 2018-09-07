---
categories:
- Ruby
date: "2011-02-03T00:00:00Z"
description: Algumas pequenas diferenças entre Ruby 1.8 e Ruby 1.9
keywords: ruby
---

# Algumas diferenças entre Ruby 1.8 e 1.9

Recentemente [lancei a versão 0.1.0 do
Outpost](http://blog.plataformatec.com.br/2011/02/outpost-v0-1-0-is-released/),
um projeto que tenho na cabeça faz um século. Dessa forma, para vê-lo
realizado, enviei-o como projeto pessoal para a minha turma do
[RMU](http://university.rubymendicant.com), que foi agora em Janeiro.

A ideia foi um sucesso, consegui terminar boas partes do _core_ do projeto
e ele está de vento em popa. Porém uma das coisas do RMU é que basicamente só
usávamos Ruby 1.9. De qualquer forma, resolvi publica-lo do mesmo jeito.

Enfim, descobri que o Outpost não rodava no Ruby 1.8. Os problemas foram:

## !~ e != não são métodos de verdade

É natural usarmos <code>=~</code> e <code>==</code> em nosso código no
dia-a-dia, e eles são métodos, como era de se esperar:

{{< highlight ruby >}}

# Ruby 1.8

# =~
"abc" =~ /a/ # => 0
"abc".send('=~', /a/) # => 0


# ==
"abc" == "a" # => false
"abc".send('==', "a") # => false

{{< / highlight >}}

Nada mais natural tentarmos usar sua negativa também, certo? Errado:
{{< highlight ruby >}}

# Ruby 1.8

# !~
"abc" !~ /a/ # => false
"abc".send('!~', /a/) # => NoMethodError: undefined method `!~' for "abc":String

# !=

"abc" != "a" # => true
"abc".send('!=', "a") # => NoMethodError: undefined method `!=' for "abc":String
{{< / highlight >}}

Vamos mais além! Vamos tentar implementar o método <code>!=</code>:

{{< highlight ruby >}}

# Ruby 1.8

class String
  def !=(other)
    # whatever
  end
end
# syntax error, unexpected tNEQ
#  def !=(other)

{{< / highlight >}}

Ops! Nem conseguimos implementar o método, temos um erro de sintaxe.
Agora tudo isso ocorre normalmente no Ruby 1.9, como esperado.


## Símbolos não possuem alguns métodos, como upcase

{{< highlight ruby >}}

# Ruby 1.8

:bla.upcase        # NoMethodError: undefined method `upcase' for :bla:Symbol

# Ruby 1.9

:bla.upcase
# => :BLA 

{{< / highlight >}}

## Initializers default diferem

{{< highlight ruby >}}

# Ruby 1.8
class Bla; end
Bla.ancestors    # => [Bla, Object, Kernel]

Bla.new          # => #<Bla:0x101d7efe0> 
Bla.new 1        # ArgumentError: wrong number of arguments (1 for 0)

# Ruby 1.9

Bla.ancestors    # => [Bla, Object, Kernel, BasicObject]

Bla.new          # => #<Bla:0x000001019ac6d8>
Bla.new 1        # => #<Bla:0x00000101953b28>
Bla.new 1,2,3,4  # => #<Bla:0x0000010193fb28>

{{< / highlight >}}

## Mas não é só isso

Esses detalhes na verdade são pequenos, mas que de fato passam despercebidos
quando estamos implementando. Ainda bem que temos uma suite de testes, né? ;)

Para mais detalhes mais interessantes do que temos no Ruby 1.9, veja essa
[seleção especial das novas features](http://blog.mostof.it/ruby-1.9-changes-cherry-picked).
