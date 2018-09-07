---
title: "Pipeline de distribuição de aplicativos iOS"
date: 2014-08-27 15:06:23.86 +0000 UTC
author: "Vinícius Baggio Fuentes"

---

_Esse artigo é baseado em uma apresentação que dei no Medium TechTalks em 19 de Agosto de 2014._

Para distribuir aplicativos Web, garantindo qualidade, é necessário o uso de chaveamento de funcionalidades, ou “feature toggling”. O chaveamento de funcionalidades permite que administrador possa ligar ou desligar uma funcionalidade, sem a necessidade de um novo deploy ou alteração código. É possível também determinar quais grupos de usuários irão observar essa funcionalidade, ou uma quantidade de usuários (1%, 5%, 50%, etc).

Com o chaveamento de funcionalidades, é possível realizar testes A/B, ou seja, uma parte de usuários irão observar funcionalidade A, outra fatia, a B. Outro uso importante dessa funcionalidade é desativar uma funcionalidade com defeito. Assim, quando se faz um deploy de uma aplicativo com uma série de funcionalidades, não é necessário fazer o rollback do sistema para desfazer-se de um ocasional defeito, bem como progressos no sistema. Isso dá agilidade à toda a equipe de desenvolvimento e de operações.

É possível liberar uma nova funcionalidade para apenas parte dos usuários, por exemplo 1%, por meio de deploy “rolante”. Também, através de rastreamento e métricas, medir o status, e, à partir daí, aumentar progressivamente o número de usuários que irão observá-la. Caso algum defeito seja apresentado, um sistema de controle de saúde do sistema pode automaticamente desativá-la e evitar que maior número de usuários do sistema observem erros.

Este conjunto de funcionalidades tornam um sistema flexível o bastante para que seja eliminado o ritual formal do deploy, tornando-o uma coisa banal e muito frequente, como dezenas ou centenas de vezes por dia. A redução do tempo de deploy entre sistemas dá aos desenvolvedores uma ferramenta muito poderosa: o curto tempo de funcionalidade pronta estar disponível. Dessa forma, a evolução de um sistema mais correto é encorajado, já que correções de defeitos tendem a chegar em produção mais rapidamente.

Com essa premissa em mãos, o que podemos aproveitar deste conhecimento para fazer o deploy de aplicativos iOS? Há duas grandes diferenças que tornam este processo mais difícil. Primeiro, o tempo de aprovação de um aplicativo pela Apple é, no mínimo, maior que um dia, tornando o ciclo de deploy muito demorado. Em segundo, a distribuição de aplicativos para os usuários de teste, antes da aprovação do aplicativo pela Apple, necessita-se do cadastramento de cada um deles, e do UDID, ou ID do dispositivo, um processo laborioso.

Considerando esses desafios, elaboramos uma lista de requisitos para um sistema de distribuição pré-App Store, para que possamos trazer ao menos parte dos benefícios de distribuições de aplicativos web ao cenário da Apple:

*   Chaveamento de funcionalidades
*   _Over-The-Air (OTA) updates;_
*   Sistema de relatório de crash;
*   Sistema de autorização;
*   Sistema de versionamento bem definido;
*   Canais de distribuição

#### Chaveamento de funcionalidades

O chaveamento de funcionalidades é fundamental para a distribuição de aplicativos, conforme foi discutido. Contudo, existem duas vantagens que essa abordagem nos dá no desenvolvimento de aplicativos iOS: desativar funcionalidades defeituosas mesmo com o aplicativo aprovado pela Apple — muito importante em momentos de emergência. Outro caso é o desenvolvimento de funcionalidades que ainda não estão prontas para o uso por usuários, mesmo que estejam prontas em termos de qualidade de engenharia. Veja o exemplo a seguir, quando desenvolvíamos a funcionalidade de recomendação com anotação:




