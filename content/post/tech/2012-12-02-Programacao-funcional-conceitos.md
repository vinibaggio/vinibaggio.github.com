---
categories:
- Prog Funcional
date: "2012-12-02T00:00:00Z"
description: Artigo sobre a definição de programação funcional e a comparação com
  outros paradigmas de programação.
keywords: programação funcional, scala, erlang, clojure
---

# Programação funcional: conceitos

Observação: Esta série sobre programação funcional é basicamente uma
interpretação _minha_ do que estou aprendendo enquanto estudo. Note que o tempo
verbal usado é o presente no modo contínuo. Isso significa que eu ainda estou
aprendendo, e portanto, este e outros artigos estão sujeitos a erros crassos ou
aproximações ingênuas.

## Por que programação funcional importa?

Antes de entrarmos em exemplos de programação funcional e os principais
conceitos envolvidos, primeiro vamos entender a motivação por trás desse
paradigma e por quê ela se mostra uma boa alternativa para a resolução de
problemas na computação.

Existe um artigo excelente chamado ["Why functional programming
matters"](http://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf), do
qual recomendo a leitura a partir do momento que você estiver um pouco mais
confortável com as ideias vistas aqui, que eu não considero trivial (pelo menos
não para mim, que não vi esse paradigma no curso de Ciências da Computação).

Em programação procedural (e, por ter sido originado em programação procedural,
podemos considerar também programação orientada a objetos), como o nome diz,
descrevemos, em um procedimento (ou função, ou método, se preferir), passos
para a resolução de um problema. Esses passos podem consistir de declaração de
variáveis, transformação de tipos dos parâmetros (uma string em um vetor de
valores, por exemplo), alocação de memória, cálculos matemáticos, chamadas a
outros procedimentos, etc.

Em programação funcional, saímos um pouco dos detalhes de implementação
e tentamos descrever o problema usando outros pedaços menores de funções. Em
geral, usa-se bastante recursividade para isso, de forma que a solução do
problema geral é a abstração da solução de um problema menor, conhecido.
Fazemos o layout geral da solução do problema, e depois partimos para os
detalhes do algoritmo.

Se isso te lembra provas por indução, na matemática, você não está enganado. Se
você pensar dessa maneira quando estiver escrevendo programas funcionais, verá
que seu código ficará, em geral, mais limpo e mais elegante. Veja também que
nada nos impede de escrevermos programas orientados a objetos da mesma maneira,
e é essa a grande vantagem de aprendermos programação funcional: é uma mudança
de forma de pensar, e não simplesmente uma limitação técnica.

## Características de linguagens de programação funcional

A principal característica de programação funcional é que não existe atribuição
de variáveis e sim apenas a definição delas. Em programação estruturada, usamos
variáveis como um "balde" nomeado, no qual conseguimos tirar e colocar qualquer
dado dentro deste balde. Isso fica ainda mais claro quando estamos lidando com
linguagens fracamente tipadas, ou seja, linguagens cujas variáveis não requerem
que as variáveis sejam declaradas com tipos.

Na programação funcional, o que fazemos é simplesmente dar um nome a um valor,
porém não podemos mudar. O pensamento é o mesmo da matemática, uma variável em
uma equação é apenas um apelido dado a um valor, seja ele determinado ou não.

Eu particularmente considero essa característica bastante polêmica. Uma das
fundações da programação, no meu ponto de vista, já não funcionava mais. Porém,
existe um outro lado problemático de variáveis: compartilhamento de estado.

O valor de uma variável em programas estruturado depende do tempo, ou seja, só
é possível ter absoluta certeza do valor de uma variável uma vez que
determinamos o exato instante do estado do programa em execução:
