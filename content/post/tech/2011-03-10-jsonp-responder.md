---
categories:
- Rails
date: "2011-03-10T00:00:00Z"
description: Um Responder JSONP no Rails 3
keywords: rails, jsonp
---

# Criando um Responder para JSONP no Rails 3

Recentemente eu tive que implementar uma feature no [call4paperz](http://www.call4paperz.com)
que é responder dados dos eventos do site em JSONP.

JSONP é na verdade bem similar com a resposta JSON que o site já tinha, porém
a resposta não mais é JSON puro, e sim um código JavaScript que chama um
callback especificado. Quando a resposta do servidor for executada, esse
callback é chamado automaticamente. Exemplo:

{{< highlight javascript >}}
my_callback({"foo": "bar"});
{{< / highlight >}}

Mas, para dar esse suporte, eu não queria arruinar os _controllers_ que já
estavam simples e elegantes, com o <code>respond_with</code>:

{{< highlight ruby >}}
class EventsController < ApplicationController
    respond_to :json, :xml, :html

    def index
        @events = Event.all
        respond_with @events
    end

    # ...
end
{{< / highlight >}}

Obviamente, senti a necessidade de criar um novo formato de resposta na
aplicação. A API de Responders no Rails 3 funciona muito bem para isso. Dessa
forma, eu:

* Adicionei um _handler_ JSONP para o meu Responder já existente (eu uso a gem [responders](http://github.com/plataformatec/responders));
* Adicionei um Mime type para isso;
* Adicionei <code>respond\_to :jsonp</code> ao _controller_.

## Adicionar um handler JSONP

Como eu já tinha um Responder devido a gem, eu simplesmente adicionei o método
to\_jsonp a ele:

lib/jsonp\_responder.rb
{{< highlight ruby >}}
module JSONPResponder
  def to_jsonp
    render :json => "#{callback}(#{resource.to_json});"
  end

  private
  def callback
    controller.params[:callback]
  end
end
{{< / highlight >}}

lib/application\_responder.rb
{{< highlight ruby >}}
class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder
  include JSONPResponder
end
{{< / highlight >}}

## Adicionar um Mime type

Como não há de fato um Mime type específico para JSONP, o site deverá responder
como <code>application/javascript</code>, já que não respondemos mais JSON
válido.

config/initializers/mime\_types.rb
{{< highlight ruby >}}
Mime::Type.register_alias "application/javascript", :jsonp
{{< / highlight >}}

## Adicionar respond\_to :jsonp ao controller

Esse é o passo mais simples de todos:

{{< highlight ruby >}}
class EventsController < ApplicationController
    respond_to :json, :jsonp, :xml, :html

    def index
        @events = Event.all
        respond_with @events
    end

    # ...
end
{{< / highlight >}}

## Finito!

Simples, não? O código do _controller_ continua limpo como deveria ser, graças
à API de Responders do Rails 3. Mais informações sobre ele pode ser visto
em um [blog post do próprio Rails](http://weblog.rubyonrails.org/2009/8/31/three-reasons-love-responder).
