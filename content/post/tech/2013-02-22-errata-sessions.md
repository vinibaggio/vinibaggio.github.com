---
categories:
- Rails
date: "2013-02-22T00:00:00Z"
description: Errata do livro Ruby on Rails sobre sessões
keywords: rails, session, digest, cookies
---

# Errata: Sessões em Rails

No meu livro Ruby on Rails: Coloque sua aplicação web nos trilhos, há um
capítulo sobre sessões e cookies, em que eu falo:

    O Rails já sabe disso e sabe a melhor maneira de prever ataques como esse.
    E é justamente essa a grande diferença entre o cookie e o session
    - o session é encriptado usando uma chave "mágica", de forma que o usuário
    nunca saberá o conteúdo do cookie e, portanto, dificilmente conseguirá forjar
    uma sessão.

Isso está **errado**. No Rails 3, as sessões do Rails estão apenas codificadas
usando Base 64 e assinadas, usando HMAC-SHA1. Ou seja, as mensagens não são
encriptadas, portanto é possível ler a sessão quando se tem acesso aos cookies.
Veja o exemplo abaixo, de uma sessão do Colcho.net:

{{< highlight ruby >}}
session = "BAh7B0kiD3Nlc3Npb25faWQGOgZFRkkiJTBkM2FmNTlkNDcy\
N2VhNDJkZTRhYzE4YjQ0Yjc5OGJkBjsAVEkiEF9jc3JmX3Rva2VuBjsARkki\
MVh1NFMvUWJnOG9pQ0NsbjRkbnducFhTZXEzaUl0NDArVkFQVHVTZi9CZlE9\
BjsARg%3D%3D--100ae84bad4e222ebd17a30f44dac7424549e94f"

data, digest = session.split('--')
Marshal.load(Base64.decode64(data))
{{< / highlight >}}

O resultado é:

{{< highlight ruby >}}
{
    "session_id"=>"0d3af59d4727ea42de4ac18b44b798bd",
    "_csrf_token"=>"Xu4S/Qbg8oiCCln4dnwnpXSeq3iIt40+VAPTuSf/BfQ="
}
{{< / highlight >}}

Esse código está na classe [MessageVerifier](https://github.com/rails/rails/blob/3-2-stable/activesupport/lib/active_support/message_verifier.rb#L40-L50), do <code>ActiveSupport</code>.

Esta informação tem sido notícia recentemente, por causa de uma nova
funcionalidade no Rails 4: cookies encriptados de fato. Para usá-lo, basta
alterar o seu session_store.rb:

{{< highlight ruby >}}
ColchoNet::Application.config.session_store :encrypted_cookie_store, key: '_colcho_net_session'
{{< / highlight >}}

Ainda é possível migrar as sessões dos seus usuários do cookie store para
o encrypted cookie store usando o <code>upgrade_signature_to_encryption_cookie_store</code>.
Mais informações, [veja a documentação](http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#action-pack).
