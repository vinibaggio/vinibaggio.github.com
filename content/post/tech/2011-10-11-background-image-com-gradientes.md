---
categories:
- CSS
date: "2011-10-11T00:00:00Z"
description: Misturando imagens de background com gradientes
keywords: css, css3, background, gradiente, gradient
---

# Misturando imagens de background com gradientes

Estou trabalhando atualmente no site [RockInSampa](http://www.rockinsampa.com),
um site que agrega os shows de rock da cidade de São Paulo. O layout final
do site é o seguinte:

![Layout](/images/posts/rock-in-sampa/layout-rock-in-sampa.png)

O fundo dele consiste de uma leve "textura" com noise, dando uma impressão de
cimento ou asfalto, e também um gradiente que vai escurecendo conforme chega-se
ao fundo da página.

Porém, este efeito é problemático de se implementar. Se criarmos uma imagem de
background suficientemente grande para cobrir toda a possível altura que o site
pode chegar, a imagem ficará gigante, deixando o site mais lento para carregar.

Dessa forma, eu recortei a textura, sem o gradiente:

![Textura](/images/posts/rock-in-sampa/textura.png)

{{< highlight css >}}
body {
    background: #1e1e1e;
    background-image: url('textura.png');
}
{{< / highlight >}}

O resultado foi:

![Textura aplicada](/images/posts/rock-in-sampa/textura-aplicada.png)

Em seguida, usando a propriedade de gradientes do CSS3 e cores alpha, consegui
alcançar o background que queria:

![Gradiente aplicado](/images/posts/rock-in-sampa/gradiente-aplicado.png)

{{< highlight css >}}
html { min-height: 100%; }

body {
    background: #1e1e1e;
    background-image: -webkit-linear-gradient(top, rgba(100, 100, 100, 0.2),
        rgba(0, 0, 0, 0.5)), url('textura.png'); /* Chrome 10+, Saf5.1+ */
}
{{< / highlight >}}

Há alguns detalhes importantes sobre o CSS acima:

+  É importante colocar o min-height: 100% no nó HTML pois se o conteúdo da sua página não atingir 100% da tela, o gradiente irá terminar justamente no final do conteúdo, ficando um resultado bem estranho.
+  É possível combinar dois ou mais fundos em um nó. Usei essa técnica para
  aplicar a imagem e, em seguida, o gradiente por cima. A ordem é sim
  importante, invertê-la irá sumir com o gradiente.
+  Omiti o CSS equivalente para outros browsers para ficar mais claro. Como o CSS3 gradient ainda não
  é padrão de todos os browsers, é necessário colocar os vendors e suas
  especificidades. O resultado final do CSS pode ser observado no [gist](https://gist.github.com/1274488).
+  Eu acho interessante deixar uma cor de fundo, caso tudo dê errado e a imagem
  não seja exibida, ainda deixará o site com uma aparência razoável.
+  Este CSS está funcionando perfeitamente em Opera, Firefox e Chrome. Não funciona no IE 7, IE 8 e IE 9, mas deve ser possível fazer algum hack. Para o RockInSampa, eu fiz um fallback com o background somente com a textura.

Para mais informações sobre gradientes CSS, veja [neste post no CSS tricks](http://css-tricks.com/5700-css3-gradients/).

