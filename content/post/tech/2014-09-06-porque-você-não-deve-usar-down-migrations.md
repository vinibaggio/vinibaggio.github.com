---
title: "Porque você não deve usar down migrations"
date: 2014-09-06 17:27:40.674 +0000 UTC
author: "Vinícius Baggio Fuentes"

---

Se você trabalha com web, é muito provável que você já usa migrações de banco de dados. Frameworks Web como Rails adotam migrações em seu design por padrão e projetos como [Goose](https://bitbucket.org/liamstask/goose) ou [DbMaintain](http://dbmaintain.org) tornam migrações fáceis de ser aplicadas em qualquer projeto.

Porém, você já pensou o que acontece quando o aplicativo precisa ser atualizado em produção, e você precisa rodar migrações de banco? Vamos pensar em um exemplo para ilustrar o problema. Imagine que a Zezinho Ltda está atualizando o seu ERP e os desenvolvedores querem trocar o nome da coluna “e_mail” para “email”.

No caso de um aplicativo pequeno, no qual apenas uma máquina dá conta de todas as requisições, o processo é tranquilo (exceto passo 1):

1.  Dia anterior: colocar o alarme para às 2:00, às 2:05, às 2:10, 2:15 e 2:30
2.  2:30 Entrar na VPN/Cloud
3.  2:33 Coloca uma página “estamos em manutenção”
4.  2:35 Pára a aplicação
5.  2:36 Roda migrações no banco
6.  2:38 Sobe a aplicação
7.  2:40 Testa para ver se deu tudo certo
8.  2:45 Tira a página “estamos em manutenção”
9.  2:50 Dar refresh que nem louco no dashboard de monitoração, “só pra ter certeza”
10.  3:00 Voltar à dormir

Essa pode ser uma solução plausível para projetos internos, no qual sabemos os horários mais tranquilos para fazer “janelas de manutenção”.

Agora imagine que, ao invés de ser uma empresa pequena, a Zezinho Ltda se tornou ZezinhoCorp, já fez IPO há dois anos e o seu maior cliente é baseado na Malásia. A janela de manutenção não rola mais, pois não importa o horário, haverá alguém acessando o ERP e que vai ficar fulo da vida se o site não funcionar. E agora? Você tem a seguinte lista não-exaustiva de opções:

*   Você pode sacar o trunfo “é o que tem pra hoje” e fazer a migração online, sem a página de manutenção. Porém, Murphy vai fazer questão de mandar a requisição de compra de 500,000 dólares malasianos (cerca de R$350,000) para o servidor que ainda se refere à coluna antiga e que provavelmente vai dar zica. Seu cliente vai ficar triste, mas mais triste ainda ficará o valor de suas ações.
*   Mandar um email para todos os seus clientes falando da janela de manutenção e travar o site. Essa alternativa é a menos ruim, mas não significa que é boa. Lembro-te que a web não tem horário de funcionamento.

Podemos ser mais inteligentes. Vamos então pensar em alguma forma de evitar o seguinte pseudo-SQL:
`ALTER TABLE users RENAME COLUMN e_mail TO email`

O que vamos fazer é alterações de versões em múltiplas etapas. Ou seja, para renomear a coluna, precisamos:

1.  Criar uma nova coluna no banco, chamada email;
2.  Fazer o double writing, ou seja, escrever o dado tanto na coluna “email” quanto na coluna “e_mail”, mas ainda consumir de “e_mail”;
3.  Quando a versão do aplicativo que faz double writing estiver no ar, você pode fazer o backfill, ou seja, copiar os valores “e_mail” para “email” das entradas no banco que ainda não tiverem esses valores, porém ainda consumir de “e_mail”;
4.  Backfill completo, consumir a partir da coluna “email”;
5.  Quando você tiver certeza que não há versões do aplicativo que ainda usam “e_mail”, você pode deletar a coluna antiga e apenas ler da coluna nova.

Parece complicado, mas não é. É claro que existem milhões de fatores que devem ser considerados, como caching, sharding e etc, que na verdade se tornam muito mais fáceis pelo uso dessa prática.

O que isso tem a ver com o título do post — “Porque você não deve usar down migrations”? Pode parecer desconectado, mas a filosofia de down migrations (que você reza para nunca precisar usar e executa só quando der muita merda) é equivocada. Se você precisar executar down migrations, quer dizer que a versão atual e a versão anterior do banco de dados são “ou-exclusivas”, ou seja, são como irmão-mais-velho e irmão-mais-novo, não se bicam.

Removendo o conceito de down migrations do seu processo de desenvolvimento faz você forçar o pensamento em migrações progressivas como ilustrei anteriormente, ou seja, o seu código deve ser capaz de lidar com múltiplas versões do banco de dados. É sim um esforço mais complicado, mas o retorno, espero que tenha sido claro!

O que você acha? Se você concorda ou discorda, deixe um comentário.
