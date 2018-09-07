---
categories:
- resque
date: "2012-03-29T00:00:00Z"
description: Tomar cuidado com a configuração de servidores com o resque-web.
keywords: Servidores, resque-web
---

# Careful With That Hax, Eugene

(Esta é uma brincadeira com o nome da música "Careful with that axe, Eugene",
do Pink Floyd)

Dificilmente temos um site hoje em dia em que não precisamos usar jobs em
background. Para Rails, o [Resque](http://github.com/defunkt/resque) é uma
das soluções mais populares.

O resque vem com uma ferramenta bem elegante para monitoração das filas:

![Resque-web](/images/posts/careful-hax/resque-web.png)

Essa ferramenta é excelente para monitorar e depurar os jobs executando
no site atualmente. Por isso é bastante comum colocarmos o resque-web em
algum ponto tal que possamos acessar de qualquer lugar para gerenciar as
filas.

## Jeito 1: servidor embutido do resque-web

O jeito mais simples de colocar esse monitor no ar é executando o resque-web
manualmente e protegê-lo via HTTP Basic auth.

Dessa forma, basicamente basta rodar o resque-web:

    resque-web config/resque-web.rb

E, em seguida, protegê-lo, no nginx podemos fazer:

    upstream resque {
      server 127.0.0.1:5678;
    }
    
    server {
      server_name resque.example.com;
    
      location / {
        auth_basic "Restricted";
        auth_basic_user_file /opt/nginx/conf/htpasswd;
        proxy_pass http://resque;
      }
    }

Assim, ao acessar resque.example.com, você será apresentado por uma tela de
autenticação comum HTTP (lógico que você precisa gerar o htpasswd).

### Rá! Pegadinha do Mallandro! Ié ié!

Tem um problema nessa história. Por padrão, o <code>resque-web</code> faz bind
no host <code>0.0.0.0</code>. Isso significa que requisições por *qualquer*
interface de rede irá responder. Assim, se você digitar o IP e a porta
diretamente, o <code>nginx</code> não irá interceptar a requisição e irá cair
no <code>resque-web</code>, que é um grande risco, já que você pode deletar as
filas e ver informações talvez sensíveis.

A solução é bem simples. Basta você iniciar o resque-web com o comando para
fazer o bind no host <code>127.0.0.1</code>. Isso fará com que
o <code>vegas</code> (servidor HTTP que o <code>resque-web</code>) receba
apenas conexões via loopback, ou seja, apenas de servidores locais (tudo isso
quem faz é o esperto do kernel do Linux).

    resque-web -o 127.0.0.1 config/resque-web.rb

Ou seja, se você for ao endereço de IP, por exemplo
<code>200.100.123.456:5678</code>, a requisição jamais irá chegar no
<code>resque-web</code> pois o servidor vegas não estará ouvindo requisições da
interface de rede exposta à internet, mas o nginx será capaz de comunicar-se
pois estão em contato via loopback. Legal né?

## Jeito 2: resque-web dentro do Rails

Outra maneira é embutir o <code>resque-web</code> dentro da sua aplicação
Rails. O problema dessa forma é que você irá ocupar preciosos recursos de sua
web app com painel de administração. Ou talvez você nem queira ter sua app
rails rodando no mesmo servidor em que o resque estiver executando.

A grande vantagem dessa forma é que você pode usar de regras de aplicação
dentro do Rails. O <code>resque-web</code> não deixa de ser uma Rack app,
podendo ser montada facilmente dentro do Rails:

{{< highlight ruby >}}
Coolapp::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"
end
{{< / highlight >}}

O mais legal de tudo é que se você usar o Devise, você pode usar o sistema de
login da sua própria aplicação para permitir apenas admins a entrarem no
<code>resque-web</code>:

{{< highlight ruby >}}
Coolapp::Application.routes.draw do
  authenticate :admin_user do
    mount Resque::Server.new, :at => "/resque"
  end
end
{{< / highlight >}}

Um único porém dessa solução é que, ao tentar entrar deslogado, rola uma
redireção infinita, mas deve ser alguma coisa que eu fiz de errado, que no meu
caso deve relacionar-se com o ActiveAdmin.

Essa versão também tem outro problema. Em produção, quem serve os arquivos
estáticos é o nginx ou Apache. Dessa forma, ao fazer deploy, você tem que fazer
um symlink dos estáticos dentro da gem para o seu public, que pode ser um pouco
chato.