![image](https://cdn-images-1.medium.com/max/800/1*fgHMgDW1ZhDS7FHglvQ8aw.png)

Funcionalidade de recomendação, vista por usuários em geral





![image](https://cdn-images-1.medium.com/max/800/1*KrWbu9UkEfgaWnJ3AajDmQ.png)

Funcionalidade de recomendação, vista por desenvolvedores



Recomendo os projetos [GroundControl](https://github.com/mattt/GroundControl) e [SkyLab](https://github.com/mattt/SkyLab) para implementar chaveamento de funcionalidades em seu projeto.

#### Over-The-Air updates, relatório de crash e autorização

Atualizações Over-The-Air (OTA) são atualização de software sem o uso de software externo, como iTunes. Ou seja, dentro de sua própria aplicação você deverá ser capaz de detectar se há atualizações disponíveis e então fazer a atualização in loco. Isso traz à equipe de desenvolvedores a confiança de que todos os testadores estão utilizando a versão mais atual que cabe a eles.

Serviços de terceiros como [Crashlytics Beta](http://crashlytics.com) ou [HockeyApp](http://hockeyapp.net/), ou [até mesmo o serviço da Apple Beta, que está por vir](http://techcrunch.com/2014/06/02/ios-testflight/), são serviços que provém atualizações OTA. Não é difícil, porém, construir o seu próprio. Um exemplo a seguir é o [protocolo Omaha utilizado pelo CoreOS](https://coreos.com/docs/coreupdate/custom-apps/coreupdate-protocol/).

Em aplicativos iOS, é muito mais difícil obter dados sobre o dispositivo do usuário no momento que um crash acontece. Recomendo o uso de um serviço de terceiro, que se responsabiliza pela captura de exceções não tratadas e interrupções e envio desses relatórios de uma maneira que seja fácil consumir os dados e analisar stack traces para fazer a depuração de um defeito. Um exemplo de serviço é o [Crashlytics](http://crashlytics.com), que usamos e estamos satisfeitos.

Por fim, autorização é importante para que você possa controlar o acesso aos binários do aplicativo, de forma que um link não seja copiado e distribuído de maneira inapropriada, e garantindo que apenas os usuários designados terão acesso a certos binários. Mais uma vez, serviços como Crashlytics e HockeyApp fazem isso para você, mas não é difícil fazer algo integrado à seu aplicativo, caso já exista, e é o que fazemos no Medium.

#### Sistema de versionamento

No desenvolvimento de aplicativos iOS, infelizmente não podemos apenas incrementar números de versão para os binários. Isso deve-se ao fato de que temos múltiplas versões do aplicativo em distribuição e em desenvolvimento, seja na App Store, seja para usuários de testes ou mesmo internamente na empresa. Dessa forma, adotamos um versionamento similar ao [Semantic Versioning](http://semver.org/).

Uma versão de um binário é composto de três dígitos, na forma de M.m.p, sendo M _major,_ m _minor e_ p _patch._ Por exemplo, 1.4.91 corresponde a versão major 1, 4 minor e patch 91. A versão major usamos para identificar alterações fundamentais no aplicativo. A versão minor é uma versão cuja há funcionalidades menores, mas que o produto ainda continua sendo o mesmo em sua filosofia. A combinação major e minor chamamos de “família”, ou _short version_, conforme terminologia estabelecida pela Apple. Finalmente, a versão patch incrementa quando fazemos correções de bugs ou melhorias de performance.

Para suportar este sistema de versionamento, temos um conjunto de ferramentas escritas em Python que são executadas automaticamente por jobs no sistema de Continuous Integration, que guarda estes metadados no software de versionamento Git. Usando a terminologia git, o branch _master_ contém a versão mais atual do desenvolvimento do aplicativo:




![image](https://cdn-images-1.medium.com/max/800/1*n0x4dJvb_91kbg_OwxgMHA.png)



Quando determinamos que uma nova versão do aplicativo deve ser gerada para distribuição, congelamos o produto em termos de funcionalidades e o produto vai para avaliação internamente e externamente com um time de QA. Assim, fazemos um branch congelando a família:




![image](https://cdn-images-1.medium.com/max/800/1*WHS-t5FmyQMAZUIi2ptoLQ.png)



Caso algum defeito seja descoberto no desenvolvimento, fazemos as correções necessárias e geramos uma nova versão completa, incluindo todos os componentes da versão. Isso garante, que temos um produto cujas funcionalidades que estão inclusas são conhecidas, quem tem acesso a essas funcionalidades e eventualmente, quais defeitos existem. Dessa forma, o binário continua vivo e preparando-se para distribuição de maior audiência, enquanto desenvolvimento de novas funcionalidades não pára:




![image](https://cdn-images-1.medium.com/max/800/1*EEb8Ixc-xSVcaQab6PQtCw.png)



Finalmente, existe a possibilidade de um novo congelamento de funcionalidades. Criamos então uma nova família do software, sem impedir que o restante continue o desenvolvimento:




![image](https://cdn-images-1.medium.com/max/800/1*-oir2uM6omWF_L6pHb9R8w.png)



A maior desvantagem desse mecanismo é a necessidade de garantir que correções importantes sejam integradas em todas as famílias de versão, portanto fazemos os ciclos de distribuições curtos tal que não temos muitas versões correndo em paralelo.

#### Canais de distribuição

Determinamos canais de distribuição para formalizar dentro e fora da empresa, quais versões dos produtos estão disponíveis e para quem. Dessa forma, criamos também um dialeto interno tal que sabemos em que ponto de maturidade o binário se encontra de acordo com qual canal de distribuição e quanto tempo o aplicativo está lá.

Exemplos que temos na empresa de canais de distribuição são: _trusted testers_ ou _friends and family_— amigos, familiares, cônjuges e etc. O que caracteriza este canal é que relatório de bugs podem ser feitos de maneira bem informal, através de envio de mensagens via instant messengers ou mesmo mostrando pessoalmente. Outro canal que usamos é o canal _beta,_ em que usuários que nos acompanha desde o início, usuários importantes, _advisors_, etc. O processo de feedback e acompanhamento é bem mais formal, e queremos que esses usuários tenham uma experiência mais completa e estável. A forma que transitamos uma versão de aplicativo entre esses canais é da seguinte forma:




![image](https://cdn-images-1.medium.com/max/800/1*UegU3qMkWU06wmD0CZQoPw.png)



Toda vez que fazemos um _merge_ de código, o sistema de integração contínua irá executar os testes e, caso haja sucesso, irá distribuir uma nova versão automaticamente para os funcionários da empresa. Após um dia, distribuímos essa versão para os testers. Uma vez que esse binário apresenta-se estável durante uma semana, enviamos aos beta testers. Essas datas são flexíveis para que tenhamos agilidade na distribuição de um aplicativo, de acordo com a confiança nas mudanças. Porém, antes de enviar o aplicativo à App Store, deixamos este binário na mão de beta testers por pelo menos 3 dias, de acordo com o nível de uso do aplicativo e das funcionalidades em teste, determinados por métricas.

#### Lições aprendidas

Ao construir este projeto, aprendemos alguns detalhes que nos permitiram andar com maior velocidade e confiança em qualidade:

**Uso de Xcconfigs:** Arquivos Xcconfig sobrescrevem todas as configurações estabelecidas pelo Xcode. Esses arquivos garantem os parâmetros para a construção do binário, não importando qual a configuração de cada computador. Nesses arquivos, configuramos desde parâmetros de compilador até qual servidor o binário deverá atingir. Observe o meta-arquivo abaixo:
`#include “base.xcconfig”  
#include “Servers/medium.xcconfig”  
#include “Build/config-debug.xcconfig”``MEDIUM_DISTRIBUTION_CHANNEL = mediumStaff`

Neste arquivo, base.xcconfig irá incluir os parâmetros de compilação que não mudam, em seguida apontamos o cliente para o servidor oficial do Medium (ao contrário de versões que apontam para [servidores canário](http://www.infoq.com/news/2013/03/canary-release-improve-quality), ou localhost, etc) e por fim, incluímos as configurações de debug. A última linha demonstra como determinamos um canal de distribuição para um binário.

**Uso de -derivedDataPath:** Usado na compilação via CLI, o -derivedDataPath evita problemas como erros no preprocessamento de arquivos de cabeçalho, e caching de objetos compilados, gerando binários não determinísticos. Especificamos um novo diretório a cada compilação, de forma que podemos compilar projetos em paralelo, com a desvantagem que a compilação toma mais tempo. Porém, ganhamos tempo ao evitar a depuração de erros de compilação.

**Comunicação sobre versionamento de canais de distribuição:** É necessário que todo o time saiba comunicar entre si e que todos tenham acesso aos scripts para a manipulação deste pipeline. Dada a complexidade do sistema, problemas de comunicação podem acontecer e é necessário haver um local canônico para esta informação e as ferramentas devem ser documentadas.

**Automação completa:** todo processo manual é passível de erros, portanto a automação é essencial. Além disso, com o uso de uma boa ferramenta de integração contínua, é possível que qualquer engenheiro na empresa, mesmo sem os certificados e ambiente configurado possa gerar novos binários e novas distribuições. Usamos Jenkins ao invés de Xcode Bots dado que ele é bastante inflexível para fazer as automações descritas neste artigo. Outras ferramentas que ajudam nessa automação são as ferramentas da suite [Nomad-CLI](http://nomad-cli.com/) e o pacote binplist do Python, para manipulação de arquivos plists binários ou XML.

#### Referências

*   [www.nomad-cli.com](http://www.nomad-cli.com/)
*   [jenkins-ci.org](http://jenkins-ci.org/)
*   [crashlytics.com](http://crashlytics.com/)
*   [https://github.com/mattt/GroundControl](https://github.com/mattt/GroundControl)
*   [http://semver.org](http://semver.org/)
*   [hockeyapp.net](http://hockeyapp.net/)
*   [http://www.infoq.com/news/2013/03/canary-release-improve-quality](http://www.infoq.com/news/2013/03/canary-release-improve-quality)
*   [http://techcrunch.com/2014/06/02/ios-testflight/](http://techcrunch.com/2014/06/02/ios-testflight/)
