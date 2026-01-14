begin;

insert into public.categories (id, name, updated_at) values
('68be09dc-e73d-ff41-1589-220baaea442d', $catname0$Caboclos$catname0$, now()),
('30923a92-0f1f-c859-b221-6f1ecffe0a6b', $catname1$Egunitá _ Oroiná$catname1$, now()),
('bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $catname2$Iansã$catname2$, now()),
('a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $catname3$Iemanjá$catname3$, now()),
('b92d98f8-159a-c815-271e-0c44a053ff02', $catname4$Logun Edé$catname4$, now()),
('4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $catname5$Nanã Buruquê$catname5$, now()),
('fc694bba-8c71-f762-b0f3-705b93a5c8ad', $catname6$Obaluaiê$catname6$, now()),
('733c52d2-4676-0982-e37c-e8ed27eb14cd', $catname7$Obá$catname7$, now()),
('3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $catname8$Ogum$catname8$, now()),
('4e5aeee6-7861-cac7-db20-4a43b8402230', $catname9$Oiá Tempo _ Logunã$catname9$, now()),
('dd50b86b-6507-420e-115b-460ed55724c1', $catname10$Omulu$catname10$, now()),
('e4df098d-ac14-6633-ded8-0d2ab271a4c6', $catname11$Ossain$catname11$, now()),
('aac65700-2760-4f83-0702-b8009120587d', $catname12$Oxalá$catname12$, now()),
('5ded97da-d6ce-c352-9ffe-80042e55c80d', $catname13$Oxossi$catname13$, now()),
('845f426a-315f-16b0-d00a-60471b18abf6', $catname14$Oxum$catname14$, now()),
('ff90bc57-689a-9af6-54b5-1c66af310ceb', $catname15$Oxumarê$catname15$, now()),
('1133e4d7-5f35-9e21-9c76-9518b0c3488e', $catname16$Pretos Velhos$catname16$, now()),
('654413a1-1c02-de9b-908d-abc47f2b8e6f', $catname17$Xangô$catname17$, now())
on conflict (id) do update set
  name = excluded.name,
  updated_at = excluded.updated_at;

insert into public.lyrics (id, category_id, title, content, youtube_link, updated_at) values
('5e26987c-0c84-0717-8fcc-fff1db026c31', '68be09dc-e73d-ff41-1589-220baaea442d', $t5e26987c0c8407178fccfff1db026c31$Caboclo Pena Dourada -Lá na aldeia tem um Caboclo forte$t5e26987c0c8407178fccfff1db026c31$, $c5e26987c0c8407178fccfff1db026c31$Lá na aldeia tem um caboclo forte
Foipai Oxóssi quem o enviou
O seu penacho eu vejo a brilhar
Pena Dourada vem cá, vem trabalhar
Que vento é esse tão forte que vem de lá
Mãe Iansã chegando no Jacutá
Anunciando oseu grande amor
Por um Caboclo tão forteque alichegou
Seu rompe mato deu coroa de Orixá
Pena dourada felizentão bradou
Anunciando que ele é Orixá
Oke Caboclo oke oke aro$c5e26987c0c8407178fccfff1db026c31$, NULL, now()),
('f1162738-0f9d-e09c-9fd5-c4ebf48cc664', '68be09dc-e73d-ff41-1589-220baaea442d', $tf11627380f9de09c9fd5c4ebf48cc664$Aldeia do Pai Tupinambá$tf11627380f9de09c9fd5c4ebf48cc664$, $cf11627380f9de09c9fd5c4ebf48cc664$É láque o tambor mora
É láque eu vou tocar
Ooo mais que felicidade
Eu vou lá na aldeia cantar
É láque o tambor mora
É láque eu vou tocar
Ooo mais que felicidade
Eu vou lá na aldeia cantar
Na aldeia do Pai Tupi
Na aldeia do Pai Tupi
Na aldeia do Pai Tupinambá (Bis)
Eu matei minha saudade
Eu vio caboclo dançar
Na aldeia ele é majestade
Na Umbanda ele é nosso Pai (Bis)
Na aldeia do Pai Tupi
Na aldeia do Pai Tupi
Na aldeia do Pai Tupinambá (Bis)$cf11627380f9de09c9fd5c4ebf48cc664$, NULL, now()),
('84818590-bbea-ba3d-e930-e938668f7eee', '68be09dc-e73d-ff41-1589-220baaea442d', $t84818590bbeaba3de930e938668f7eee$Cabocla Iara$t84818590bbeaba3de930e938668f7eee$, $c84818590bbeaba3de930e938668f7eee$ôôôô...Cabocla Iara
que lindas flores
tem no seu Congá
ôôôô...Cabocla Iara
Senhor Oxóssi
quem mandou enfeitar
ôôôô...Cabocla Iara
que lindas flores
tem no seu Congá
ôôôô...Cabocla Iara
Senhor Oxóssi
quem mandou enfeitar
Cabocla Iara
tem a pele morena
Cabocla Iara
vem no Reino da Jurema$c84818590bbeaba3de930e938668f7eee$, NULL, now()),
('a4000c8b-3500-70bd-d822-6b12e296119e', '68be09dc-e73d-ff41-1589-220baaea442d', $ta4000c8b350070bdd8226b12e296119e$Caboclos -Dois guerreiros$ta4000c8b350070bdd8226b12e296119e$, $ca4000c8b350070bdd8226b12e296119e$A lua iluminou o meu Congá
Foiseu Ubirajara que
chegou pra trabalhar
éé é é
FoiTupinambá quem
trouxe luze paz
éé é é
FoiTupinambá quem
trouxe luze paz
Eu vou cantar
Pros dois guerreiros
Que estão no Congá
Eu vou dizer
Os dois guerreiros
Trouxe muita paz
Eu vou cantar
Pros dois guerreiros
Que estão no Congá
Eu vou dizer
Os dois guerreiros
Trouxe muita paz$ca4000c8b350070bdd8226b12e296119e$, NULL, now()),
('cbef7b30-aff0-9bc7-e794-de850451f3c3', '68be09dc-e73d-ff41-1589-220baaea442d', $tcbef7b30aff09bc7e794de850451f3c3$Iracema Cabocla Guerreira$tcbef7b30aff09bc7e794de850451f3c3$, $ccbef7b30aff09bc7e794de850451f3c3$Eu conheço a Cabocla que vem aí
Seu saiote e penacho vem de longe
Seus olhos brilham em noite de luar
Deixa eu cantar Iracema,
Deixa eu cantar Iracema
Deixa eu cantar Iracema,
para você.
Deixa eu cantar Iracema,
Deixa eu cantar Iracema
Deixa eu cantar Iracema,
para você.
Ôô Iracema,
vamos girar...
Ôô Iracema, Cabocla
Guerreira de Oxalá
Ôô Iracema,
vamos girar...
Ôô Iracema, Cabocla
Guerreira de Oxalá$ccbef7b30aff09bc7e794de850451f3c3$, NULL, now()),
('3a2a7c0d-f8cd-9507-70b0-b9fb4dc2a87e', '68be09dc-e73d-ff41-1589-220baaea442d', $t3a2a7c0df8cd950770b0b9fb4dc2a87e$Caboclo Urutu$t3a2a7c0df8cd950770b0b9fb4dc2a87e$, $c3a2a7c0df8cd950770b0b9fb4dc2a87e$Quem chamou você aqui
FoiEu ,Foi Eu
Quem chamou você aqui
FoiEu ,Foi Eu
Quem chamou você aqui
Foios Curimbeiros de Pai Oxalá
Quem chamou você aqui
Foios Curimbeiros de Pai Oxalá
Eu Vim do Outro Lado ,do Infinito,do Espaço
Eu Vim do Outro Lado ,do Infinito,do Espaço
Sou Caboclo URUTU
Filhosde Guerreiro de Pai Oxalá
Sou Caboclo URUTU
Filhosde Guerreiro de Pai Oxalá$c3a2a7c0df8cd950770b0b9fb4dc2a87e$, NULL, now()),
('2ef84e48-cbe1-4df6-6f05-3220867aeba5', '68be09dc-e73d-ff41-1589-220baaea442d', $t2ef84e48cbe14df66f053220867aeba5$Caboclos da Aldeia Real$t2ef84e48cbe14df66f053220867aeba5$, $c2ef84e48cbe14df66f053220867aeba5$Tem Caboclos correndo nas Matas
Oxóssi deu a ordem é hora de caçar
Tem Caboclos correndo nas Matas
Oxóssi deu a ordem é hora de caçar
Somos os Caboclos da Aldeia Real
Vamos todos juntos caçando todo o mal
Somos os Caboclos da Aldeia Real
Vamos todos juntos caçando todo o mal
Tem Caboclos correndo nas Matas
Oxóssi deu a ordem é hora de caçar
Tem Caboclos correndo nas Matas
Oxóssi deu a ordem é hora de caçar
Somos os Caboclos da Aldeia Real
Vamos todos juntos caçando todo o mal
Somos os Caboclos da Aldeia Real
Vamos todos juntos caçando todo o mal$c2ef84e48cbe14df66f053220867aeba5$, NULL, now()),
('3798a9d8-02a7-8b49-ed75-6d9233d0a52b', '68be09dc-e73d-ff41-1589-220baaea442d', $t3798a9d802a78b49ed756d9233d0a52b$Caboclo Luiz$t3798a9d802a78b49ed756d9233d0a52b$, $c3798a9d802a78b49ed756d9233d0a52b$Juazeiro Juazeiro foiaíque eu Conheci
No Sertão do Ceará
O Caboclo Luiz
No Sertão do Ceará
O Caboclo Luiz
Juazeiro Juazeiro foiaíque eu Conheci
Juazeiro Juazeiro foiaíque eu Conheci
No Sertão do Ceará
O Caboclo Luiz
No Sertão do Ceará
O Caboclo Luiz
Eleensinou Ele ensinou Ele ensinou
Eu aprendi Eu aprendi Eleensinou
Eleensinou Eu aprendi
E quem vailá no Ceará
Conhece o Caboclo Luiz$c3798a9d802a78b49ed756d9233d0a52b$, NULL, now()),
('35ac3d3f-f966-0e26-fdaf-3d5a3eef4989', '68be09dc-e73d-ff41-1589-220baaea442d', $t35ac3d3ff9660e26fdaf3d5a3eef4989$Caboclos - Se meu Pai é um Caboclo$t35ac3d3ff9660e26fdaf3d5a3eef4989$, $c35ac3d3ff9660e26fdaf3d5a3eef4989$Se meu pai éum Caboclo
Caboclo eu também quero ser- 2x
Se meu pai éum Caboclo
Elehá de me valher - 2x$c35ac3d3ff9660e26fdaf3d5a3eef4989$, NULL, now()),
('97543bdf-cbb8-190f-dd6a-3ce4fc823a35', '68be09dc-e73d-ff41-1589-220baaea442d', $t97543bdfcbb8190fdd6a3ce4fc823a35$Caboclos - Como é bonita a pisada do caboclo$t97543bdfcbb8190fdd6a3ce4fc823a35$, $c97543bdfcbb8190fdd6a3ce4fc823a35$Como é bonita a pisada de Caboclo
Elepisa na areia, no rastroum do outro
(2x)
Salve a Mãe Sereia,salve Iemanjá
Salve os Caboclos na areia do mar
(2x)$c97543bdfcbb8190fdd6a3ce4fc823a35$, NULL, now()),
('a21ae1ff-5f29-99fd-2cce-3b837ad77090', '68be09dc-e73d-ff41-1589-220baaea442d', $ta21ae1ff5f2999fd2cce3b837ad77090$Meu tambor bateu na aldeia - Caboclo Sete Flechas$ta21ae1ff5f2999fd2cce3b837ad77090$, $ca21ae1ff5f2999fd2cce3b837ad77090$Meu tambor bateu na aldeia
meu tambor bateu na aldeia
bateu nas ondas do mar (2x)
Eu venho atirando a minha flecha
do reinosou Sete Fechas
sou índiodo Juremá (2x)$ca21ae1ff5f2999fd2cce3b837ad77090$, NULL, now()),
('2682c15b-8a03-b601-daf0-b8ec6179cb33', '68be09dc-e73d-ff41-1589-220baaea442d', $t2682c15b8a03b601daf0b8ec6179cb33$Caboclos - Filho da Jurema$t2682c15b8a03b601daf0b8ec6179cb33$, $c2682c15b8a03b601daf0b8ec6179cb33$Jurema, Jurema
aJurema não engana ninguém
eu sou filhodaJurema
aJurema não engana ninguém
Jurema, Jurema
aJurema não engana ninguém
Saravá Umbanda meu pai,
saravá Jurema
salveno terreiromeu pai
banda suprema$c2682c15b8a03b601daf0b8ec6179cb33$, NULL, now()),
('203e3d0e-bd28-e506-6c20-80d8d186e98b', '68be09dc-e73d-ff41-1589-220baaea442d', $t203e3d0ebd28e5066c2080d8d186e98b$Caboclo - Cobra Coral é Caboclo é$t203e3d0ebd28e5066c2080d8d186e98b$, $c203e3d0ebd28e5066c2080d8d186e98b$Cobra Coral
É Caboclo é -3x
Nasceu na Jurema
É irmão de Arranca Toco é
Cobra Coral
É Caboclo é -3x$c203e3d0ebd28e5066c2080d8d186e98b$, NULL, now()),
('ce8fa0ba-d7b1-158d-e2c5-75ad003b341e', '68be09dc-e73d-ff41-1589-220baaea442d', $tce8fa0bad7b1158de2c575ad003b341e$Caboclo Ubirajara - Que penacho é aquele$tce8fa0bad7b1158de2c575ad003b341e$, $cce8fa0bad7b1158de2c575ad003b341e$Que penacho é aquele
É um penacho de arara -2x
Só quem rompe a mata virgem
Só quem rompe a mata virgem
É oCaboclo Ubirajara -2x$cce8fa0bad7b1158de2c575ad003b341e$, NULL, now()),
('b28afd8e-3d8c-21db-8ccf-66e7807caefb', '68be09dc-e73d-ff41-1589-220baaea442d', $tb28afd8e3d8c21db8ccf66e7807caefb$Caboclo Pena Verde -Ele é o rei$tb28afd8e3d8c21db8ccf66e7807caefb$, $cb28afd8e3d8c21db8ccf66e7807caefb$Seu Pena Verde
Lá na mata ele éo Rei
Seu Pena Verde
Lá na mata ele éo Tatá - 2x
Eleé o Rei, eleé o Tatá - 2x
Lá nas matas a sua flechazoa -2x
Zoa quando sobe
Quando desce elamata -2x
Eleé o Rei, eleé o Tatá - 2x$cb28afd8e3d8c21db8ccf66e7807caefb$, NULL, now()),
('1fdaa401-bd20-c9eb-20a3-1242ed2cbfb9', '68be09dc-e73d-ff41-1589-220baaea442d', $t1fdaa401bd20c9eb20a31242ed2cbfb9$Cabocla Jurema -Que Lindo Capacete De Penas$t1fdaa401bd20c9eb20a31242ed2cbfb9$, $c1fdaa401bd20c9eb20a31242ed2cbfb9$Que lindo capacete de penas
Que tem a Cabocla Jurema -2x
Nascida na terra dos Orixás
A Cabocla Jurema vem aquipara trabalhar- 2x$c1fdaa401bd20c9eb20a31242ed2cbfb9$, NULL, now()),
('7100d6d9-272c-62c5-d72a-e7b3f5baae50', '68be09dc-e73d-ff41-1589-220baaea442d', $t7100d6d9272c62c5d72ae7b3f5baae50$Caboclos - Debaixo da folha seca$t7100d6d9272c62c5d72ae7b3f5baae50$, $c7100d6d9272c62c5d72ae7b3f5baae50$(2x)
Debaixo da folhaseca
A Cobra-coral morava
Piou quando viuo Caboclo
Com a sua flecha na mata
(2x)
Piou...Piou...
Piou na mão do Caboclo*
Elapiou$c7100d6d9272c62c5d72ae7b3f5baae50$, NULL, now()),
('ad2077b5-bc36-8699-0222-2b193ecc7514', '68be09dc-e73d-ff41-1589-220baaea442d', $tad2077b5bc36869902222b193ecc7514$Caboclos - Olha o seu Juremá$tad2077b5bc36869902222b193ecc7514$, $cad2077b5bc36869902222b193ecc7514$Lá na Jurema
embaixo de um pé de ingá
Lá na Jurema
embaixo de um pé de ingá
aonde o luar clareia
para meus Caboclos passar
aonde o luar clareia
para meus Caboclos passar
Jurema, Jurema
Olha o seu Juremá
Jurema, Jurema
Olha o seu Juremá
na Juremá...$cad2077b5bc36869902222b193ecc7514$, NULL, now()),
('aeb71847-7859-a263-bb94-f41e1ae376fe', '68be09dc-e73d-ff41-1589-220baaea442d', $taeb718477859a263bb94f41e1ae376fe$Louvação aos Caboclos$taeb718477859a263bb94f41e1ae376fe$, $caeb718477859a263bb94f41e1ae376fe$2x
Lê Lerê Lê Lerê, Okê
Lê Lerê Lê Lerá, Saravá
2x
Mãos que guardam o cheiro da mata
E pintam a pele pra caçar
Mãos ungidas por Oxóssi
Que firmam o ponto no Gongá
2x Okê Arô, (ô) Bamboclim Caboclos
Olhos brilham, guiam a Macaia
Caminhos de féao luar
Arco, flecha,lança e bodoque
Nas mãos de quem sabe trabalhar
Vem de Aruanda...
Vem do Juremá...
Arco, flecha,lança e bodoque
Mãos erguidas a louvar
4x Okê Arô, (ô) Bamboclim Caboclos$caeb718477859a263bb94f41e1ae376fe$, NULL, now()),
('fd866eae-acff-7940-bdb7-7e0c5f66ce61', '68be09dc-e73d-ff41-1589-220baaea442d', $tfd866eaeacff7940bdb77e0c5f66ce61$No alto da serra$tfd866eaeacff7940bdb77e0c5f66ce61$, $cfd866eaeacff7940bdb77e0c5f66ce61$No altoda serra
tem uma choupana
eo Caboclo mora lá
No altoda serra
tem uma choupana
eo Caboclo mora lá
Tem uma choupana
elemora lá
Tupinambá mora no pé do Juremá
Tem uma choupana
elemora lá
Tupinambá mora no pé do Juremá$cfd866eaeacff7940bdb77e0c5f66ce61$, NULL, now()),
('5cd19af4-8491-92a8-87d8-16d7ebac3846', '68be09dc-e73d-ff41-1589-220baaea442d', $t5cd19af4849192a887d816d7ebac3846$Cabocla Jaciara$t5cd19af4849192a887d816d7ebac3846$, $c5cd19af4849192a887d816d7ebac3846$Sombra de nuvem na areia
É sinalde que tem, sereia por lá
E quando faz luacheia a cabocla do mar canta pra Iemanjá
Elaé uma cabocla serena
Elavem do fundo do mar
Do mar elatrás suas forças
Vem Jaciara, vem trabalhar
Vem Jaciara, vem trabalhar
Onda vem, onda vai
É Jaciara a cabocla do mar
Onda vem Odoya, onda vaio Odocia
Vem Jaciara, vem trabalhar
Vem Jaciara, vem trabalhar$c5cd19af4849192a887d816d7ebac3846$, NULL, now()),
('bb8561de-972a-622b-960c-e383c01c7074', '68be09dc-e73d-ff41-1589-220baaea442d', $tbb8561de972a622b960ce383c01c7074$Caboclo Pedra Preta$tbb8561de972a622b960ce383c01c7074$, $cbb8561de972a622b960ce383c01c7074$Da estrala Dalva eu vi um caboclo surgi
Lá da pedreira eu vio caboclo bradar
Mas ele é o caboclo da pedreira
É o seu Pedra Preta de Xangô Ayra
Mas ele é enviado da Jurema
É seu Pedra Preta que vem trabalhar$cbb8561de972a622b960ce383c01c7074$, NULL, now()),
('49c769e2-776c-5d39-39dd-91fd4c19c865', '68be09dc-e73d-ff41-1589-220baaea442d', $t49c769e2776c5d3939dd91fd4c19c865$Seu Arranca toco é de Aruanda$t49c769e2776c5d3939dd91fd4c19c865$, $c49c769e2776c5d3939dd91fd4c19c865$Seu Arranca toco é de Aruanda
éde Nagô Zambê. (2x)
quando ele vem de Aruanda
auê auê (2x)$c49c769e2776c5d3939dd91fd4c19c865$, NULL, now()),
('d331df0b-4c4d-0ce9-77cc-5af31e436dde', '68be09dc-e73d-ff41-1589-220baaea442d', $td331df0b4c4d0ce977cc5af31e436dde$o Juremê, o Juremá$td331df0b4c4d0ce977cc5af31e436dde$, $cd331df0b4c4d0ce977cc5af31e436dde$oJuremê, o Juremá
Suas flechas caiu serena o Jurema
dentro desse congá. (2x)
oisalve São Jorge guerreiro
salve São Sebastião
salve aCabocla Jurema
com a sua proteção
oJurema…$cd331df0b4c4d0ce977cc5af31e436dde$, NULL, now()),
('1d8ab301-2a25-5e51-5efa-e111422567e6', '68be09dc-e73d-ff41-1589-220baaea442d', $t1d8ab3012a255e515efae111422567e6$Cabocla Janaina$t1d8ab3012a255e515efae111422567e6$, $c1d8ab3012a255e515efae111422567e6$E Janaina
eJanaina menina (2x)
Cabocla pequenina com força de guerreira
éJanaina menina láda cachoeira
Cabocla pequenina com força de guerreira
éJanaina menina da pele vermelha
Filhode fé que é filhode fénão desanima
salve a cabocla Janaina menina (2x)$c1d8ab3012a255e515efae111422567e6$, NULL, now()),
('01b5cfbb-6862-e324-292c-2e0fd6651eab', '68be09dc-e73d-ff41-1589-220baaea442d', $t01b5cfbb6862e324292c2e0fd6651eab$Caboclo Tupi$t01b5cfbb6862e324292c2e0fd6651eab$, $c01b5cfbb6862e324292c2e0fd6651eab$Ogum com seu fogo de guerra
Preparou a terra
Para semear
Em sete noitede lua cheia
Agora a esperança dança na aldeia
Em sete noitede lua cheia
Agora a esperança dança na aldeia (2x)
Vem ládo Jurema
Uma força suprema pra reconstruir
Esteio de aruanda
Guerreiro de umbanda
Caboclo Tupi
Esteio de aruanda
Guerreiro de umbanda
Caboclo Tupi
É o caboclo Tupi guerreiro de Ogum
Vencendo demandas
Na leida Umbanda caboclo Tupi
É o caboclo Tupi guerreiro de Ogum
Vencendo demandas
Na leida Umbanda caboclo Tupi$c01b5cfbb6862e324292c2e0fd6651eab$, NULL, now()),
('5e7c2b61-3d9f-54d4-543a-1e505b4962a2', '68be09dc-e73d-ff41-1589-220baaea442d', $t5e7c2b613d9f54d4543a1e505b4962a2$Uma linda cabocla eu vi - Cabocla Jurema$t5e7c2b613d9f54d4543a1e505b4962a2$, $c5e7c2b613d9f54d4543a1e505b4962a2$No centro da Mata virgem uma linda cabocla eu vi(2x)
Com seu saiotefeito de pena é a Jurema filhade Tupi.(2x)
Jurema Jurema Jurema
Linda cabocla filhaTupi
Ela vem láda Juremá vem firma seu ponto nesse congá(2x)$c5e7c2b613d9f54d4543a1e505b4962a2$, NULL, now()),
('cf5f0951-8f3e-6b69-b6d3-a3f00e8e3e26', '68be09dc-e73d-ff41-1589-220baaea442d', $tcf5f09518f3e6b69b6d3a3f00e8e3e26$Caboclo Pena Dourada$tcf5f09518f3e6b69b6d3a3f00e8e3e26$, $ccf5f09518f3e6b69b6d3a3f00e8e3e26$Na mata virgem, naquele monte
Tem uma fonte de agua viva escondida
A bandeira da paz jáfoi firmada
É a morada do caboclo pena dourada
Caboclo mensageiro, das forças de aruanda
caboclo forte e guerreiro, que sabe vencer demanda
Caboclo desse terreiro,batizado nesse chão
Caboclo pena dourada, dourada é sua missão
Ele cruza monte, ele cruza montanha
elecruza a mata virgem
Pena dourada, vai baixar nesse conga$ccf5f09518f3e6b69b6d3a3f00e8e3e26$, NULL, now()),
('722a7ffe-e639-fbd9-9e1e-73bab37cb60f', '68be09dc-e73d-ff41-1589-220baaea442d', $t722a7ffee639fbd99e1e73bab37cb60f$Cabocla Yara$t722a7ffee639fbd99e1e73bab37cb60f$, $c722a7ffee639fbd99e1e73bab37cb60f$Ela é a cabocla Yara, ela vem do fundo do mar
Ela é a cabocla Yara (Jaciara), ela vem do fundo do mar
Salve a Cabocla Yara, que vem pisar firme no conga
Salve a Cabocla Yara, vem sarava o povo do mar$c722a7ffee639fbd99e1e73bab37cb60f$, NULL, now()),
('ec0730a8-109b-e30a-3a33-9d67493ee49a', '68be09dc-e73d-ff41-1589-220baaea442d', $tec0730a8109be30a3a339d67493ee49a$Cabocla Jupira$tec0730a8109be30a3a339d67493ee49a$, $cec0730a8109be30a3a339d67493ee49a$Foi sobre a luz do luar, que eu via cabocla saldar Iemanjá (2x)
Em frente ao mar, eu vitudo começar
E no fim do horizonte uma estrela á brilhar
Era Jupira, com seu brado a entoar, e o seu penacho verde caminhando sobre o mar
Eu vi a lua,e as estrelas se alinhar
Com a permissão de Oxóssi, dançava a beira mar
Salve Jupira, dona desse jacuta
Riscando ponto na areia
Sobre as forças de Iemanjá
Salve Jupira, dona desse jacuta
Riscando ponto na areia
Sobre as forças de Iemanjá$cec0730a8109be30a3a339d67493ee49a$, NULL, now()),
('8518a610-653f-d4c2-2428-6bbe9cc7b7d0', '68be09dc-e73d-ff41-1589-220baaea442d', $t8518a610653fd4c224286bbe9cc7b7d0$Caboclo Sultão das Matas$t8518a610653fd4c224286bbe9cc7b7d0$, $c8518a610653fd4c224286bbe9cc7b7d0$Na aldeia lá da Serra, o céu escureceu
Trovejou, relampeou mas não choveu
Sultão das Matas veio em terra
firmou seu ponto e o céu agradeceu (2x)
Caboclo sultão das Matas, reidas matas se tornou
Estrela de ouro e prata da coroa de Xangô
Sultão das Matas caboclo, das matas ele é o senhor
O muito pra ele é pouco, é justiçade caboclo
Caboclo que é de Xangô.$c8518a610653fd4c224286bbe9cc7b7d0$, NULL, now()),
('3c072591-173c-fcdc-eb18-3439fea2fb6d', '68be09dc-e73d-ff41-1589-220baaea442d', $t3c072591173cfcdceb183439fea2fb6d$Caboclo Tupã$t3c072591173cfcdceb183439fea2fb6d$, $c3c072591173cfcdceb183439fea2fb6d$Quando Tupã vem de Aruanda
firmaseu ponto nesse conga
eleé caboclo guerreiro, feiticeiro,demandeiro
em qualquer lugar
tupã é caboclo de oxossi
tupã é oxossi caçador
Quando tupã vem de aruanda, ele quebra as demandas
éoxossi vencedor$c3c072591173cfcdceb183439fea2fb6d$, NULL, now()),
('a59858db-adcc-6a0b-0936-2ade77be76e5', '68be09dc-e73d-ff41-1589-220baaea442d', $ta59858dbadcc6a0b09362ade77be76e5$Caboclos -Saravá 7 Montanhas$ta59858dbadcc6a0b09362ade77be76e5$, $ca59858dbadcc6a0b09362ade77be76e5$Salve o grande guerreiro
Cultua a lua e o sol
Sua morada é na pedreira
Onde canta o rouxinol
Sua flecha é minha fé
Me dá luze direção
Seu machado é meu escudo
E a minha proteção
Kio kio
Kaô kaô
Saravá 7 Montanhas
Coroado por Xangô...$ca59858dbadcc6a0b09362ade77be76e5$, NULL, now()),
('51c18713-2b37-8368-93f1-bd9880c255b3', '68be09dc-e73d-ff41-1589-220baaea442d', $t51c187132b37836893f1bd9880c255b3$Caboclo Aymoré - Caboclo de fé$t51c187132b37836893f1bd9880c255b3$, $c51c187132b37836893f1bd9880c255b3$Salve o grande caboclo
reido terreiro
salve o grande guerreiro caçador
É vencedor de demandas
eleé flecheiro
na mata eleé grande atirador
É meu caboclo de fé
émeu caboclo de fé
érei da mata
seu Aymoré (2x)$c51c187132b37836893f1bd9880c255b3$, NULL, now()),
('59b1dcf7-08e1-ad46-08cd-a678a770779a', '68be09dc-e73d-ff41-1589-220baaea442d', $t59b1dcf708e1ad4608cda678a770779a$Cabocla Jandaia$t59b1dcf708e1ad4608cda678a770779a$, $c59b1dcf708e1ad4608cda678a770779a$elaconhece os segredos da Jurema
na cachoeira ela vive a se banhar
seu lindo brado ecoa por toda a mata
eé no luarde prata
que ela vem pra trabalhar (2x)
écaçadora, elaé quem protege aldeia
elaé flecheira atirapra não errar
salve essa cabocla de pena
mulher de pele morena
peço venha me ajudar (2x)
"Canta Jandaia" nas matas do Juremá
lindacabocla da tribo tupinambá
lindamorena por vc eu tenho fé
vem Iracema, vem trazer o seu axé (2x)$c59b1dcf708e1ad4608cda678a770779a$, NULL, now()),
('be8e57aa-b377-69e6-8e19-5fce37422fc9', '68be09dc-e73d-ff41-1589-220baaea442d', $tbe8e57aab37769e68e195fce37422fc9$Rei Caboclo do Sol$tbe8e57aab37769e68e195fce37422fc9$, $cbe8e57aab37769e68e195fce37422fc9$É caboclo, rei da mata
Onde canta o rouxinol
É caboclo, rei da mata
Saravá Rei Caboclo do Sol (2x)
Salve o guerreiro
Salve o grande caçador
Força que vem de Aruanda
A sua estrela brilhou
Luz que me guia
E ilumina o mundo inteiro
Vamos todos saravá
Caboclo do Sol no terreiro
É caboclo, rei da mata
Onde canta o rouxinol
É caboclo, rei da mata
Saravá Rei Caboclo do Sol (2x)$cbe8e57aab37769e68e195fce37422fc9$, NULL, now()),
('7177ee86-a387-f62d-b6b5-36a61e2e2a25', '68be09dc-e73d-ff41-1589-220baaea442d', $t7177ee86a387f62db6b536a61e2e2a25$Caboclos - Maré encheu maré vazou$t7177ee86a387f62db6b536a61e2e2a25$, $c7177ee86a387f62db6b536a61e2e2a25$Maré encheu
maré vazou
De longe, bem longe
eu avisteiAra
Com sua casinha
coberta de sapê
Seu arco sua fecha
sua cabaça de mel
eu ia
eu iaara, eu ia ara, eu iaara
eu ia
eu iaara, eu ia ara, eu iaara
eu iaeu iaara, eu ia ara,eui
eu iaeu iaara, eu ia ara,eui$c7177ee86a387f62db6b536a61e2e2a25$, NULL, now()),
('9ad7dec1-d728-9b64-ea5d-a4eef727400b', '68be09dc-e73d-ff41-1589-220baaea442d', $t9ad7dec1d7289b64ea5da4eef727400b$Caboclo Mirim$t9ad7dec1d7289b64ea5da4eef727400b$, $c9ad7dec1d7289b64ea5da4eef727400b$Com sua flecha e seu bodoque
agirar, a girar
Com sua flecha e seu bodoque
agirar, a girar
vem…
cumprir a leique trasdo Juremá
Penacho lindo,eu nunca vi assim
quem vem na Umbanda trabalhar
éo Caboclo Mirim
Penacho lindo,eu nunca vi assim
quem vem na Umbanda trabalhar
éo Caboclo Mirim$c9ad7dec1d7289b64ea5da4eef727400b$, NULL, now()),
('f50cac8b-628b-9284-e4c6-6932bb6af052', '68be09dc-e73d-ff41-1589-220baaea442d', $tf50cac8b628b9284e4c66932bb6af052$Ele é Rompe mato$tf50cac8b628b9284e4c66932bb6af052$, $cf50cac8b628b9284e4c66932bb6af052$Ele é Rompe mato, oh paranga
esta no gongá, oh paranga
Ele é Rompe mato, oh paranga
Vem do Juremá
Ele é Rompe mato, oh paranga
esta no gongá, oh paranga
Ele é Rompe mato, oh paranga
Vem do Juremá
Ele vem da mata
oh que mata ė a sua
onde pia cobra, canta o sabia e clareia a lua
Ele vem da mata
oh que mata ė a sua
onde pia cobra, canta o sabia e clareia a lua$cf50cac8b628b9284e4c66932bb6af052$, NULL, now()),
('f8b094fd-2b66-5cee-8ba0-584e77fe678a', '68be09dc-e73d-ff41-1589-220baaea442d', $tf8b094fd2b665cee8ba0584e77fe678a$Sou filho de Arranca toco$tf8b094fd2b665cee8ba0584e77fe678a$, $cf8b094fd2b665cee8ba0584e77fe678a$Eu sou da mata
Eu sou Caboclo
Sou filhode Arranca toco
Eu sou da mata
Eu sou Caboclo
Sou filhode Arranca toco
Oh lá nas matas, lá da Jurema
Nada se faz sem ordem suprema
Oh lá nas matas, lá da Jurema
Nada se faz sem ordem suprema
///////////////////////////////////////////
Oh lá nas matas, lá da Jurema
éuma leisevera é uma leisem pena
Oh lá nas matas, lá da Jurema
éuma leisevera é uma leisem pena$cf8b094fd2b665cee8ba0584e77fe678a$, NULL, now()),
('f47d517a-222f-7367-44d8-782af666c209', '68be09dc-e73d-ff41-1589-220baaea442d', $tf47d517a222f736744d8782af666c209$Cabocla Jandira$tf47d517a222f736744d8782af666c209$, $cf47d517a222f736744d8782af666c209$Quem quer viver sobre a terra
quem quer viversobre o mar
Salve a Cabocla Jandira
Salve a Sereia do mar
rere re re,re re re,re re re rah
rere re re,re re re… Jandira$cf47d517a222f736744d8782af666c209$, NULL, now()),
('324eb342-dccc-799b-c41f-4594a476bd30', '68be09dc-e73d-ff41-1589-220baaea442d', $t324eb342dccc799bc41f4594a476bd30$Caboclo dessa aldeia$t324eb342dccc799bc41f4594a476bd30$, $c324eb342dccc799bc41f4594a476bd30$Ele é Caboclo dessa aldeia
éguerreiro do Juremá
Cavaleiro das campinas
ésementinha de Lembá
O meu pai vem ver seus filhos
venha todos abençoar
se a sua folha é que nos cura
ésegredo no Juremá
Venha ver meu Caboclo
Venha ver a sua aldeia
Venha ver a sua aldeia
Venha ver seu Juremá$c324eb342dccc799bc41f4594a476bd30$, NULL, now()),
('25be03a4-9257-5d0e-930d-55d8ca60efcc', '68be09dc-e73d-ff41-1589-220baaea442d', $t25be03a492575d0e930d55d8ca60efcc$Caboclo - O vento nas matas$t25be03a492575d0e930d55d8ca60efcc$, $c25be03a492575d0e930d55d8ca60efcc$O vento vaisoprando nas matas
jogando as folhasda Jurema no chão
O vento vaisoprando
asfolhas vão caindo
Caboclo vai apanhando elas no chão$c25be03a492575d0e930d55d8ca60efcc$, NULL, now()),
('23df5f0a-92e0-2ff0-5f06-677d963fddee', '68be09dc-e73d-ff41-1589-220baaea442d', $t23df5f0a92e02ff05f06677d963fddee$Caboclo cruzado com Preto Velho$t23df5f0a92e02ff05f06677d963fddee$, $c23df5f0a92e02ff05f06677d963fddee$Caboclo me reza com as folhas
ePreto Velho faz seu canjerê
E quando eu cruzomeu Preto Velho
com seu Caboclo, podes crer
atéCalunga fazestremecer$c23df5f0a92e02ff05f06677d963fddee$, NULL, now()),
('5d4a2511-50d4-5449-a212-74ebc1c34fb8', '68be09dc-e73d-ff41-1589-220baaea442d', $t5d4a251150d45449a21274ebc1c34fb8$Subida de Caboclo -Numa gira só$t5d4a251150d45449a21274ebc1c34fb8$, $c5d4a251150d45449a21274ebc1c34fb8$Adeus meu Caboclo, adeus
asua banda lhe chama, ele vaigirar
Elevai girar
Deixa a pemba, leva a pemba
Macaia com caiana, numa girasó$c5d4a251150d45449a21274ebc1c34fb8$, NULL, now()),
('83943cdb-caf6-8cb6-eeec-f398d9d0906d', '68be09dc-e73d-ff41-1589-220baaea442d', $t83943cdbcaf68cb6eeecf398d9d0906d$Ponto de cura com Caboclo - Aruanda tem$t83943cdbcaf68cb6eeecf398d9d0906d$, $c83943cdbcaf68cb6eeecf398d9d0906d$Aruanda trás
Aruanda tem
Luz praseus filhos
epros Caboclos também
Cura Caboclo
sem olhar a quem
tráspra Umbanda
oque aAruanda tem$c83943cdbcaf68cb6eeecf398d9d0906d$, NULL, now()),
('2f0e04b7-1728-bbfc-4134-02cb11f8ddd1', '68be09dc-e73d-ff41-1589-220baaea442d', $t2f0e04b71728bbfc413402cb11f8ddd1$Caboclos das matas$t2f0e04b71728bbfc413402cb11f8ddd1$, $c2f0e04b71728bbfc413402cb11f8ddd1$Caboclos, das matas
das cachoeiras
das pedras das pedreiras
das ondas do mar
Caboclas, guerreiras
mensageiras
da paz e da harmonia
soldados de Oxalá
Vem de Aruanda, vem, vem ,vem
trazendo forças, vem, vem, vem
quebrando mirongas, vem, vem, vem
na Umbanda saravá$c2f0e04b71728bbfc413402cb11f8ddd1$, NULL, now()),
('b0cca99c-219a-e96c-96af-772d0a1e55cf', '68be09dc-e73d-ff41-1589-220baaea442d', $tb0cca99c219ae96c96af772d0a1e55cf$Caboclo Sucuri$tb0cca99c219ae96c96af772d0a1e55cf$, $cb0cca99c219ae96c96af772d0a1e55cf$Na mata escura não podia ver a lua
Na mata escura não podia caminhar
atéa cobra sucuri,que o Caboclo trázna cinta
eledeixou fugir
Mas eleé caçador
bravo guerreiro ô
deu um assovio na mata, amanheceu e a sucuri
pra sua cintavoltou$cb0cca99c219ae96c96af772d0a1e55cf$, NULL, now()),
('00c11c5b-e272-b3e7-608f-04be0f3c3e1c', '68be09dc-e73d-ff41-1589-220baaea442d', $t00c11c5be272b3e7608f04be0f3c3e1c$Caboclos - O vento$t00c11c5be272b3e7608f04be0f3c3e1c$, $c00c11c5be272b3e7608f04be0f3c3e1c$embalança, embalança
embalança afolha da Jurema
embalança, embalança
embalança opé de Guararema
ovento embalança o cipó lána mata
ovento embalança a folhade guiné
ovento embalança o pau da Jurema
ovento embalança a barca de Noé
embalança, embalança
embalança afolha da Jurema
embalança, embalança
embalança opé de Guararema
ovento embalança as nuvens no céu
ovento embalança a fumaça no ar
ovento embalança o navio ao léu
ovento embalança as ondas do mar$c00c11c5be272b3e7608f04be0f3c3e1c$, NULL, now()),
('c0afe5f3-decd-9bc4-fba0-ffb41c31a5ce', '68be09dc-e73d-ff41-1589-220baaea442d', $tc0afe5f3decd9bc4fba0ffb41c31a5ce$Caboclo Sete Flechas Nasceu$tc0afe5f3decd9bc4fba0ffb41c31a5ce$, $cc0afe5f3decd9bc4fba0ffb41c31a5ce$Caboclo 7 flechas nasceu
No jardim das oliveiras-2x
Trazia amarrado em sua cinta uma coral
Oh sucuri jibóia da aldeia -2x
Oh sucuri jibóia
Quando vem beirando o mar - 2x
Olha como o branco olhou
A sua cobra coral -2x
Então segura essa cobra não deixa elafugir
O nome dessa cobra é cobra sucuri -2x$cc0afe5f3decd9bc4fba0ffb41c31a5ce$, NULL, now()),
('bc6b6c40-839b-c439-b2a4-38c32d0dc751', '68be09dc-e73d-ff41-1589-220baaea442d', $tbc6b6c40839bc439b2a438c32d0dc751$Cabocla Iara - Lindos botões$tbc6b6c40839bc439b2a438c32d0dc751$, $cbc6b6c40839bc439b2a438c32d0dc751$Lindos botões que eu coloquei a beira mar
Se abriram em rosas, ajoelhei-me a chorar
Cabocla Iara,me ajude a vencer
Cabocla Iara,me ajude a caminhar
Essas rosas brancas se formaram a beira mar
foipra lhe ofertar$cbc6b6c40839bc439b2a438c32d0dc751$, NULL, now()),
('098b02bc-6d79-36df-b488-43628f26c0e7', '68be09dc-e73d-ff41-1589-220baaea442d', $t098b02bc6d7936dfb48843628f26c0e7$Caboclo - Seu Cobra Verde nas matas$t098b02bc6d7936dfb48843628f26c0e7$, $c098b02bc6d7936dfb48843628f26c0e7$Abriu o portalde Aruanda
uma flecha o espaço cruzou
Okê okê o bando okê Caboclo
Seu Cobra Verde chegou (bis)
Nessa fé por toda a natureza
ouvi o cairde montes de cascatas
Okê okê o bando okê Caboclo
Seu Cobra Verde nas matas (bis)$c098b02bc6d7936dfb48843628f26c0e7$, NULL, now()),
('e49a87af-95ae-9f84-7f64-251ed24a59a0', '68be09dc-e73d-ff41-1589-220baaea442d', $te49a87af95ae9f847f64251ed24a59a0$Ubirajara do peito de aço$te49a87af95ae9f847f64251ed24a59a0$, $ce49a87af95ae9f847f64251ed24a59a0$Ubirajara é caboclo bom
Ubirajara é caboclo forte
Ubirajara do peito de aço
Ele é cacique do sertão do norte
Ubirajara do peito de aço
Ele é cacique do sertão do norte
ôô Ubirajara, ôô seu Guararema
trasa cabocla Jussara
pro terreiroda Jurema
Ubirajara é caboclo bom
Ubirajara é caboclo forte
Ubirajara do peito de aço
Ele é cacique do sertão do norte
Ubirajara do peito de aço
Ele é cacique do sertão do norte
Trás suas flechas, trássua guia
Vem trabalhar no terreiro
com o Caboclo Ventania$ce49a87af95ae9f847f64251ed24a59a0$, NULL, now()),
('55165673-b4d9-6ae9-c9b5-38110ff651d3', '68be09dc-e73d-ff41-1589-220baaea442d', $t55165673b4d96ae9c9b538110ff651d3$Subida de Caboclo - Quem sente saudades chora$t55165673b4d96ae9c9b538110ff651d3$, $c55165673b4d96ae9c9b538110ff651d3$Adeus meus filhos de Umbanda
A Jurema mandou me chamar
Quem sente saudades chora
mas quem não sente de saudades vai chorar$c55165673b4d96ae9c9b538110ff651d3$, NULL, now()),
('5d2ea80b-6d4a-d325-9b49-fda7551e04c6', '68be09dc-e73d-ff41-1589-220baaea442d', $t5d2ea80b6d4ad3259b49fda7551e04c6$Caboclo Pena Azul - Caboclo Roxo$t5d2ea80b6d4ad3259b49fda7551e04c6$, $c5d2ea80b6d4ad3259b49fda7551e04c6$Quem vem chegando de lá
pisando firme,com olhar sereno
Bravo guerreiro, Pena azul
que pega a cobra, dá um nó, tirao veneno$c5d2ea80b6d4ad3259b49fda7551e04c6$, NULL, now()),
('22681b76-88f1-f3a0-a446-4af15a296e33', '68be09dc-e73d-ff41-1589-220baaea442d', $t22681b7688f1f3a0a4464af15a296e33$Cabocla Indaiá$t22681b7688f1f3a0a4464af15a296e33$, $c22681b7688f1f3a0a4464af15a296e33$Cabocla Indaiá
Cabocla Indaiá
Salve os conselhos que a cabocla vem nos dar!
Cabocla Indaiá
Cabocla Indaiá
Ela é guerreira na falange de Iemanjá
Cabocla Indaiá
Cabocla Indaiá
Seu brado é forte chegam com as ondas do mar
Cabocla Indaiá
Cabocla Indaiá
Ela é guerreira na falange de iemanjá
Cabocla Indaiá
Cabocla Indaiá
Seu brado é forte chegam com as ondas do mar
Cabocla Indaiá
Cabocla Indaiá
Salve os conselhos que a cabocla vem nos dar!
Cabocla Indaiá
Cabocla Indaiá
Ela é guerreira na falange de Iemanjá
Cabocla Indaiá
Cabocla Indaiá
Seu brado é forte chegam com as ondas do mar
Cabocla Indaiá
Cabocla Indaiá
Ela é guerreira na falange de iemanjá
Cabocla Indaiá
Cabocla Indaiá
Seu brado é forte chegam com as ondas do mar$c22681b7688f1f3a0a4464af15a296e33$, NULL, now()),
('062fa073-a4fb-2966-2504-a96a2fd1ab82', '68be09dc-e73d-ff41-1589-220baaea442d', $t062fa073a4fb29662504a96a2fd1ab82$Caboclo Ventania - A Lua Clareou$t062fa073a4fb29662504a96a2fd1ab82$, $c062fa073a4fb29662504a96a2fd1ab82$A lua clareou
Brilhou a estrelaguia
Com licença de Oxalá
Vai chegar Seu Ventania
A lua clareou
Brilhou a estrelaguia
Com licença de Oxalá
Vai chegar Seu Ventania
Ele é caboclo
É flecheiroatirador
Na mata virgem,
Na pedreira de Xangô
Sua coroa
Tem a luz de Oxalá
E na Umbanda
Ele vem trabalhar$c062fa073a4fb29662504a96a2fd1ab82$, NULL, now()),
('c02ea9e4-2585-cedc-a453-5bf19fad4cd6', '68be09dc-e73d-ff41-1589-220baaea442d', $tc02ea9e42585cedca4535bf19fad4cd6$Sete Flechas - Foi Numa Tarde Serena$tc02ea9e42585cedca4535bf19fad4cd6$, $cc02ea9e42585cedca4535bf19fad4cd6$Foinuma tarde serena
Lá nas matas da Jurema
Que eu vimeu caboclo bradar
Mas foi
Foi numa tarde serena
Lá nas matas da Jurema
Que eu vi meu caboclo bradar
Kiô
kiô,kiô,kiô, kiera…
Toda mata está em festa
Saravá seu Sete Flechas
Ele é o reida floresta
Kiô
kiô,kiô,kiô, kiera…
Toda mata está em festa
Saravá seu Sete Flechas
Ele é o reida floresta$cc02ea9e42585cedca4535bf19fad4cd6$, NULL, now()),
('10e004e3-3a63-0a39-392a-824ec6a5b362', '68be09dc-e73d-ff41-1589-220baaea442d', $t10e004e33a630a39392a824ec6a5b362$Jurema da Cachoeira$t10e004e33a630a39392a824ec6a5b362$, $c10e004e33a630a39392a824ec6a5b362$Ela é Jurema, sua terraé formosa
Salve Oxóssi lá na mata
Salve meu Pai Oxalá
Ela é Jurema, ela vem da cachoeira
Trás a força da pedreira
Para os filhosajudar
Ela é Jurema, sua flecha tem estrelas
Que clareiam a juremá
Quando atiraa sua flecha
É pra filhoiluminar
Ela é Jurema, sua flecha tem estrelas
Que clareiam a juremá
Quando atiraa sua flecha
É pra filhoiluminar$c10e004e33a630a39392a824ec6a5b362$, NULL, now()),
('1ae7a1c7-1f4f-925d-6056-d5932cb48a5c', '68be09dc-e73d-ff41-1589-220baaea442d', $t1ae7a1c71f4f925d6056d5932cb48a5c$Louvação à Cabocla Jussara$t1ae7a1c71f4f925d6056d5932cb48a5c$, $c1ae7a1c71f4f925d6056d5932cb48a5c$Ela venceu
Ela venceu demanda
Ela vem para o mal derrubar
Jussara, linda cabocla de pena
Ela é filhada Jurema
Neta de Tupinambá
Ela venceu
Ela venceu demanda
Ela vem para o mal derrubar
Jussara, linda cabocla de pena
Ela é filhada Jurema
Neta de Tupinambá
Bendito seja seu girarnesse terreiro
Seu arco e flechacerteiro
Abençoa nosso caminhar
As matas são seu lar
Salve Cabocla Jussara
Salve o raio de luar
As matas são seu lar
Salve Cabocla Jussara
Salve o raio de luar$c1ae7a1c71f4f925d6056d5932cb48a5c$, NULL, now()),
('731b1dca-b326-a766-6040-5da9aa897a60', '68be09dc-e73d-ff41-1589-220baaea442d', $t731b1dcab326a76660405da9aa897a60$Caboclos -Oxalá Chamou$t731b1dcab326a76660405da9aa897a60$, $c731b1dcab326a76660405da9aa897a60$Oxalá chamou!
Oxalá chamou e já mandou buscar
Os caboclos da Jurema
Lá no seu Juremá
Pai Oxalá
Que é reido mundo inteiro
Já deu ordens pra Jurema
Chamar teus capangueiros
Mandai, Mandai
Linda cabocla Jurema
Os seus guerreiros
Essa é a ordem suprema!!$c731b1dcab326a76660405da9aa897a60$, NULL, now()),
('489716fc-b44d-9395-4ed0-fbf493d6f00f', '68be09dc-e73d-ff41-1589-220baaea442d', $t489716fcb44d93954ed0fbf493d6f00f$Caboclos -Caçada de Caboclos$t489716fcb44d93954ed0fbf493d6f00f$, $c489716fcb44d93954ed0fbf493d6f00f$oooo...oh que beleza, no clarão da lua
no Juremá, Caboclo Arranca Toco
Jurema e Caçador, saindo para caçar
oooo...oh que beleza, no clarão da lua
no Juremá, Caboclo Arranca Toco
Jurema e Caçador, saindo para caçar
Arranca Toco com sua lança dourada
pede licença a Zambi, quando saipara caçar
dona Jurema com seu saiote de penas
com seu arco e sua flecha,reza prece a Oxalá
seu caçador avistou a linda ema
belo pássaro de penas, no tronco do Juremá
kiô,kiô,okê, o Juremá
não mate a ema, deixe a ema passar
kiô,kiô,okê, o Juremá
não mate a ema, deixe a ema passar
Cabocla Jurema - Ela tras força$c489716fcb44d93954ed0fbf493d6f00f$, NULL, now()),
('da0d23a5-adc2-5774-9746-a38bd0acfd4b', '68be09dc-e73d-ff41-1589-220baaea442d', $tda0d23a5adc257749746a38bd0acfd4b$Página21de 83$tda0d23a5adc257749746a38bd0acfd4b$, $cda0d23a5adc257749746a38bd0acfd4b$Linda Cabocla Jurema
ela vem do Humaitá
Linda Cabocla Jurema
ela vem do Humaitá
das águas de pai Oxalá
das águas de mãe Iemanjá
ela trasforça pra seus filhosabençoar
das águas de pai Oxalá
das águas de mãe Iemanjá
ela trasforça pra seus filhosabençoar$cda0d23a5adc257749746a38bd0acfd4b$, NULL, now()),
('6cd93c23-13ff-e1ee-310f-abdf1496d3b8', '68be09dc-e73d-ff41-1589-220baaea442d', $t6cd93c2313ffe1ee310fabdf1496d3b8$Caboclo Arariboia - Brasil, é hora$t6cd93c2313ffe1ee310fabdf1496d3b8$, $c6cd93c2313ffe1ee310fabdf1496d3b8$Brasil,é hora
de saudar Arariboia
Brasil,é hora
de saudar Arariboia
Arariboia
é um Caboclo guerreiro
é caçador lá da Jurema
Oxóssi na mata ele é
a sua estrela iluminou
e a bandeira do brasil abençoou
a sua estrela iluminou
e a bandeira do brasil abençoou$c6cd93c2313ffe1ee310fabdf1496d3b8$, NULL, now()),
('80b521af-a10c-521f-6869-160c3056311a', '68be09dc-e73d-ff41-1589-220baaea442d', $t80b521afa10c521f6869160c3056311a$Caboclo Sete Estrelas$t80b521afa10c521f6869160c3056311a$, $c80b521afa10c521f6869160c3056311a$No centro da mata eu vi
uma estrela brilhar
Era o Caboclo Sete Estrelas
tava girando láno Juremá
Sete estrelas, Sete estrelas
olha a gira como está
ele brilhalá na mata e vai girar
neste gongá$c80b521afa10c521f6869160c3056311a$, NULL, now()),
('3e5fe9dc-0b28-d74a-051e-1984b59773a2', '68be09dc-e73d-ff41-1589-220baaea442d', $t3e5fe9dc0b28d74a051e1984b59773a2$Caboclo - Aldeia cercada / A luz do mato$t3e5fe9dc0b28d74a051e1984b59773a2$, $c3e5fe9dc0b28d74a051e1984b59773a2$A minha aldeia tá cercada!
A minha aldeia tá cercada!
de Caboclo é, de Caboclo é!
de Caboclo é, de Caboclo é!
Caboclo de Nazaré
de Caboclo é, de Caboclo é!
de Caboclo é, de Caboclo é!$c3e5fe9dc0b28d74a051e1984b59773a2$, NULL, now()),
('a9df3dad-a83b-1881-d316-6a4cb41f18e1', '68be09dc-e73d-ff41-1589-220baaea442d', $ta9df3dada83b1881d3166a4cb41f18e1$Caboclo Laçador$ta9df3dada83b1881d3166a4cb41f18e1$, $ca9df3dada83b1881d3166a4cb41f18e1$Surgiu, por entre rios e cascatas
de dentro daquelas matas um lindo Caboclo surgiu
foinum momento de beleza
jóiarara da mãe natureza
que aos meus olhos encantou
Caboclo, um lindobrado eu ouvi
era Seu Laçador cantando em Guarani
kiô,kiô
kiô,kiô
Seu Laçador na Umbanda chegou$ca9df3dada83b1881d3166a4cb41f18e1$, NULL, now()),
('0bb28fc7-0d25-d3d6-26de-028b8ec93b09', '68be09dc-e73d-ff41-1589-220baaea442d', $t0bb28fc70d25d3d626de028b8ec93b09$Caboclo Cobra Coral$t0bb28fc70d25d3d626de028b8ec93b09$, $c0bb28fc70d25d3d626de028b8ec93b09$As folhas secas, se alvoroção
fazendo seu ritual
é que as cobras já conhecem
o som do assovio do Seu Cobra Coral
Elas vêem por baixo das folhas
deslizando nelas sem parar
obediência sem igual
para atender ao Seu Cobra Coral$c0bb28fc70d25d3d626de028b8ec93b09$, NULL, now()),
('c5af40cb-2378-983e-cce3-acec3c6c5722', '68be09dc-e73d-ff41-1589-220baaea442d', $tc5af40cb2378983ecce3acec3c6c5722$Caboclo Pena Branca -Ele é a luz, ele é o guia$tc5af40cb2378983ecce3acec3c6c5722$, $cc5af40cb2378983ecce3acec3c6c5722$Caboclo Pena Branca, ele é aluz,ele é o guia
Eleé Oxóssi filhoda Virgem Maria
Eleé a luzque iluminano escuro
eno terreiroos seus filhosestão seguros$cc5af40cb2378983ecce3acec3c6c5722$, NULL, now()),
('023de6fb-d7c9-7daf-a125-3732dc6ee0e4', '68be09dc-e73d-ff41-1589-220baaea442d', $t023de6fbd7c97dafa1253732dc6ee0e4$Na boca da mata eu vi couro gemer$t023de6fbd7c97dafa1253732dc6ee0e4$, $c023de6fbd7c97dafa1253732dc6ee0e4$Na boca da mata eu vicouro gemer
Na boca da mata eu vicouro gemer
vicouro gemer, vi gunga falar
vicouro gemer, vi gunga falar
eos Caboclos faziam, ôôô
eos Caboclos faziam, ôôô$c023de6fbd7c97dafa1253732dc6ee0e4$, NULL, now()),
('644b259d-855e-f881-4110-814e36f1bb9e', '68be09dc-e73d-ff41-1589-220baaea442d', $t644b259d855ef8814110814e36f1bb9e$Caboclos -Vestimenta de caboclo$t644b259d855ef8814110814e36f1bb9e$, $c644b259d855ef8814110814e36f1bb9e$Saia Caboclo, não se atrapalha
saiado meio da samambaia
Vestimenta de Caboclo
ésamambaia, é samambaia, é samambaia$c644b259d855ef8814110814e36f1bb9e$, NULL, now()),
('7efdbe7d-ee72-43eb-c3b0-f5fb62aa6bce', '68be09dc-e73d-ff41-1589-220baaea442d', $t7efdbe7dee7243ebc3b0f5fb62aa6bce$Caboclos -Chamei meus dois irmãos$t7efdbe7dee7243ebc3b0f5fb62aa6bce$, $c7efdbe7dee7243ebc3b0f5fb62aa6bce$Chamei, chamei
Chamei meus doisirmãos
Quem tá de ronda é Caboclo
com seu ouvido no chão
quem tána mata é Jurema
com seu bodoque na mão$c7efdbe7dee7243ebc3b0f5fb62aa6bce$, NULL, now()),
('e04e47b9-8d5a-057c-878f-1d4684f3fdc7', '68be09dc-e73d-ff41-1589-220baaea442d', $te04e47b98d5a057c878f1d4684f3fdc7$Caboclo - Saudação aos Caboclos$te04e47b98d5a057c878f1d4684f3fdc7$, $ce04e47b98d5a057c878f1d4684f3fdc7$Pisa na folha seca
Balança a samambaia
Caboclo tem seu ponto firmado na sapucaia
Tupinambá traz a flecha de Oxóssi
E o caminho Rompe Mato quem abriu
Águia da Mata quem vigia a floresta
Gritou Seu Sete Flechas e o mundo inteiro ouviu
Pisa na folha seca
Balança a samambaia
Caboclo tem seu ponto firmado na sapucaia
Flecheiro atirou,cantou a seriema
E a água da cascata refletiuDona Jurema
E o Caboclo da Lua vem para clarear
Clareia Pena Branca na coroa de Oxalá
Pisa na folha seca
Balança a samambaia
Caboclo tem seu ponto firmado na sapucaia$ce04e47b98d5a057c878f1d4684f3fdc7$, NULL, now()),
('d543bba3-cc6e-87c9-087e-9074f2149dfd', '68be09dc-e73d-ff41-1589-220baaea442d', $td543bba3cc6e87c9087e9074f2149dfd$Caboclo Arruda$td543bba3cc6e87c9087e9074f2149dfd$, $cd543bba3cc6e87c9087e9074f2149dfd$Caboclo Arruda quando vem láde Aruanda
todo mundo entra na banda, abriu seu jacutá
ô brilhaa lua, ô brilhao sol
brilhaestrela Dalva láno arrebol$cd543bba3cc6e87c9087e9074f2149dfd$, NULL, now()),
('c2bd077f-5068-9ddf-b973-37dce26e6f08', '68be09dc-e73d-ff41-1589-220baaea442d', $tc2bd077f50689ddfb97337dce26e6f08$Cabocla Jurema$tc2bd077f50689ddfb97337dce26e6f08$, $cc2bd077f50689ddfb97337dce26e6f08$Sob a lua de prata brincava na mata
uma formosa ema
e enquanto corria, ao seu lado sorriaa Cabocla Jurema
Jurema ê ê ê, Jurema ê ê a
Ela vive em festaporque a florestaé seu abassá
_______________________________________________
E quando a lua sair, eu quero ver quem é
é a cCbocla Jurema, com saiote de penas e seu diadema
_______________________________________________
o Juremê ê ê, o Juremá
Cadê "sua" bodoque, "sua samburá"
sua pitasilga,"sua" sabiá
sua cobra caninana, "sua" tamanduá
deu três voltas na Jurema e tornou a voltar$cc2bd077f50689ddfb97337dce26e6f08$, NULL, now()),
('03b26af5-244f-6ffb-4df0-a5eac246876a', '68be09dc-e73d-ff41-1589-220baaea442d', $t03b26af5244f6ffb4df0a5eac246876a$Caboclos - Caçador de Ubá$t03b26af5244f6ffb4df0a5eac246876a$, $c03b26af5244f6ffb4df0a5eac246876a$Caçador de Ubá veio caçar
Caçador de Ubá veio caçar
Caçador de Ubá êê
Caçador de Ubá êa$c03b26af5244f6ffb4df0a5eac246876a$, NULL, now()),
('efe2c015-81bb-4628-418d-3f594ac60d4b', '68be09dc-e73d-ff41-1589-220baaea442d', $tefe2c01581bb4628418d3f594ac60d4b$Caboclo Ubirajara - Senhor da selva$tefe2c01581bb4628418d3f594ac60d4b$, $cefe2c01581bb4628418d3f594ac60d4b$Elenasceu na mata, foicriado na mata
com as bençãos da Jurema
E vem do Juremá pra trabalharna Umbanda
com ordem suprema
Porque ele é,o Caboclo Ubirajara
pelevermelha, pintada de urucum
enfrentaos perigos das matas
osenhor da selvanão teme a mal nenhum$cefe2c01581bb4628418d3f594ac60d4b$, NULL, now()),
('7cfe655f-2a79-395c-bd7f-ee53173efa8d', '68be09dc-e73d-ff41-1589-220baaea442d', $t7cfe655f2a79395cbd7fee53173efa8d$Caboclo Araúna - Bandeira da Paz$t7cfe655f2a79395cbd7fee53173efa8d$, $c7cfe655f2a79395cbd7fee53173efa8d$Seu Araúna é um caboclo valente
Mas traz abandeira da paz para quem quer união
Mas quem com ele mexer
Seu Araúna lutasem temer
Com sua triboguerreira
E seu irmão Arerê
Aíele atirasua flecha,Okê Caboclo
Eleatirapra vencer$c7cfe655f2a79395cbd7fee53173efa8d$, NULL, now()),
('81500800-1563-5c3c-b3c1-2975e9bfa813', '68be09dc-e73d-ff41-1589-220baaea442d', $t8150080015635c3cb3c12975e9bfa813$Cabocla Jurema - A Jurema é muito linda$t8150080015635c3cb3c12975e9bfa813$, $c8150080015635c3cb3c12975e9bfa813$A Jurema é muito linda
Com seu capacete de penas
Chama a Jurema, chama a Jurema
Chama a Jurema pra salvarfilhosde pemba$c8150080015635c3cb3c12975e9bfa813$, NULL, now()),
('704c6302-7df7-e4b2-0458-8b85d27713c8', '68be09dc-e73d-ff41-1589-220baaea442d', $t704c63027df7e4b204588b85d27713c8$Cabocla Flecheira no passo da ema$t704c63027df7e4b204588b85d27713c8$, $c704c63027df7e4b204588b85d27713c8$Piôôô...
Na mata virgem a sucuri deu um bote
passa no rastroda cobra Cabocla
veioseu ponto firmar
Chama a Cabocla que é filhade Oxóssi
guerreira da tribode Tupinambá
Cabocla Flecheira no passo da ema
veioseus filhosguiar$c704c63027df7e4b204588b85d27713c8$, NULL, now()),
('87b2a57a-c4aa-b32f-659c-4681808f221f', '68be09dc-e73d-ff41-1589-220baaea442d', $t87b2a57ac4aab32f659c4681808f221f$Seu Beira Mar, forte Caboclo do Oriente$t87b2a57ac4aab32f659c4681808f221f$, $c87b2a57ac4aab32f659c4681808f221f$Seu Beira Mar, forteCaboclo do Oriente
vem trabalhar e ajudar filhoscarentes
Traga sua força,sua benção pro gongá
nos ilumine com a bandeira de Oxalá
Seu Beira Mar, forteCaboclo do Oriente
vem trabalhar e ajudar filhoscarentes
Trás o amor, a harmonia e a caridade
iluminando toda a humanidade$c87b2a57ac4aab32f659c4681808f221f$, NULL, now()),
('03c73c3f-f702-a696-c922-124326a93d44', '68be09dc-e73d-ff41-1589-220baaea442d', $t03c73c3ff702a696c922124326a93d44$Caboclo Ventania$t03c73c3ff702a696c922124326a93d44$, $c03c73c3ff702a696c922124326a93d44$Eu sou Ventania de Umbanda, de Umbanda
Eu sou filhoredentor
Mas quando eu chego na Aruanda
É pra saravá com licença de Oxalá
Mas quando eu chego na Aruanda
É pra saravá com licença de Xangô$c03c73c3ff702a696c922124326a93d44$, NULL, now()),
('bc7f10d2-dc40-f4c5-da54-926fd2be657e', '68be09dc-e73d-ff41-1589-220baaea442d', $tbc7f10d2dc40f4c5da54926fd2be657e$Caboclos -A cura dos Tupinambás$tbc7f10d2dc40f4c5da54926fd2be657e$, $cbc7f10d2dc40f4c5da54926fd2be657e$Bradou, bradou
Galo cantou pra anunciar
Bradou, bradou
Galo cantou pra anunciar
Que na mata caboclo mora
Sua pena é verde, Tupinambá
Que na mata caboclo mora
Sua pena é verde, Tupinambá
Caboclo tem passo firme
E na mata não há de existir
Braço mais fortepra proteger
Que o índioguerreiro Tupirani
Na aldeia o índio faz cura
Com as ervas que Ossaim mandou
Para Tupi, índio curandeiro
Que essas ervas amacerou
Os três irmãos vem bradando
Cada um com seu gritode fé
Para curar os filhosdo terreiro
Contando com a ajuda da Aimoré
Bradou, bradou
Galo cantou pra anunciar
Bradou, bradou
Galo cantou pra anunciar
Que na mata caboclo mora
Sua pena é verde, Tupinambá
Que na mata caboclo mora
Sua pena é verde, Tupinambá
Caboclo tem passo firme
E na mata não há de existir
Braço mais forte pra proteger
Que o índio guerreiro Tupirani
Na aldeia o índio faz cura
Com as ervas que Ossaim mandou
Para Tupi, índio curandeiro
Que essas ervas amacerou
Os três irmãos vem bradando
Cada um com seu gritode fé
Para curar os filhosdo terreiro
Contando com a ajuda da Aimoré
Bradou, bradou
Galo cantou pra anunciar
Bradou, bradou
Galo cantou pra anunciar
Que na mata caboclo mora
Sua pena é verde, Tupinambá
Que na mata caboclo mora
Sua pena é verde, Tupinambá$cbc7f10d2dc40f4c5da54926fd2be657e$, NULL, now()),
('3c8e00ce-2c8e-ced0-eb11-64ffd249c5e9', '68be09dc-e73d-ff41-1589-220baaea442d', $t3c8e00ce2c8eced0eb1164ffd249c5e9$Caboclos - Salve os caboclos da Jurema$t3c8e00ce2c8eced0eb1164ffd249c5e9$, $c3c8e00ce2c8eced0eb1164ffd249c5e9$Amanheceu e o sol jáanunciou
Um lindo diaassim se resplandece
Linda alvorada na cidade da jurema
Solo fecundo que abençoa a natureza
Vida sagrada
Que a mãe terra fazbrotar
Seu protetor é filhode Pai Oxalá
Ele é Oxóssi, rei de Ketu o caçador
Reina com sua falange,
Okê, okê! okê, arô!
Seu Rompe Mato, Urubatão,
Cobra-coral, Tupinambá
Bradou tão forte,é meia lua no congá
Pena Verde, Juracy,
Linda Yara e Açucena
Okê, okê, salve os caboclos da jurema
Seu Rompe Mato, Urubatão,
Cobra-coral, Tupinambá
Bradou tão forte,é meia lua no congá
Pena Verde, Juracy,
Linda Yara e Açucena
Okê, okê, salve os caboclos da jurema$c3c8e00ce2c8eced0eb1164ffd249c5e9$, NULL, now()),
('64b6214c-a59b-b7e8-21f4-9afd19f020a6', '68be09dc-e73d-ff41-1589-220baaea442d', $t64b6214ca59bb7e821f49afd19f020a6$Caboclo Rompe Mato$t64b6214ca59bb7e821f49afd19f020a6$, $c64b6214ca59bb7e821f49afd19f020a6$É o rei,é o rei
É o reido panaiá e da jurema
É o rei,é o rei
É o reido panaiá e da jurema
Lá na jurema
Rompe mato é o rei
É o reido panaiá e da jurema
Lá na jurema
Rompe mato é o rei
É o reido panaiá e da jurema
Hoje tem alegria no terreirodo meu pai
Saravá seu rompe mato, que ele é chefe de gongá
Hoje tem alegria no terreirodo meu pai
Saravá seu rompe mato, que ele é chefe de gongá
Embala eu, babá
Embala eu
Embala eu, babá
Embala eu
Embala eu, babá
Embala eu
Embala eu, babá
Embala eu
Hoje tem alegria no terreirodo meu pai
Saravá seu rompe mato, que ele é chefe de gongá
Hoje tem alegria no terreirodo meu pai
Saravá seu rompe mato, que ele é chefe de gongá
Embala eu, babá
Embala eu
Embala eu, babá
Embala eu
Embala eu, babá
Embala eu
Embala eu, babá
Embala eu$c64b6214ca59bb7e821f49afd19f020a6$, NULL, now()),
('ffd494cf-72b6-7bad-aa45-15b6a953dc2b', '68be09dc-e73d-ff41-1589-220baaea442d', $tffd494cf72b67badaa4515b6a953dc2b$Cabocla Jandaia - Na Fé de Zambi$tffd494cf72b67badaa4515b6a953dc2b$, $cffd494cf72b67badaa4515b6a953dc2b$Um arco-írissurgiu láno céu
Jandaia já cantou nas matas
Mas foium canto tão lindo
Que apassarada revoou
Mas foium canto tão lindo
Que apassarada revoou
Mas elavem beirando as ondas
As ondas de Mãe Iemanjá
Ela écabocla guerreira
Jandaia do juremá
Ela écabocla guerreira
Jandaia do juremá
Auê jurema
Peço licença neste gongá
Auê jurema
Cabocla Jandaia que vem trabalhar
Auê jurema
Na fé de Zambi e de Pai Oxalá$cffd494cf72b67badaa4515b6a953dc2b$, NULL, now()),
('faf00f56-41e3-1d94-60c7-e7e0ca45afdc', '68be09dc-e73d-ff41-1589-220baaea442d', $tfaf00f5641e31d9460c7e7e0ca45afdc$Cabocla Iracema - No alto da Serra$tfaf00f5641e31d9460c7e7e0ca45afdc$, $cfaf00f5641e31d9460c7e7e0ca45afdc$No alto da serra
Uma cobra piou
No alto da serra
Iracema chegou
No alto da serra
Uma cobra piou
No alto da serra
Iracema chegou
Cobra que pia
Cobra que chora
No alto da serra
Iracema mora
Cobra que pia
Cobra que chora
No alto da serra
Iracema mora$cfaf00f5641e31d9460c7e7e0ca45afdc$, NULL, now()),
('d9b1193e-5015-df4b-f874-7fbeed74ff4b', '68be09dc-e73d-ff41-1589-220baaea442d', $td9b1193e5015df4bf8747fbeed74ff4b$Caboclo 7 flechas - Foi numa tarde serena$td9b1193e5015df4bf8747fbeed74ff4b$, $cd9b1193e5015df4bf8747fbeed74ff4b$Foinuma tarde serena
Lá nas matas da Jurema eu vium Caboclo bradar
Kiô,kiô,kiô, kiôque era
Sua mata está em festa
Saravá seu Sete Flechas
Que eleé o reida floresta$cd9b1193e5015df4bf8747fbeed74ff4b$, NULL, now()),
('a6cf1650-dcbc-53d1-a14a-305973021dfa', '68be09dc-e73d-ff41-1589-220baaea442d', $ta6cf1650dcbc53d1a14a305973021dfa$Caboclo Arranca Toco$ta6cf1650dcbc53d1a14a305973021dfa$, $ca6cf1650dcbc53d1a14a305973021dfa$Caboclo Arranca Toco
Vem reinar este lugar
Vem cortar todas mirongas
Abençoado por Oxalá
Vem cortar todas mirongas
Abençoado por Oxalá
No terreiroele cura
Suas ervas tem poder
Ele éfilhodo trovão
Meu Pai maior, venha nos valer
Ele éfilhodo trovão
Meu Pai maior, venha nos valer
O seu brado faz tremer
Todos os irmãos de fé
Consulentes no terreiro
Querem levarseu axé
Consulentes no terreiro
Querem levarseu axé
Mas elevem, ele vem trabalhar
Caboclo Arranca Toco vem reinar este lugar
Mas elevem, ele vem trabalhar
Ele vem de aruanda para nos abençoar$ca6cf1650dcbc53d1a14a305973021dfa$, NULL, now()),
('b25f17e3-2551-305c-dad6-0941e1844e10', '68be09dc-e73d-ff41-1589-220baaea442d', $tb25f17e32551305cdad60941e1844e10$Cabocla Jussara - Louvação à Cabocla Jussara$tb25f17e32551305cdad60941e1844e10$, $cb25f17e32551305cdad60941e1844e10$Ela venceu
Ela venceu demanda
Ela vem para o mal derrubar
Jussara, linda cabocla de pena
Ela éfilhada Jurema
Neta de Tupinambá
Ela venceu
Ela venceu demanda
Ela vem para o mal derrubar
Jussara, linda cabocla de pena
Ela é filhada Jurema
Neta de Tupinambá
Bendito seja seu girar nesse terreiro
Seu arco e flecha certeiro
Abençoa nosso caminhar
As matas são o seu lar
Salve Cabocla Jussara
Salve raio de luar
As matas são o seu lar
Salve Cabocla Jussara
Salve raio de luar
Ela venceu
Ela venceu demanda
Ela vem para o mal derrubar
Jussara, linda cabocla de pena
Ela é filhada Jurema
Neta de Tupinambá
Bendito seja seu girar nesse terreiro
Seu arco e flecha certeiro
Abençoa nosso caminhar
As matas são o seu lar
Salve Cabocla Jussara
Salve raio de luar
As matas são o seu lar
Salve Cabocla Jussara
Salve raio de luar
As matas são o seu lar
Salve Cabocla Jussara
Salve raio de luar$cb25f17e32551305cdad60941e1844e10$, NULL, now()),
('e94a3738-c560-7f31-3b1d-c4b64ea315bb', '68be09dc-e73d-ff41-1589-220baaea442d', $te94a3738c5607f313b1dc4b64ea315bb$Caboclo Pena Dourada - A Cura de Pena Dourada$te94a3738c5607f313b1dc4b64ea315bb$, $ce94a3738c5607f313b1dc4b64ea315bb$Grande guerreiro de Oxóssi, traz seu ofá como guia
Nas batalhas da minha vida
Faz a noite virar dia.
Nas batalhas da minha vida
Faz a noite virar dia.
Quando ele vem na Umbanda, os seus filhosvem curar
Traz folhas, frutos e flores
Pro seu pranto enxugar
Traz folhas, frutos e flores
Pro seu pranto enxugar
Ele é nobre, é guerreiro,sábio observador
Com suas ervas ele cura
Viva Deus nosso Senhor
Com suas ervas ele cura
Viva Deus nosso Senhor
Linha maior de Umbanda, capangueiros do astral
Extermina o inimigo
Faz o bem e leva o mal
Extermina o inimigo
Faz o bem e leva o mal
É um caboclo de pena, no firmamento chegou
Ele é Pena Dourada, Oxalá foiquem mandou
Ele é Pena Dourada, Oxalá foiquem mandou$ce94a3738c5607f313b1dc4b64ea315bb$, NULL, now()),
('70b00a3d-68b0-9d65-7dd6-033901df445a', '68be09dc-e73d-ff41-1589-220baaea442d', $t70b00a3d68b09d657dd6033901df445a$Cabocla Jurema -Serenou tanto, Jurema$t70b00a3d68b09d657dd6033901df445a$, $c70b00a3d68b09d657dd6033901df445a$Jurema
Serenou tanto, oh,Jurema
Não molhou nem a minha guia
Oh, Jurema
Jurema
Serenou tanto, oh,Jurema
Não molhou nem a minha guia
Oh, Jurema
Estava na mata caçando
Para os filhosde Vovó Maria
Quando me disseram
Que minha conga caia
Sai pelas matas correndo
Para ver o que acontecia
Quando eu cheguei na tenda
Os meus inimigos caindo
É que eu vi,oh,Jurema
Jurema
Serenou tanto, oh,Jurema
Não molhou nem a minha guia
Oh, Jurema
Jurema
Serenou tanto, oh,Jurema
Não molhou nem a minha guia
Oh, Jurema
Estava na mata caçando
Para os filhosde Vovó Maria
Quando me disseram
Que minha conga caia
Sai pelas matas correndo
Para ver o que acontecia
Quando eu cheguei na tenda
Os meus inimigos caindo
É que eu vi,oh, Jurema
Jurema
Serenou tanto,oh, Jurema
Jurema
Serenou tanto,oh, Jurema$c70b00a3d68b09d657dd6033901df445a$, NULL, now()),
('8e10c096-937f-9ad4-893e-00ece612bf77', '68be09dc-e73d-ff41-1589-220baaea442d', $t8e10c096937f9ad4893e00ece612bf77$Caboclas - Cabocla Tem Pena de Mim$t8e10c096937f9ad4893e00ece612bf77$, $c8e10c096937f9ad4893e00ece612bf77$Oh, Iara,Oh Jurema!
Cabocla, tem pena de mim
Oh, Iara,Oh Jurema!
Cabocla, tem pena de mim
Okê, Cabocla
Salve elas!
Iaraquando vem trazuma rosa
Jurema quando vem, traz um jasmin
Se as duas são irmãs na umbanda, auê!
Cabocla, tem pena de mim
Iaraquando vem trazuma rosa
Jurema quando vem, traz um jasmin
Se as duas são irmãs na umbanda, auê!
Cabocla, tem pena de mim
Se as duas são irmãs na umbanda, auê!
Cabocla, tem pena de mim
Oh, Iara,Oh Jurema!
Cabocla, tem pena de mim
Oh, Iara,Oh jurema!
Cabocla, tem pena de mim
Iaraquando vem trazuma rosa
Jurema quando vem, traz um jasmin
Se as duas são irmãs na Umbanda, auê!
Cabocla, tem pena de mim
Se as duas são irmãs na Umbanda, auê!
Cabocla, tem pena de mim
Oh, Iara,Oh Jurema!
Cabocla, tem pena de mim
Oh, Iara,Oh Jurema!
Cabocla, tem pena de mim
Oh, Iara,Oh jurema!
Cabocla, tem pena de mim
Oh, Iara,Oh jurema!
Cabocla, tem pena de mim$c8e10c096937f9ad4893e00ece612bf77$, NULL, now()),
('c279d910-4bf9-9bb7-55b2-b544aed8e30a', '68be09dc-e73d-ff41-1589-220baaea442d', $tc279d9104bf99bb755b2b544aed8e30a$Caboclo Cobra Coral -Ele é Seu Cobra Coral$tc279d9104bf99bb755b2b544aed8e30a$, $cc279d9104bf99bb755b2b544aed8e30a$Ê,Caboclo,
Salve ele,
Salve seu Cobra Coral!
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Caboclo forte e valente
É o seu Cobra Coral
Força divina e sagrada
Na leide Pai Oxalá
Caboclo forte e valente
É o seu Cobra Coral
Força divina e sagrada
Na leide Pai Oxalá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Caboclo forte e valente
É o seu Cobra Coral
Força divina e sagrada
Na leide Pai Oxalá
Caboclo forte e valente
É o seu Cobra Coral
Força divina e sagrada
Na leide Pai Oxalá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Caboclo forte e valente
É o seu Cobra Coral
Força divina e sagrada
Na leide Pai Oxalá
Caboclo fortee valente
É o seu Cobra Coral
Força divina e sagrada
Na leide Pai Oxalá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Ele é seu Cobra Coral
Ele é seu Cobra Coral
Filhode Oxóssi das matas
Ele mora no juremá
Filhode Oxóssi das matas
Ele mora no juremá
Filhode Oxóssi das matas
Ele mora no juremá$cc279d9104bf99bb755b2b544aed8e30a$, NULL, now()),
('368c5830-ca6f-ef1b-2593-38d1746045b7', '68be09dc-e73d-ff41-1589-220baaea442d', $t368c5830ca6fef1b259338d1746045b7$Caboclos - Cabocla Jacira$t368c5830ca6fef1b259338d1746045b7$, $c368c5830ca6fef1b259338d1746045b7$Ôh, lá na mata o trovão roncou
Ôh lá na mata o chão estremeceu
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foiquem chegou
Oké, Cabocla!
Salve a Cabocla Jacira!
Ôh, lá na mata o trovão roncou
Ôh lá na mata o chão estremeceu
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foiquem chegou
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foiquem chegou
Com seu penacho arco e flecha na mão
Firmou seu ponto aqui no chão
Ela vem para trabalhar
É a Cabocla Jacira que vem nos ajudar
Ela vem para trabalhar
É a Cabocla Jacira que vem nos ajudar
Ôh, lá na mata o trovão roncou
Ôh lá na mata o chão estremeceu
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foiquem chegou
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foiquem chegou
Com seu penacho arco e flecha na mão
Firmou seu ponto aqui no chão
Ela vem para trabalhar
É a Cabocla Jacira que vem nos ajudar
Ela vem para trabalhar
É a Cabocla Jacira que vem nos ajudar
Ôh, lá na mata o trovão roncou
Ôh lá na mata o chão estremeceu
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foi quem chegou
Ôh lá na mata e Oxóssi anunciou
Que a Cabocla Jacira foi quem chegou
Com seu penacho arco e flecha na mão
Firmou seu ponto aqui no chão
Ela vem para trabalhar
É a Cabocla Jacira que vem nos ajudar
Ela vem para trabalhar
É a Cabocla Jacira que vem nos ajudar$c368c5830ca6fef1b259338d1746045b7$, NULL, now()),
('450f8b0e-2ea8-b198-711b-cfdadba6dbe8', '68be09dc-e73d-ff41-1589-220baaea442d', $t450f8b0e2ea8b198711bcfdadba6dbe8$Cabocla Jupira - Jupira Guerreira$t450f8b0e2ea8b198711bcfdadba6dbe8$, $c450f8b0e2ea8b198711bcfdadba6dbe8$Ouça o som que vem das matas…laià
Forte brado a ecoar
Para todo mal quebrar
É a cabocla Jupira, guardiã do jacutá
É a cabocla Jupira, guardiã do jacutá
Ouça o som que vem das matas…laià
Forte brado a ecoar
Para todo mal quebrar
É a cabocla Jupira, guardiã do jacutá
É a cabocla Jupira, guardiã do jacutá
Índiaguerreira
Princesa do juremá
Cabocla flecheira
De firmeza no olhar
Traz seus segredos caetés
Itamaracá
Bate folhas, pajelança
Paié do meu congá
Bate folhas, pajelança
Paié do meu congá
Ouça o som que vem das matas…laià
Forte brado a ecoar
Para todo mal quebrar
É a cabocla Jupira, guardiã do jacutá
É a cabocla Jupira, guardiã do jacutá
Ouça o som que vem das matas…laià
Forte brado a ecoar
Para todo mal quebrar
É a cabocla Jupira, guardiã do jacutá
É a cabocla Jupira, guardiã do jacutá
Índiaguerreira
Princesa do juremá
Cabocla flecheira
De firmeza no olhar
Traz seus segredos caetés
Itamaracá
Bate folhas, pajelança
Paié do meu congá
Bate folhas, pajelança
Paié do meu congá
Ouça o som que vem das matas…laià
Forte brado a ecoar
Para todo mal quebrar
É a cabocla Jupira, guardiã do jacutá
É a cabocla Jupira, guardiã do jacutá
Ouça o som que vem das matas…laià
Forte brado a ecoar
Para todo mal quebrar
É a cabocla Jupira, guardiã do jacutá
É a cabocla Jupira, guardiã do jacutá$c450f8b0e2ea8b198711bcfdadba6dbe8$, NULL, now()),
('5cdf459f-b48e-53e5-66f7-0451513a938b', '68be09dc-e73d-ff41-1589-220baaea442d', $t5cdf459fb48e53e566f70451513a938b$Caboclo Tupinambá - Caboclo Guerreiro$t5cdf459fb48e53e566f70451513a938b$, $c5cdf459fb48e53e566f70451513a938b$Ele abre os caminhos
Pra que eu possa caminhar
Ogan segura a curimba, vai chegar Tupinambá
Okê, Caboclo. Salve o Caboclo Tupinambá!
Ôooooh, esse caboclo guerreiro
É um grande caçador...Ôohhh
Ôooooh, esse caboclo guerreiro
É um grande caçador.
Esse caboclo valente, ele vem de Aruanda
Protege todos os seus filhos,
Quebra todas as demandas
Ele abre os caminhos
Pra que eu possa caminhar
Ogan segura a curimba, vai chegar Tupinambá.
Ôooooh, esse caboclo guerreiro
É um grande caçador...Ôohhh
Ôooooh, esse caboclo guerreiro
É um grande caçador.
Sua flecha é certeira,como a flecha de odé
Ele reza, ele cura, todos os filhosde fé
Com penacho colorido, e seu tacapi na mão
É meu pai, é meu amigo, ele é meu guardião
Sempre estará comigo, assim nunca estou sozinho
Saravá este caboclo, guardião do meu caminho… Ôoh!
Ôooooh, esse caboclo guerreiro
É um grande caçador...Ôohhh
Ôooooh, esse caboclo guerreiro
É um grande caçador.
Esse caboclo valente, ele vem de Aruanda
Protege todos os seus filhos,
Quebra todas as demandas
Ele abre os caminhos
Pra que eu possa caminhar
Ogan segura a curimba, vai chegar Tupinambá.
Ôooooh, esse caboclo guerreiro
É um grande caçador...Ôohhh
Ôooooh, esse caboclo guerreiro
É um grande caçador.
Sua flecha é certeira,como a flecha de odé
Ele reza, ele cura, todos os filhosde fé
Com penacho colorido, e seu tacapi na mão
É meu pai, é meu amigo, ele é meu guardião
Sempre estará comigo, assim nunca estou sozinho
Saravá este caboclo, guardião do meu caminho… Ôoh!
Ôooooh, esse caboclo guerreiro
É um grande caçador...Ôohhh
Ôooooh, esse caboclo guerreiro
É um grande caçador.$c5cdf459fb48e53e566f70451513a938b$, NULL, now()),
('6b46aab2-b9b0-b5b8-a0c4-4d5de0698cb2', '68be09dc-e73d-ff41-1589-220baaea442d', $t6b46aab2b9b0b5b8a0c44d5de0698cb2$Caboclo Ubirajara - A estrela Dalva é sua guia / Que penacho é aquele$t6b46aab2b9b0b5b8a0c44d5de0698cb2$, $c6b46aab2b9b0b5b8a0c44d5de0698cb2$A estrela d´alva é sua guia
Ubirajara é caboclo valente
A estrela d´alva é sua guia
Ubirajara é caboclo valente
Ubirajara mora lá na mata
Lá na grota funda
Lá no fim do mundo
Ubrirajara mora lá na mata
Lá na grota funda
Lá no fim do mundo
A estrela d´alva é sua guia
Ubirajara é caboclo valente
A estrela d´alva é sua guia
Ubirajara é caboclo valente
Ubirajara mora lána mata
Lá na grota funda
Lá no fim do mundo
Ubirajara mora lána mata
Lá na grota funda
Lá no fim do mundo$c6b46aab2b9b0b5b8a0c44d5de0698cb2$, NULL, now()),
('fbdd255e-4328-edc9-cd85-15b679f60548', '68be09dc-e73d-ff41-1589-220baaea442d', $tfbdd255e4328edc9cd8515b679f60548$Cabocla Jandira - Guerreira da Jurema$tfbdd255e4328edc9cd8515b679f60548$, $cfbdd255e4328edc9cd8515b679f60548$Na Jurema faz chover!! Okê Okê!!!
Sol nascer cachoeira brotar!!!
Tem Caboclo na aldeia,
Tem Jandira no Congá!!!
Na Jurema faz chover!! Okê Okê!!!
Sol nascer cachoeira brotar!!!
Tem Caboclo na aldeia,
Tem Jandira no Congá!!!
Ela atirou uma flecha certeira
Iluminou toda a escuridão
Salve a índia brasileira
filhade Urubatão.
Traz das matas de Oxóssi força e fartura
Das águas de mãe Oxum um alento de paz
Traz nascente de água pura,
Uma fonte de luz,
Traz das matas e aldeias com as bençãos de Jesus.
Na Jurema faz chover!! Okê Okê!!!
Sol nascer cachoeira brotar!!!
Tem Caboclo na aldeia,
Tem Jandira no Congá!!!
Na Jurema faz chover!! Okê Okê!!!
Sol nascer cachoeira brotar!!!
Tem Caboclo na aldeia,
Tem Jandira no Congá!!!
Índia Pajé, Takumi cacurucaia
Na linha das águas
Purificae tira a dor
Traz a cura e lava a alma
E me ensina amor
Sua luzque clareia
Os caminhos onde eu for
Oh guerreira Jandira, canto hoje em seu louvor!!!
Na Jurema faz chover!! Okê Okê!!!
Sol nascer cachoeira brotar!!!
Tem Caboclo na aldeia,
Tem Jandira no Congá!!!
Na Jurema faz chover!! Okê Okê!!!
Sol nascer cachoeira brotar!!!
Tem Caboclo na aldeia,
Tem Jandira no Congá!!!$cfbdd255e4328edc9cd8515b679f60548$, NULL, now()),
('2ef50313-15aa-393d-6b4d-7070f2f030ce', '68be09dc-e73d-ff41-1589-220baaea442d', $t2ef5031315aa393d6b4d7070f2f030ce$Caboclo - Caboclo Iambuga$t2ef5031315aa393d6b4d7070f2f030ce$, $c2ef5031315aa393d6b4d7070f2f030ce$Lá no galho da guiné
Tem uma lindajuriti
E ela foiatraída
Pela cobra sucuri
Lá no galho da guiné
Tem uma lindajuriti
E ela foiatraída
Pela cobra sucuri
Seu Iambuga é caçador
Aquela cobra ele matou
E a pomba rola
Bateu asas e voou
Seu Iambuga é caçador
Aquela cobra ele matou
E a pomba rola
Bateu asas e voou
Lá no galho da guiné
Tem uma lindajuriti
E ela foiatraída
Pela cobra sucuri
Lá no galho da guiné
Tem uma lindajuriti
E ela foiatraída
Pela cobra sucuri
Seu Iambuga é caçador
Aquela cobra ele matou
E a pomba rola
Bateu asas e voou
Seu Iambuga é caçador
Aquela cobra ele matou
E a pomba rola
Bateu asas e voou
Seu Imabuga é pai
É chefe do congá
Seu Imabuga é pai
É chefe do congá
Seus filhosestão aqui
Em nome de Oxalá
Seus filhosestão aqui
Em nome de Oxalá
Vamos pedir
Vamos implorar
Benção, meu pai
Que eleé de abençoar
Vamos pedir
Vamos implorar
Benção, meu pai
Que eleé de abençoar
Seu Imabuga é pai
É chefe do congá
Seu Imabuga é pai
É chefe do congá
Seus filhosestão aqui
Em nome de Oxalá
Seus filhosestão aqui
Em nome de Oxalá
Vamos pedir
Vamos implorar
Benção, meu pai
Que eleé de abençoar
Vamos pedir
Vamos implorar
Benção, meu pai
Que eleé de abençoar$c2ef5031315aa393d6b4d7070f2f030ce$, NULL, now()),
('912861ed-4bc9-da97-1b16-9cc9b823e11f', '68be09dc-e73d-ff41-1589-220baaea442d', $t912861ed4bc9da971b169cc9b823e11f$Cabocla Ciara - Cabocla Ciara, Caçadora do Juremá$t912861ed4bc9da971b169cc9b823e11f$, $c912861ed4bc9da971b169cc9b823e11f$Numa tarde linda, à beira da praia
Vidona Ciara, sua flecha atirar
Numa tarde linda, à beira da praia
Vidona Ciara, sua flecha atirar
Jovem cabocla que Iansã nos deu
Traz a força e seu axé,
Com suas rosas e guiné
Ela é guerreira,como um grande javali
Sempre nos defende do mal,
Com a ajuda de Cobra Coral
Dona Ciara, caçadora do juremá
Vem na vibração de Oxóssi, de Iansã e Oxalá
Numa tarde linda,na beira da praia
Vidona Ciara a sua flecha atirar
Numa tarde linda,à beira da praia
Vidona Ciara a sua flecha atirar
Jovem cabocla que Iansã nos deu
Traz a força e seu axé,
Com suas rosas e guiné
Ela é guerreira, como um grande javali
Sempre nos defende do mal,
Com a ajuda de Cobra Coral
Dona Ciara, caçadora do juremá
Vem na vibração de Oxóssi, de Iansã e Oxalá$c912861ed4bc9da971b169cc9b823e11f$, NULL, now()),
('b201a5a7-7b4a-706e-0d97-b7434ab7301a', '68be09dc-e73d-ff41-1589-220baaea442d', $tb201a5a77b4a706e0d97b7434ab7301a$Cabocla - Cabocla Iara$tb201a5a77b4a706e0d97b7434ab7301a$, $cb201a5a77b4a706e0d97b7434ab7301a$Eu vi a cabocla Iara
Sentar na beira do rio
Eu vi a cabocla Iara
Sentar na beira do rio
Pegando peixe, meu senhor
Pegando peixe, meu senhor
Pra levar pra quem pediu
Pegando peixe, meu senhor
Pegando peixe, meu senhor
Pra levar pra quem pediu
Iaracabocla linda
Vem fazer sua obrigação
Iaracabocla linda
Vem fazer sua obrigação
No seu terreiro,meu senhor
No seu terreiro,meu senhor
Ela faz sua devoção
No seu terreiro,meu senhor
No seu terreiro,meu senhor
Ela faz sua devoção
Eu vi a cabocla Iara
Sentar na beira do rio
Eu vi a cabocla Iara
Sentar na beira do rio
Pegando peixe, meu senhor
Pegando peixe, meu senhor
Pra levar pra quem pediu
Pegando peixe, meu senhor
Pegando peixe, meu senhor
Pra levar pra quem pediu
Iaracabocla linda
Vem fazer sua obrigação
Iaracabocla linda
Vem fazer sua obrigação
No seu terreiro,meu senhor
No seu terreiro,meu senhor
Ela faz sua devoção
No seu terreiro,meu senhor
No seu terreiro,meu senhor
Ela faz sua devoção$cb201a5a77b4a706e0d97b7434ab7301a$, NULL, now()),
('e9831f98-5057-d05d-c9bb-8a444b11141e', '68be09dc-e73d-ff41-1589-220baaea442d', $te9831f985057d05dc9bb8a444b11141e$Caboclo - Caboclo Guaracy$te9831f985057d05dc9bb8a444b11141e$, $ce9831f985057d05dc9bb8a444b11141e$Eu vi brilhar,eu vi
No meio da mata, eu vi
A pena de prata do Caboclo Guaracy
Eu vi brilhar,eu vi
No meio da mata, eu vi
A pena de prata do Caboclo Guaracy
O seu arco é de ouro do sol
Sua flecha é um raio de lua
Guardião da floresta
Real sentinela da mata que é sua
Ele é filhoda dona do rio
E se benze com a erva que queima
Bebe a água da casca do pé de aroeira
E licorde jurema
Kiô,kiô, kiô, kiô,que era...
Seu Guaracy vigiaa mata...
Seu Guaracy domina a fera…
Kiô,kiô, kiô, kiô,que era...
Seu Guaracy vigiaa mata...
Seu Guaracy domina a fera…
Eu vi brilhar,eu vi
No meio da mata, eu vi
A pena de prata do Caboclo Guaracy
Eu vi brilhar,eu vi
No meio da mata, eu vi
A pena de prata do Caboclo Guaracy
O seu arco é de ouro do sol
Sua flecha é um raio de lua
Guardião da floresta
Real sentinela da mata que é sua
Ele é filhoda dona do rio
E se benze com a erva que queima
Bebe a água da casca do pé de aroeira
E licorde jurema
Kiô,kiô, kiô, kiô,que era...
Seu Guaracy vigiaa mata...
Seu Guaracy domina a fera…
Kiô,kiô, kiô, kiô,que era...
Seu Guaracy vigiaa mata...
Seu Guaracy domina a fera…$ce9831f985057d05dc9bb8a444b11141e$, NULL, now()),
('1c1be103-50a9-c1da-109e-ea7c93a6ca1c', '68be09dc-e73d-ff41-1589-220baaea442d', $t1c1be10350a9c1da109eea7c93a6ca1c$Caboclo Sete Flechas - Rei dos caçadores$t1c1be10350a9c1da109eea7c93a6ca1c$, $c1c1be10350a9c1da109eea7c93a6ca1c$Na mata virgem o sabiá cantou
aestrela no céu brilhou
Saravá, Seu Sete Flechas o paranga
Eleé rei dos caçadores
Mas eleé o reido Juremá
Saravá Seu Sete Flechas que ele é chefe de gongá
êê...êaOgum jurou bandeira nos campos do Humaitá$c1c1be10350a9c1da109eea7c93a6ca1c$, NULL, now()),
('50208b8e-6f0c-4240-efa1-3d922c97879d', '68be09dc-e73d-ff41-1589-220baaea442d', $t50208b8e6f0c4240efa13d922c97879d$Dois pontos para vários Caboclos e Caboclas$t50208b8e6f0c4240efa13d922c97879d$, $c50208b8e6f0c4240efa13d922c97879d$Okê kokê kokê Odé
Okê oh kokê Odé
Okê de (nome do caboclo) Odé
Okê oh kokê Odé$c50208b8e6f0c4240efa13d922c97879d$, NULL, now()),
('40130573-bb1f-21ed-7845-ed92538d7c40', '68be09dc-e73d-ff41-1589-220baaea442d', $t40130573bb1f21ed7845ed92538d7c40$Caboclo Mirim -Chefe do Oriente$t40130573bb1f21ed7845ed92538d7c40$, $c40130573bb1f21ed7845ed92538d7c40$Salve Mirim, nosso chefe do oriente
Quando ele chega é pra salvar a sua gente
A sua estrela brilhade noite e de dia
no caminho da verdade Seu Mirim é nosso guia$c40130573bb1f21ed7845ed92538d7c40$, NULL, now()),
('532b4ed8-f0e8-bd76-9b00-878fa2ec0718', '68be09dc-e73d-ff41-1589-220baaea442d', $t532b4ed8f0e8bd769b00878fa2ec0718$Caboclo Itatuité$t532b4ed8f0e8bd769b00878fa2ec0718$, $c532b4ed8f0e8bd769b00878fa2ec0718$Quando ele gritana serra,
ea sereia no no mar
Elese chama Itatuité,
Caboclo de urubá
Sua jiboiaestá no rio,
ea sereia no mar
Ele se chama Itatuité,
Caboclo de urubá$c532b4ed8f0e8bd769b00878fa2ec0718$, NULL, now()),
('a6d4aba9-676a-ef79-a31a-07f2f2afc3da', '68be09dc-e73d-ff41-1589-220baaea442d', $ta6d4aba9676aef79a31a07f2f2afc3da$Caboclos - Peri, Aimoré e Tupaiba$ta6d4aba9676aef79a31a07f2f2afc3da$, $ca6d4aba9676aef79a31a07f2f2afc3da$Caboclo do mato
caminhava na beirado rio
Na tribodos Guanaris
seu nome chama Peri
Aimoré moré moré,
Aimoré moré moré,
Aimoré moré moré, moré....
éo indio, é oindio, é o indio
eleé o indio aonde o solnasceu
Já foicacique, jáfoi pajé
hoje éguerreiro na tribodos Aimorés
Aimoré moré moré,
Aimoré moré moré,
Aimoré moré moré, moré...
Nós somos dois guerreiros,dois irmãos unidos
meu nome é Tupaiba, sou filhode Aimoré
Na tribodos Guaranis
omeu irmão chama Peri
Aimoré moré moré,
Aimoré moré moré,
Aimoré moré moré, moré...$ca6d4aba9676aef79a31a07f2f2afc3da$, NULL, now()),
('b629a4a9-1a39-c7c8-62de-68546efed424', '68be09dc-e73d-ff41-1589-220baaea442d', $tb629a4a91a39c7c862de68546efed424$Caboclo - Seu irmão é flor do dia$tb629a4a91a39c7c862de68546efed424$, $cb629a4a91a39c7c862de68546efed424$Seu irmão é flordo dia
Florda manhã e Pena Dourada
Ele éo orvalho da noite
Sereno da madrugada
Mundera alumeia o mundo
Helena aimensidão
Papa ceia vem guiando
ochefe guerreiro ÍndioJaguarão$cb629a4a91a39c7c862de68546efed424$, NULL, now()),
('9406ea1a-1b9b-4f85-2f75-8569f08c6505', '68be09dc-e73d-ff41-1589-220baaea442d', $t9406ea1a1b9b4f852f758569f08c6505$Caboclo - Louvação ao Caboclo Pena Branca$t9406ea1a1b9b4f852f758569f08c6505$, $c9406ea1a1b9b4f852f758569f08c6505$Não tem distância
Não importa o caminho
Não há fronteiras
Que possa me impedir
Seja onde for
Eu vou louvar esse Caboclo
Que me criou
E me ensinou a lhe seguir
Lá na aldeia onde os tambores tocam
Reúne moço, velhinho e criança
Clareia, lua clareia,
Clareia a aldeia de seu Pena Branca
Clareia lua clareia
Quem nesse caboclo não perde a confiança
Okê, caboclo
Seus filhosquerem lhe agradecer
Okê, caboclo
Senhor da mata virgem
Venha sempre me valer
Okê, caboclo
Seus filhosquerem lhe agradecer
Okê, caboclo
Senhor da mata virgem
Venha sempre me valer
Não tem distância
Não importa o caminho
Não há fronteiras
Que possa me impedir
Seja onde for
Eu vou louvar esse caboclo
Que me criou
E me ensinou a lhe seguir
Lá na aldeia onde os tambores tocam
Reúne moço, velhinho e criança
Clareia, lua clareia,
Clareia a aldeia de seu Pena Branca
Clareia lua clareia
Quem nesse caboclo não perde a confiança
Okê, caboclo
Seus filhosquerem lhe agradecer
Okê, caboclo
Senhor da mata virgem
Venha sempre me valer
Okê, caboclo
Seus filhosquerem lhe agradecer
Okê, caboclo
Senhor da mata virgem
Venha sempre me valer$c9406ea1a1b9b4f852f758569f08c6505$, NULL, now()),
('5472a1c3-f9eb-a428-4246-fe44a2d474bc', '68be09dc-e73d-ff41-1589-220baaea442d', $t5472a1c3f9eba4284246fe44a2d474bc$Caboclo Cauíza$t5472a1c3f9eba4284246fe44a2d474bc$, $c5472a1c3f9eba4284246fe44a2d474bc$Kindolelê auê Cauíza
Kindolelê meu sangue real
Mas eleé filhoe ele é neto da Jurema
Kindolelê auê Cauíza
Cauíza é orei
É Orixá
E na hora de Deus, amém
É Orixá
Cauíza é orei
É Orixá
E na hora de Deus, amém
É Orixá
Kindolelê auê Cauíza
Kindolelê meu sangue real
Mas eleé filhoe ele é neto da Jurema
Kindolelê auê Cauíza
Cauíza é orei
É Orixá
E na hora de Deus, amém
É Orixá
Cauíza é orei
É Orixá
E na hora de Deus, amém
É Orixá$c5472a1c3f9eba4284246fe44a2d474bc$, NULL, now()),
('b0dc66fa-b1c2-d804-3fc1-5283ae13ee9a', '68be09dc-e73d-ff41-1589-220baaea442d', $tb0dc66fab1c2d8043fc15283ae13ee9a$Caboclo - Salve seu Mata Verde$tb0dc66fab1c2d8043fc15283ae13ee9a$, $cb0dc66fab1c2d8043fc15283ae13ee9a$No terreirode Umbanda
Uma estrela brilhou
Afirma a corrente, Mata Verde chegou
Iêeeê
Caboclo vem trabalhar
Salve os Caboclos
Seu ponto vamos cantar
Salve o povo de Aruanda
Salve meu pai Oxalá
Salve todos de Umbanda
Salve todo Juremá
Iêeeê
Caboclo vem trabalhar
Salve os Caboclos
Seu ponto vamos cantar$cb0dc66fab1c2d8043fc15283ae13ee9a$, NULL, now()),
('4e90a4f8-2f12-4f30-223f-57e72bb9d762', '68be09dc-e73d-ff41-1589-220baaea442d', $t4e90a4f82f124f30223f57e72bb9d762$Caboclo - Caboclo Sete Estrelas$t4e90a4f82f124f30223f57e72bb9d762$, $c4e90a4f82f124f30223f57e72bb9d762$Mas olha que caboclo lindo
Que seu Oxóssi mandou saravar
Mas olha que caboclo lindo
Que seu Oxóssi mandou saravar
Seu Sete Estrelas na linha de Umbanda
Pena Dourada na leide Oxalá
Seu Sete Estrelas na linha de Umbanda
Pena Dourada na leide Oxalá
Mas olha que caboclo lindo
Que seu Oxóssi mandou saravar
Mas olha que caboclo lindo
Que seu Oxóssi mandou saravar
Seu Sete Estrelas na linha de Umbanda
Pena Dourada na leide Oxalá
Seu Sete Estrelas na linha de Umbanda
Pena Dourada na leide Oxalá
Seu Sete Estrelas na linha de Umbanda
Pena Dourada na leide Oxalá$c4e90a4f82f124f30223f57e72bb9d762$, NULL, now()),
('6bb10053-5455-2700-bc81-ce8a0d60a93f', '68be09dc-e73d-ff41-1589-220baaea442d', $t6bb1005354552700bc81ce8a0d60a93f$Cabocla Jurema - O brado de Jurema$t6bb1005354552700bc81ce8a0d60a93f$, $c6bb1005354552700bc81ce8a0d60a93f$Cabocla, o teu brado eu ouvi
Senti a pureza da mãe natureza
A força das matas também corre em mim
Foi no alvorecer que saí pela mata a caçar
A minha triboestá a me esperar
E no alto daquela pedreira
Onde o rouxinol cantou
A sua flecha
Cabocla Jurema lançou
Lançou, mas não foide maldade
E nem por perigo
No meio da mata não há inimigo
Sua flecha zoou pra triboalimentar
Pois a Cabocla Jurema não vaideixar faltar
Muita fartura pro seu povo prosperar
Pois a Cabocla Jurema não vaideixar faltar
Muita fartura pro seu povo prosperar
Jurema, me dê seu axé, a sua proteção
Na hora difícilestendeu sua mão
Me mostrou o caminho, me ensinou a andar
Me disse em seu abraço, pra nunca parar de tentar
Ainda me disse: não se acerta se não errar
Me disse em seu abraço, pra nunca parar de tentar
Ainda me disse: não se acerta se não errar$c6bb1005354552700bc81ce8a0d60a93f$, NULL, now()),
('398f2957-3c20-bc34-2bf3-3811054fae02', '68be09dc-e73d-ff41-1589-220baaea442d', $t398f29573c20bc342bf33811054fae02$Caboclo - Caboclo Sete Flechas no congá$t398f29573c20bc342bf33811054fae02$, $c398f29573c20bc342bf33811054fae02$Lê, lelelere,lere lere lerelerá
Lê, lerelere, lê,lerelere, Caboclo Sete Flechas no congá
Saravá Seu Sete Flechas, ele é o reida mata
O seu bodoque atira,ô paranga
A sua flecha mata
Saravá Seu Sete Flechas, ele é o reida mata
O seu bodoque atira,ô paranga
A sua flecha mata
Lê,lele,lê lere lerelere lerá
Lê,lele,Caboclo Sete Flechas no congá
Saravá Seu Sete Flechas, ele é orei da mata
O seu bodoque atira,ô paranga
A sua flecha mata
Saravá Seu Sete Flechas, ele é orei da mata
O seu bodoque atira,ô paranga
A sua flecha mata$c398f29573c20bc342bf33811054fae02$, NULL, now()),
('917be80b-72d4-ad21-47ed-b2b134a63baf', '68be09dc-e73d-ff41-1589-220baaea442d', $t917be80b72d4ad2147edb2b134a63baf$Caboclo Tupinambá - Samambaia e Aroeira$t917be80b72d4ad2147edb2b134a63baf$, $c917be80b72d4ad2147edb2b134a63baf$Samambaia e Aroeira na boca da mata tem (2x)
Quando Oxóssi chama, ele vem, elevem, ele vem (2x)
Na sua mata tem a folha que nos cura
E na pedreira correm águas a rolar
Pedra por pedra é que se forma a cachoeira
Na cachoeira onde eu vi Tupinambá
Chamei, chamei
Tupinambá lá na mata é rei$c917be80b72d4ad2147edb2b134a63baf$, NULL, now()),
('9db78a93-52a4-683f-a236-52a27b9513b9', '68be09dc-e73d-ff41-1589-220baaea442d', $t9db78a9352a4683fa23652a27b9513b9$Caboclo Girassol - Girou um Girassol$t9db78a9352a4683fa23652a27b9513b9$, $c9db78a9352a4683fa23652a27b9513b9$O amarelo que brotou em meu jardim
É o mesmo que ilumina esse congá
Traz a alegria
Irradiaenergia
De um caboclo nobre
Que chegou para ajudar
Oxalá lhe coroou
A ele confiou
Os segredos, os mistérios
Que um diao ensinou
Hoje em prol da caridade
Trabalha com lealdade
Cura toda enfermidade
Com uma pétala de flor
Hoje em prol da caridade
Trabalha com lealdade
Cura toda enfermidade
Com uma pétala de flor
Gira girana Umbanda
Gira que o sol raiou
Eu ouvi um lindo brado
Girassol me consagrou
Gira girana Umbanda
Gira que o sol raiou
Eu ouvi um lindo brado
Girassol me consagrou
Okê, Caboclo
Axé!$c9db78a9352a4683fa23652a27b9513b9$, NULL, now()),
('0fbebb55-16ae-e194-8a66-9a6ced3ae4ec', '68be09dc-e73d-ff41-1589-220baaea442d', $t0fbebb5516aee1948a669a6ced3ae4ec$Caboclo - Lua que clareia o mundo$t0fbebb5516aee1948a669a6ced3ae4ec$, $c0fbebb5516aee1948a669a6ced3ae4ec$Lua que clareiao mundo
Que clareiaa terra e o mar
Clareia as matas de Oxóssi
Cidade da jurema
Clareia os caminhos
Que os caboclos vão passar
Para virna umbanda trabalhar
Clareia os caminhos
Que os caboclos vão passar
Para virna umbanda trabalhar
Clareia o luar,clareia
Clareia a umbanda
E esse jacutá
Clareia o luar,clareia
Clareia a umbanda
E esse jacutá$c0fbebb5516aee1948a669a6ced3ae4ec$, NULL, now()),
('5a7a2a2f-0a85-f228-d0d5-317a1bb0f9df', '68be09dc-e73d-ff41-1589-220baaea442d', $t5a7a2a2f0a85f228d0d5317a1bb0f9df$Caboclos - Caboclo Flecheiro$t5a7a2a2f0a85f228d0d5317a1bb0f9df$, $c5a7a2a2f0a85f228d0d5317a1bb0f9df$Ele é CabocloFflecheiro, estrela guia guiou
quando ele vem da Jurema com ordem suprema,
Oxalá quem mandou
Ele atirousua flecha no alto do serra, no romper da manhã
Ele é Caboclo Flecheiro, ele é Caboclo guerreiro
Ele é filhode Tupã$c5a7a2a2f0a85f228d0d5317a1bb0f9df$, NULL, now()),
('c8d35f68-d37b-16aa-6f5d-f690b0f6d6c8', '68be09dc-e73d-ff41-1589-220baaea442d', $tc8d35f68d37b16aa6f5df690b0f6d6c8$Cabocla Jupira - Guerreira da flor$tc8d35f68d37b16aa6f5df690b0f6d6c8$, $cc8d35f68d37b16aa6f5df690b0f6d6c8$Jupira mora de baixo do arvoredo
E caça durante as noites de luar
Na sua gruta ela guarda o segredo
Aonde Oxóssi mandou ela jurar
Jura Jupira Cabocla flecheira da mata
Você traza caça para o povo sofredor
Jura Jupira que sua flecha não erra
Protetora dessa terra
A guerreira da flor$cc8d35f68d37b16aa6f5df690b0f6d6c8$, NULL, now()),
('49ebfe89-0042-545f-5cbe-8def700c4104', '68be09dc-e73d-ff41-1589-220baaea442d', $t49ebfe890042545f5cbe8def700c4104$Cabocla Jurema - Sou filha do vento e da mata$t49ebfe890042545f5cbe8def700c4104$, $c49ebfe890042545f5cbe8def700c4104$Sou filhado vento e da mata
Do vento que vem e que vai
Ossain me olhe e me ajude
Oxóssi que é o meu pai
Guerreira mestiça valente
A vidame ensina a viver
Coragem eu trago na frente
Oxóssi me dá pra vencer
Minha lança, meu arco,meu grito
Meu arco não é vidaem vão
Na mata onde eu sou mestiça
Eu sempre encontro um irmão$c49ebfe890042545f5cbe8def700c4104$, NULL, now()),
('7c12fa63-fcec-adfe-08ff-58e89bfeae6a', '68be09dc-e73d-ff41-1589-220baaea442d', $t7c12fa63fcecadfe08ff58e89bfeae6a$Caboclo Girassol - Força da mata$t7c12fa63fcecadfe08ff58e89bfeae6a$, $c7c12fa63fcecadfe08ff58e89bfeae6a$Força da mata
Folha da sapucaia
Caboclo da aldeia de força maior
Sou eu meu pai,sou eu
A florque nasceu
O Caboclo Girassol$c7c12fa63fcecadfe08ff58e89bfeae6a$, NULL, now()),
('d4d9ea1b-2b6b-fc66-9e19-aaab08093ee5', '68be09dc-e73d-ff41-1589-220baaea442d', $td4d9ea1b2b6bfc669e19aaab08093ee5$Caboclo - Seu Cachoeira$td4d9ea1b2b6bfc669e19aaab08093ee5$, $cd4d9ea1b2b6bfc669e19aaab08093ee5$Caboclo da banda de lá
Peço licença a Oxóssi, para seu ponto afirmar
Kiôkiô
Ouço o brado no rochedo
Balanceia o arvoredo
O meu paivem trabalhar
Corre água na cascata
Mãe Oxum abençoou
Saravá seu Cachoeira
Que fala com pai Xangô
Falacom pai Xangô (2x)
Pede paz na Terra
Que a guerra vire flor$cd4d9ea1b2b6bfc669e19aaab08093ee5$, NULL, now()),
('38501e77-2303-9ab9-24e0-ed3a631606fd', '68be09dc-e73d-ff41-1589-220baaea442d', $t38501e7723039ab924e0ed3a631606fd$Caboclo - Ele é seu Rompe Mato$t38501e7723039ab924e0ed3a631606fd$, $c38501e7723039ab924e0ed3a631606fd$Seu Rompe Mato
Quando vem da sua aldeia
Elevem descendo aserra
Sob a luzda luacheia
Rompendo terra
Rompe o rioe rompe o mar
Eleé seu Rompe Mato
Que chegou pra trabalhar$c38501e7723039ab924e0ed3a631606fd$, NULL, now()),
('f72d0225-2373-0211-d76d-28eafc468f56', '68be09dc-e73d-ff41-1589-220baaea442d', $tf72d022523730211d76d28eafc468f56$Cabocla Jurema - Pode procurar$tf72d022523730211d76d28eafc468f56$, $cf72d022523730211d76d28eafc468f56$Pode procurar
Você não vaiachar
Cabocla de pena
IgualJurema não há
Riscou ponto areia
Firmou seu endá
Cantarola a sereia
Nas sete ondas do mar
Lá na mata virgem
Manda quem veste pena
Se Oxóssi é o rei
A rainhaé Jurema$cf72d022523730211d76d28eafc468f56$, NULL, now()),
('d69ee677-33f6-75f2-8600-cd433c4bf338', '68be09dc-e73d-ff41-1589-220baaea442d', $td69ee67733f675f28600cd433c4bf338$Caboclo Tupinambá - Dono desse Cazuá$td69ee67733f675f28600cd433c4bf338$, $cd69ee67733f675f28600cd433c4bf338$Quando ele veio,láde Aruanda
Trazendo ordens de Pai Oxalá
Sua missão é muito grande
É praticara caridade dentro desse Cazuá
Oisaravá mamãe Oxum
Oisaravá meu paiOxalá
Saravá Tupinambá
OiSaravá, o dono desse Cazuá$cd69ee67733f675f28600cd433c4bf338$, NULL, now()),
('94f996c7-776d-e785-9374-24e85f0fe914', '68be09dc-e73d-ff41-1589-220baaea442d', $t94f996c7776de785937424e85f0fe914$Caboclos - Pena Verde e Pena Branca - Margem do rio$t94f996c7776de785937424e85f0fe914$, $c94f996c7776de785937424e85f0fe914$Eu vina margem do rio
Em linda manhã serena
Caboclo seu Pena Verde
Firmando ponto na areia
Eleé Caboclo guerreiro que mora no rochedo
Somente Cobra Coral
Conhece dele o segredo
Galo cantou na serra, a mata estremeceu
Caboclo seu Pena Branca
Na cachoeira apareceu
Eleé Caboclo guerreiro que mora no rochedo
Somente Cobra Coral
Conhece dele o segredo$c94f996c7776de785937424e85f0fe914$, NULL, now()),
('af9c157a-7fe3-8099-9709-dfb06361e807', '68be09dc-e73d-ff41-1589-220baaea442d', $taf9c157a7fe380999709dfb06361e807$Caboclo Mata Virgem - Nasceu lá nas matas$taf9c157a7fe380999709dfb06361e807$, $caf9c157a7fe380999709dfb06361e807$Seu Mata Virgem nasceu lá nas matas
Se crioulá nas matas
Nas matas reais
Oh lele lê
Oh lele a
Eleé filhode Bartira
Neto de Tupinambá
Bartiraé sua mãe
Seu pai é Aymoré
É mano de mata serrada
Paide mata real
Seu Mata Virgem é
Fugitivoda guaranaia
Com a Jaciramulher do pajé
Seu Mata Virgem é o reidas matas
échefe da tribodos Aymorés
Aymoré moré moré
Aymoré moré moré
Aymoré moré moré, sou eu$caf9c157a7fe380999709dfb06361e807$, NULL, now()),
('aea2dddc-37c7-ce68-a9f3-5523e2d72a45', '68be09dc-e73d-ff41-1589-220baaea442d', $taea2dddc37c7ce68a9f35523e2d72a45$Caboclo da Jurema - Aldeia de Nazaré$taea2dddc37c7ce68a9f35523e2d72a45$, $caea2dddc37c7ce68a9f35523e2d72a45$Ê que Caboclo
Caboclo da Jurema
Ê que Caboclo
Caboclo da Juremá
Caboclo trabalha sentado
Caboclo trabalha em pé
Caboclo vem da aldeia
Da aldeia de Nazaré
Eleé, eleé
Caboclo de Nazaré$caea2dddc37c7ce68a9f35523e2d72a45$, NULL, now()),
('12f2ed61-a66f-eb19-ccde-f4a96168395e', '68be09dc-e73d-ff41-1589-220baaea442d', $t12f2ed61a66feb19ccdef4a96168395e$Caboclo Samambaia -Hoje eu vim pra trabalhar$t12f2ed61a66feb19ccdef4a96168395e$, $c12f2ed61a66feb19ccdef4a96168395e$Quanto tempo que eu não bambeio
Hoje eu vim pra trabalhar
Sou Caboclo Samambaia
Vim aqui pra trabalhar
Sou Caboclo Samambaia
Vim aqui pra saravar$c12f2ed61a66feb19ccdef4a96168395e$, NULL, now()),
('2d599371-6f42-a8c4-b657-32107ec41ed5', '68be09dc-e73d-ff41-1589-220baaea442d', $t2d5993716f42a8c4b65732107ec41ed5$Cabocla Jurema - Olha as folhas$t2d5993716f42a8c4b65732107ec41ed5$, $c2d5993716f42a8c4b65732107ec41ed5$Olha as folhas da Jurema estão caindo
Estão caindo enfeitando esse congá
Jurema Cabocla linda
Jurema da pele morena
Jurema do saiote de pena
Vem dançar nesse terreiro(bis)
Saravando meu congá
Vem ládas matas onde fazsua morada
No seu penacho tem penas de várias cores
Pena vermelha porquê elajá foiguerreira
Tem pena verde porquê Oxóssi é seu pai
Tem pena azulque representa as forças d'água
Tem pena branca pra representar a paz
Jurema ê
Jurema a
Cabocla lindavem dançar nesse congá$c2d5993716f42a8c4b65732107ec41ed5$, NULL, now()),
('ba63b734-08ec-0dc0-3c48-caaaa3e780b3', '68be09dc-e73d-ff41-1589-220baaea442d', $tba63b73408ec0dc03c48caaaa3e780b3$Caboclo Guaracy - Eu vi brilhar$tba63b73408ec0dc03c48caaaa3e780b3$, $cba63b73408ec0dc03c48caaaa3e780b3$Eu vibrilhar,eu vi
No meio da mata, eu vi
A pena de prata
Do Caboclo Guaracy
O seu arco é de ouro do sol
sua flecha é um raiode lua
Guardião da floresta
Real sentinela
Da mata que é sua
Eleé filhoda dona do rio
E se benze com a erva que queima
Bebe a água da casca
Do pé de aroeira
E licorde Jurema
Kiô,kiô,kiô, kiô,que era
Seu Guaracy vigiaa mata
Seu Guaracy domina a fera$cba63b73408ec0dc03c48caaaa3e780b3$, NULL, now()),
('a9711063-8044-ec03-15ba-31a565cdf3d4', '68be09dc-e73d-ff41-1589-220baaea442d', $ta97110638044ec0315ba31a565cdf3d4$Caboclo Tamandaqué -Quem ele é?$ta97110638044ec0315ba31a565cdf3d4$, $ca97110638044ec0315ba31a565cdf3d4$Aonde vaivocê?
Aonde você vai?
Eu vou na mata
Tomar benção do meu pai
Quem ele é?
Quem ele é?
Eleé meu pai Caboclo Tamandaqué$ca97110638044ec0315ba31a565cdf3d4$, NULL, now()),
('f8b0f43b-50a9-6d88-7478-9e7f9a49a0ec', '68be09dc-e73d-ff41-1589-220baaea442d', $tf8b0f43b50a96d8874789e7f9a49a0ec$Caboclo Sete Flechas -Jardim das Oliveiras$tf8b0f43b50a96d8874789e7f9a49a0ec$, $cf8b0f43b50a96d8874789e7f9a49a0ec$Caboclo Sete Flechas nasceu
No jardim das oliveiras
Traziaamarrado em sua cintauma coral
Sucuri,jibóiada aldeia
Sucuri,jibóia
Quando vem beirando omar
Olha com o branco olhou
A sua cobra coral
Segura essa cobra não deixa elafugir
Que o nome dessa cobra, é cobra sucuri$cf8b0f43b50a96d8874789e7f9a49a0ec$, NULL, now()),
('6874ce52-94b5-f012-0ed9-78cf696b7ed9', '68be09dc-e73d-ff41-1589-220baaea442d', $t6874ce5294b5f0120ed978cf696b7ed9$Caboclo da Lua - Ele é filho de Umbanda$t6874ce5294b5f0120ed978cf696b7ed9$, $c6874ce5294b5f0120ed978cf696b7ed9$Eleé filhode Umbanda
Elevem lá do oriente
Salve o Caboclo da Lua
Salve Deus onipotente
Salve o Caboclo da Lua
Eleé Oxóssi, é São Sebastião$c6874ce5294b5f0120ed978cf696b7ed9$, NULL, now()),
('ce689a25-2dfc-1588-160e-34b3c6730556', '68be09dc-e73d-ff41-1589-220baaea442d', $tce689a252dfc1588160e34b3c6730556$Caboclo Flecheiro - Ele vem de tão longe$tce689a252dfc1588160e34b3c6730556$, $cce689a252dfc1588160e34b3c6730556$Elevem de tão longe
Cansado de caminhar
Salve o Caboclo Flecheiro
Que vem saravá seu congá
Pra chegar nesse terreiro
Elecortou tanto cipó
Atravessou a mata virgem
Veio na fédo pai maior
Caboclo Tupaiba -Pedra rolou$cce689a252dfc1588160e34b3c6730556$, NULL, now()),
('de9f2a34-9c13-e777-dca3-c70696e2ade4', '68be09dc-e73d-ff41-1589-220baaea442d', $tde9f2a349c13e777dca3c70696e2ade4$Página 57de 83$tde9f2a349c13e777dca3c70696e2ade4$, $cde9f2a349c13e777dca3c70696e2ade4$Eu vicair folha
Eu vicair galho
Caboclo Tupaiba
Vem abrirnossos trabalhos
Pedra rolou, rolou lanas pedreiras
Passou pela mata virgem
Foicair nas cachoeiras$cde9f2a349c13e777dca3c70696e2ade4$, NULL, now()),
('893676d6-a020-0846-3120-9a079b3b0d03', '68be09dc-e73d-ff41-1589-220baaea442d', $t893676d6a020084631209a079b3b0d03$Caboclo Pena Branca - Na mata virgem$t893676d6a020084631209a079b3b0d03$, $c893676d6a020084631209a079b3b0d03$Na mata virgem uma coral piou
Ele "tava"caçando, eu "tava"escutando
Oh seu Pena Branca de Umbanda
Caçador de Aruanda, vencedor de demanda$c893676d6a020084631209a079b3b0d03$, NULL, now()),
('21cb41de-f0cd-0284-b141-17385023a57b', '68be09dc-e73d-ff41-1589-220baaea442d', $t21cb41def0cd0284b14117385023a57b$Caboclos - Tupinambá - Caboclo Guerreiro$t21cb41def0cd0284b14117385023a57b$, $c21cb41def0cd0284b14117385023a57b$Ôooooh, esse caboclo guerreiro
éum grande caçador...Ôohhh
esse caboclo valente
elevem de Aruanda
protege todos os seus filhos
quebra todas as demandas
Ele abre os caminhos
pra que eu possa caminhar
Ogan segura a curimba
vaichegar Tupinambá
ôoohhh
Ôooooh, esse caboclo guerreiro
éum grande caçador...Ôohhh
Sua flecha é certeira
como a flecha de Odé
elereza, ele cura
todos os filhosde fé
Com penacho colorido
eseu tacapi na mão
émeu pai,é meu amigo
eleé meu guardião
sempre estará comigo
assim nunca estou sozinho
Saravá este caboclo
Guardião do meu caminho
Ôooooh, esse caboclo guerreiro
éum grande caçador...Ôohhh$c21cb41def0cd0284b14117385023a57b$, NULL, now()),
('0e6fcd0e-3892-07ec-6adc-2d624fc99ed4', '68be09dc-e73d-ff41-1589-220baaea442d', $t0e6fcd0e389207ec6adc2d624fc99ed4$Caboclo - Portão da Aldeia /Boca da Mata$t0e6fcd0e389207ec6adc2d624fc99ed4$, $c0e6fcd0e389207ec6adc2d624fc99ed4$Portão da Aldeiaabriu
Para Caboclo passar 2x
É hora,é hora, é hora meus Caboclos
É hora de trabalhar2x
Auê auê auê boca da mata
Deixa Caboclo passar boca da mata 2x$c0e6fcd0e389207ec6adc2d624fc99ed4$, NULL, now()),
('d942f576-337c-250d-4533-19bcfff4cf8d', '68be09dc-e73d-ff41-1589-220baaea442d', $td942f576337c250d453319bcfff4cf8d$Caboclo Curumataí - Sou Curumataí$td942f576337c250d453319bcfff4cf8d$, $cd942f576337c250d453319bcfff4cf8d$Meu pai Xangô me coroou lána pedreira
na cachoeira eu vim saudar mamãe Oxum
Meu filhoeu não sou rei,eusó trabalho aqui
na Umbanda eu sou Curumataí
Na minha terratem líriobrancomamãe
aieieu minha mãe
tem machadinha de ouro Xangô, Agodô$cd942f576337c250d453319bcfff4cf8d$, NULL, now()),
('13b1ad71-9490-0c5a-b574-4f85d6de5c6c', '68be09dc-e73d-ff41-1589-220baaea442d', $t13b1ad7194900c5ab5744f85d6de5c6c$Caboclo Flecheiro - Vocês estão vendo aquele meu Caboclo$t13b1ad7194900c5ab5744f85d6de5c6c$, $c13b1ad7194900c5ab5744f85d6de5c6c$Vocês estão vendo aquele meu Caboclo
que está em cima daquele lajedo
olhando o tempo para não chover
evendo a luapra sairmais cedo
okê Caboclo
okê Caboclo Flecheiro [2x]$c13b1ad7194900c5ab5744f85d6de5c6c$, NULL, now()),
('50affad3-b5fa-7947-0bac-d4633239dbb6', '68be09dc-e73d-ff41-1589-220baaea442d', $t50affad3b5fa79470bacd4633239dbb6$Caboclo - Eu andei, andei, andei$t50affad3b5fa79470bacd4633239dbb6$, $c50affad3b5fa79470bacd4633239dbb6$Eu andei
andei
andei,andei, andei
praencontrar ______________
nessa aldeiareal [4x]
Caboclo - Eu já mandei fazer 3 capacetes de pena$c50affad3b5fa79470bacd4633239dbb6$, NULL, now()),
('09413563-a662-83bc-e533-1f6b5cf37eeb', '68be09dc-e73d-ff41-1589-220baaea442d', $t09413563a66283bce5331f6b5cf37eeb$Página59de 83$t09413563a66283bce5331f6b5cf37eeb$, $c09413563a66283bce5331f6b5cf37eeb$Eu jámandei fazer
trêscapacetes de penas [2x]
um é da Iara
outroé da Janaína
eoutro é da Jurema [2x]$c09413563a66283bce5331f6b5cf37eeb$, NULL, now()),
('2f19b906-c448-8aac-ff8a-1f9be6e1aafb', '68be09dc-e73d-ff41-1589-220baaea442d', $t2f19b906c4488aacff8a1f9be6e1aafb$Caboclos - Caboclo Rompe Ferro$t2f19b906c4488aacff8a1f9be6e1aafb$, $c2f19b906c4488aacff8a1f9be6e1aafb$O dono da mata é Oxóssi,
protetordos Caboclos de Umbanda
O dono da mata é Oxóssi,
protetordos Caboclos de Umbanda
aiê,aiê,
Rompe Ferro é quem vence demanda
aiê,aiê,
Rompe Ferro é quem vence demanda
Rompe Ferro é Caboclo valente
arrebenta corrente,meu Pai Oxalá
Rompe Ferro é Cacique de tribo
derrota oinimigo do lado de lá
Rompe Ferro é Caboclo valente
arrebenta corrente,meu Pai Oxalá
Rompe Ferro é Cacique de tribo
derrota oinimigo do lado de lá$c2f19b906c4488aacff8a1f9be6e1aafb$, NULL, now()),
('f42899ab-d50b-cd6f-b7b6-e97e0e423d69', '68be09dc-e73d-ff41-1589-220baaea442d', $tf42899abd50bcd6fb7b6e97e0e423d69$Caboclo -Foi numa tarde serena$tf42899abd50bcd6fb7b6e97e0e423d69$, $cf42899abd50bcd6fb7b6e97e0e423d69$Foinuma tarde serena
lánas matas da jurema
eu vium Caboclo bradar
Foinuma tarde serena
lánas matas da jurema
eu vium Caboclo bradar
kiooooo
kiokio kiokiera
toda mata está em festa
saravá Seu Sete Flechas
que ele é reida floresta$cf42899abd50bcd6fb7b6e97e0e423d69$, NULL, now()),
('2e618115-9497-c245-6728-5425fd34b0d5', '68be09dc-e73d-ff41-1589-220baaea442d', $t2e6181159497c24567285425fd34b0d5$Caboclo -Estrela lá no céu brilhou$t2e6181159497c24567285425fd34b0d5$, $c2e6181159497c24567285425fd34b0d5$Estrelalá no céu brilhou
eas matas estremeceu [2x]
Aonde anda capangueiro da Jurema
que até agora não apareceu [2x]$c2e6181159497c24567285425fd34b0d5$, NULL, now()),
('98b9dbc2-8614-a6f2-ef2d-673c6fad1ff6', '68be09dc-e73d-ff41-1589-220baaea442d', $t98b9dbc28614a6f2ef2d673c6fad1ff6$Caboclo - Entrei nas matas sem pedir licença$t98b9dbc28614a6f2ef2d673c6fad1ff6$, $c98b9dbc28614a6f2ef2d673c6fad1ff6$Entreinas matas sem pedir licença
só pra vera força que a Jurema tem [2x]
Jurema oh minha mãe
Jurema oh minha mãe
Jurema oh minha mãe
Jurema…$c98b9dbc28614a6f2ef2d673c6fad1ff6$, NULL, now()),
('2d31dcd5-6dfb-a9c4-858b-d1d25cc327b8', '68be09dc-e73d-ff41-1589-220baaea442d', $t2d31dcd56dfba9c4858bd1d25cc327b8$Caboclo - Ubirajara é caboclo bom$t2d31dcd56dfba9c4858bd1d25cc327b8$, $c2d31dcd56dfba9c4858bd1d25cc327b8$Ubirajaraé caboclo bom
Ubirajaraé caboclo forte
Ubirajaratem peito de aço
eleé cacique, é do sertão do norte
Ubirajara
oh Iracema
traza Cabocla Jussara
proterreiroda Jurema
traza sua flecha
traza sua guia
vem trabalhar no terreiro
com Caboclo Ventania [2x]$c2d31dcd56dfba9c4858bd1d25cc327b8$, NULL, now()),
('13d50f59-6e3b-98e3-4734-5349e7bf4d87', '68be09dc-e73d-ff41-1589-220baaea442d', $t13d50f596e3b98e347345349e7bf4d87$Cabocla Jupira - Estava na beira do rio$t13d50f596e3b98e347345349e7bf4d87$, $c13d50f596e3b98e347345349e7bf4d87$Estava na beira do rio
ouvium Caboclo assobiar [2x]
acorda Jupira, acorda Jupira, acorda
vem trabalhar [2x]$c13d50f596e3b98e347345349e7bf4d87$, NULL, now()),
('6497d434-8a49-15f3-ed1b-bf6d30f8268c', '68be09dc-e73d-ff41-1589-220baaea442d', $t6497d4348a4915f3ed1bbf6d30f8268c$Caboclo - Sete Encruzilhadas$t6497d4348a4915f3ed1bbf6d30f8268c$, $c6497d4348a4915f3ed1bbf6d30f8268c$Um índioCaboclo guerreiro
um Jezuíta que Zambi enviou
com sua força esabedoria
abraçou a Umbanda com o seu amor
No dia 15 de novembro
Zéliode Moraes teve a incorporação
foiem 1908 no bairrode Neves
uma revolução
Houve muita discórdia
no centro de mesa com a revelação
quando ele disse, eu vim cumprir a missão
vou fincara bandeira da nossa nação
Vitóriameu Pai, vitória
de um índioguerreiro um desbravador
Caboclo das Sete Encruzilhadas
que plantou a semente que se alastrou
Umbanda é amor, fraternidade
Umbanda é bondade
édeterminação
élutar em prolda caridade para os nossos guias
da-nos evolução
São glórias meu Pai, são glórias
são glórias para homenagear
Caboclo das Sete Encruzilhadas
neste solo sagrado de Pai Oxalá$c6497d4348a4915f3ed1bbf6d30f8268c$, NULL, now()),
('f20d05cf-a2ef-2ba8-ee45-3bbadf983d13', '68be09dc-e73d-ff41-1589-220baaea442d', $tf20d05cfa2ef2ba8ee453bbadf983d13$Caboclo - Cobra Coral é caboclo$tf20d05cfa2ef2ba8ee453bbadf983d13$, $cf20d05cfa2ef2ba8ee453bbadf983d13$Cobra Coral é Caboclo
Cobra Coral é Caboclo
Ele mora lánas matas
juntocom Arranca-Toco [2x]$cf20d05cfa2ef2ba8ee453bbadf983d13$, NULL, now()),
('edfc35c1-2a2d-58ec-f9b6-c19e4ebc3a21', '68be09dc-e73d-ff41-1589-220baaea442d', $tedfc35c12a2d58ecf9b6c19e4ebc3a21$Caboclo - Caboclo Arranca-toco , Jurema e Caçador$tedfc35c12a2d58ecf9b6c19e4ebc3a21$, $cedfc35c12a2d58ecf9b6c19e4ebc3a21$Ôoooo
Ó que beleza o clarão da lua no Juremá
Caboclo Arranca Toco, Jurema e Caçador
Saindo para caçar
Ôooooo
Arranca Toco com sua lança dourada
Pede licença a Zambi quando sai para caçar
Dona Jurema com saiote de pena
Seu arco e sua flecha
Reza prece a Oxalá
Seu Caçador avistou a linda ema
Belo pássaro de pena
No tronco do Juremá
Kio kiookê ô Juremá
Não mate a ema, deixe a ema passar$cedfc35c12a2d58ecf9b6c19e4ebc3a21$, NULL, now()),
('a87c5749-269b-93db-afd0-26e4e6c72fca', '68be09dc-e73d-ff41-1589-220baaea442d', $ta87c5749269b93dbafd026e4e6c72fca$Caboclo - Hoje tem alegria no terreiro do meu Pai$ta87c5749269b93dbafd026e4e6c72fca$, $ca87c5749269b93dbafd026e4e6c72fca$Hoje tem alegria
no terreirodo meu Pai
saravá dona Jurema
que ela é chefe de gongá
embala eu Babá
embala eu
embala eu Babá
embala eu$ca87c5749269b93dbafd026e4e6c72fca$, NULL, now()),
('f8ee86bf-d4de-a626-79fd-7401b69633eb', '68be09dc-e73d-ff41-1589-220baaea442d', $tf8ee86bfd4dea62679fd7401b69633eb$Caboclo - Ele é Caboclo$tf8ee86bfd4dea62679fd7401b69633eb$, $cf8ee86bfd4dea62679fd7401b69633eb$Ele é Caboclo
éo rei da selva
Ele é Caboclo
éo rei da selva
Pai e filhoEspiritoSanto
nas horas de Deus amém
na glóriado Pai eterno
éum lê lêlê
éum lá lálá
éum lê lêlê
éum lá lálá
éum lê lêdo lêlê
éum lá ládo lálá
éum lê lêdo lêlê
éum lá ládo lálá$cf8ee86bfd4dea62679fd7401b69633eb$, NULL, now()),
('b410e5a1-6a7c-e3ae-deee-fcd7a1abb238', '68be09dc-e73d-ff41-1589-220baaea442d', $tb410e5a16a7ce3aedeeefcd7a1abb238$Caboclos - Boca da mata /Portão da aldeia abriu / Dança do Caboclo$tb410e5a16a7ce3aedeeefcd7a1abb238$, $cb410e5a16a7ce3aedeeefcd7a1abb238$Ea ea ê boca da mata
deixa meus Caboclos passar
boca da mata
Ea ea ê boca da mata
deixa meus Caboclos passar
boca da mata$cb410e5a16a7ce3aedeeefcd7a1abb238$, NULL, now()),
('1451ee02-85ff-a711-f256-86acfd3f96c4', '68be09dc-e73d-ff41-1589-220baaea442d', $t1451ee0285ffa711f25686acfd3f96c4$Caboclo Tupinambá$t1451ee0285ffa711f25686acfd3f96c4$, $c1451ee0285ffa711f25686acfd3f96c4$Tupinambá por Deus eu lhepeço
epela sua coroa real
Tupinambá por Deus eu lhepeço
epela sua coroa real
Olha eu lhe peço saia da sua aldeia
evenha dar um passeio por cá
Olha eu lhe peço saia da sua aldeia
evenha dar um passeio por cá$c1451ee0285ffa711f25686acfd3f96c4$, NULL, now()),
('abc973b8-9ef7-1926-a5bd-d47b09d54aba', '68be09dc-e73d-ff41-1589-220baaea442d', $tabc973b89ef71926a5bdd47b09d54aba$Caboclos - Quando o meu tambor rufar (Caboclo Tupinambá)$tabc973b89ef71926a5bdd47b09d54aba$, $cabc973b89ef71926a5bdd47b09d54aba$Quando o meu tambor rufar
eu sintoa presença de Tupinambá
Quando o meu tambor rufar
eu sintoa presença de Tupinambá
deixa a noitecair
vejauma estrela brilhar
amacáia estava em festa
praTupinambá chegar
eleé Caboclo
elevem caçar
eleé guerreiro
eleé Tupinambá
eleé Caboclo
elevem caçar
eleé guerreiro
eleé Tupinambá$cabc973b89ef71926a5bdd47b09d54aba$, NULL, now()),
('b68fe3f9-13d0-bf12-8f41-6a813acca65c', '68be09dc-e73d-ff41-1589-220baaea442d', $tb68fe3f913d0bf128f416a813acca65c$Caboclos - Caçador na beira do caminho$tb68fe3f913d0bf128f416a813acca65c$, $cb68fe3f913d0bf128f416a813acca65c$Caçador na beira do caminho
não me mate essa coral na estrada
elaabandonou sua choupana
no romper da madrugada
Caboclos - As folhas da Jurema quando o vento vai levando$cb68fe3f913d0bf128f416a813acca65c$, NULL, now()),
('abc710ad-af88-09f0-eba9-215630a1d57f', '68be09dc-e73d-ff41-1589-220baaea442d', $tabc710adaf8809f0eba9215630a1d57f$Página64de 83$tabc710adaf8809f0eba9215630a1d57f$, $cabc710adaf8809f0eba9215630a1d57f$As Folhas da Jurema
quando o vento vai levando
Ela vaicaindo
eos Caboclos apanhando$cabc710adaf8809f0eba9215630a1d57f$, NULL, now()),
('0de4150c-786e-85f3-d835-172d304949d2', '68be09dc-e73d-ff41-1589-220baaea442d', $t0de4150c786e85f3d835172d304949d2$Caboclos - Caboclo Guaracy$t0de4150c786e85f3d835172d304949d2$, $c0de4150c786e85f3d835172d304949d2$Eu vibrilhareu vi,no meio da mata eu vi
apena de pratado Caboclo Guaracy
O seu arco éde ouro do sol
sua flecha é um raiode lua
guardião da floresta,real sentinela da mata que é sua
eleé filhoda dona do rio
ese benze com a erva que queima
bebe água da casca do pé de aroeira e licorde Jurema
kiô
kiô,kiô,kiô que era
seu Guaracy vigia a mata
seu Guaracy domina a fera$c0de4150c786e85f3d835172d304949d2$, NULL, now()),
('e9ea5931-a994-e1f2-6461-7d3df8ef8114', '68be09dc-e73d-ff41-1589-220baaea442d', $te9ea5931a994e1f264617d3df8ef8114$Caboclo - Caiu uma folha na Jurema$te9ea5931a994e1f264617d3df8ef8114$, $ce9ea5931a994e1f264617d3df8ef8114$Caiu uma folha na Jurema
veioo sereno e molhou
Caiu uma folha na Jurema
veioo sereno e molhou
E depois veio o sol
enxugou enxugou
eas sua mata
se abriutoda em flôr
E depois veio o sol
enxugou enxugou
eas sua mata
se abriutoda em flôr$ce9ea5931a994e1f264617d3df8ef8114$, NULL, now()),
('9c3a1b0b-a8c4-a7a7-ac86-db9d513cba42', '68be09dc-e73d-ff41-1589-220baaea442d', $t9c3a1b0ba8c4a7a7ac86db9d513cba42$Caboclo - Como é tão lindo assistir festa na mata$t9c3a1b0ba8c4a7a7ac86db9d513cba42$, $c9c3a1b0ba8c4a7a7ac86db9d513cba42$Como é tão lindo
assistirfestana mata
ouviro som das cascatas
eo lindo canto do sabiá
Que noitelinda
lindanoite de luar
foino clarão da lua
que eu vi,Seu Flecheiro passar
A mata está em festa
toda coberta de flores
atéos passarinhos cantavam, meus caboclos
mas elescantam em seu louvor
ôôôô oh que beleza
ôôôô quanto esplendor
como é bom tera certeza
que o Seu Flecheiro
émeu protetor[2x]$c9c3a1b0ba8c4a7a7ac86db9d513cba42$, NULL, now()),
('cb4d64a9-b774-eb78-5aeb-81b2a73c7678', '68be09dc-e73d-ff41-1589-220baaea442d', $tcb4d64a9b774eb785aeb81b2a73c7678$Caboclo -7 flechas no gongá$tcb4d64a9b774eb785aeb81b2a73c7678$, $ccb4d64a9b774eb785aeb81b2a73c7678$erê rê
Caboclo 7 flechas no gongá
erê rê
Caboclo 7 flechas no gongá
Saravá Seu 7 flechas
que ele é o reida mata
com asua bodoque atira (ôparanga)
sua flecha mata [2x]
erê rê
Caboclo 7 flechas no gongá
erê rê
Caboclo 7 flechas no gongá$ccb4d64a9b774eb785aeb81b2a73c7678$, NULL, now()),
('d17fae8d-dd69-ae6e-b7f3-894fc65dd673', '68be09dc-e73d-ff41-1589-220baaea442d', $td17fae8ddd69ae6eb7f3894fc65dd673$Subida Caboclos - Na boca da mata$td17fae8ddd69ae6eb7f3894fc65dd673$, $cd17fae8ddd69ae6eb7f3894fc65dd673$Eleveio e trabalhou na Umbanda atéagora
Oxalá lhe chama, ele vaiembora
Eletrabalhou na Umbanda até agora
éna boca da mata, é na boca da mata que ele mora$cd17fae8ddd69ae6eb7f3894fc65dd673$, NULL, now()),
('57fa9d38-a163-040e-eb87-6cf66fd29b10', '68be09dc-e73d-ff41-1589-220baaea442d', $t57fa9d38a163040eeb876cf66fd29b10$Caboclo -Louvação ao Caboclo Pena Branca$t57fa9d38a163040eeb876cf66fd29b10$, $c57fa9d38a163040eeb876cf66fd29b10$Não tem distância
não importa o caminho
Não há fronteiras
que possa me impedir
Seja onde for
eu vou louvar esse Caboclo
Que me criou
eme ensinou a lhe seguir
Lá na aldeia onde os tambores tocam
reúne moço, velinho e criança
Clareia luaclareia
clareiaa aldeia de Seu Pena Branca
Clareia luaclareia
quem crê nesse Caboclo não perde a confiança
Okê Caboclo
Okê Caboclo
seus filhosquerem lheagradecer
Okê Caboclo
Senhor da mata virgem
venha sempre me valer$c57fa9d38a163040eeb876cf66fd29b10$, NULL, now()),
('4635a8cb-6ea2-eeba-7e4f-890b5e43bf48', '68be09dc-e73d-ff41-1589-220baaea442d', $t4635a8cb6ea2eeba7e4f890b5e43bf48$Caboclo Bugre - Oxalá quem deu a ordem$t4635a8cb6ea2eeba7e4f890b5e43bf48$, $c4635a8cb6ea2eeba7e4f890b5e43bf48$Oxalá quem deu a ordem
Omulú foiquem lheescolheu
Oxalá quem deu a ordem
Omulú foiquem lheescolheu
Pai Oxóssi brada na mata
Caboclo Bugre apareceu
Pai Oxóssi brada na mata
Caboclo Bugre apareceu
Com a sua coral no pescoço
Caboclo Bugre guerreiro
Com a sua coral no pescoço
Caboclo Bugre guerreiro
Ele éfilhoda Jurema
riscouseu ponto no terreiro
Ele éfilhoda Jurema
riscouseu ponto no terreiro
écomedor de carne crua
eo seu ponto ele vem firmar
écomedor de carne crua
eo seu ponto ele vem firmar
saravá Caboclo Bugre
éo rei do Panaiá
saravá Caboclo Bugre
éo rei do Panaiá$c4635a8cb6ea2eeba7e4f890b5e43bf48$, NULL, now()),
('554f34dc-c509-adc8-0ef9-97c796230479', '68be09dc-e73d-ff41-1589-220baaea442d', $t554f34dcc509adc80ef997c796230479$Caboclo - Okê Caboclo, chama seu Cobra Coral$t554f34dcc509adc80ef997c796230479$, $c554f34dcc509adc80ef997c796230479$Okê Caboclo
chama Seu Cobra Coral
Okê Caboclo
chama Seu Cobra Coral
abre os trabalhos
na mata virgem
chama Seu Cobra Coral
abre os trabalhos
na mata virgem
chama Seu Cobra Coral$c554f34dcc509adc80ef997c796230479$, NULL, now()),
('2ce25b91-7658-f96d-2cd5-b0732b54ba57', '68be09dc-e73d-ff41-1589-220baaea442d', $t2ce25b917658f96d2cd5b0732b54ba57$Caboclos - Lei Severa nas matas da Jurema$t2ce25b917658f96d2cd5b0732b54ba57$, $c2ce25b917658f96d2cd5b0732b54ba57$Oh lá nas matas
láda Jurema
Oh lá nas matas
láda Jurema
éuma leisevera
éuma leisem pena
éuma leisevera
éuma leisem pena$c2ce25b917658f96d2cd5b0732b54ba57$, NULL, now()),
('ae67d1cf-b6e2-a580-8040-e0b4df825d4e', '68be09dc-e73d-ff41-1589-220baaea442d', $tae67d1cfb6e2a5808040e0b4df825d4e$Caboclos - Subida -Já vai, já vai, meu Caboclo já vai$tae67d1cfb6e2a5808040e0b4df825d4e$, $cae67d1cfb6e2a5808040e0b4df825d4e$Já vai,jávai
meu Caboclo já vai
jávai,jávai
vaina hora de Deus
jávai,jávai
meu Caboclo já vai
jávai,jávai
vaina hora de Deus
Auê auá
aJurema mandou lhe chamar
Auê auá
aJurema mandou lhe chamar$cae67d1cfb6e2a5808040e0b4df825d4e$, NULL, now()),
('1aefcedf-4eb7-75e1-eedb-b04e37472f09', '68be09dc-e73d-ff41-1589-220baaea442d', $t1aefcedf4eb775e1eedbb04e37472f09$Caboclos - Sucurí jibóia, como vêm beirando o mar$t1aefcedf4eb775e1eedbb04e37472f09$, $c1aefcedf4eb775e1eedbb04e37472f09$Sucurí jibóia
como vêm beirando o mar
Sucurí jibóia
como vêm beirando o mar
Olha como brogoiô
asua Cobra-coral
olhacomo brogoiô
asua Cobra-coral
Segura essa cobra
não deixa ela fugir
onome dessa cobra
écobra Sucurí
Segura essa cobra
não deixa elafugir
onome dessa cobra
écobra Sucurí$c1aefcedf4eb775e1eedbb04e37472f09$, NULL, now()),
('1db6d073-b693-7bd8-3b7d-062e6ccbf429', '68be09dc-e73d-ff41-1589-220baaea442d', $t1db6d073b6937bd83b7d062e6ccbf429$Caboclos - Tambor, chama quem mora longe$t1db6d073b6937bd83b7d062e6ccbf429$, $c1db6d073b6937bd83b7d062e6ccbf429$Tambor tambor
Chama quem mora longe
Tambor tambor
Chama quem mora longe
A giraé de Caboclo
foiOxalá quem mandou
Segura o couro tambor
que elevai chegar$c1db6d073b6937bd83b7d062e6ccbf429$, NULL, now()),
('14b5f327-3750-ecaa-4523-c1d755dc3535', '68be09dc-e73d-ff41-1589-220baaea442d', $t14b5f3273750ecaa4523c1d755dc3535$Caboclos - Assovia assovia, ele é assoviou$t14b5f3273750ecaa4523c1d755dc3535$, $c14b5f3273750ecaa4523c1d755dc3535$Assovia assovia
eleé assoviou
Assovia assovia
eleé assoviou
Cadê o Caboclo da Mata
que ainda não chegou
Cadê o Caboclo da Mata
que ainda não chegou$c14b5f3273750ecaa4523c1d755dc3535$, NULL, now()),
('2f8b05a1-e6b0-18b4-a906-ff820ea5df2b', '68be09dc-e73d-ff41-1589-220baaea442d', $t2f8b05a1e6b018b4a906ff820ea5df2b$Caboclos - Pena Branca -Ele é a luz$t2f8b05a1e6b018b4a906ff820ea5df2b$, $c2f8b05a1e6b018b4a906ff820ea5df2b$Caboclo Pena Branca, eleé a luz,ele é oguia
Eleé Oxóssi filhoda Virgem Maria
Eleé a luz que ilumina no escuro
eno terreiroos seus filhosestão seguro$c2f8b05a1e6b018b4a906ff820ea5df2b$, NULL, now()),
('83da1f93-23ef-086d-b510-93626b8f10bc', '68be09dc-e73d-ff41-1589-220baaea442d', $t83da1f9323ef086db51093626b8f10bc$Caboclos - Cabocla Iaraçu$t83da1f9323ef086db51093626b8f10bc$, $c83da1f9323ef086db51093626b8f10bc$Cabocla tu és lindacomo o luar
Caboclinha, tués filhade guiné
na mão direitatrásuma arara
na outrajararacuçu
seu nome é Iaraçu$c83da1f9323ef086db51093626b8f10bc$, NULL, now()),
('19bd8645-cc7c-1b63-028a-dcae281af246', '68be09dc-e73d-ff41-1589-220baaea442d', $t19bd8645cc7c1b63028adcae281af246$Caboclos - Caboclo Flecha Dourada$t19bd8645cc7c1b63028adcae281af246$, $c19bd8645cc7c1b63028adcae281af246$Flecha Dourada Oxalá foiquem mandou
Flecha Dourada Oxalá foiquem mandou
Com a sua pemba branca trazendo paz e amor
Com a sua pemba branca trazendo paz e amor
Flecha Dourada no terreiroeleestá
Flecha Dourada no terreiroeleestá
Eleveio de Aruanda, eleveio trabalhar
Eleveio de Aruanda, eleveio trabalhar.$c19bd8645cc7c1b63028adcae281af246$, NULL, now()),
('4d69d841-5d4f-82c5-2a60-7e4309545978', '68be09dc-e73d-ff41-1589-220baaea442d', $t4d69d8415d4f82c52a607e4309545978$Caboclos - Ô Juremê Ô Jurema$t4d69d8415d4f82c52a607e4309545978$, $c4d69d8415d4f82c52a607e4309545978$Ô Juremê Ô Jurema
sua folhacaiu serena ô Jurema
dentro desse gongá
Ô Juremê Ô Juremá
sua folhacaiu serena ô Jurema
dentro desse gongá
Sua folha caiu serena ô Jurema
dentro desse gongá
Elaé Cabocla Jurema
aquie em qualquer lugar
Sua folha caiu serena ô Jurema
dentro desse gongá
Elaé Cabocla Jurema
aquie em qualquer lugar$c4d69d8415d4f82c52a607e4309545978$, NULL, now()),
('800c2161-e448-0773-f187-6aeccb6be6bf', '68be09dc-e73d-ff41-1589-220baaea442d', $t800c2161e4480773f1876aeccb6be6bf$Caboclo - Na mata perto de uma cachoeira$t800c2161e4480773f1876aeccb6be6bf$, $c800c2161e4480773f1876aeccb6be6bf$Na mata perto de uma cachoeira
eu olheipara um Caboclo
eele estava na pedreira
Estava com sua lança na mão
dando seu brado de guerra
paiXangô mandou trovão
Diziasalve os filhosde Oxalá
salve Oxóssi reidas matas
salve Ogum no Humaitá
No céu um arco-írisnasceu
eramamãe Iemanjá
Iansã e Aieieu
No céu um arco-írisnasceu
era mamãe Iemanjá
Iansã e Aieieu$c800c2161e4480773f1876aeccb6be6bf$, NULL, now()),
('b9b63d5b-3ac6-76d4-2db0-24d58d6de89d', '68be09dc-e73d-ff41-1589-220baaea442d', $tb9b63d5b3ac676d42db024d58d6de89d$Caboclo - Caboclo Flecheiro$tb9b63d5b3ac676d42db024d58d6de89d$, $cb9b63d5b3ac676d42db024d58d6de89d$Vocês "tão"vendo aquele meu Caboclo
está em cima daquele lajedo
olhando o tempo para não chover
pedindo a luapra sairmais cedo
Oquê, Caboclo
Oquê, Caboclo Flecheiro
E toda a tribodesse meu Caboclo
adora o canto de um rouxinol
de manhã cedo pede ao seu Flecheiro
caçar a ema ao romper do sol
Oquê, Caboclo
Oquê, Caboclo Flecheiro$cb9b63d5b3ac676d42db024d58d6de89d$, NULL, now()),
('0dbfa0b9-de3d-d7b8-772f-db2b490cee5e', '68be09dc-e73d-ff41-1589-220baaea442d', $t0dbfa0b9de3dd7b8772fdb2b490cee5e$Caboclos - Na mata virgem uma coral piou$t0dbfa0b9de3dd7b8772fdb2b490cee5e$, $c0dbfa0b9de3dd7b8772fdb2b490cee5e$Na mata virgem uma coral piou
eleatirou a sua flecha certeira
Na mata virgem uma coral piou
eleatirou a sua flecha certeira
eleatirou
eleatirou
eleatirou
atiraCaboclo lá nas matas da Jurema$c0dbfa0b9de3dd7b8772fdb2b490cee5e$, NULL, now()),
('16fd5421-0678-e094-ae1b-b98359c4f1e5', '68be09dc-e73d-ff41-1589-220baaea442d', $t16fd54210678e094ae1bb98359c4f1e5$Cabocla Jurema -Coroa de flores$t16fd54210678e094ae1bb98359c4f1e5$, $c16fd54210678e094ae1bb98359c4f1e5$O sol brilhoupra Jurema
osol brilhou sem parar
com seu bodoque de penas
essa linda morena
entrou na mata a caçar
O arco e flecha é a vida
dos grandes caçadores
que receberam de Oxossi
uma coroa de flores$c16fd54210678e094ae1bb98359c4f1e5$, NULL, now()),
('595cbeb0-1eb3-298a-654c-7385d9a0f684', '68be09dc-e73d-ff41-1589-220baaea442d', $t595cbeb01eb3298a654c7385d9a0f684$Caboclo - Japiaçu$t595cbeb01eb3298a654c7385d9a0f684$, $c595cbeb01eb3298a654c7385d9a0f684$Eu me perdi meu pai,eu me perdi
lána mata da Amazônia eu me perdi
Eu me perdi meu pai,eu me perdi
lána mata da Amazônia eu me perdi
Eu procurei Japiaçu e não achei
lána mata da Jurema eu encontrei
ao longe, muito longe
láestavam dois guerreiros a lutar
ouvio Seu Japiaçu
dando o brado da derrota de Ojaguá
Eu me perdi meu pai,eu me perdi
lána mata da Amazônia eu me perdi
Eu me perdi meu pai,eu me perdi
lána mata da Amazônia eu me perdi
Japiaçu, Japiaçu
onde tá que eu não ouço seu bradar?
será que ta lána maloca ou na grota?
onde se ouve o zuar do maracá
Eu me perdi meu pai,eu me perdi
lána mata da Amazônia eu me perdi
Eu me perdi meu pai,eu me perdi
lána mata da Amazônia eu me perdi$c595cbeb01eb3298a654c7385d9a0f684$, NULL, now()),
('359099dd-8ae3-3473-80bc-f377b9c78ebb', '68be09dc-e73d-ff41-1589-220baaea442d', $t359099dd8ae3347380bcf377b9c78ebb$Cabocla -Jurema caçadora$t359099dd8ae3347380bcf377b9c78ebb$, $c359099dd8ae3347380bcf377b9c78ebb$Eu vino altoda serra
Cabocla Jurema dando o seu brado de guerra
kiô,kiô
em toda mata oseu brado ecoou
Com o seu arco e sua flecha
ea sua lança de indaiá
Jurema dava o seu brado de guerra
anunciando que iacaçar
Sete luas se passaram quando
aJurema voltou
toda a caça que ela trazia
ao cacique entregou
eele tão alegre, cantou em seu louvor
ôôô Jurema
ôôôJurema linda caçadora
bela cabocla de pena$c359099dd8ae3347380bcf377b9c78ebb$, NULL, now()),
('bea6a209-9f66-5bcb-55b9-18721d418328', '68be09dc-e73d-ff41-1589-220baaea442d', $tbea6a2099f665bcb55b918721d418328$Caboclos - Seu Sete flechas$tbea6a2099f665bcb55b918721d418328$, $cbea6a2099f665bcb55b918721d418328$A mata estava serena
Iluminada pelo sol de Aruanda
Chegou seu Sete flechas
Para saravar na Umbanda
Trazendo seu bodoque na mão
O seu penacho, é reluzente
Ele vem cortardemandas
eajudar a nossa gente
Ele vem cortardemandas
eajudar a nossa gente
Kiô,kiô
Saravá seu Sete flechas
Kiô,kiô
Ele é orei da floresta.$cbea6a2099f665bcb55b918721d418328$, NULL, now()),
('d47d3847-a9d6-540d-9e21-ed788863241d', '68be09dc-e73d-ff41-1589-220baaea442d', $td47d3847a9d6540d9e21ed788863241d$Caboclos - Seu Orirê$td47d3847a9d6540d9e21ed788863241d$, $cd47d3847a9d6540d9e21ed788863241d$Meu pai é um Caboclo do mato
tem uma choupana lá no Juremá
eleusa saiote de penas
prepara suas flechas quando vaicaçar
Seu Orirê,seu Orirá
Seu Orirê,seu Orirá
Meu pai é um Caboclo girante
que vive girando lá no Juremá
elegira na sua cangira
chega no terreiro,saravá o endá
Seu Orirê,seu Orirá
Seu Orirê,seu Orirá$cd47d3847a9d6540d9e21ed788863241d$, NULL, now()),
('2ecbad19-0411-88fc-8419-f09cbf489598', '68be09dc-e73d-ff41-1589-220baaea442d', $t2ecbad19041188fc8419f09cbf489598$Ogum - Partiu pra guerra - São dois irmãos - Lanceiro de Oxalá$t2ecbad19041188fc8419f09cbf489598$, $c2ecbad19041188fc8419f09cbf489598$Quando Ogum partiu pra guerra
Iemanjá chorou
Quando Ogum voltou vencedor
Iemanjá cantou
//////////////////////////////////////////////////////
Ogum venceu a guerra
Ogum tocou clarim
e o exército todo
foicomandado por ele
São dois irmãos da madrugada
Seu Ogum iara,seu Ogum Matinata
//////////////////////////////////////////////////////
Lanceiro, lanceiro
Lanceiro de Oxalá
Bendito e louvado seja
a hora em que Ogum nasceu$c2ecbad19041188fc8419f09cbf489598$, NULL, now()),
('328a7150-1ace-d43a-fb6b-6d67c0a22a22', '68be09dc-e73d-ff41-1589-220baaea442d', $t328a71501aced43afb6b6d67c0a22a22$Caboclas - Jacira e Jussara$t328a71501aced43afb6b6d67c0a22a22$, $c328a71501aced43afb6b6d67c0a22a22$São duas Caboclas tão lindas
que tem lá das matas do Juremá
Salve a Cabocla Jacira
Cabocla Jussara, filhasde Iemanjá$c328a71501aced43afb6b6d67c0a22a22$, NULL, now()),
('3534b2f4-7b5f-4adb-0518-20cb81af60e2', '68be09dc-e73d-ff41-1589-220baaea442d', $t3534b2f47b5f4adb051820cb81af60e2$Caboclos - Cobra Coral - Araúna - Sete Estrelas$t3534b2f47b5f4adb051820cb81af60e2$, $c3534b2f47b5f4adb051820cb81af60e2$Na mata, perto de uma cachoeira
encontrei Cobra Coral, ele tava na pedreira
trazia,seu arco e flecha na mão
dava o seu brado de guerra
a Xangô Deus do trovão
faziaoração a Oxalá
a Oxóssi reidas matas
e Ogum no Humaitá
no céu, um arco írisnasceu
era Nanã, Iemanjá, Iansã e Aieieu.
////////////////////////////////////////////////
Seu capacete é carijó
Sua flecha é dourada
Mas ele é o Caboclo Araúna
ele é filhoda Oxum e mora nas águas sagradas
//////////////////////////////////////////////////
Luar, luar
segue o seu destino luar
segue o seu destino luar
Onde há muita alegria
sete estrelas mora lá
Por de trazdaquela serra
onde canta o sabiá
Onde há muita alegria
Sete Estrelas mora lá.$c3534b2f47b5f4adb051820cb81af60e2$, NULL, now()),
('ae7d1616-13d3-cd9d-eca4-56cc2da45d0d', '68be09dc-e73d-ff41-1589-220baaea442d', $tae7d161613d3cd9deca456cc2da45d0d$Caboclos - Embalaça a folha da Jurema$tae7d161613d3cd9deca456cc2da45d0d$, $cae7d161613d3cd9deca456cc2da45d0d$embalança, embalança
embalança a folha da Jurema
embalança, embalança
embalança o pé de Guararema
o vento embalança o cipó lána mata
o vento embalança a folha de guiné
o vento embalança o pau da Jurema
o vento embalança a barca de Noé
embalança, embalança
embalança a folha da Jurema
embalança, embalança
embalança o pé de Guararema
o vento embalança as nuves no céu
o vento embalança a fumaça no ar
o vento embalança o navio ao léu
o vento embalança as ondas do mar$cae7d161613d3cd9deca456cc2da45d0d$, NULL, now()),
('79ad973e-e1d7-117b-119a-acfdf14ae31f', '68be09dc-e73d-ff41-1589-220baaea442d', $t79ad973ee1d7117b119aacfdf14ae31f$Caboclo Sete Flechas - Rei da floresta$t79ad973ee1d7117b119aacfdf14ae31f$, $c79ad973ee1d7117b119aacfdf14ae31f$Foi,numa tarde serena
lána mata da Jurema
eu vium caboclo bradar
Quiô
quiô,quiô, quiô que era
sua mata está em festa
saravá seu Sete Flechas
que ele é o reida floresta$c79ad973ee1d7117b119aacfdf14ae31f$, NULL, now()),
('481ed26d-b20f-24c1-1703-ecf295e3711a', '68be09dc-e73d-ff41-1589-220baaea442d', $t481ed26db20f24c11703ecf295e3711a$Caboclos - Louvação aos caboclos$t481ed26db20f24c11703ecf295e3711a$, $c481ed26db20f24c11703ecf295e3711a$ôsalve o sol,salve a estrela guia
saravá seu Ventania
Umbanda vamos saudar
ôsalve a folhada macaia na Jurema
salve cabocla de pena
filhade Tupinambá
aluz brilha iluminando o mundo inteiro
clareando o terreiro
para caboclo passar
kiôkiô
Okê okiô kiá
salve a folhada macaia
Umbanda vamos saudar (2X)
firmou seu ponto
na raizda urucaia
Jupira e cabocla iara
vieram pra confirmar
bendito seja o nome deste caboclo
saravá Arranca toco
saravá pai Oxalá
caboclo Arruda que chegou neste terreiro
juntocom seu Flecheiro
Umbanda vamos saudar
seus filhosvibram com o brado caboclo
saravá Arranca toco, Arruda e Tupinambá$c481ed26db20f24c11703ecf295e3711a$, NULL, now()),
('fa6e3d53-1500-8944-5f58-004ecc101c97', '68be09dc-e73d-ff41-1589-220baaea442d', $tfa6e3d53150089445f58004ecc101c97$Caboclos - Ventania - Urucutum - Jaguar$tfa6e3d53150089445f58004ecc101c97$, $cfa6e3d53150089445f58004ecc101c97$A lua clareou, brilhoua estrela guia
com licença de Oxalá vai chegar seu Ventania
eleé caboclo, é flecheiroatirador
na mata virgem, na padreira de xangô
sua coroa tem a luz de Oxalá
ena Umbanda ele vem trabalhar
////////
A sua flecha
quem lhe deu foiOxóssi
asua lança
quem lhe deu foiOgum
ea estrela que brilha
em seu capacete
veio do manto
de mamãe Oxum
salve pai Ogum
salve pai Ogum
quem vai chegar de Aruanda
éo Caboclo Urucutum
//////
A sua flecha, tem uma bandeira
ea estrela, que lheguia no mar
vem cortando onda, cortando mironga
elevem de Aruanda, na Umbanda
no canto da Sereia, mamãe Iemanjá é oCaboclo Jaguar$cfa6e3d53150089445f58004ecc101c97$, NULL, now()),
('06994a1a-7e60-d29e-d87c-3b2fb510a93c', '68be09dc-e73d-ff41-1589-220baaea442d', $t06994a1a7e60d29ed87c3b2fb510a93c$Caboclos - Ele é Tupinambá$t06994a1a7e60d29ed87c3b2fb510a93c$, $c06994a1a7e60d29ed87c3b2fb510a93c$Quando o meu tambor rufar
eu sintoa presença de Tupinambá
Deixa a noite cair
veja,sua estrelabrilhar
amacaia está em festa
pra ver Tupinambá chegar
Ele é caboclo
Ele vem caçar
Ele é guerreiro
Ele é Tupinambá$c06994a1a7e60d29ed87c3b2fb510a93c$, NULL, now()),
('0c871667-0b61-64d9-8966-33b1f53fc8d9', '68be09dc-e73d-ff41-1589-220baaea442d', $t0c8716670b6164d9896633b1f53fc8d9$Cabocla Jupira - Uma flor rosa$t0c8716670b6164d9896633b1f53fc8d9$, $c0c8716670b6164d9896633b1f53fc8d9$Passarinho cantou
lána mata da Jurema
nasceu uma flor
pra uma linda Cabocla de Pena
Jupira,é tão formosa
nasceu na mata pra você
uma florrosa$c0c8716670b6164d9896633b1f53fc8d9$, NULL, now()),
('7e080bdf-b69b-6d2f-38ca-21f2e19f9e56', '68be09dc-e73d-ff41-1589-220baaea442d', $t7e080bdfb69b6d2f38ca21f2e19f9e56$Caboclo das Sete Encruzilhadas - Umbanda Nação Querida$t7e080bdfb69b6d2f38ca21f2e19f9e56$, $c7e080bdfb69b6d2f38ca21f2e19f9e56$Um índiocaboclo guerreiro
um jesuíta que Zambi enviou
com sua força e sabedoria
abraçou aUmbanda com o seu amor (2x)
No dia 15 de novembro
Zéliode Moraes teve a incorporação
foiem 1908 no bairro de Neves, uma revolução
Houve muita discórdia
no centro de mesa com a revelação
quando ele disse,eu vim cumprir a missão
vou fincara bandeira da nossa nação
Vitóriameu pai,vitória
de um índioguerreiro um desbravador
Caboclo das Sete Encruzilhadas
que plantou a semente que se alastrou
Umbanda é amor, fraternidade
Umbanda é bondade é determinação
élutar em prol da caridade para os nossos guias dar-nos evolução
São glórias meu pai,são glórias
São glórias para homenagear
Caboclo das Sete Encruzilhadas
neste solo sagrado de Pai Oxalá$c7e080bdfb69b6d2f38ca21f2e19f9e56$, NULL, now()),
('bdab0679-48a6-5dac-f7c8-5c04957252c6', '68be09dc-e73d-ff41-1589-220baaea442d', $tbdab067948a65dacf7c85c04957252c6$Caboclas - Jurema tem pena de mim$tbdab067948a65dacf7c85c04957252c6$, $cbdab067948a65dacf7c85c04957252c6$Jandira trásno cabelo uma rosa
Iara,no peito um jasmim
Jussara é uma linda cabocla de pena
Jurema tem pena de mim
ôJurema, ô Jurema
Jurema tem pena de mim$cbdab067948a65dacf7c85c04957252c6$, NULL, now()),
('41c5715e-299c-2190-020e-36870964a398', '68be09dc-e73d-ff41-1589-220baaea442d', $t41c5715e299c2190020e36870964a398$Caboclo Cobra coral - Obediência sem igual$t41c5715e299c2190020e36870964a398$, $c41c5715e299c2190020e36870964a398$As folhas secas
se alvoroção
fazendo seu ritual
É que as cobras jáconhecem
osom do assovio do seu Cobra Coral
Elas vêem por baixo das folhas
deslizando nelas sem parar
obediência sem igual
para atender ao seu Cobra Coral$c41c5715e299c2190020e36870964a398$, NULL, now()),
('7da47cec-a19e-6c08-3f0e-363ec6a17305', '68be09dc-e73d-ff41-1589-220baaea442d', $t7da47ceca19e6c083f0e363ec6a17305$Cabocla Iara - Deusa das águas$t7da47ceca19e6c083f0e363ec6a17305$, $c7da47ceca19e6c083f0e363ec6a17305$Cabocla Iara
venha na Umbanda trabalhar
trazendo seu diadema
das águas sagradas do mar
elafoicoroada,
com a estrela de Iemanjá
Iaraôô, Iara
Iaraé cabocla de pena
Iara,elavem da Jurema
Iaraé a deusa das águas
asua leiésuprema$c7da47ceca19e6c083f0e363ec6a17305$, NULL, now()),
('9511b479-ccf9-d311-8a76-9fbb4416e75a', '68be09dc-e73d-ff41-1589-220baaea442d', $t9511b479ccf9d3118a769fbb4416e75a$Caboclos - Rompe Mato e Cobra Coral - Dois nomes$t9511b479ccf9d3118a769fbb4416e75a$, $c9511b479ccf9d3118a769fbb4416e75a$No centro da mata eu vi
doisnomes gravados num toco de pau
de um lado, seu Rompe Mato
do outroseu Cobra Coral
No centro da mata virgem eu vi
osdois caboclos falavam
alíngua Tupi-guarani$c9511b479ccf9d3118a769fbb4416e75a$, NULL, now()),
('cae03c8b-867d-49ed-8a7c-df957656e9d5', '68be09dc-e73d-ff41-1589-220baaea442d', $tcae03c8b867d49ed8a7cdf957656e9d5$Caboclos - Jurema Caçadora$tcae03c8b867d49ed8a7cdf957656e9d5$, $ccae03c8b867d49ed8a7cdf957656e9d5$Eu vino altoda serra
Cabocla Jurema dando o seu brado de guerra
kiô.kiô
em toda mata o seu brado ecoou
com o seu arco e sua flecha
ea sua lança de indaiá
Jurema dava o seu brado de guerra
anunciando que iacaçar
seteluas se passaram quando a Jurema voltou
todaa caça que ela traziaao cacique entregou
eele tão alegre cantou em seu louvor
ôôô Jurema ôôô
Jurema lindacaçadora, bela cabocla de pena$ccae03c8b867d49ed8a7cdf957656e9d5$, NULL, now()),
('1e0a16d5-d11b-676d-4e31-3e5dda4e0078', '68be09dc-e73d-ff41-1589-220baaea442d', $t1e0a16d5d11b676d4e313e5dda4e0078$Caboclos - Caboclo vem trabalhar$t1e0a16d5d11b676d4e313e5dda4e0078$, $c1e0a16d5d11b676d4e313e5dda4e0078$Enquanto houver folhas nas matas
enquanto houver água no mar
Enquanto existiraUmbanda
Caboclo vem trabalhar
pega seu bodoque, pega seu cocar
evem para o terreirona fé de Oxalá$c1e0a16d5d11b676d4e313e5dda4e0078$, NULL, now()),
('98a3337a-2783-aeb1-d646-f522ec5ba889', '68be09dc-e73d-ff41-1589-220baaea442d', $t98a3337a2783aeb1d646f522ec5ba889$Caboclos - Rompe mato Caboclo cismado$t98a3337a2783aeb1d646f522ec5ba889$, $c98a3337a2783aeb1d646f522ec5ba889$Elevem de longe
da cidade da Jurema
seu Rompe Mato é um caboclo cismado
com sua flechana mão
eseu bodoque do lado$c98a3337a2783aeb1d646f522ec5ba889$, NULL, now()),
('9bd5dc18-9e1d-662c-2772-3e8b2f538a6b', '68be09dc-e73d-ff41-1589-220baaea442d', $t9bd5dc189e1d662c27723e8b2f538a6b$Caboclos - Vestimenta de Caboclo$t9bd5dc189e1d662c27723e8b2f538a6b$, $c9bd5dc189e1d662c27723e8b2f538a6b$Vestimenta de Caboclo
ésamambaia, é samambaia, é samambaia [2x]
saiaCaboclo
não se atrapalha
saiado meio
da samambia$c9bd5dc189e1d662c27723e8b2f538a6b$, NULL, now()),
('25293084-dd2a-08c0-52d5-3896174d5786', '68be09dc-e73d-ff41-1589-220baaea442d', $t25293084dd2a08c052d53896174d5786$Caboclos - Caboclo Roxo$t25293084dd2a08c052d53896174d5786$, $c25293084dd2a08c052d53896174d5786$Caboclo roxo
da cormorena
eleé Oxossi
caçador lá da Jurema [2x]
elejurou
etornou a jurar
quando ouviros concelhos
que a Jurema tem pra dar [2x]$c25293084dd2a08c052d53896174d5786$, NULL, now()),
('ca75f3e5-d778-6fcf-98de-7863066300ac', '68be09dc-e73d-ff41-1589-220baaea442d', $tca75f3e5d7786fcf98de7863066300ac$Caboclos - Cabocla Jurema$tca75f3e5d7786fcf98de7863066300ac$, $cca75f3e5d7786fcf98de7863066300ac$no meio da mata virgem
uma lindaCabocla eu vi[2x]
com seu saiote
cheio de pena
elaé Jurema
filhadeTupí$cca75f3e5d7786fcf98de7863066300ac$, NULL, now()),
('e4d9c795-a497-5d4d-5258-161c45507fb1', '68be09dc-e73d-ff41-1589-220baaea442d', $te4d9c795a4975d4d5258161c45507fb1$Caboclo - Oxalá mandou buscar$te4d9c795a4975d4d5258161c45507fb1$, $ce4d9c795a4975d4d5258161c45507fb1$Oxalá mandou
elemandou buscar
os Caboclos da Jurema
láno Jurema
PaiOxalá
érei do mundo inteiro
jádeu ordens pra Jurema
chamar seus capangueiros [2x]$ce4d9c795a4975d4d5258161c45507fb1$, NULL, now()),
('44c5b831-463c-1b5b-eb9a-46c5a8cd42e8', '68be09dc-e73d-ff41-1589-220baaea442d', $t44c5b831463c1b5beb9a46c5a8cd42e8$Caboclo - Cabocla Iara$t44c5b831463c1b5beb9a46c5a8cd42e8$, $c44c5b831463c1b5beb9a46c5a8cd42e8$eu viuma morena sentada na beira da praia
elapeteava seus cabelos ao luar[2x]
mas que Cabocla é essa
éa Cabocla Iara
eladesceu o riotodo
atéchegar ao mar$c44c5b831463c1b5beb9a46c5a8cd42e8$, NULL, now()),
('63bff973-e350-87c7-73f3-0dd7d3b80ee0', '68be09dc-e73d-ff41-1589-220baaea442d', $t63bff973e35087c773f30dd7d3b80ee0$Subida de Caboclo -Zoa atabaque$t63bff973e35087c773f30dd7d3b80ee0$, $c63bff973e35087c773f30dd7d3b80ee0$zoa atabaque zoa
todos os caboclos vão embora[2x]
eledisse adeus, atélogo e até já
se precisarem dele é só mandar chamar [2x]$c63bff973e35087c773f30dd7d3b80ee0$, NULL, now()),
('3f5b568c-c756-4937-7482-9c0188cc11bd', '68be09dc-e73d-ff41-1589-220baaea442d', $t3f5b568cc756493774829c0188cc11bd$Caboclos - 7 Estrelas$t3f5b568cc756493774829c0188cc11bd$, $c3f5b568cc756493774829c0188cc11bd$Lá no céu tem uma estrela a brilhar
enas matas um caboclo a trabalhar [2x]
vem de aruanda
vem de aruanda
éSete Estrelas
eleveio saravar [2x]
tem capacete de pena
tem flecha e tem bodoque
Sete estrelas a brilhar
para as matas clarear [2x]$c3f5b568cc756493774829c0188cc11bd$, NULL, now()),
('a0d35415-8c34-b7a3-7b68-3f43e4aac7d3', '68be09dc-e73d-ff41-1589-220baaea442d', $ta0d354158c34b7a37b683f43e4aac7d3$Caboclos - Ele é caboclo da banda de lá$ta0d354158c34b7a37b683f43e4aac7d3$, $ca0d354158c34b7a37b683f43e4aac7d3$eleé caboclo da banda de lá
eleé caboclo da banda de lá
quando vê a cobra corre pra matar
quando vê a cobra corre pra matar
eleatirou a sua flecha mas errou
eleatirou a sua flecha mas errou
sentou-se na areiae poise achorar
sentou-se na areiae poise achorar
quando vê a cobra corre pra matar
quando vê a cobra corre pra matar$ca0d354158c34b7a37b683f43e4aac7d3$, NULL, now()),
('d7d7569c-196a-e353-6542-33e069ca6365', '68be09dc-e73d-ff41-1589-220baaea442d', $td7d7569c196ae353654233e069ca6365$Caboclos - O seu saiote é branco (Pena Branca)$td7d7569c196ae353654233e069ca6365$, $cd7d7569c196ae353654233e069ca6365$oseu saiote é branco
éda cor do dia [2x]
seu capacete é
éfeitode guias [2x]$cd7d7569c196ae353654233e069ca6365$, NULL, now()),
('9a8137d3-a898-1e00-00d6-f48d9593da3d', '68be09dc-e73d-ff41-1589-220baaea442d', $t9a8137d3a8981e0000d6f48d9593da3d$Cabocla Jurema - deixa a coral passar$t9a8137d3a8981e0000d6f48d9593da3d$, $c9a8137d3a8981e0000d6f48d9593da3d$Salve a Jurema, ela rainha
Ela éfilhade Tupinambá
Salve a Jurema, ela rainha
Ela éfilhade Tupinambá
Tamanduá, tamanduá, tamanduá
deixa a coralpassar
Saravá Dona Jurema
que ela chefe de congá
Saravá Dona Jurema
que ela chefe de congá$c9a8137d3a8981e0000d6f48d9593da3d$, NULL, now()),
('64272685-270a-85a2-bc1a-d222d80a6171', '68be09dc-e73d-ff41-1589-220baaea442d', $t64272685270a85a2bc1ad222d80a6171$Subida de Caboclo - Adeus coqueiral$t64272685270a85a2bc1ad222d80a6171$, $c64272685270a85a2bc1ad222d80a6171$Adeus coqueiral,adeus coqueiral
Adeus coqueiral,adeus coqueiral
Os filhoschoram
quando meus caboclos vão embora
Os filhoschoram
quando meus caboclos vão embora
Sua banda lhe chama
éhora é hora
Sua banda lhe chama
éhora é hora.$c64272685270a85a2bc1ad222d80a6171$, NULL, now()),
('6fdf11a4-5fb7-02c5-cd6f-f40009219834', '30923a92-0f1f-c859-b221-6f1ecffe0a6b', $t6fdf11a45fb702c5cd6ff40009219834$Egunitá - Dona do Fogo$t6fdf11a45fb702c5cd6ff40009219834$, $c6fdf11a45fb702c5cd6ff40009219834$Dona do fogo descarrega o meu congá
Dona do fogo descarrega o meu congá
Purificaesse terreiropro seus filhostrabalhar
Purificaesse terreiropro seus filhostrabalhar
Vem de Aruanda mãe guerreira Egunitá
Vem de Aruanda mãe guerreira Egunitá
Ilumina nossa banda vem na Umbanda trabalhar
Ilumina nossa banda vem na Umbanda trabalhar$c6fdf11a45fb702c5cd6ff40009219834$, NULL, now()),
('e4485a82-2a40-e6b5-99e6-b9fad12f1be1', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $te4485a822a40e6b599e6b9fad12f1be1$Iansã - Ventou, relampejou e trovejou / Senhora da paixão, venha nos ajudar..$te4485a822a40e6b599e6b9fad12f1be1$, $ce4485a822a40e6b599e6b9fad12f1be1$Ventou, relampejou e trovejou
É Iansã que vem chegando
Trazendo todo o seu amor
Ventou, relampejou e trovejou
É Iansã que vem chegando
Trazendo todo o seu amor
É Iansã, Oyá eparrei
Minha mãe guerreira, Oyá eparrei
Senhora dos ventos e das tempestades
Leva para sempre a dor e a maldade
É Iansã, Oyá eparrei
Minha mãe guerreira, Oyá eparrei
Balança com o vento e traz movimento
Nos dê equilíbriopra fazer o bem
Senhora da paixão
Venha nos ajudar
Rainha de oyó, no trono de ayrá
Guerreia
Guerreia
Ouço teu chamado
Dama ao teu lado
Fogueira ao luar,dança das yabás
Guerreia
Guerreia
Seu fogo abre o chão, és lava de vulcão
Traz purificação ao som do seu trovão
Guerreia., guerreia
Guerreia$ce4485a822a40e6b599e6b9fad12f1be1$, NULL, now()),
('6fc3890a-32b9-46ea-06f5-4d61eb668bc5', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t6fc3890a32b946ea06f54d61eb668bc5$É Oyá! Eparrey Iansã!$t6fc3890a32b946ea06f54d61eb668bc5$, $c6fc3890a32b946ea06f54d61eb668bc5$(2x)O tempo mudou... Eu senti a presença
(2x)É Oyá! Eparrey Iansã!
(2x)Força que move, transforma, renova pra um novo amanhã
Move riose mares, faz a mata dançar
Quem um dia rasteja, no outro pode voar
Arrebata a terra,leva o que tem que levar
(2x)Ah, Eparrey Iansã! Bárbara Santa é Oyá!
Iansã - A minha aldeia balançou$c6fc3890a32b946ea06f54d61eb668bc5$, NULL, now()),
('88c36637-0555-f89b-f70c-50853dff7166', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t88c366370555f89bf70c50853dff7166$Página1de 24$t88c366370555f89bf70c50853dff7166$, $c88c366370555f89bf70c50853dff7166$A minha aldeia balançou
Sacudiu o meu conga
Ventania anunciou
É iansã quem vai chegar
[2x]
Ela é filhado dendê
Ela é matamba, ela é Oyá
Coroada com seu adê
Baila nos ventos
Eparrey, Oyá
[2x]
Traz o bem na ventania
Leva o mal no temporal
Omolu lhe consagrou
Santa guerreira do bambuzal
[2x]$c88c366370555f89bf70c50853dff7166$, NULL, now()),
('b710bb0f-850b-d2e1-a3c0-1a15435a500f', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tb710bb0f850bd2e1a3c01a15435a500f$Iansã - Dona do meu jacutá$tb710bb0f850bd2e1a3c01a15435a500f$, $cb710bb0f850bd2e1a3c01a15435a500f$Eparrey, eparrey
Bela Oyá, bela Oyá (2x)
é raioé temporal
é luzna escuridão
é vento no bambuzal
é amor no coração...
elaé minha orixáde fé
elaé quem me carrega de axé
elae dona do meu caminhar...
elaé fogo é de arrepiar
traza espada para guerrear
elafaz a gira vibrar...
dona do meu jacutá
a tisempre vou louvar
Oyá vim te agradecer
por tisempre vou cantar...
Eparrey, eparrey
Bela Oyá, bela Oyá (2x)$cb710bb0f850bd2e1a3c01a15435a500f$, NULL, now()),
('078f61b8-ea7b-296e-a3f3-a4a65ab7fc55', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t078f61b8ea7b296ea3f3a4a65ab7fc55$Iansã - Saravá deusa dos ventos$t078f61b8ea7b296ea3f3a4a65ab7fc55$, $c078f61b8ea7b296ea3f3a4a65ab7fc55$É saravá, é saravá
Deusa dos ventos
Eparrey Oyá... (2x)
Iansã bela e guerreira
Protege meu caminhar
Sua espada luz clareia
Ela é santa é Orixá...
Deusa do fogo
Bem todo o mau retirar
E que o brilhodos seus olhos
Venha me purificar...
É saravá, é saravá
Deusa dos ventos
Eparrey Oyá... (2x)$c078f61b8ea7b296ea3f3a4a65ab7fc55$, NULL, now()),
('d37a8c37-749d-cda7-efe4-c86a1205ead3', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $td37a8c37749dcda7efe4c86a1205ead3$Iansã - Deusa do fogo$td37a8c37749dcda7efe4c86a1205ead3$, $cd37a8c37749dcda7efe4c86a1205ead3$Relampejou lá no céu deixa clarear
Vento soprou na palmeira eh a!!
Salve a Deusa do fogo oyá
É Iansã que chegou deixa ela girar (2x)...
Ó guerreira rainha desse jacutá
Seu encanto me fascina
Você é quem me fazsonhar...
É vento que sopra no meu coração
Energia que me faz vibrar de emoção...
É fogo que aquece meu anoitecer
É luz que me guia, é meu bem querer
Com sua espada eu venço a batalha
Minha féem você não falha
Eparrey minha mãe vem me proteger
Relampejou lá o céu deixa clarear
Vento soprou na palmeira eh a!!!
Salve a Deusa do fogo oyá
É Iansã que chegou deixa ela girar (2x)...$cd37a8c37749dcda7efe4c86a1205ead3$, NULL, now()),
('58622012-888c-dd84-69d9-308e941f7deb', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t58622012888cdd8469d9308e941f7deb$Iansã - Bela Oyá$t58622012888cdd8469d9308e941f7deb$, $c58622012888cdd8469d9308e941f7deb$E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã é o meu Orixá - 2x
Quando Iansã chegou
Saravou Yalorixá
O Ogã louvou a sua coroa
Eparrey, bela Oyá
Ela é moça bonita
Moça rica ela é
Conhecida dentro do santo
Ela é Iansã de Balé
E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã é o meu Orixá -2x$c58622012888cdd8469d9308e941f7deb$, NULL, now()),
('b4645f8f-f892-f046-c34b-e14c901063ee', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tb4645f8ff892f046c34be14c901063ee$Iansã - O tempo virou$tb4645f8ff892f046c34be14c901063ee$, $cb4645f8ff892f046c34be14c901063ee$Raios do sol a brilhar
a passarada revoar
Na luz do amanhecer
Mãe Iansã vai chegar
Quem nunca viu venha ver
Glória e tanto poder
Uma beleza sem fim
Ela é tudo pra mim
E o tempo virou
quando ela aqui chegou
Lá no céu relampeou
todo mau ela levou$cb4645f8ff892f046c34be14c901063ee$, NULL, now()),
('277a17be-2241-c80a-ead2-036981e7b835', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t277a17be2241c80aead2036981e7b835$Ponto de Iansã - Guerreira$t277a17be2241c80aead2036981e7b835$, $c277a17be2241c80aead2036981e7b835$Guerreira, tens o bailarde um beija-flor
Guerreira, o seu bailar me encantou
Guerreira
Guerreira, tens o bailarde um beija-flor
Guerreira, o seu bailar me encantou
Senhora dos ventos,
Senhora do balé,
Eparrêi ó bela Oyá,
Nessa deusa eu tenho fé
Sua força vem do vento,
A sua beleza irradia,
É força da natureza,
É a força que me guia
Guerreira
Guerreira, tens o bailarde um beija-flor
Guerreira, o seu bailar me encantou
Guerreira
Guerreira, tens o bailarde um beija-flor
Guerreira, o seu bailar me encantou
Essa deusa tem um rei
Que em seu reino governou
Dividindo fortes raios esse reié Pai Xangô
Com poder da ventania
Toda palha ela soprou
No xirê dos Orixás
Omulu ela curou
Guerreira
Guerreira, tens o bailarde um beija-flor
Guerreira, o seu bailar me encantou
Guerreira
Guerreira, tens o bailarde um beija-flor
Guerreira, o seu bailar me encantou$c277a17be2241c80aead2036981e7b835$, NULL, now()),
('8b45d428-a209-5349-4159-9758e34379ce', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t8b45d428a209534941599758e34379ce$Iansã - Mãe de Camutuê$t8b45d428a209534941599758e34379ce$, $c8b45d428a209534941599758e34379ce$Mãe de camutuê
Olha sua banda
Riscando o céu, vem dos jardinsde Aruanda
Regada no dendê, de axé vou me banhar
Saúdo a forca dessa grande Orixá
Mãe de camutuê
Olha sua banda
Riscando o céu, vem dos jardinsde Aruanda
Regada no dendê, de axé vou me banhar
Saúdo a forca dessa grande Orixá
Oyá, eparrey, oyá
Deusa guerreira
Poderosa iabá
Oyá, eparrey, oyá
Deusa guerreira
Poderosa iabá
Iansã, mãe do céu rosado
Sua essência é firmamento
Que me fazabençoado
Ela é o fogo,energia, brisaé furacão
Mãe Iansã é quem nos dá adireção
Mãe de camutuê
Olha sua banda
Riscando o céu, vem dos jardinsde Aruanda
Regada no dendê, de axé vou me banhar
Saúdo a forca dessa grande Orixá
Mãe de camutuê
Olha sua banda
Riscando o céu, vem dos jardinsde Aruanda
Regada no dendê, de axé vou me banhar
Saúdo a forca dessa grande Orixá$c8b45d428a209534941599758e34379ce$, NULL, now()),
('9a6f57f4-22c8-402c-87b5-0ac11a325b73', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t9a6f57f422c8402c87b50ac11a325b73$Iansã - Ventou, mas que ventania$t9a6f57f422c8402c87b50ac11a325b73$, $c9a6f57f422c8402c87b50ac11a325b73$Ventou
mas que ventania
Iansã é nossa mãe
Iansã é nossa guia$c9a6f57f422c8402c87b50ac11a325b73$, NULL, now()),
('0db87597-1030-8035-7f0f-417c6e4c80ea', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t0db87597103080357f0f417c6e4c80ea$é Iansã, dona da ventania$t0db87597103080357f0f417c6e4c80ea$, $c0db87597103080357f0f417c6e4c80ea$Olha quem vem com o vento
Olha quem vem com a chuva
vem na mudança do tempo
pra essa banda segura
Olha quem vem com o vento
Olha quem vem com a chuva
vem na mudança do tempo
pra essa banda segura
éIansã, dona da ventania
grande guerreira
que vem nos salvar
traza coroa
de bela rainha
eo poder, de uma iabá$c0db87597103080357f0f417c6e4c80ea$, NULL, now()),
('7d16fa11-9feb-6be7-d2c5-280ec3f755f9', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t7d16fa119feb6be7d2c5280ec3f755f9$Iansã - Olha eu bela oyá$t7d16fa119feb6be7d2c5280ec3f755f9$, $c7d16fa119feb6be7d2c5280ec3f755f9$Olha eu
olha eu
olha eu bela oyá
Olha eu
olha eu
elaé Iansã, é meu orixá
Quando Iansã chegou,
saravou yalorixá
Ogã louvou sua coroa
eparreibela Oyá
Ela émoça bonita
moça ricaela é
conhecida dentro do santo
elaé Iansã do Balé
olha eu
Olha eu
olha eu
olha eu bela oyá
Olha eu
olha eu
elaé Iansã, é meu orixá$c7d16fa119feb6be7d2c5280ec3f755f9$, NULL, now()),
('8caa0040-b55a-9dd0-63a7-221884b49345', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t8caa0040b55a9dd063a7221884b49345$Iansã -Ventou, é Oyá /Brisa e Fogo$t8caa0040b55a9dd063a7221884b49345$, $c8caa0040b55a9dd063a7221884b49345$Ventou, relampejou e trovejou
É Iansã que vem chegando
Trazendo todo o seu amor
Ventou, relampejou e trovejou
É Iansã que vem chegando
Trazendo todo o seu amor
É Iansã, Oyá eparrei
Minha mãe guerreira, Oyá eparrei
Senhora dos ventos e das tempestades
Leva para sempre a dor e a maldade
É Iansã, Oyá eparrei
Minha mãe guerreira, Oyá eparrei
Balança com o vento e traz movimento
Nos dê equilíbriopra fazer o bem
Senhora da paixão
Venha nos ajudar
Rainha de oyó, no trono de ayrá
Guerreia...guerreia
Ouço teu chamado,
Dama ao teu lado
Fogueira ao luar,dança das yabás
Guerreia...guerreia
Seu fogo abre o chão, és lava de vulcão
Traz purificação ao som do seu trovão
Guerreia...guerreia… a a a
Guerreia a a a
A a a a
A a a a$c8caa0040b55a9dd063a7221884b49345$, NULL, now()),
('7d224c05-df9f-c0c0-cbd1-4ec4b307e555', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t7d224c05df9fc0c0cbd14ec4b307e555$Iansã - A Deusa dos Orixás$t7d224c05df9fc0c0cbd14ec4b307e555$, $c7d224c05df9fc0c0cbd14ec4b307e555$Iansã, cadê Ogum?
Foipro mar
Mas Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar
Mas Iansã, cadê Ogum?
Foipro mar
Iansã penteia os seus cabelos macios
Quando a luzda lua cheia clareia as águas do rio
Ogum sonhava com a filhade Nanã
E pensava que as estrelas eram os olhos de Iansã
Mas Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar
Na terra dos Orixás, o amor se dividia
Entre um deus que era de paz
E outro deus que combatia
Como a luta só termina quando existe um vencedor
Iansã virou rainha da coroa de Xangô
Mas Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar
Iansã, cadê Ogum?
Foipro mar$c7d224c05df9fc0c0cbd14ec4b307e555$, NULL, now()),
('a0016129-e88f-99f1-df85-96673f1ef8a6', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $ta0016129e88f99f1df8596673f1ef8a6$Iansã - Minha aldeia nos ventos de Iansã$ta0016129e88f99f1df8596673f1ef8a6$, $ca0016129e88f99f1df8596673f1ef8a6$Ela é filhado dendê
Ela é matamba, ela é Oyá
Coroada com seu adê
Bailanos ventos
Eparrey, Oyá!
Coroada com seu adê
Bailanos ventos
Eparrey, Oyá!
Minha aldeia balançou sacudiu o meu conga
Ventania anunciou
É iansã quem vaichegar
Ventania anunciou
É iansã quem vaichegar
Traz o bem na ventania
Leva o mal no temporal
Omolu lhe consagrou
Santa guerreira do bambuzal
Omolú lhe consagrou
Santa guerreira do bambuzal$ca0016129e88f99f1df8596673f1ef8a6$, NULL, now()),
('73fc1412-cc49-a239-efe0-c453a846a46b', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t73fc1412cc49a239efe0c453a846a46b$Iansã - Senhora da Ventania$t73fc1412cc49a239efe0c453a846a46b$, $c73fc1412cc49a239efe0c453a846a46b$Iansã, meu Orixá estrela guia
Tu és a própria ventania
Que em meu terreiro
Sempre louvo em meu congar
Tu és a moça rica,és formosa
És minha mãe, a linda rosa
Do jardim suspenso de Pai Oxalá
Guerreira, és minha força,és minha fé
Guardo comigo teu axé e o misticismo da Bahia
Louvo seu lindo relampear
Que ilumina meu passar, ôh, senhora da ventania
Louvo o vento, louvo o raio,louvo o relampear
Saravá santa guerreira, saravá seu jacutá
Louvo o vento, louvo o raio,louvo o relampear
Saravá santa guerreira, saravá seu jacutá$c73fc1412cc49a239efe0c453a846a46b$, NULL, now()),
('e8ac642c-b2e2-38cb-c706-62ce713a5e06', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $te8ac642cb2e238cbc70662ce713a5e06$Iansã - A Força dos Ventos$te8ac642cb2e238cbc70662ce713a5e06$, $ce8ac642cb2e238cbc70662ce713a5e06$É Iansã, a deusa guerreira
É Iansã, mãe do entardecer
É Iansã, com sua ventania
Mãe Iansã, venha nos valer
Dona Iansã é a força dos ventos
Do raio e do vendaval
Ela é guerreira, divindade do fogo
Com seu eruxim, vai afastando o mal
Ela é mudança, é rapidez, é coragem
Ela é lealdade, é movimento, é poder
Contra injustiça, elatraz a verdade
Com sua espada defende o seu filho da dor
Comanda o tempo,
Comanda a tempestade,
É minha mãe na Umbanda
É mulher de xangô
Oh salve ela,
Seu poder
Sua riqueza
Salve sua beleza e o axé que me traz
Sua energia ilumina meus dias
Que eu seja merecedor
Não me abandone jamais
É Iansã
A deusa guerreira
É Iansã
Mãe do entardecer
É Iansã
Com sua ventania
Mãe Iansã
Venha nos valer
É Iansã
A deusa guerreira
É Iansã
Mãe do entardecer
É Iansã
Com sua ventania
Mãe Iansã
Venha nos valer$ce8ac642cb2e238cbc70662ce713a5e06$, NULL, now()),
('ba9f1dc0-39cd-d415-6519-f9eac478a024', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tba9f1dc039cdd4156519f9eac478a024$Iansã - Eparrey Oyá$tba9f1dc039cdd4156519f9eac478a024$, $cba9f1dc039cdd4156519f9eac478a024$O céu brilhou relampejou
Vento soprou de norte a sul, Oyá
Mina de ouro, céu azul
Mulher guerreira de xangô, Oyá
Santa forjada a ferroe fogo,
A mãe do entardecer, Oyá
Orixá da natureza
Dona de rara nobreza, Oyá
O céu brilhou relampejou
Vento soprou de norte a sul, Oyá
Mina de ouro, céu azul
Mulher guerreira de xangô, Oyá
Santa forjada a ferroe fogo,
A mãe do entardecer, Oyá
Orixá da natureza
Dona de rara nobreza, Oyá
Chove chuva, ventania
Traz a guerra em sua companhia
Sua espada como brilha
Nessa estrada tudo se ilumina
Eparrey eparrey, Oyá
Eparrey eparrey, Oyá$cba9f1dc039cdd4156519f9eac478a024$, NULL, now()),
('93511337-af1f-f97e-0fa6-26722245a585', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t93511337af1ff97e0fa626722245a585$Iansã - Moça bonita$t93511337af1ff97e0fa626722245a585$, $c93511337af1ff97e0fa626722245a585$Ela é,uma moça bonita
Ela é dona do seu jacutá
Eparrei, eparrei,eparrei
o mamãe de Aruanda
segura a banda que eu quero ver
Ela vem, abençoar os seu filhos
Saravá todos filhos de Umbanda
Eparrei, eparrei,eparrei
omamãe de Aruanda
segura a banda que eu quero ver$c93511337af1ff97e0fa626722245a585$, NULL, now()),
('d16197ff-bcad-796b-9966-2e468063e60b', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $td16197ffbcad796b99662e468063e60b$Iansã -Ventania chegou$td16197ffbcad796b99662e468063e60b$, $cd16197ffbcad796b99662e468063e60b$ôôô ôô...ventania chegou
Raios cruzando o céu, o mar começa a se agitar
guerreira com a espada na mão, girando num lindobailar
Iansã mostrando sua força, impondo seu grande poder
divina,rainha da Umbanda
minha mãe eu imploro, venha nos valer
ôôô ôô...ventania chegou
Tenho certeza que com ela eu posso contar
com minha fé,o mal ireiderrotar
no terreirotoco atabaque em seu louvor
lindascanções entoadas com muito amor
Eparrei, eparrei,eparrei
daimae forças minha mãe Iansã, eparrei$cd16197ffbcad796b99662e468063e60b$, NULL, now()),
('8cea14ab-f145-cadf-15de-1601fdfff101', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t8cea14abf145cadf15de1601fdfff101$Iansã -Oyá Matamba$t8cea14abf145cadf15de1601fdfff101$, $c8cea14abf145cadf15de1601fdfff101$Oyá matamba, eta deme
Oyá matamba, eta deme
Aê dim dim
Aê dim dá
Oyá matamba de Aruê
Oyá matamba de Aruá
Tiberebere, ô minha mãe, tibereré
Tiberebere, ô Iansã, tibereré
Oyá, Oyá, Oyá êee
Olha a matamba de carurucá dendê
Rê, rê,rê, rê,na Aruanda, ê
Rê, rê,rê, rê,na Aruanda, ê
Na Aruanda, ê,é minha mãe
Na Aruanda, ê,é eparrei
Na Aruanda, ê,é Iansã
Na Aruanda ê
Iansã é uma moça bonita
Mas ela é dona do seu jacutá
Iansã é uma moça bonita
Mas ela é dona do seu jacutá
Eparrei, eparrei,eparrei!
Mamãe de Aruanda segura essa banda que eu quero ver
Ventou, mais que ventania
Ventou, mais que ventania
Iansã é nossa mãe
Santa Barbara é nossa guia
Iansã é nossa mãe
Santa Barbara é nossa guia
Aê dim dim
Aê dim dá
Oyá matamba de Aruê
Oyá matamba de Aruá$c8cea14abf145cadf15de1601fdfff101$, NULL, now()),
('ebd04868-256a-91e7-a6ee-f267bb177c97', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tebd04868256a91e7a6eef267bb177c97$Iansã - Deusa do Fogo$tebd04868256a91e7a6eef267bb177c97$, $cebd04868256a91e7a6eef267bb177c97$Relampejou lá no céu, deixa clarear
Vento soprou na palmeira, ê ah!
Salve a deusa do fogo, Oyá!
É Iansã quem chegou, deixa ela girar
Relampejou lá no céu, deixa clarear
Vento soprou na palmeira, ê ah!
Salve a deusa do fogo, Oyá!
É Iansã quem chegou, deixa ela girar
Oh, guerreira, rainha desse jacutá
Seu encanto me fascina, você é quem me faz sonhar
É vento que sopra no meu coração
Energia que me faz vibrar de emoção
É fogo que aquece o meu anoitecer
É luz que me guia, é meu bem querer
Com sua espada eu venço a batalha
Minha féem você não falha
Eparrêi, minha mãe, vem me proteger
Relampejou lá no céu, deixa clarear
Vento soprou na palmeira, ê ah!
Salve a deusa do fogo, Oyá!
É Iansã quem chegou, deixa ela girar
Relampejou lá no céu, deixa clarear
Vento soprou na palmeira, ê ah!
Salve a deusa do fogo, Oyá!
É Iansã quem chegou, deixa ela girar
É Iansã quem chegou, deixa ela girar
É Iansã quem chegou, deixa ela girar$cebd04868256a91e7a6eef267bb177c97$, NULL, now()),
('c5dcb12d-137d-e0b4-39a7-a8065564e837', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tc5dcb12d137de0b439a7a8065564e837$Iansã - Olha eu bela Oyá$tc5dcb12d137de0b439a7a8065564e837$, $cc5dcb12d137de0b439a7a8065564e837$E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã, ela é meu Orixá
E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã, ela é meu Orixá
Quando Iansã chegou
Saravou yalorixá
O ogã louvou sua coroa
Eparrey, bela Oyá
Ela é moça bonita
Moça rica ela é
Conhecida dentro do santo
Ela é Iansã de Balé
E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã, ela é meu Orixá
E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã, ela é meu Orixá
Vamos pedir com fé
Com amor no coração
Pedir à Iansã do Balé
Para todos os filhos
Sua proteção
E olha eu, olha eu
E olha eu bela Oyá
E olha eu, olha eu
Ela é Iansã, ela é meu Orixá$cc5dcb12d137de0b439a7a8065564e837$, NULL, now()),
('a99528fc-aea9-4de1-e3b7-f61f1281a5e1', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $ta99528fcaea94de1e3b7f61f1281a5e1$Iansã - Força de Oyá$ta99528fcaea94de1e3b7f61f1281a5e1$, $ca99528fcaea94de1e3b7f61f1281a5e1$Eparrê ô,eparrê á, eparrê, força de Oyá
Eparrê ô,eparrê á, eparrê, força de Oyá
Eparrê ô,eparrê á, eparrê, força de Oyá
Eparrê ô,eparrê á, eparrê, força de Oyá
Ela é mais que temporal
Muito mais que ventania
Uma força sem igual
Um poder que arrepia
A bravura de mil homens
Tudo em uma só mulher
E por nós ela guerreia
Venha o mal de onde vier
Eparrê ô,eparrê á, eparrê, força de Oyá
Eparrê ô,eparrê á, eparrê, força de Oyá
Eparrê ô,eparrê á, eparrê, força de Oyá
Eparrê ô, eparrê á, eparrê, força de Oyá
Filhade santa guerreira
Meu caminho eu mesma traço
Fui criada em fogo alto
Tenho minha alma de aço
Agradeço à Iansã
Tudo o que ela me ensinou
A coragem de Ogum
E a justiçade Xangô
Eparrê ô, eparrê á, eparrê, força de Oyá
Eparrê ô, eparrê á, eparrê, força de Oyá
Eparrê ô, eparrê á, eparrê, força de Oyá
Eparrê ô, eparrê á, eparrê, força de Oyá$ca99528fcaea94de1e3b7f61f1281a5e1$, NULL, now()),
('1ffb3c90-8417-1006-c31c-c11854e45b18', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t1ffb3c9084171006c31cc11854e45b18$Iansã - Ela é Oyá$t1ffb3c9084171006c31cc11854e45b18$, $c1ffb3c9084171006c31cc11854e45b18$Olha que o céu clareou
Quando o dia raiou
Fez o filhopensar
A mãe do tempo mandou
A nova era chegou
Agora vamos plantar
No humaitá Ogum bradou
Seu Oxóssi atinou
Iansã vai chegar
O ogã jáfirmou
Atabaque afinou
Agora vamos cantar
Ah! Eparrei!
Ela é Oyá! Ela é Oyá!
Ah! Eparrei!
É Iansã! É Iansã!
Ah! Eparrei!
Quando Iansã vai pra batalha
Todos cavaleiros param
Só pra ver ela passar
Ah! Eparrei!
Ela é Oyá! Ela é Oyá!
Ah! Eparrei!
É Iansã! É Iansã!
Ah! Eparrei!
Quando Iansã vai pra batalha
Todos cavaleiros param
Só pra ver ela passar$c1ffb3c9084171006c31cc11854e45b18$, NULL, now()),
('943e46ed-ec4d-74c5-9b88-685fc03738f7', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t943e46edec4d74c59b88685fc03738f7$Iansã - Deu um clarão no céu$t943e46edec4d74c59b88685fc03738f7$, $c943e46edec4d74c59b88685fc03738f7$Deu um clarão no céu
As nuvens se esconderam
Mas de repente deu uma ventania
Era a dona dos raios
Iansã que aparecia
Mas de repente deu uma ventania
Era a dona dos raios
Iansã que aparecia
Tão linda como o ouro nagô
Sua coroa é cravejada de brilhantes
Eparrêi,Eparrêi Oyá
Ilumina meus caminhos
Por onde eu passar
Eparrêi,Eparrêi Oyá
Ilumina meus caminhos
Por onde eu passar$c943e46edec4d74c59b88685fc03738f7$, NULL, now()),
('a7f616d1-f9f0-adc5-cf81-ff6f4b1f8e19', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $ta7f616d1f9f0adc5cf81ff6f4b1f8e19$Iansã - Iansã com seu batacotô$ta7f616d1f9f0adc5cf81ff6f4b1f8e19$, $ca7f616d1f9f0adc5cf81ff6f4b1f8e19$Ventou na mata, ventou na pedreira
Que vento forte na cachoeira
Não é Oxóssi, nem é Xangô
éIansã com o seu batacotô$ca7f616d1f9f0adc5cf81ff6f4b1f8e19$, NULL, now()),
('0d788c64-3243-13dc-ce9d-f35006ab7d2e', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t0d788c64324313dcce9df35006ab7d2e$Iansã - Senhora da ventania$t0d788c64324313dcce9df35006ab7d2e$, $c0d788c64324313dcce9df35006ab7d2e$Iansã, meu orixá,estrela guia, tu és a própria ventania
que em meu terreiro sempre louvo em meu gongá
Tu és a moça rica,és formosa, és minha mãe a linda rosa
do jardim suspenso de pai Oxalá
Guerreira, é minha força, minha fé
guardo comigo seu axé, e o misticismo da Bahia
Louvo, seu lindorelampear, que ilumina o me passar
Senhora da ventania
Louvo o vento, louvo o raio,louvo o relampear
Saravá santa guerreira, saravá seu jacutá (2x)$c0d788c64324313dcce9df35006ab7d2e$, NULL, now()),
('5cd9bf1f-3d3e-94c7-6123-f668251bed7c', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t5cd9bf1f3d3e94c76123f668251bed7c$Iansã - Dona do raio da manhã$t5cd9bf1f3d3e94c76123f668251bed7c$, $c5cd9bf1f3d3e94c76123f668251bed7c$Salve a santa guerreira
Saravá seu jacutá
Brilhaforte na pedreira, a coroa de Oyá
Eparrey
Eparrey Iansã
A dona do raioda manhã (Refrão)
Abre o seu leque, e controla todo vento
A dona do tempo chegou
Pra fazer seu firmamento
(Refrão)
Com sua espada, guerreia na tempestade
Relampeia clarão do raio
No céu vejo sua imagem
(Refrão)$c5cd9bf1f3d3e94c76123f668251bed7c$, NULL, now()),
('5ece1856-34cf-e537-1093-f1e153eb9a21', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t5ece185634cfe5371093f1e153eb9a21$Iansã - Vendaval de Iansã$t5ece185634cfe5371093f1e153eb9a21$, $c5ece185634cfe5371093f1e153eb9a21$O vendaval de Iansã, leva as folhas da Jurema
E o raiode Iansã, ilumina e clareia
E a espada de Iansã, corta os perigos no caminho
E o olhar de Iansã me ilumina, pra nunca estar sozinho
E a coroa de Iansã, foiXangô quem coroou
E o nome de guerreira, Oxalá quem batizou$c5ece185634cfe5371093f1e153eb9a21$, NULL, now()),
('79f546a2-f554-b09b-a299-0fd682c429f5', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t79f546a2f554b09ba2990fd682c429f5$Iansã - Senhora do Amanhecer$t79f546a2f554b09ba2990fd682c429f5$, $c79f546a2f554b09ba2990fd682c429f5$No amanhecer é,que essa estrela brilha
No amanhecer é,que ela se ilumina
Iansã senhora do amanhecer
Sua espada brilha
Pra nos proteger
É Oyá, Iansã quem nos conduz
É Oyá, Iansã com sua luz
É santa guerreira
Se preciso for
Pra acabar com a guerra
E espantar ador
É Oyá, Iansã quem nos conduz
É Oyá, Iansã com sua luz
Ao rodopiar faz o vento
E a chuva traz
Pra lavar a terra
Semear a paz$c79f546a2f554b09ba2990fd682c429f5$, NULL, now()),
('d06eddec-d1ef-e9fd-2cf0-f4d2b1abce95', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $td06eddecd1efe9fd2cf0f4d2b1abce95$Iansã - Ela é dona do mundo$td06eddecd1efe9fd2cf0f4d2b1abce95$, $cd06eddecd1efe9fd2cf0f4d2b1abce95$Oyá, Cabocla da aldeia
elavem chegando quando a lua é cheia
Quando Oyá me chamou, eu fuiatender
tavasentada Iansã aos pés de dendê
Elaé dona do mundo, Ela é dona do mundo
Iansã venceu guerra, Ela é dona do mundo$cd06eddecd1efe9fd2cf0f4d2b1abce95$, NULL, now()),
('40f0dc16-0d66-2f4a-0ffc-dca2b4c1b972', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t40f0dc160d662f4a0ffcdca2b4c1b972$Iansã - Me protegi no bambuzal de Iansã$t40f0dc160d662f4a0ffcdca2b4c1b972$, $c40f0dc160d662f4a0ffcdca2b4c1b972$Me protegi
no bambuzal de Iansã
das demandas que jogaram em mim
Elaé do vento que traz toda bondade
ecom seu raiodestrói toda maldade
Eparrei bela Oyá
virouo tempo, foipra ela guerrear
Eparrei bela Oyá
na nossa Umbanda ela é grande orixá$c40f0dc160d662f4a0ffcdca2b4c1b972$, NULL, now()),
('3fae4b3c-3258-9961-8171-abff9d726219', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t3fae4b3c325899618171abff9d726219$Iansã - Leque que venta$t3fae4b3c325899618171abff9d726219$, $c3fae4b3c325899618171abff9d726219$Iansã tem um leque que venta
praabanar dia de calor
Iansã tem um leque que venta
praabanar dia de calor
Iansã mora na pedreira
eu quero ver meu pai Xangô
Iansã mora na pedreira
eu quero ver meu pai Xangô$c3fae4b3c325899618171abff9d726219$, NULL, now()),
('da76f4c3-b1c9-7222-4782-9ba5ba9bb0ca', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tda76f4c3b1c9722247829ba5ba9bb0ca$Iansã - Iansã orixá de Umbanda$tda76f4c3b1c9722247829ba5ba9bb0ca$, $cda76f4c3b1c9722247829ba5ba9bb0ca$Iansã… orixá de Umbanda
Rainha do nosso Gongá
Saravá Iansâ lána Aruanda,
Eparrei,Eparrei, Iansã
Venceu demanda
Iansã,saravá Pai Xangô
No céu o trovão roncou
E lána mata o leão bradou
Saravá Iansã
Saravá Xangô
E lána mata o leão bradou
Saravá Iansã
Saravá Xangô$cda76f4c3b1c9722247829ba5ba9bb0ca$, NULL, now()),
('c77b7e3d-e8d3-38d4-50da-ef91c1330218', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tc77b7e3de8d338d450daef91c1330218$Iansã - Depois do raio vem a trovoada$tc77b7e3de8d338d450daef91c1330218$, $cc77b7e3de8d338d450daef91c1330218$Desceu do céu
um grande raioque clareou a terra
Numa forteventania
mãe Iansã mostrou quem era
Ela tem força, divino poder
Santa guerreira venha nos valer
No bambuzal ela faz morada
depois do raiovem a trovoada$cc77b7e3de8d338d450daef91c1330218$, NULL, now()),
('3b690bd5-c992-fa98-1f0e-f8eca8472991', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t3b690bd5c992fa981f0ef8eca8472991$Iansã -A Guerreira vai Reinar$t3b690bd5c992fa981f0ef8eca8472991$, $c3b690bd5c992fa981f0ef8eca8472991$Ô Iansã Menina seu jeitome fascina
É de arrepiar
Ô Iansã guerreira não há barreiras
Pra lhe segurar
Ela chegou !Bem devagar
E observou em cada canto desse mundo
E a fez pensar
A luzbrilhou em seu Jacutá
E anunciou
Prepare que a Guerreira agora vai Reinar
Ô Iansã Menina seu jeitome fascina
É de arrepiar
Ô Iansã guerreira não há barreiras
Pra lhe segurar
O tempo mudou ! Fez o céu brilhar
O Sol e a Lua irradiam energia
Para renovar
Que renasça o amor, e fortaleçaa fé
Pois Iansã esta soprando pelo mundo
Um vendaval de Axé !
Ô Iansã Menina seu jeitome fascina
É de arrepiar
Ô Iansã guerreira não há barreiras
Pra lhe segurar$c3b690bd5c992fa981f0ef8eca8472991$, NULL, now()),
('8e644ab5-35b8-babf-f848-f86624b695d7', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t8e644ab535b8babff848f86624b695d7$Iansã -Dona dos ventos$t8e644ab535b8babff848f86624b695d7$, $c8e644ab535b8babff848f86624b695d7$Eparrei, Oyá
dona dos ventos, mensageira de Oxalá
Eparrei bela Oyá
Eparrei, Oyá
dona dos ventos, mensageira de Oxalá
Saravá santa guerreira
deusa do fogo e da luz
minha santa padroeira
que meu destino conduz
proteção para seus filhos
Eparrei oh bela Oyá
moça rica na Umbanda
venha nos abençoar
Eparrei bela Oyá$c8e644ab535b8babff848f86624b695d7$, NULL, now()),
('aa52d26b-b350-0b75-dba1-74048baa3c67', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $taa52d26bb3500b75dba174048baa3c67$Iansã -Vento de paz$taa52d26bb3500b75dba174048baa3c67$, $caa52d26bb3500b75dba174048baa3c67$Vem ó vento vem
soprar bem fortetrazpra esse Jacutá
aforça Divina de Iansã
ea bênção de Oxalá
Vem ó vento e traz também
apaz e a esperança para quem não tem$caa52d26bb3500b75dba174048baa3c67$, NULL, now()),
('1fe3bdea-2d60-b5b4-970e-87937ce1ab26', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t1fe3bdea2d60b5b4970e87937ce1ab26$Iansã - Rainha de Aruanda$t1fe3bdea2d60b5b4970e87937ce1ab26$, $c1fe3bdea2d60b5b4970e87937ce1ab26$Soprou um vento longe
de longe vem com a brisa do mar
énossa mãe, rainha de Aruanda
eparrei,eparrei oh! que bela Oyá
Erga seus braços pro céu
epeça a ela que venha nos ajudar
vem proteger, os filhosde Umbanda
eabençoar todos filhosde Oxalá
Relampejou, trovejou, choveu
veioa bonança quando elaapareceu$c1fe3bdea2d60b5b4970e87937ce1ab26$, NULL, now()),
('91b1dc49-b1d9-4715-8317-e28c66db4120', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t91b1dc49b1d947158317e28c66db4120$Iansã - Iansã do mar$t91b1dc49b1d947158317e28c66db4120$, $c91b1dc49b1d947158317e28c66db4120$Que vento é esse que vem lá do mar
Que vento é esse que vem lá do mar
éo vento de Iansã que vem descarregar
éo vento de Iansã que vem descarregar
Relampiou
achuva caiu
ovento soprou
Iansã chegou
Que vento é esse que vem lá do mar
Que vento é esse que vem lá do mar
éo vento de Iansã que vem descarregar
éo vento de Iansã que vem descarregar
Salve a rainha
salve a guerreira
meu orixá
minha padroeira
nesse terreiro
elavem girar
oeparrei, "parrei"
Iansã do mar$c91b1dc49b1d947158317e28c66db4120$, NULL, now()),
('46161344-e7ef-18e9-22e2-d93ef471a9b6', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t46161344e7ef18e922e2d93ef471a9b6$Iansã - Vento vai lhe levar$t46161344e7ef18e922e2d93ef471a9b6$, $c46161344e7ef18e922e2d93ef471a9b6$Oh! Que bom vento lhe trouxe
bom vento vai lhe levar
eu vio sol, via lua
mãe Iansã vai girar$c46161344e7ef18e922e2d93ef471a9b6$, NULL, now()),
('7bc5c1e6-0632-980f-1a50-9e5aa8f66049', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t7bc5c1e60632980f1a509e5aa8f66049$Iansã -Rainha das yaôs$t7bc5c1e60632980f1a509e5aa8f66049$, $c7bc5c1e60632980f1a509e5aa8f66049$Trovejou lá no céu
eo mundo balanceou
No céu
eo mundo balanceou
Saravá Iansã
rainha das yaôs$c7bc5c1e60632980f1a509e5aa8f66049$, NULL, now()),
('4e213a51-7313-6bf8-2fe1-e921f9a7b32e', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t4e213a5173136bf82fe1e921f9a7b32e$Iansã -Ela é Oyá$t4e213a5173136bf82fe1e921f9a7b32e$, $c4e213a5173136bf82fe1e921f9a7b32e$Olha que o céu clareou
quando o dia raiou
fezo filhopensar
amãe do tempo mandou
anova era chegou
agora vamos plantar
do Humaitá Ogum bradou
senhor Oxossi atinou
Iansã vai chegar
oogã já firmou
atabaque afinou
agora vamos cantar
aeparrei elaé Oyá ela é Oyá
aeparrei é Iansã é Iansã
aeparrei
quando Iansã vaipra batalha
todos cavaleiros param
só pra ver ela passar$c4e213a5173136bf82fe1e921f9a7b32e$, NULL, now()),
('6e78e927-f76d-490e-810d-a93ca82497d2', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t6e78e927f76d490e810da93ca82497d2$Iansã - Deusa da ventania$t6e78e927f76d490e810da93ca82497d2$, $c6e78e927f76d490e810da93ca82497d2$Faz tanto tempo que eu não vejo chover
relampear, trovejar,água correr
faztanto tempo que eu não sinto a energia
de Iansã, a Deusa da ventania
É o orixá,que na mão trazespada de ouro
pra defender, filhos que nela tem fé
Ela é meu axé, ela é minha guia
meu grande tesouro, ela é do Balé$c6e78e927f76d490e810da93ca82497d2$, NULL, now()),
('9e091a85-6510-d4b5-dac0-600f8d29a7f1', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t9e091a856510d4b5dac0600f8d29a7f1$Iansã - Vento de paz$t9e091a856510d4b5dac0600f8d29a7f1$, $c9e091a856510d4b5dac0600f8d29a7f1$Vem ó vento vem
soprar bem forte,trás pra esse jacutá
aforça divina de Iansã
ea bênção de Oxalá
vem ó vento e trástambém
apaz e a esperança para quem não tem$c9e091a856510d4b5dac0600f8d29a7f1$, NULL, now()),
('2548b3e1-2311-028c-986b-a2eda371ecaa', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t2548b3e12311028c986ba2eda371ecaa$Iansã - Me protegi$t2548b3e12311028c986ba2eda371ecaa$, $c2548b3e12311028c986ba2eda371ecaa$Me protegi no bambuzal de Iansã
das demandas que jogaram em mim
Ela é do vento que traztoda bondade
ecom seu raio destróitoda maldade
eparreibela Oyá
virouo tempo, foipra ela guerrear
eparreibela Oyá
na nossa Umbanda elaé grande Orixá$c2548b3e12311028c986ba2eda371ecaa$, NULL, now()),
('de56625a-7d5d-4091-71c2-e131f5d2583f', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tde56625a7d5d409171c2e131f5d2583f$Iansã - Rainha do nosso gongá$tde56625a7d5d409171c2e131f5d2583f$, $cde56625a7d5d409171c2e131f5d2583f$Iansã orixá de Umbanda
rainha do nosso gongá
saravá Iansã lá na Aruanda eparrei
eparrei,Iansã venceu demanda
Iansã saravou paiXangô
no céu o trovão roncou
elá na mata o leão bradou
saravá Iansã, saravá Xangô$cde56625a7d5d409171c2e131f5d2583f$, NULL, now()),
('bd11899a-f1f9-c0a4-7061-79a50aec648c', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tbd11899af1f9c0a4706179a50aec648c$Iansã - Acarajé tem dendê$tbd11899af1f9c0a4706179a50aec648c$, $cbd11899af1f9c0a4706179a50aec648c$Elamostra sua forçapra quem quiser ver
balançou obambuzal
acarajé tem dendê
ererê,ererê, ererê, ererá
dona da ventania, eparreibela Oyá
ererê,ererê, ererê, ererá
sua espada irradialuz pro meu jacutá$cbd11899af1f9c0a4706179a50aec648c$, NULL, now()),
('3dac9a71-5368-cc88-368e-702f69be60fa', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t3dac9a715368cc88368e702f69be60fa$Iansã - Quem vem com o vento$t3dac9a715368cc88368e702f69be60fa$, $c3dac9a715368cc88368e702f69be60fa$Olha quem vem com ovento
Olha quem vem com achuva
vem na mudança do tempo
praessa banda segura
éIansã, dona da ventania
grande guerreira que vem nos salvar
traza coroa, de bela rainha
eo poder de uma iabá$c3dac9a715368cc88368e702f69be60fa$, NULL, now()),
('be4bddba-2761-6a17-b86c-9529bc2c1ab4', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $tbe4bddba27616a17b86c9529bc2c1ab4$Iansã - Sonho Lindo$tbe4bddba27616a17b86c9529bc2c1ab4$, $cbe4bddba27616a17b86c9529bc2c1ab4$Sonhei um sonho lindo
sonho tão lindo que me encantou
eu me banhava com as águas da Oxum
que desciam da pedreira de pai Xangô
tempo virava,ventos eum trovão roncou
eraa bela Oyá, que no meu sonho
vinha para me ajudar
elabailava sem ter os pés no chão
com sua espada e seu calice na mão
eraIansã me dando sua proteção
Iansã - Ventou mas que ventania$cbe4bddba27616a17b86c9529bc2c1ab4$, NULL, now()),
('1590a85b-e86b-f61d-e8f1-ca9e64d258fc', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $t1590a85be86bf61de8f1ca9e64d258fc$Página23de 24$t1590a85be86bf61de8f1ca9e64d258fc$, $c1590a85be86bf61de8f1ca9e64d258fc$ventou, mas que ventania
ventou, mas que ventania
Iansã é nossa mãe
Iansã é nossa guia [2x]$c1590a85be86bf61de8f1ca9e64d258fc$, NULL, now()),
('d48a20e0-80c7-8fc8-bd5a-5ab259f515f8', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $td48a20e080c78fc8bd5a5ab259f515f8$Iansã - Eparrei de Aruanda$td48a20e080c78fc8bd5a5ab259f515f8$, $cd48a20e080c78fc8bd5a5ab259f515f8$eparrei de aruanda
anossa mãe é Iansã [2x]
oh gira, deixa gira girar[4x]
rainha lindade umbanda
oh Iansã não deixa eu sofrer
se a minha mãe é santa barbara
oh iansã não deixa eu sofrer$cd48a20e080c78fc8bd5a5ab259f515f8$, NULL, now()),
('d085328d-aa70-9b2c-7446-c076ca37dee2', 'bcaeffc1-057c-46a9-2d7c-49d0d4d97716', $td085328daa709b2c7446c076ca37dee2$Iansã - Mensageira de Oxalá$td085328daa709b2c7446c076ca37dee2$, $cd085328daa709b2c7446c076ca37dee2$Eparrei Oyá\n Dona dos ventos mensageira de Oxalá [2x]\n \nSaravá grande guerreira\n Dona do Sol e da Lua\n Minha
Santa padroeira\n Que me traz e me conduz\n \nProteção para esses filhos\nEparrei oh bela Oyá\n Moça linda de
Aruanda\n Venha nos abençoar\n \nEparrei Oyá\n Dona dos ventos mensageira de Oxalá [2x]\n$cd085328daa709b2c7446c076ca37dee2$, NULL, now()),
('95f7e484-0e1c-9140-4c4a-d99d482141a0', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t95f7e4840e1c91404c4ad99d482141a0$Levei Flores pro Mar$t95f7e4840e1c91404c4ad99d482141a0$, $c95f7e4840e1c91404c4ad99d482141a0$Levei Flores pro Mar
Levei Flores pro Mar
Levei Flores pro Mar para ver Mãe Iemanjá
Mas no Caminho eu Sofri
Para Chegar ao Grande Mar
Aimil Promessas eu Fiz
Aimeu Pecados eu Paguei
Mas minha Fé ,mas minha Fé
Levou-me ao Mar
Mas eu Levei Flor pro Mar
Foipara ver Mãe Iemanjá
Levei Flores pro Mar
Levei Flores pro Mar
Levei Flores para ver Mãe Iemanjá$c95f7e4840e1c91404c4ad99d482141a0$, NULL, now()),
('484e8e98-fd08-8a6e-a02a-98f677606e2a', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t484e8e98fd088a6ea02a98f677606e2a$Iemanjá - Motivos pra sorrir$t484e8e98fd088a6ea02a98f677606e2a$, $c484e8e98fd088a6ea02a98f677606e2a$Eu pedi um abraço ela me deu,
Eu pedi amor e ela não negou.
Iemanjá olhai pelo filhoseu,
Iemanjá cuida do seu yaô.
Quando a vida era só tristeza,
Pelo caminho pedras e rancor.
Eu fuina praia falarcom Iemanjá,
A rainha do mar minha vida mudou
Ela me dá motivos para sorrir
Mesmo o mundo me fazendo chorar
Se com ela a vida anda difícil
Sem ela eu sei que não posso caminhar
Suas ondas eram meu refúgio,
O meu Castelo era o Fundo do mar.
Cada estrelaera testemunha,
Do meu amor por mamãe Iemanjá.
Minha oração é de corpo e alma,
O seu canto me fazemocionar,
O meu presente é a flormais bela,
Minha coroa é de Iemanjá.$c484e8e98fd088a6ea02a98f677606e2a$, NULL, now()),
('be6abda3-bc02-c577-bb2f-58fbd33f23d7', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tbe6abda3bc02c577bb2f58fbd33f23d7$Iemanjá - Como é lindo o canto de Iemanjá$tbe6abda3bc02c577bb2f58fbd33f23d7$, $cbe6abda3bc02c577bb2f58fbd33f23d7$Mãe d'água
Rainha das ondas sereia do mar
Mãe d'água
Seu canto é bonito quando tem luar
Como é lindoo canto de Iemanjá
Faz até o pescador Chorar
Quem escuta a Mãe d'água cantar
Vai com ela pro fundo do mar -2x
Iêêêê Iemanjá
Rainha das ondas sereia do mar -2x$cbe6abda3bc02c577bb2f58fbd33f23d7$, NULL, now()),
('5e6c03f2-da94-96f5-f80a-c8134f5cfe8a', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t5e6c03f2da9496f5f80ac8134f5cfe8a$Mãe Iemanjá$t5e6c03f2da9496f5f80ac8134f5cfe8a$, $c5e6c03f2da9496f5f80ac8134f5cfe8a$Lavei minhas guias no mar
Manto azul, abracei
Voz horizonte a cantar
Mãe Iemanjá saravei
(2x)
Odociaba, (oi)Odoyá!
O céu e as águas formam lindo Gongá
É a Sereia das Ondas e Pai Oxalá
Com os anjinhos do céu e os do mar
Mãe Iemanjá savarei
Ondas sagradas vão levar
Tudo que um dia eu chorei
Vou no seu reino navegar
(2x)
Odociaba, (oi)Odoyá!
O céu e as águas formam lindo Gongá
É a Sereia das Ondas e Pai Oxalá
Com os anjinhos do céu e os do mar$c5e6c03f2da9496f5f80ac8134f5cfe8a$, NULL, now()),
('bb7eebe5-189b-46d5-80d1-4907e9606a0c', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tbb7eebe5189b46d580d14907e9606a0c$Rosas pra Iemanjá$tbb7eebe5189b46d580d14907e9606a0c$, $cbb7eebe5189b46d580d14907e9606a0c$Rosas pra Iemanjá, Rosas pra Iemanjá
Rosas pra Iemanjá, eu vou levar(x2)
Eu vou levar,Eu vou
Iemanjá, Iemanjá
Leva pro mar esta saudade
Da terra-mãe distante
Minha vontade de chorar, leva pro mar
Iemanjá, Iemanjá
Quero curtirfelicidade
Ser livrecomo as ondas
Grande como essa imensidão azul do mar
Rosas pra Iemanjá, Rosas pra Iemanjá
Rosas pra Iemanjá, eu vou levar(x2)
Eu vou levar,Eu vou
Iemanjá, Iemanjá
Dona do mar ó divindade
No borbulhar das ondas
Ouço sua voz me abençoar lindasereia
Iemanjá, Iemanjá
Meu orixá é só bondade
Protege tanto a gente
Com o seu manto azul de paz, amor e luz
Rosas pra Iemanjá, Rosas pra Iemanjá
Rosas pra Iemanjá, eu vou levar(x2)
Eu vou levar,eu vou
Iemanjá, Iemanjá$cbb7eebe5189b46d580d14907e9606a0c$, NULL, now()),
('e123c855-a61d-7cbc-ecb3-78327ac5b25d', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $te123c855a61d7cbcecb378327ac5b25d$Iemanjá - Lua de prata$te123c855a61d7cbcecb378327ac5b25d$, $ce123c855a61d7cbcecb378327ac5b25d$O lua de prata
ilumina o mar
é o reino sagrado
da mamãe sereia...
O lua de prata
ilumina o mar
é o reino sagrado
de Iemanjá...
O dona
das águas
rainha
é Orixá ô...
Sereia
me guarda
me guia
me embala...
O lua de prata
ilumina o mar
é o reino sagrado
da mamãe sereia...
O lua de prata
ilumina o mar
é o reino sagrado
de Iemanjá...$ce123c855a61d7cbcecb378327ac5b25d$, NULL, now()),
('887f3455-773f-8d53-b1fc-c7dd10d75fa2', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t887f3455773f8d53b1fcc7dd10d75fa2$Iemanjá - É ela$t887f3455773f8d53b1fcc7dd10d75fa2$, $c887f3455773f8d53b1fcc7dd10d75fa2$É ela
minha deusa rainha o meu bem querer
que me enche de amor e domina o meu ser
no seu reino sagrado eu canto em seu louvor
Mãe D'água
de joelhos na areia estou a orar
e de braços abertos vim te suplicar
nessa noite de luavem me abençoar
Ó mãe
que o balanço do mar leve todo o meu pranto
que o som do seu canto me tome em acalanto
ea luz do luar traga o seu axé
Ó mãe
eu trouxe rosas brancas pra lheofertar
trouxe água de cheiro pra lhe presentear
eno meu coração trago a minha fé
É no fundo do mar
que eu vou teencontrar
minha lindaYabá quero te abraçar
órainha Sobá
Odoyá Iemanjá
nas águas do seu mar eu quero navegar... (2x)$c887f3455773f8d53b1fcc7dd10d75fa2$, NULL, now()),
('b6946035-5014-5491-d104-c332fb124fff', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tb694603550145491d104c332fb124fff$O canto de Iemanjá$tb694603550145491d104c332fb124fff$, $cb694603550145491d104c332fb124fff$Estava
Caminhando na areia
Contemplando alua cheia
E o balanço do mar
Quando
Eu senti rolarmeu pranto
Ao ouvir um lindocanto
Era mãe Iemanjá (2x)
Ô ôôôôô ôôôôôô
O seu canto é uma beleza
Odoyá (2x)$cb694603550145491d104c332fb124fff$, NULL, now()),
('f2dc253c-f333-d8d8-9ecc-8f34fb054f16', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tf2dc253cf333d8d89ecc8f34fb054f16$Prece a Iemanjá$tf2dc253cf333d8d89ecc8f34fb054f16$, $cf2dc253cf333d8d89ecc8f34fb054f16$Eu vou fazeruma prece
Pra saudar mãe Iemanjá
Saravá mamãe sereia
Salve a rainha do mar (2x)
Santa senhora
Que ao meu lado caminha
Protetora e rainha
Uma estrela a me guiar
Olhe meus passos
Onde quer que eu esteja
E peço que me proteja
Nos caminhos que eu passar
Eu vou fazeruma prece
Pra saudar mãe Iemanjá
Saravá mamãe sereia
Salve a rainha do mar (2x)$cf2dc253cf333d8d89ecc8f34fb054f16$, NULL, now()),
('e4433012-5b3c-13ed-0fd0-4e9137b6039f', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $te44330125b3c13ed0fd04e9137b6039f$Iemanjá - Odoyá$te44330125b3c13ed0fd04e9137b6039f$, $ce44330125b3c13ed0fd04e9137b6039f$Odoyá
Odoyá
Odoyá
Santa senhora
Venha nos abençoar (2x)
Saravá mamãe sereia
Yabá dona do mar
Janaína minha deusa
Quero ouviro seu cantar
Por você eu tenho apreço
Sua luz me ilumina
A você eu agradeço
Minha féé quem me guia
Odoyá
Odoyá
Odoyá
Santa senhora
Venha nos abençoar (2x)
És minha estrela guia
Minha mãe meu bem querer
Seja noite ou seja dia
Eu vou te agradecer
E no mês de fevereiro
Nós vamos comemorar
Com florese água de cheiro
Pra saudar Iemanjá$ce44330125b3c13ed0fd04e9137b6039f$, NULL, now()),
('abd96ac3-585e-41ca-c57f-0331e17f501c', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tabd96ac3585e41cac57f0331e17f501c$Iemanjá - O reino de Iemanjá$tabd96ac3585e41cac57f0331e17f501c$, $cabd96ac3585e41cac57f0331e17f501c$Eu vim me banhar
Me abençoar
Eu estou no reino de Iemanjá
A luzdo luar
Vem me iluminar
Sereia quero ouviro seu cantar (2x)
Minha deusa mãe rainha
Salve a sereia do mar
Tu és bela, és divina
Odoyá Iemanjá
Toda a sua riqueza
Vem ládo fundo do mar
Salve a sereia mais linda
Odoyá Iemanjá
Eu vim me banhar
Me abençoar
Eu estou no reino de Iemanjá
A luzdo luar
Vem me iluminar
Sereia quero ouviro seu cantar (2x)$cabd96ac3585e41cac57f0331e17f501c$, NULL, now()),
('b9025f2e-cbee-5f96-c324-c1250d5e14d7', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tb9025f2ecbee5f96c324c1250d5e14d7$Iemanjá - Imenso mar$tb9025f2ecbee5f96c324c1250d5e14d7$, $cb9025f2ecbee5f96c324c1250d5e14d7$Caminhando na areia
Em noitede luacheia
Ouço a sereia cantar
Ela com o seu manto branco
Me tomou em acalanto
E veio me abençoar
Como um sonho encantado
Eu viviafascinado
Com a graça da mais linda Orixá
Ó divina flormulher
Deixe todo o seu axé
Nas ondas que vem do seu mar (2x)
Saravá mamãe sereia
Dona do meu caminhar
Salve a dona das águas
Ela équem me faz sonhar
Trouxe flore água de cheiro
Para lhe presentear
Saravá mãe 7 ondas
Dona desse imenso mar (2x)$cb9025f2ecbee5f96c324c1250d5e14d7$, NULL, now()),
('acb20605-5cb0-e5d3-e439-f98356f8de33', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tacb206055cb0e5d3e439f98356f8de33$Iemanjá - Flores Brancas$tacb206055cb0e5d3e439f98356f8de33$, $cacb206055cb0e5d3e439f98356f8de33$Iemanjá, Iemanjá
Iemanjá, Iemanjá
Eu vim saudar a rainha do mar
Eu vim saudar a rainha do mar
Deixa a Janaína passar (2x)
Em noitede luacheia
Eu ouço o canto da sereia do mar
Canta minha Deusa
Leva meu pranto e vem me abençoar
Eu trouxe floresbrancas pra saudar Iemanjá
Tem água de cheiro para a vida perfumar
No mar ou na areia eu vou teagradecer
Dona das águas olhe sempre o meu viver...
Iemanjá, Iemanjá
Iemanjá, Iemanjá
Eu vim saudar a rainha do mar
Eu vim saudar a rainha do mar
Deixa a Janaína passar (2x)$cacb206055cb0e5d3e439f98356f8de33$, NULL, now()),
('8378a6a9-1e8f-54f5-742f-7664bc8d7e0c', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t8378a6a91e8f54f5742f7664bc8d7e0c$Iemanjá - Deusa Encantada$t8378a6a91e8f54f5742f7664bc8d7e0c$, $c8378a6a91e8f54f5742f7664bc8d7e0c$Ôô salve a rainha do mar
Ôô venha me abençoar
Mamãe sereia traz o seu axé
Eu sou o seu filhoe tenho muita fé (2x)
A lua no céu
Cercada de estrelas
A brisa no mar vem anunciar
A Deusa encantada, sereia do mar
Com o seu manto azul, vem me iluminar...
Me dê aconchego, retireo meu pranto
Me faça sonhar, com o seu acalanto
Ó linda Yabá, vim te agradecer
Rainha das águas olha o meu viver...
Ôô salve a rainha do mar
Ôô venha me abençoar
Mamãe sereia traz o seu axé
Eu sou o seu filhoe tenho muita fé (2x)$c8378a6a91e8f54f5742f7664bc8d7e0c$, NULL, now()),
('5167380f-536b-5396-0c68-f5e504d96a07', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t5167380f536b53960c68f5e504d96a07$Subida de Iemanjá$t5167380f536b53960c68f5e504d96a07$, $c5167380f536b53960c68f5e504d96a07$Ela vaisacudir
atoalha do gongá
Ela vaisacudir
atoalha do gongá
Com licença de Oxalá
Iemanjá vaigirar,Iemanjá vai girar
Com licença de Oxalá
Iemanjá vaigirar,Iemanjá vai girar
————————————————
Em seu barquinho
Ela vainavegar
Em seu barquinho
Ela vainavegar
Vou pedir a mamãe Iemanjá
eo povo d'água pra nos ajudar
Vou pedir a mamãe Iemanjá
eo povo d'água pra nos ajudar
Vou pedir a mamãe Iemanjá
eo povo d'água pra nos ajudar$c5167380f536b53960c68f5e504d96a07$, NULL, now()),
('d1d40395-4e27-65db-ac96-d6484becab31', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $td1d403954e2765dbac96d6484becab31$Eu vi um retrato na areia$td1d403954e2765dbac96d6484becab31$, $cd1d403954e2765dbac96d6484becab31$Fuilá na beira da praia
pra ver o balanço do mar
Fuilá na beira da praia
pra vero balanço do mar
Eu vium retrato na areia
me lembrei da sereia
começei a cantar
Eu vium retrato na areia
me lembrei da sereia
começei a cantar
Vem Janaína vem ver
Vem Janaína vem cá
vem receber as flores
que eu vim lheofertar
Vem Janaína vem ver
Vem Janaína vem cá
vem receber as flores
que eu vim lheofertar$cd1d403954e2765dbac96d6484becab31$, NULL, now()),
('4fa2e603-c759-36cb-78dc-8a8844b2ef81', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t4fa2e603c75936cb78dc8a8844b2ef81$A onda do mar rolou$t4fa2e603c75936cb78dc8a8844b2ef81$, $c4fa2e603c75936cb78dc8a8844b2ef81$A onda do mar rolou…
A onda do mar rolou…
A onda do mar rolou, a onda do mar rolou
A onda do mar rolou…
A onda do mar rolou…
A onda do mar rolou, a onda do mar rolou
Saravá a rainha do Mar
Saravá a nossa mãe Iemanjá
Saravá rainha do Mar
Saravá nossa mãe Iemanjá
Saravá a rainha do Mar
Saravá a nossa mãe Iemanjá
Saravá rainha do Mar
Saravá nossa mãe Iemanjá$c4fa2e603c75936cb78dc8a8844b2ef81$, NULL, now()),
('9ad623da-4b37-5a99-97fd-f6709741fe01', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t9ad623da4b375a9997fdf6709741fe01$Iemanjá - Iansã - Eram duas ventarolas$t9ad623da4b375a9997fdf6709741fe01$, $c9ad623da4b375a9997fdf6709741fe01$Eram duas ventarolas
duas ventarolas
que ventavam láno mar
Eram duas ventarolas
duas ventarolas
que ventavam láno mar
Uma era Iansã
oh Eparrey
aoutra era Iemanjá
Odociaba
Uma era Iansã
oh Eparrey
aoutra era Iemanjá
Odociaba$c9ad623da4b375a9997fdf6709741fe01$, NULL, now()),
('bad90e08-7608-83c9-af8c-5c44f7c7a68d', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tbad90e08760883c9af8c5c44f7c7a68d$Barquinho pequenino$tbad90e08760883c9af8c5c44f7c7a68d$, $cbad90e08760883c9af8c5c44f7c7a68d$Barquinho pequenino
que vem em altomar
Barquinho pequenino
que vem em altomar
Nossa Senhora vem dentro
prame ensinar a remar
Nossa Senhora vem dentro
prame ensinar a remar
Sereia,
Sereia,
Sereia nas ondas do mar
Sereia,
Sereia,
Não deixa o barquinho virar$cbad90e08760883c9af8c5c44f7c7a68d$, NULL, now()),
('db12e095-8921-524d-12f6-449e44dcb092', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tdb12e0958921524d12f6449e44dcb092$Botei meu barco na água$tdb12e0958921524d12f6449e44dcb092$, $cdb12e0958921524d12f6449e44dcb092$Boteimeu barco na água
praele navegar
Pedi licençaprimeiro
ànossa mãe Iemanjá
Iemanjá, oh Iemanjá
Iemanjá, oh Iemanjá
quem mora no fundo mar
Iemanjá, Iemanjá
Iemanjá, Iemanjá$cdb12e0958921524d12f6449e44dcb092$, NULL, now()),
('7771cf40-74bf-10c3-c27c-a61d7542191e', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t7771cf4074bf10c3c27ca61d7542191e$Alodê, Alodê yaô$t7771cf4074bf10c3c27ca61d7542191e$, $c7771cf4074bf10c3c27ca61d7542191e$É no mar, é no mar, é no mar…
onde mora Odociaba
É no mar, é no mar, é no mar…
onde mora Odociaba
Coroa maior
Coroa maior
Alodê, Alodê yaô
Alodê, Alodê yaô$c7771cf4074bf10c3c27ca61d7542191e$, NULL, now()),
('b52ab718-40cc-09b1-3ec7-9ce1079341b5', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tb52ab71840cc09b13ec79ce1079341b5$Mãe Iemanjá, como vem rompendo água$tb52ab71840cc09b13ec79ce1079341b5$, $cb52ab71840cc09b13ec79ce1079341b5$Mãe Iemanjá, como vem rompendo água
Mãe Iemanjá, como vem rompendo água
como vem rompendo água
Iemanjá mora no mar$cb52ab71840cc09b13ec79ce1079341b5$, NULL, now()),
('f74a90fc-4778-00dd-4866-5a7e15d6d2bb', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tf74a90fc477800dd48665a7e15d6d2bb$Festa no mar -Iemanjá ( Clipe )$tf74a90fc477800dd48665a7e15d6d2bb$, $cf74a90fc477800dd48665a7e15d6d2bb$Oxum mandou avisar pra Nanã e Iemanjá
Janaína menina, que vaiter festano mar
Pediu que rufassem os tambores, alabês e iabás
rum, rumpi, lé,vão falar
Dia dois de fevereiro,riovermelho é um formigueiro
aBahia toda em festa
prasaudar a Rainha do mar
os terreirospreparam seus presentes
eos mais atraentes vêm lá do Gantois
Pediu que rufassem os tambores, alabês e iabás
rum, rumpi, lé,vão falar$cf74a90fc477800dd48665a7e15d6d2bb$, NULL, now()),
('86172961-9556-582e-2f3a-12a78896ad26', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t861729619556582e2f3a12a78896ad26$Iemanjá - Oh, Santa de Azul$t861729619556582e2f3a12a78896ad26$, $c861729619556582e2f3a12a78896ad26$Odo odo, odo odo, odoyá!
Odo odo, odo odo, odoyá!
Oh santa de azul
Oh santa do mar
Vem ver seus filhos
Oh santa de azul
Oh santa do mar
Vem ver seus filhos
Saia do mar
E venha ver asua yaô
Saia do mar
E venha ver a sua yaô
Odo odo, odo odo, odoyá
Odo odo, odo odo, odoyá
Oh santa de azul
Oh santa do mar
Vem ver seus filhos
Oh santa de azul
Oh santa do mar
Vem ver seus filhos
Saia do mar
E venha ver a sua yaô
Saia do mar
E venha ver a sua yaô
Odo odo, odo odo, odoyá
Odo odo, odo odo, odoyá
Odo odo, odo odo, odoyá
Odo odo, odo odo, odoyá$c861729619556582e2f3a12a78896ad26$, NULL, now()),
('e3893b39-1c4e-d2eb-87d9-a2107cec4051', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $te3893b391c4ed2eb87d9a2107cec4051$Iemanjá - Eu Vou à Praia Grande$te3893b391c4ed2eb87d9a2107cec4051$, $ce3893b391c4ed2eb87d9a2107cec4051$Eu vou àpraia grande
Eu vou pra lá
Levar buquê de rosas
Pra Iemanjá
Eu vou àpraia
Vou firmar ponto na areia
Vou pedir à mãe sereia
Dona das ondas do mar
Que me protejasempre a luz do seu encanto
E me cubra com seu manto
Sobre estrelas a brilhar
Eu vou àpraia grande
Eu vou pra lá
Levar buquê de rosas
Pra iemanjá
Eu vou àpraia grande
Eu vou pra lá
Levar buquê de rosas
Pra iemanjá
Levar presentes, lindas rosas e perfumes
São as normas e costumes
De todo filhode fé
Pente de ouro vou levar pra mãe das águas
Pra que tireas minhas mágoas
Poderosa como é!
Eu vou à praia grande
Eu vou pra lá
Levar buquê de rosas
Pra iemanjá
Eu vou à praia grande
Eu vou pra lá
Levar buquê de rosas
Pra iemanjá$ce3893b391c4ed2eb87d9a2107cec4051$, NULL, now()),
('675da7ee-3899-5851-01fe-6e131218b404', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t675da7ee3899585101fe6e131218b404$Iansã & Iemanjá - A Força do Vento, Criou as Ondas do Mar$t675da7ee3899585101fe6e131218b404$, $c675da7ee3899585101fe6e131218b404$Mãe Oyá convidou, a rainha do mar pra dançar
Foia luz que criou,o sentimento no olhaaar
A força do vento criou as ondas do maaar
Foia dança de Oyá com a rainha do mar odoyáaa
E hoje na umbanda não me canso de louvar porque jurei!!!
Jureiamar Oyá, por onde passar, és o amor da minha vida
Enquanto eu respirar saúdo as onda do mar
Iemanjá quem me guiaaa
Jureiamar Oyá, por onde passar, és o amor da minha vida
Enquanto eu respirar saúdo as onda do mar
Iemanjá quem me guiaaa
Mãe Oyá convidou, a rainha do mar pra dançar
Foia luz que criou,o sentimento no olhaaar
A força do vento criou as ondas do maaar
Foia dança de Oyá com a rainha do mar odoyáaa
E hoje na umbanda não me canso de louvar porque jurei!!!
Jureiamar Oyá, por onde passar, és o amor da minha vida
Enquanto eu respirar saúdo as onda do mar
Iemanjá quem me guiaaa
Jureiamar Oyá, por onde passar, és o amor da minha vida
Enquanto eu respirar saúdo as onda do mar
Iemanjá quem me guiaaa$c675da7ee3899585101fe6e131218b404$, NULL, now()),
('5c66fcb8-0daa-67d2-9bf6-2afa91dba96f', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t5c66fcb80daa67d29bf62afa91dba96f$Iemanjá - Oxum -Tem areia no fundo do mar$t5c66fcb80daa67d29bf62afa91dba96f$, $c5c66fcb80daa67d29bf62afa91dba96f$Se tem areiano fundo do mar, tem areia
Se tem areia,tem mamãe Oxum com a Sereia
Se tem areiano fundo do mar, tem areia
Se tem areia,tem mamãe Oxum com a Sereia
Tem areia,tem
Tem areia,tem
tem areia no fundo do mar, tem areia
Tem areia,tem
Tem areia,tem
tem areia no fundo do mar, tem areia$c5c66fcb80daa67d29bf62afa91dba96f$, NULL, now()),
('d6e2cf72-d9f5-33ec-34de-ca0be60ed07e', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $td6e2cf72d9f533ec34deca0be60ed07e$Iemanjá - Oxum - São pétalas de rosas$td6e2cf72d9f533ec34deca0be60ed07e$, $cd6e2cf72d9f533ec34deca0be60ed07e$São pétalas de rosas desfolhadas
sobre as ondas do mar
São lágrimas de Oxum que veem rolando, aie ieu
no manto de mãe Iemanjá$cd6e2cf72d9f533ec34deca0be60ed07e$, NULL, now()),
('96d09961-fb7a-13f9-5aae-f17c1ac2b41d', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t96d09961fb7a13f95aaef17c1ac2b41d$Iemanjá - Estou ouvindo o lindo toque do tambor$t96d09961fb7a13f95aaef17c1ac2b41d$, $c96d09961fb7a13f95aaef17c1ac2b41d$Estou ouvindo o lindotoque do tambor
É louvação aIemanjá com muito amor
Estou ouvindo o lindotoque do tambor
É louvação aIemanjá com muito amor
Ô iáô Iemanjá,
Que todo amor vem de Oxalá
Ô iáô Iemanjá
Que toda dor levapro mar
Ô iáô Iemanjá,
Que todo amor vem de Oxalá
Ô iáô Iemanjá
Que toda dor levapro mar
Estou ouvindo o lindotoque do tambor
É louvação aIemanjá com muito amor
Estou ouvindo o lindotoque do tambor
É louvação aIemanjá com muito amor
Ô, iáô,Iemanjá,
Que todo amor vem de Oxalá
Ô, iáô,Iemanjá
Que toda dor levapro mar
Ô, iáô,Iemanjá,
Que todo amor vem de Oxalá
Ô, iáô,Iemanjá
Que toda dor levapro mar$c96d09961fb7a13f95aaef17c1ac2b41d$, NULL, now()),
('166b804c-53aa-dc50-c5ea-4df65afd2953', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t166b804c53aadc50c5ea4df65afd2953$ô mãe d'água, rainha sereia do mar$t166b804c53aadc50c5ea4df65afd2953$, $c166b804c53aadc50c5ea4df65afd2953$Brilhao sol
canta o rouxinol
eu olho céu e o infinito
aonde o azul é bonito
eu saravá Oxalá
Rios,montes e cascatas
eu olho o verde das matas
sintoa paz que a natureza trás
eo mar com sua grandeza
seu poder, sua beleza
eu imploro à iemanjá
ômãe d'água, rainha sereia do mar
segura a banda, ilumina esse gongá$c166b804c53aadc50c5ea4df65afd2953$, NULL, now()),
('6957b582-bb75-9d97-f026-35efa759d597', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t6957b582bb759d97f02635efa759d597$Iemanjá é a rainha do mar$t6957b582bb759d97f02635efa759d597$, $c6957b582bb759d97f02635efa759d597$Iemanjá éa rainha do mar
eo povo d'água é linhade forçamaior
Afirma ponto mamãe
afirma ponto mamãe
que no fundo do mar
éouro só, é ouro só
Eu via mamãe sereia
sentada àbeira mar
Pedindo para seus filhos
aproteção de Oxalá$c6957b582bb759d97f02635efa759d597$, NULL, now()),
('08b31c94-a9d9-ecbe-a89f-43c5b3dca30f', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t08b31c94a9d9ecbea89f43c5b3dca30f$Iemanjá - Escrevi um pedido na areia$t08b31c94a9d9ecbea89f43c5b3dca30f$, $c08b31c94a9d9ecbea89f43c5b3dca30f$Eu escrevi um pedido na areia
pedindo aZambi pra virme socorrer
Eu escrevi um pedido na areia
mas foimãe d'agua quem veio me valer
E foinas ondas do mar
que entreguei os meus problemas
eaprendi a confiar
que todo mal, nao dura para sempre
que a paz é uma semente que precisa semear
E no horizonte do mar tão infinito
Iemanjá me acolheu
eme deu um mundo tão mais bonito
eu abrimeu coração
elame estendeu amão
eentreguei meu caminhar
Iemanjá Sobá -Brilha o Sol$c08b31c94a9d9ecbea89f43c5b3dca30f$, NULL, now()),
('51701a06-7458-c957-7984-a6ef28984dad', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t51701a067458c9577984a6ef28984dad$Página 14de 33$t51701a067458c9577984a6ef28984dad$, $c51701a067458c9577984a6ef28984dad$Odociaba, minha mãe Iemanjá,
Saravá, Iemanjá Sobá!
Brilhao sol,canta o rouxinol,
Eu olho o céu e o infinito,
Aonde o azul é bonito,
Eu saravo a Oxalá!
Rios,montes e cascatas,
Eu olho o verde das matas
Sintoa paz que a natureza traz
(laia,laia!)
E no mar com sua grandeza
Seu poder, sua beleza,
Eu imploro a Iemanjá
Oh! mãe d’água, rainha, sereia do mar,
Segura a banda e ilumina esse congá.
Oh! mãe d’água, rainha, sereia do mar,
Segura a banda e ilumina esse congá.$c51701a067458c9577984a6ef28984dad$, NULL, now()),
('97ad3ca1-c0f6-ba19-f788-78ed4c460abe', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t97ad3ca1c0f6ba19f78878ed4c460abe$Iemanjá - Saudação à Yemanjá$t97ad3ca1c0f6ba19f78878ed4c460abe$, $c97ad3ca1c0f6ba19f78878ed4c460abe$Vamos saravá
Mãe Iemanjá
Vamos todos juntos
Jogar floresno mar
É do mar, é do mar, é do mar
É do mar minha mãe sereia
Papai risca ponto na pedra
Mamãe risca ponto na areia$c97ad3ca1c0f6ba19f78878ed4c460abe$, NULL, now()),
('356f923c-1562-32f4-0f7a-5cf9853d1eef', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t356f923c156232f40f7a5cf9853d1eef$Iemanjá - Fiz um pedido$t356f923c156232f40f7a5cf9853d1eef$, $c356f923c156232f40f7a5cf9853d1eef$Fizum pedido pra mamãe sereia
àIemanjá, para nunca mais penar
Foina areia,numa noite
na areia branca do mar$c356f923c156232f40f7a5cf9853d1eef$, NULL, now()),
('8ba86381-8427-a990-2b3b-e8d2e301bf2f', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t8ba863818427a9902b3be8d2e301bf2f$Iemanjá - Um presente dos Orixás$t8ba863818427a9902b3be8d2e301bf2f$, $c8ba863818427a9902b3be8d2e301bf2f$Odoiá!
Huumm
Ô, ô,ô
Oh, Minha mãe Iemanjá
Hoje
Hoje eu vou cantar
Hoje eu vou cantar
Vou louvar na areia
Em lua cheia a mãe Iemanjá
Iê,iê!
Rosa do mar
Minha estrela do céu azul
Não é históriado pescador
Que meu amor eu vou lhe entregar
Iê,iê!
Deixa
Deixa as ondas do mar passar
Ouça o canto da bela Odoiá
Oxalá quem mandou
Um grande amor
Do fundo do mar
Iê,iê!
Huuuumm
Ô, ô, ô,ô, ô, ô,
Ô, ô, ô,ô, ô, ô,
Oh, mãe Iemanjá!
Iê,iê!
Huuuumm
Ô, ô, ô,ô, ô, ô,
Ô, ô, ô,ô, ô, ô,
Oh, mãe Iemanjá!
Iê,iê!
Hoje
Hoje eu vou cantar
Hoje eu vou cantar
Vou louvar na areia
Em lua cheia a mãe Iemanjá
Iê,iê!
Rosa do mar
Minha estrela do céu azul
Não é históriado pescador
Que meu amor eu vou lhe entregar
Iê,iê!
Deixa
Deixa as ondas do mar passar
Ouça o canto da bela Odoiá
Oxalá quem mandou
Um grande amor
Do fundo do mar
Iê,iê!
Huuuumm
Ô, ô, ô,ô, ô, ô,
Ô, ô, ô,ô, ô, ô,
Oh, mãe Iemanjá!
Iê,iê!
Huuuumm
Ô, ô, ô,ô, ô, ô,
Ô, ô, ô,ô, ô, ô,
Oh, mãe Iemanjá!$c8ba863818427a9902b3be8d2e301bf2f$, NULL, now()),
('76d5d51b-96d7-cd4d-2bd7-88fd60ee9d8a', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t76d5d51b96d7cd4d2bd788fd60ee9d8a$Iemanjá - Mar de Luz$t76d5d51b96d7cd4d2bd788fd60ee9d8a$, $c76d5d51b96d7cd4d2bd788fd60ee9d8a$Odoyá
Eu vim lhe pedir que a força do mar
Carregue meu pranto pra longe de mim
Sereia,
Te trago uma florpro mar enfeitar
Em forma de amor eu sei que vai voltar
Seu axé
E de joelhos na areia
A noite clareia
A estrelareflete o tapete de luz
Que teu amor conduz
Sereia
Onde quer que eu vá
Eu vou telouvar, teu nome falar
Teu axé sentir,meus irmãos amar
Teus ensinamentos sempre repassar
É que no barco da vida, você é meu mar
Me mostra o caminho e como chegar
Sei que é dura alida,prometo lutar
Meu escudo é teu manto
Mamãe Iemanjá$c76d5d51b96d7cd4d2bd788fd60ee9d8a$, NULL, now()),
('65b39852-5f7e-a903-b650-f5e190a4aa1c', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t65b398525f7ea903b650f5e190a4aa1c$Iemanjá - No colo de Iemanjá$t65b398525f7ea903b650f5e190a4aa1c$, $c65b398525f7ea903b650f5e190a4aa1c$Quando me sinto sozinha
E o meu pranto vem me visitar
Eu me vejo entre as ondas
E o seu nome me ponho a chamar
Eu me vejo entre as ondas
E o seu nome me ponho a chamar
Dandalunda, Iemanjá,
Inaê ou Janaina,
venha me abençoar
Marabô, Mucunã, princesa de Aiocá
São todas rainhas do mar
Ó mãe ilumine os seus filhos
Meus pensamentos venha clarear
Pois sem sua energia
Eu nada seria minha mãe Iemanjá
Dandalunda, Iemanjá,
Inaê ou Janaina,
venha me abençoar
Marabô, Mucunã, princesa de Aiocá
São todas rainhas do mar
E o meu pranto vai levando
Minha dor tranquilizando
Ó mãe, sereia do mar$c65b398525f7ea903b650f5e190a4aa1c$, NULL, now()),
('53cb23ff-cd23-d163-1a8d-4766103b5037', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t53cb23ffcd23d1631a8d4766103b5037$Iemanjá - Estava sentado na areia$t53cb23ffcd23d1631a8d4766103b5037$, $c53cb23ffcd23d1631a8d4766103b5037$Estava sentada na areia
Olhando as ondas do mar
No céu tinham muitas estrelas
E a lua estava a brilhar.
Sozinha e perdida eu estava,
Sem saber me encontrar
Mas, de repente uma voz me faloubaixinho:
Tenha féem Oxalá!
Mas de repente uma voz me falou baixinho:
Tenha féem Oxalá!
Era ela,a deusa do mar
Que coisa mais linda
Mamãe Iemanjá!
Mas era ela,a deusa do mar
Estendendo suas mãos
Para nos abençoar.
Era ela,a deusa do mar
Que coisa mais linda
Mamãe Iemanjá!
Mas era ela,a deusa do mar
Estendendo suas mãos
Para nos abençoar.$c53cb23ffcd23d1631a8d4766103b5037$, NULL, now()),
('86a1b93f-51d2-d1fe-de5a-968736e09c05', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t86a1b93f51d2d1fede5a968736e09c05$Iemanjá - Canto para te louvar$t86a1b93f51d2d1fede5a968736e09c05$, $c86a1b93f51d2d1fede5a968736e09c05$Vou levar meu barquinho para o mar
Linda sereia
Odoyá
Mãe de todas as cabeças
Este canto é para telouvar
No balanço das ondas
Vou levar meu barquinho para o mar
Linda sereia
Odoyá
Mãe de todas as cabeças
Este canto é para telouvar
No balanço das ondas
Dia dois de fevereiro
Meu barquinho eu vou levar
Faço preces, trago rosas, para te dar
Sou teu filho e vistobranco
Para te homenagear
Seu amor é acalanto, e vive a nos abençoar
Vou levar meu barquinho para o mar
Linda sereia
Odoyá
Mãe de todas as cabeças
Este canto é para te louvar
No balanço das ondas
Vou levar meu barquinho para o mar
Linda sereia
Odoyá
Mãe de todas as cabeças
Este canto é para te louvar
No balanço das ondas
Sou eterno navegante, aprendendo a navegar
No seu reino fascinante
Venho me purificar
És ternura e remanso
A mais bela iabá
És magia e puro encanto
Quando o rio,deságua no mar
Vou levar meu barquinho para o mar
Linda sereia
Odoyá
Mãe de todas as cabeças
Este canto é para te louvar
No balanço das ondas
Vou levar meu barquinho para o mar
Linda sereia
Odoyá
Mãe de todas as cabeças
Este canto é para te louvar
No balanço das ondas$c86a1b93f51d2d1fede5a968736e09c05$, NULL, now()),
('9e8fbcb1-d79f-bb75-f9af-ae345e53a945', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t9e8fbcb1d79fbb75f9afae345e53a945$Oferenda à Iemanjá$t9e8fbcb1d79fbb75f9afae345e53a945$, $c9e8fbcb1d79fbb75f9afae345e53a945$Todo fim de ano eu vou pro mar
levaroferenda à Iemanjá
Chegando lá, piso na areia
peço licença à minha mamãe Sereia$c9e8fbcb1d79fbb75f9afae345e53a945$, NULL, now()),
('f542cb45-17ab-595b-b8b6-f3958abfe270', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tf542cb4517ab595bb8b6f3958abfe270$Janaína$tf542cb4517ab595bb8b6f3958abfe270$, $cf542cb4517ab595bb8b6f3958abfe270$Na beira do mar ê ê...
na beira do mar ê a...
Na beira do mar ê ê...
Janaína
A luailumina o meu caminhar
banhando meus pés vem as ondas do mar
no céu as estrelas irão me guiar
Janaína...
Jangada está pronta, eu vou navegar
ouvindo seu canto a me acalmar
apaz desejada viráme abraçar
Janaína$cf542cb4517ab595bb8b6f3958abfe270$, NULL, now()),
('d69ffebb-6440-6acd-cd09-1e2d133e9fd0', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $td69ffebb64406acdcd091e2d133e9fd0$Iemanjá - Ela é do mar / Canto lindo$td69ffebb64406acdcd091e2d133e9fd0$, $cd69ffebb64406acdcd091e2d133e9fd0$No mar tem conchas,
tem areia,tem gongá
Hoje eu vim saravá com a Sereia
Ela édo mar
__________________________________________
Que canto lindoque vem ládo mar
parece que as ondas estão a cantar
ieeeee...Iemanjá
rainha das ondas, a dona do mar$cd69ffebb64406acdcd091e2d133e9fd0$, NULL, now()),
('d830dc25-abcc-1330-077c-e5461324fd3a', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $td830dc25abcc1330077ce5461324fd3a$Iemanja - Rainha do Mar$td830dc25abcc1330077ce5461324fd3a$, $cd830dc25abcc1330077ce5461324fd3a$Minha sereia é rainha do mar
Minha sereia é rainha do mar
O canto dela faz admirar
O canto dela faz admirar
Minha sereia é moça bonita
Minha sereia é moça bonita
Nas ondas do mar aonde ela habita
Nas ondas do mar aonde ela habita
Ai,tem dó de ver o meu penar
Ai,tem dó de ver o meu penar
Iemanjá - Uma Estrela tão Bonita$cd830dc25abcc1330077ce5461324fd3a$, NULL, now()),
('333cf54f-c33d-2a88-0949-e304ae760fed', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t333cf54fc33d2a880949e304ae760fed$Página 20de 33$t333cf54fc33d2a880949e304ae760fed$, $c333cf54fc33d2a880949e304ae760fed$Uma estrela tão bonita
Que brilhava lá no céu
Brilhou tanto, brilhou tanto
Que depois caiu no mar
Em uma noite linda
Na beira da praia
Eu ouvi a mãe d'àgua cantar
Em uma noite linda
Na beira da praia
Eu ouvi a mãe d'àgua cantar
Ô, ô,ô, ô, ô
Ô, ô,ô, ô, ô
Pescador,quando sair de casa para pescar
Faz sua reza e sente o perfume no ar
Joga sua rede
Não pode marejar
Traz de volta a estrela cadente
Que caiu no mar
Que caiu no mar
Que caiu no mar
Pescador, pode ter a certeza
Vai ser boa a pesca
Lá na beira do cais
O seu povo lhe espera com festa
Volta a ouvir a mãe d' água cantar
Ouvir a Iara cantar
Ouvir a mãe d' água cantar
Ô, ô,ô, ô, ô
Ô, ô,ô, ô, ô
Ô, ô,ô, ô, ô
Ô, ô,ô, ô, ô
Uma estrela tão bonita
Que brilhava lá no céu
Brilhou tanto, brilhou tanto
Que depois caiu no mar
Em uma noite linda
Na beira da praia
Eu ouvi a mãe d'àgua cantar
Em uma noite linda
Na beira da praia
Eu ouvi a mãe d'àgua cantar$c333cf54fc33d2a880949e304ae760fed$, NULL, now()),
('debbb00b-6c36-0bcf-6a2d-6bec6544b3d6', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tdebbb00b6c360bcf6a2d6bec6544b3d6$Iemanjá - Lenda das sereias, rainha do mar$tdebbb00b6c360bcf6a2d6bec6544b3d6$, $cdebbb00b6c360bcf6a2d6bec6544b3d6$Oguntê, Marabô
Caiala e Sobá (bis)
Oloxum, Inaê
Janaína, Iemanjá
(São Rainha do Mar...)
O mar, misterioso mar
Que vem do horizonte
É o berço das sereias
Lendário e fascinante
Olha o canto da sereia
Ialaô,Okê, laloá
Em noite de Lua cheia
Ouço a sereia cantar
E o luarsorrindo
Então se encanta
Com a doce melodia
Os madrigais vão despertar
Ela mora no mar
Ela brinca na areia (bis)
No balanço das ondas
A paz ela semeia
Toda a corte engalanada
Transformando o mar em flor
Vê o Império enamorado
Chegar à morada do amor
Oguntê, Marabô
Caiala e Sobá (bis)
Oloxum, Inaê
Janaína, Iemanjá
(São Rainha do Mar...)$cdebbb00b6c360bcf6a2d6bec6544b3d6$, NULL, now()),
('60621980-7fc4-d29e-5401-3abaaf0dd8e5', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t606219807fc4d29e54013abaaf0dd8e5$Iemanjá - Eu sou filho de Yabá$t606219807fc4d29e54013abaaf0dd8e5$, $c606219807fc4d29e54013abaaf0dd8e5$Eu sou filhade iabá
Iabá é minha mãe
Eu sou filhade iabá
Iabá é minha mãe
Ó rainha do tesouro
Odociaba no fundo do mar
Odociaba no fundo do mar
Odociaba no fundo do mar
Odociaba no fundo do mar
Eu sou filhade iabá
Iabá é minha mãe
Eu sou filhade iabá
Iabá é minha mãe
Ó rainha do tesouro
Odociaba no fundo do mar
Odociaba no fundo do mar
Odociaba no fundo do mar
Odociaba no fundo do mar
Eu sou filhade iabá
Iabá é minha mãe
Eu sou filhade iabá
Iabá é minha mãe
Ó rainha do tesouro
Odociaba no fundo do mar
Odociaba no fundo do mar
Odociaba no fundo do mar
Odociaba no fundo do mar$c606219807fc4d29e54013abaaf0dd8e5$, NULL, now()),
('4e943b11-64c2-cebd-ab3d-5f3a807e5c2a', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t4e943b1164c2cebdab3d5f3a807e5c2a$Iemanjá - Rainha Sobá$t4e943b1164c2cebdab3d5f3a807e5c2a$, $c4e943b1164c2cebdab3d5f3a807e5c2a$O Inae estão lhechamando
Janaina vem cá nos ajudar
Tem vento no mar soprando
Pro meu barco poder chegar
Tem vento no mar soprando
Pro meu barco poder chegar
Perdido na vidano mar me meti
Com os olhos aos prantos me pus a rezar
Do fundo do mar me veio uma força
Uma voz muito doce sentime acalmar
Se você não tem fénão adianta crer
Só você nesse mundo pode se ajudar
Quando tudo parece estarperdido
Feche o olhos e reze a Oxalá
Foientão que amor no abraço me deu
Disse filhosei tudo o que vais passar
Te dou a proteção e caminho seguro
Só não vá se perder na escolha a tomar
Tu és meu amor certo que verdadeiro
Se não amo a tia ninguém vou amar
No fundo do mar é a sua morada
Minha mãe e Rainha Sobá
No fundo do mar é a sua morada
Minha mãe e Rainha Sobá$c4e943b1164c2cebdab3d5f3a807e5c2a$, NULL, now()),
('ff67da5e-4b26-09b9-7f62-d890b7a9dcc9', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tff67da5e4b2609b97f62d890b7a9dcc9$Iemanjá - Deusa das águas claras$tff67da5e4b2609b97f62d890b7a9dcc9$, $cff67da5e4b2609b97f62d890b7a9dcc9$Iemanjá, deusa das águas claras
Rainha das ondas, sereia do mar
Flores brancas na areia para lhe ofertar
Oh, mamãe sereia
Uma estrela no céu brilhou
As ondas na areia chegou
Levando as flores pro mar
Oh, Iemanjá
As ondas vieram buscar
As floresque eu vou lheofertar
Oh, Iemanjá
Oh, Iemanjá
As ondas vieram buscar
As floresque eu vou lhe ofertar
Oh, Iemanjá
Iemanjá Sobá
Oh, Iemanjá
Iemanjá Sobá
Oh, Iemanjá
Iemanjá Sobá
Oh, Iemanjá
Iemanjá Sobá$cff67da5e4b2609b97f62d890b7a9dcc9$, NULL, now()),
('7aa976fa-63ab-37e4-304d-4fdd8767dc63', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t7aa976fa63ab37e4304d4fdd8767dc63$Iemanjá - De frente para o mar$t7aa976fa63ab37e4304d4fdd8767dc63$, $c7aa976fa63ab37e4304d4fdd8767dc63$De frente para o mar
Eu fiza minha Oração
Meus pés descalços na areia
Sentindo a água sagrada da Mãe Sereia
Oh lua ilumine nesse momento
A força das água e meus Pensamentos
Oh lua ilumine nesse momento
A força das água e meus Pensamentos$c7aa976fa63ab37e4304d4fdd8767dc63$, NULL, now()),
('dd917022-00e1-efa0-d1ae-229fd54b565a', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tdd91702200e1efa0d1ae229fd54b565a$Rainha das ondas, sereia do mar$tdd91702200e1efa0d1ae229fd54b565a$, $cdd91702200e1efa0d1ae229fd54b565a$A mãe veio me avisar
Olha lá
As águas bailam sem parar
E o mar
Em todo o seu esplendor
Vem fazer
Eu compreender o que é o amor$cdd91702200e1efa0d1ae229fd54b565a$, NULL, now()),
('9cf81687-0a0f-834f-5176-aaf9fe02d7a5', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t9cf816870a0f834f5176aaf9fe02d7a5$Iemanjá - Canto da sereia$t9cf816870a0f834f5176aaf9fe02d7a5$, $c9cf816870a0f834f5176aaf9fe02d7a5$O vento embala as ondas
E as ondas embalam o mar
A onda quebra na areia
Pra trazer Iemanjá
Olha o canto da sereia
Formosa elaé
Salve a dona do mar
Que renova a minha fé
Vem cantar nesse terreiro
Vem seus filhosabençoar
Salve dona Janaína, a rainha Iemanjá
Tem bailardas ondas
Lua vem enfeitar
Salve a coroa dela
Feitade estrela do mar$c9cf816870a0f834f5176aaf9fe02d7a5$, NULL, now()),
('a412a9b7-ee9d-3a89-d2eb-388dc2f94f19', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $ta412a9b7ee9d3a89d2eb388dc2f94f19$Iemanjá - Maré cheia$ta412a9b7ee9d3a89d2eb388dc2f94f19$, $ca412a9b7ee9d3a89d2eb388dc2f94f19$Iemanjá, Odoyá! Canta fortepra sereia
que eu quero ver ela cantar
Odoyá, Iemanjá! Salve o canto da sereia
que faz a maré cheia baixar ref
Salve as cores do seu manto, o azul celestial
Salve esse povo de branco que está na areia a cantar
Canta forte,canta alto,pra sereia encantar
hoje é noitede lua cheia e tem maré cheia no mar
ref
Iemanjá ouça meu canto, estou aqui pra lhe falar
no meu peito a maré cheia tá querendo transbordar
Não importa quantos prantos, quantas dores à curar
Iemanjá é mãe sereia que faz a maré cheia baixar
ref$ca412a9b7ee9d3a89d2eb388dc2f94f19$, NULL, now()),
('ff7c609d-5e1e-b0a4-4a81-83e2985deef9', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tff7c609d5e1eb0a44a8183e2985deef9$Iemanjá - No fundo do mar é ouro só$tff7c609d5e1eb0a44a8183e2985deef9$, $cff7c609d5e1eb0a44a8183e2985deef9$Iemanjá é a rainha do mar
eo povo d'água é linha de força maior
Afirma ponto mamãe. Afirma ponto mamãe
que no fundo do mar é ouro só,é ouro só
Eu via mamãe sereia sentada à beira mar
pedindo para seus filhosa proteção de Oxalá$cff7c609d5e1eb0a44a8183e2985deef9$, NULL, now()),
('b230abf1-3081-33ad-4cf6-ad2fd545c4ed', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tb230abf1308133ad4cf6ad2fd545c4ed$Iemanjá - Som das Águas$tb230abf1308133ad4cf6ad2fd545c4ed$, $cb230abf1308133ad4cf6ad2fd545c4ed$É no som das águas do mar
Que eu vou lheofertar
É no som das águas
Que vem vindo Iemanjá
É no som das água do mar
Que eu vou ofertar
A rainhasereia
Que dança na areia
Mãe dos Orixás
Seu retratona areia
Revela a sereia
Começa a cantar
E éno bailardas Ondas
Que vem vindo Iemanjá$cb230abf1308133ad4cf6ad2fd545c4ed$, NULL, now()),
('11d89684-a4da-884e-3b1c-785102b29892', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t11d89684a4da884e3b1c785102b29892$Subida de Iemanjá - O navio apitou$t11d89684a4da884e3b1c785102b29892$, $c11d89684a4da884e3b1c785102b29892$O navio apitou
vaide mar afora
O navio apitou
vaide mar afora
énossa Mãe Iemanjá
que jávai embora
énossa Mãe Iemanjá
que jávai embora$c11d89684a4da884e3b1c785102b29892$, NULL, now()),
('99e75b59-0139-04a3-e952-c9c6f4c3b1c3', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t99e75b59013904a3e952c9c6f4c3b1c3$Iemanjá - Não chore filho de umbanda$t99e75b59013904a3e952c9c6f4c3b1c3$, $c99e75b59013904a3e952c9c6f4c3b1c3$Não chore filhode Umbanda
não chore que aqui estou
para cobrirte com meu manto
ealiviarsua dor
Eu vou correr a minha gira
epedir ao povo do mar
para livrartedas mirongas
na féde pai Oxalá
ômironguê, ô mirongá
aUmbanda gira,deixe a gira girar$c99e75b59013904a3e952c9c6f4c3b1c3$, NULL, now()),
('b65c8404-ef28-f75a-c989-00ad17159092', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tb65c8404ef28f75ac98900ad17159092$Iemanjá - Iemanjá Sobá - Mãe das águas$tb65c8404ef28f75ac98900ad17159092$, $cb65c8404ef28f75ac98900ad17159092$Oh! mãe das águas
filhade Obatalá
venha de Aruanda, venha verseus filhos
vem nos ajudar
Mãe Iemanjá Sobá
Mãe Iemanjá Sobá
vem de aruanda minha mãe
nos abençoar
PaiOxalá mandou, ô ô ô (4X)
Minha mãe Sereia
rainha do mar
olha nossa Umbanda
peça por seus filhos,perante Oxalá$cb65c8404ef28f75ac98900ad17159092$, NULL, now()),
('d3c9a5b0-aaaa-165d-edd3-48fc5134c2df', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $td3c9a5b0aaaa165dedd348fc5134c2df$Iemanjá - Cuida desse filho teu$td3c9a5b0aaaa165dedd348fc5134c2df$, $cd3c9a5b0aaaa165dedd348fc5134c2df$Iemanjá, Iemanjá
Iemanjá, Iemanjá
Odoci yaba, odoci yaba (2x)
Piso em suas águas sagradas
Para lavar as minhas mágoas (2x)
Acredito no poder da geração
Para curar meu coração (2x)
Cuida desse filhoteu
Que o meu amor é seu (2x)$cd3c9a5b0aaaa165dedd348fc5134c2df$, NULL, now()),
('370bcadf-c2ce-8c56-d493-cfebad4a8f32', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t370bcadfc2ce8c56d493cfebad4a8f32$Iemanjá - Um Presente dos Orixás$t370bcadfc2ce8c56d493cfebad4a8f32$, $c370bcadfc2ce8c56d493cfebad4a8f32$Hoje, hoje eu vou cantar (Hoje eu vou cantar)
Vou louvar na areia
Em lua cheia minha mãe Iemanjá (iê iê)(2x)
Rosa do Mar
Minha estrelado céu azul
Não é históriade pescador
Que meu amor eu vou lhe entregar (iê iê)(2x)
Um Presente dos Orixás
Deixa, deixa as ondas do mar passar
Ouça o canto da bela Odoya
Oxalá quem mandou um grande amor
Do fundo do mar (Ieie) (2x)$c370bcadfc2ce8c56d493cfebad4a8f32$, NULL, now()),
('c896ff8e-60b5-64d5-94d2-efd33e5105c1', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tc896ff8e60b564d594d2efd33e5105c1$Iemanjá - Ciranda para Iemanjá$tc896ff8e60b564d594d2efd33e5105c1$, $cc896ff8e60b564d594d2efd33e5105c1$Seu colar e de Conchas
seu vestido se arrasta na areia
elatem cheiro de mar
elasabe cantar cantos de sereias
O Janaína quando estou felizeu choro
O Janaína deixa eu dormir no seu colo (2x)
É nesse colo que eu afogo a minha sede
Quis te pescar mas eu caí na sua rede
feitade fiose cabelos emaranhados
moro no mar e hoje sou seu namorado
O Janaína quando estou felizeu choro
O Janaína deixa eu dormir no seu colo (2x)$cc896ff8e60b564d594d2efd33e5105c1$, NULL, now()),
('b1849447-ab75-9a08-167f-2e98665b4a31', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tb1849447ab759a08167f2e98665b4a31$Iemanjá - A Lua e o Sol$tb1849447ab759a08167f2e98665b4a31$, $cb1849447ab759a08167f2e98665b4a31$O Sol brilha na cachoeira
A Lua brilha no mar
Lua refletenela e fazela cantar
Sol aquece ela a filhado Cantoá
A noite é das estrelas
O dia faz agente pensar
A Lua é da sereia
O Sol pra quem cedo acordar
Oraieieou !Adociá !
Oraieieou mamãe Oxum e Iemanjá !
Oraieieou !Adociá !
Salve a Sereia e a mãe Oxum do Cantoá
Salve minha mamãe Oxum e Iemanjá$cb1849447ab759a08167f2e98665b4a31$, NULL, now()),
('3520b7d6-aefd-829d-48ea-9831875a2b0e', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t3520b7d6aefd829d48ea9831875a2b0e$Iemanjá - Estrela do mar$t3520b7d6aefd829d48ea9831875a2b0e$, $c3520b7d6aefd829d48ea9831875a2b0e$Iemanjá Estrela do Mar!
Luz que está em meus caminhos
Hoje o meu destino eu vou lhe entregar
Em suas mãos
Hoje eu vou me entregar
A minha Yabá
Hoje eu vou me entregar
Em suas mãos
Hoje eu vou me entregar
A minha Yabá
Iemanjá mãe sereia
Guia da minha embarcação
Faça eu pisar na areia
Pois o meu destino está em suas mãos
Seja no clarão da Lua
Ou pelo Calor do Sol
De janeiro a dezembro
Não há sofrimento, poiseu vou me entregar
Em suas mãos
Hoje eu vou me entregar
A minha Yabá
Hoje eu vou me entregar
Em suas mãos
Hoje eu vou me entregar
A minha Yabá...$c3520b7d6aefd829d48ea9831875a2b0e$, NULL, now()),
('42695aba-2eb8-1283-da77-7bea0d7a20fd', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t42695aba2eb81283da777bea0d7a20fd$Iemanjá - Lindo toque do tambor$t42695aba2eb81283da777bea0d7a20fd$, $c42695aba2eb81283da777bea0d7a20fd$Estou ouvindo o lindotoque do tambor
élouvação a Iemanjá com muito amor
ôyaô !Iemanjá!
que todo amor vem de Oxalá
ôyaô !Iemanjá!
que toda dor leva pro mar$c42695aba2eb81283da777bea0d7a20fd$, NULL, now()),
('1f548d1b-ed93-180d-bac6-027aeb3fce3c', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t1f548d1bed93180dbac6027aeb3fce3c$Iemanjá - Ao entardecer$t1f548d1bed93180dbac6027aeb3fce3c$, $c1f548d1bed93180dbac6027aeb3fce3c$Ao entardecer
em sua areia,ireipisar
vou agradecer ao céu
vou agradecer ao mar
Da areia do mar, da areia do mar
da areia, minha mãe Iemanjá
Em seu barquinho
oferendas para lhe ofertar
coberto de rosas brancas
juntos vão os pedidos
oh! rainha do mar
Da areia do mar, da areia do mar
da areia minha mãe Iemanjá$c1f548d1bed93180dbac6027aeb3fce3c$, NULL, now()),
('8308e2a5-c656-21bf-a8c2-7d33e548ee35', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t8308e2a5c65621bfa8c27d33e548ee35$Iemanjá - Rainha do mar$t8308e2a5c65621bfa8c27d33e548ee35$, $c8308e2a5c65621bfa8c27d33e548ee35$Ela é a dona das ondas
Ela é a rainha do mar
Odoyá Iemanjá
o terreirose ilumina
pra Iemanjá chegar
trazendo sua magia
sua bênção vem nos dar
o seu lindo manto azul
é a força que nos guia
aos caminhos da bondade
pra crescer a dada dia
Odoyá Iemanjá
Fim de ano levo flores
para lhe presentear
lheencontro minha mãe
de joelhos à beira mar
navegando vai seu barquinho
carregando minha oração
caminhando na areia fui
cantando com emoção
Odoyá Iemanjá$c8308e2a5c65621bfa8c27d33e548ee35$, NULL, now()),
('aeeb29aa-073c-3ee8-6f36-d2b4c11055a0', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $taeeb29aa073c3ee86f36d2b4c11055a0$Iemanjá - Pescador$taeeb29aa073c3ee86f36d2b4c11055a0$, $caeeb29aa073c3ee86f36d2b4c11055a0$Ando na areia, olho pro mar
ouço a sereia cantando alegre pra mãe Iemanjá
Nas profundezas do mar azul
arraias bailando
cardumes, corais
Tem mistério e magia
é encanto Divino
os golfinhos brincando
Oh! que reino tão lindo
E lána praia,pescador chorou
ôooo...
sua rede vazia ao ver lamentou
de joelhos faz uma oração
Oh rainha das águas
solução pra minha vida!
Eu sou seu filho,venha me socorrer
minha familia,minha espera
a pesca é o sustento pra sobreviver
Iemanjá...
com seu manto sagrado abençoou
pescador tão felizpro seu larvoltou
sua pesca foifarta ele comemorou
Finalfelizde uma história
de amor e devoção
de um homem que carrega a fé em seu coração$caeeb29aa073c3ee86f36d2b4c11055a0$, NULL, now()),
('9a803209-5041-995b-c6d9-44973f1e2c40', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t9a8032095041995bc6d944973f1e2c40$Iemanjá - Festa no mar$t9a8032095041995bc6d944973f1e2c40$, $c9a8032095041995bc6d944973f1e2c40$Retire a jangada do mar
mãe d'água mandou avisar
que hoje não pode pescar
pois hoje tem festa no mar
ieie ieie ieie Iemanjá
elaé, ela é a rainha do mar
Traz pente, traz espelho, ô ô, ô ô
pra ela se enfeitar ô ô,ô ô
trazflores, trazperfume
enfeitatodo o mar$c9a8032095041995bc6d944973f1e2c40$, NULL, now()),
('418a2dfc-ed55-e2ff-0a93-fe0fd648b5ef', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t418a2dfced55e2ff0a93fe0fd648b5ef$Iemanjá - Pedido na areia$t418a2dfced55e2ff0a93fe0fd648b5ef$, $c418a2dfced55e2ff0a93fe0fd648b5ef$Eu escrevi um pedido na areia
Pedindo a Zambi pra me socorrer
Eu escrevi um pedido na areia
Mas foiMãe D'água que veio me valer
E foinas ondas do Mar
Que entreguei os meus problemas
E aprendi a confiar
Que todo mal não dura para sempre
E que a paz é uma semente que precisa semear
E no horizonte de um mar tão infinito
Iemanjá me acolheu e meu deu um mundo tão mais bonito
Eu abri meu coração, ela me estendeu a mão
E entreguei meu caminhar, a Iemanjá$c418a2dfced55e2ff0a93fe0fd648b5ef$, NULL, now()),
('d50424ca-3975-38b2-c5dd-404f0736d904', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $td50424ca397538b2c5dd404f0736d904$Iemanjá - Rainha sereia do mar$td50424ca397538b2c5dd404f0736d904$, $cd50424ca397538b2c5dd404f0736d904$Brilhao sol
canta o rouxinol
eu olho céu e o infinito
aonde o azulé bonito
eu saravá Oxalá
Rios,montes e cascatas
eu olho o verde das matas
sintoa paz que a natureza trás
laiá,laiá
eo mar com sua grandeza
seu poder, sua beleza
eu imploro à iemanjá
ôMãe d'água, rainha Sereia do mar
segura a banda, ilumina esse congá$cd50424ca397538b2c5dd404f0736d904$, NULL, now()),
('a7dd961c-2401-1467-9a06-1fd7ecc54d67', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $ta7dd961c240114679a061fd7ecc54d67$Iemanjá - É ouro só$ta7dd961c240114679a061fd7ecc54d67$, $ca7dd961c240114679a061fd7ecc54d67$Iemanjá é a rainha do mar
eo povo d'água
élinha de força maior
afirma ponto mamãe
afirma ponto mamãe
que no fundo do mar
éouro só,é ouro só
eu via mamãe Sereia
sentada à beira mar
pedindo para seus filhos
aproteção de Oxalá$ca7dd961c240114679a061fd7ecc54d67$, NULL, now()),
('c6952047-84fe-b12c-161a-778ac29385c4', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tc695204784feb12c161a778ac29385c4$Iemanjá - Como ela nada$tc695204784feb12c161a778ac29385c4$, $cc695204784feb12c161a778ac29385c4$Iemanjá, senhora das águas, rainha do mar
Iemanjá, minha mãe sereia venha me ajudar
como ela nada sereia, como ela nada sereia
levando o mal pro fundo do mar$cc695204784feb12c161a778ac29385c4$, NULL, now()),
('0ba81821-5a87-d6e6-c458-9acbc2b922d4', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $t0ba818215a87d6e6c4589acbc2b922d4$Iemanjá -Vou levar seu presente no mar$t0ba818215a87d6e6c4589acbc2b922d4$, $c0ba818215a87d6e6c4589acbc2b922d4$ieIemanjá
eu vou levarseu presente no mar, eu vou levar [4x]$c0ba818215a87d6e6c4589acbc2b922d4$, NULL, now()),
('dbe213b8-0c95-b39e-2ff9-802e225b4069', 'a8f987ed-6b8e-a6d7-3d59-f1853ab2e8e5', $tdbe213b80c95b39e2ff9802e225b4069$Iemanjá -Dizem que a sereia quando canta$tdbe213b80c95b39e2ff9802e225b4069$, $cdbe213b80c95b39e2ff9802e225b4069$Dizem que a sereia quando canta
levao pescador para o fundo do mar [2x]
oh não me leve oh sereia
oh não me leve oh sereia
oh não me leve oh sereia
para o fundo do mar [2x]$cdbe213b80c95b39e2ff9802e225b4069$, NULL, now()),
('f584340a-84ba-db21-23ce-66230767b9a1', 'b92d98f8-159a-c815-271e-0c44a053ff02', $tf584340a84badb2123ce66230767b9a1$Logun Edé - No Toque do Aguerê$tf584340a84badb2123ce66230767b9a1$, $cf584340a84badb2123ce66230767b9a1$No toque do aguerê
Na nação de ijexá
Trazendo o irukerê
Logun ê ê á
Eleé Logun Edé
Um grande Orixá
filhodeOxum ilé
Logun ê ê á
Aê abaissá
Logun ê ê ê ê
Aê abaissá
Logun ê ê á
Aê abaissá
Logun ê ê ê ê
Aê abaissá
Logun ê ê á
Oxum achou por bem
Logun disfarçar
Para Xangô velho monarca
Poder enganar
Seis meses com Oxóssi
Seis meses com Oxum
Vive esse Orixá
Seu filhoLogun
Aê abaissá
Logun ê ê ê ê
Aê abaissá
Logun ê ê á
Aê abaissá
Logun ê ê ê ê
Aê abaissá
Logun ê ê á$cf584340a84badb2123ce66230767b9a1$, NULL, now()),
('4fad23fa-6b39-64cf-9ed5-80649b178b72', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t4fad23fa6b3964cf9ed580649b178b72$Mãe Nanã Buruquê$t4fad23fa6b3964cf9ed580649b178b72$, $c4fad23fa6b3964cf9ed580649b178b72$É amais velha Yabá
Fonte de amor ebem querer
Dela são as águas mais profundas
Mãe Nanã Buruquê
Antes do Mundo como vemos
Desde opoder da criação
(2x)
Quando Nanã “pisou”na Terra
PaiOxalá lhedeu a mão
(2x)Ô...Saluba, Nanã! Mãe Nanã Buruquê!$c4fad23fa6b3964cf9ed580649b178b72$, NULL, now()),
('72fbc259-b1ed-be14-b9e0-40479fa42aa8', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t72fbc259b1edbe14b9e040479fa42aa8$Subida Nanã Buruquê - Ela vai embora$t72fbc259b1edbe14b9e040479fa42aa8$, $c72fbc259b1edbe14b9e040479fa42aa8$Elavai embora
vaiserenar
Os anjos do céu
équem vão levar
Elavai embora
vaiserenar
Os anjos do céu
équem vão levar
…
Elafoiembora
foiserenar
Os anjos do céu
équem foilevar$c72fbc259b1edbe14b9e040479fa42aa8$, NULL, now()),
('60c27db5-286a-a280-91be-dbce9bddea09', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t60c27db5286aa28091bedbce9bddea09$É Nanã é Nanã auê$t60c27db5286aa28091bedbce9bddea09$, $c60c27db5286aa28091bedbce9bddea09$É Nanã,
É Nanã éNanã auê
É Nanã,
É Nanã éNanã auê
Oh toma conta de mim, minha mãe
Oh toma conta de sua congá
Oh toma conta de mim, minha mãe
Oh toma conta de sua congá
É Nanã,
éNanã é Nanã auê
É Nanã,
éNanã é Nanã auê$c60c27db5286aa28091bedbce9bddea09$, NULL, now()),
('0f2cd167-0bdf-5814-d6c1-22de902673d5', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t0f2cd1670bdf5814d6c122de902673d5$São flores Nanã, são flores$t0f2cd1670bdf5814d6c122de902673d5$, $c0f2cd1670bdf5814d6c122de902673d5$São flores Nanã, são flores
são floresNanã Buruquê
São flores Nanã, são flores
são floresNanã Buruquê
São flores Nanã, são flores
do seu filhoObaluaiê
São flores Nanã, são flores
do seu filhoObaluaiê
Na hora de agonia
éele quem vem nos valer
Na hora de agonia
éele quem vem nos valer
Ele éseu filhoNanã
eleé meu Pai
eleé o Obaluaiê
Ele éseu filhoNanã
eleé meu Pai
eleé o Obaluaiê$c0f2cd1670bdf5814d6c122de902673d5$, NULL, now()),
('96bd1117-0827-77b5-48c2-7f7dfe6b7c09', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t96bd1117082777b548c27f7dfe6b7c09$Que barquinho é aquele$t96bd1117082777b548c27f7dfe6b7c09$, $c96bd1117082777b548c27f7dfe6b7c09$Que barquinho éaquele
que vem lá em alto mar
Que barquinho éaquele
que vem lá em alto mar
No letreiroele traz
que é de Nanã Saluba em seu jacutá
No letreiroele traz
que é de Nanã Saluba em seu jacutá$c96bd1117082777b548c27f7dfe6b7c09$, NULL, now()),
('80640b45-cba0-d4d1-8666-286492858a8e', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t80640b45cba0d4d18666286492858a8e$Ela é Nanã Buruquê$t80640b45cba0d4d18666286492858a8e$, $c80640b45cba0d4d18666286492858a8e$elaé Nanã
elaé Nanã Buruquê
elaé Nanã
elaé Nanã Buruquê
asua saia éroxa
asua casa é de sapê
asua saia éroxa
asua casa é de sapê$c80640b45cba0d4d18666286492858a8e$, NULL, now()),
('55e6d4dc-e2dc-acc0-462b-de0c05960e21', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t55e6d4dce2dcacc0462bde0c05960e21$Senhora Santana quando andou pelos montes$t55e6d4dce2dcacc0462bde0c05960e21$, $c55e6d4dce2dcacc0462bde0c05960e21$Senhora Santana
quando andou pelos montes
em cada casa ela deixava uma fonte
Senhora Santana
quando andou pelos montes
em cada casa ela deixava uma fonte
Senhora Santana
Senhora da Guia
Olhaiesses filhos
com Deus e a virgem Maria
Senhora Santana
Senhora da Guia
Olhaiesses filhos
com Deus e a virgem Maria$c55e6d4dce2dcacc0462bde0c05960e21$, NULL, now()),
('2c7e48e2-cd6b-5868-2cd7-683d3bcdd286', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t2c7e48e2cd6b58682cd7683d3bcdd286$Nanã auê, Nanã Buruquê$t2c7e48e2cd6b58682cd7683d3bcdd286$, $c2c7e48e2cd6b58682cd7683d3bcdd286$Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã, ela é fonte da vida
elaforça energia que está aminha ajudar
Nanã, ela é a esperança
no meu desespero onde eu vou procurar
Nanã, ela mostra ocaminho
da pureza e bondade que fácilencontrar
Afirma filhode Umbanda
que a mãe das mães ela vem saravá
Afirma filhode Umbanda
que a mãe das mães ela vem saravá
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã, ela minha fé
elaé uma luz que eu posso contar
Nanã, ela tem os seus filhos
que vem de Aruanda são grande orixás
Nanã, ela brilhano céu
eseu brilhoconstante brilhacom Oxalá
Afirma filhode Umbanda
que a mãe das mães ela vem saravá
Afirma filhode Umbanda
que a mãe das mães ela vem saravá
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê
Nanã auê, Nanã Buruquê$c2c7e48e2cd6b58682cd7683d3bcdd286$, NULL, now()),
('02a44d64-6d35-87f7-f0fb-f523232fd477', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t02a44d646d3587f7f0fbf523232fd477$Água minou lá no congá$t02a44d646d3587f7f0fbf523232fd477$, $c02a44d646d3587f7f0fbf523232fd477$O cachimno é de Nanã
água minou láno congá
auê, auê
água minou láno congá$c02a44d646d3587f7f0fbf523232fd477$, NULL, now()),
('dded528f-1b79-1407-0805-f6552028aeec', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tdded528f1b7914070805f6552028aeec$Olha a rosa como cheira$tdded528f1b7914070805f6552028aeec$, $cdded528f1b7914070805f6552028aeec$Olha a rosa como cheira
cheirou
Olha a rosa como cheira
cheirou praNanã Buruquê$cdded528f1b7914070805f6552028aeec$, NULL, now()),
('5c2c3fda-1ec5-3dfc-239e-8a9d8d465af7', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t5c2c3fda1ec53dfc239e8a9d8d465af7$Eu vi Nanã$t5c2c3fda1ec53dfc239e8a9d8d465af7$, $c5c2c3fda1ec53dfc239e8a9d8d465af7$Eu viNanã
sentada, na beira do poço
Senhora Santana
com seu manto roxo
DivinaNanã
venha, me ajudar
Eu viNanã eu vi
Senhora Santana Buruquê, Salubá
Eu viNanã eu vi
Senhora Santana Buruquê, Salubá$c5c2c3fda1ec53dfc239e8a9d8d465af7$, NULL, now()),
('a980d2e9-bfa3-fbf5-e7c2-353363aacf48', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $ta980d2e9bfa3fbf5e7c2353363aacf48$Nanã - Senhora Santana$ta980d2e9bfa3fbf5e7c2353363aacf48$, $ca980d2e9bfa3fbf5e7c2353363aacf48$Ê
salve Senhora Santana
salve Senhora Santana
salve Nanã Buruquê... (2x)
Ó Nanã
Ó Nanã
sinda das águas sagradas
rainha iluminada
cuida do meu caminhar...
Ó Nanã
Ó Nanã
que cuida da minha vida
me ama e me dá guarida
venha me abençoar...
Ê
salve Senhora Santana
salve Senhora Santana
salve Nanã Buruquê... (2x)$ca980d2e9bfa3fbf5e7c2353363aacf48$, NULL, now()),
('a50d7df6-e893-0b3c-3e18-3b5706b1db7f', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $ta50d7df6e8930b3c3e183b5706b1db7f$É de Nanã$ta50d7df6e8930b3c3e183b5706b1db7f$, $ca50d7df6e8930b3c3e183b5706b1db7f$É de Nanã, saluba salubá
É de Nanã, saluba salubá
É de Nanã, ê salubá...(2x)
Luz do amanhecer
Inícioda vida
É meu bem querer
É quem me da guarida
Me ensina a viver
Ê salubá...
Estenda asua mão
Senhora Santana
Me dê proteção
O seu filhote ama
Me traz sua paz
Ê salubá...
É de Nanã, saluba salubá
É de Nanã, saluba salubá
É de Nanã, ê salubá...$ca50d7df6e8930b3c3e183b5706b1db7f$, NULL, now()),
('6f55db56-24d1-e331-e9f9-85ad477d4172', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t6f55db5624d1e331e9f985ad477d4172$Cubra com véu, Nanã buruquê$t6f55db5624d1e331e9f985ad477d4172$, $c6f55db5624d1e331e9f985ad477d4172$Cubra com véu Nanã
Cubra com véu Nanã
Cubra com véu,Nanã buruquê
As chagas do seu filho
sóvocê quem pode ver
Eleentrou na mata
ea mata lhecurou
hojeé Orixá
que nos abençoou$c6f55db5624d1e331e9f985ad477d4172$, NULL, now()),
('aeac30a0-0c63-a636-e945-d51a749c99ff', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $taeac30a00c63a636e945d51a749c99ff$Nanã buruquê - Nascente de água pura$taeac30a00c63a636e945d51a749c99ff$, $caeac30a00c63a636e945d51a749c99ff$éda nascente que a água vem tão pura
eessa banda, Nanã buruquê segura
éa vovó que vem de vagarinho
com suas águas pra limparnossos caminhos
éda nascente que a água vem tão pura
eessa banda, Nanã buruquê segura
eu tenho fé,emuito quero saber
do orixá,mãe de Obaluaê$caeac30a00c63a636e945d51a749c99ff$, NULL, now()),
('f3019b6b-a26e-3fff-4d7b-6b0448dfc353', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tf3019b6ba26e3fff4d7b6b0448dfc353$Nanã Buruquê - A água é fria por que?$tf3019b6ba26e3fff4d7b6b0448dfc353$, $cf3019b6ba26e3fff4d7b6b0448dfc353$A água é friaporque?
asondas gemem por que?
Saravá Nanã
oh Nanã Buruquê$cf3019b6ba26e3fff4d7b6b0448dfc353$, NULL, now()),
('7f2cb623-fafc-9ea5-05ac-f49c5a3ea388', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t7f2cb623fafc9ea505acf49c5a3ea388$Nanã Buruquê - Negra da Costa$t7f2cb623fafc9ea505acf49c5a3ea388$, $c7f2cb623fafc9ea505acf49c5a3ea388$Negra da Costa
O que trazem seu balaiopra vender?
Elatrazacarajé
Com azeitede dendê -2x
Que Nanã auê
Que Nanã auá
Que Nanã auê
É Nanã de Buruquê - 2x
Essa banda Nanã Buruque segura$c7f2cb623fafc9ea505acf49c5a3ea388$, NULL, now()),
('f65df5b7-292b-9e25-629e-e06c24234476', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tf65df5b7292b9e25629ee06c24234476$Página6de 19$tf65df5b7292b9e25629ee06c24234476$, $cf65df5b7292b9e25629ee06c24234476$É dá nascente que a água vem tão pura
eessa banda Nanã Buruque segura
É aVovó que vem devagarinho
com suas águas pra limpar nossos caminhos
É dá nascente que a água vem tão pura
eessa banda Nanã Buruque segura
Eu tenho fé emuito quero saber
do Orixá mãe de Obaluaê$cf65df5b7292b9e25629ee06c24234476$, NULL, now()),
('636e25cb-daed-8a6e-4fd9-053f87311ca5', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t636e25cbdaed8a6e4fd9053f87311ca5$Nanã Buruque -Quando andava nos montes$t636e25cbdaed8a6e4fd9053f87311ca5$, $c636e25cbdaed8a6e4fd9053f87311ca5$Oh Nanã Buruque
quando andava nos montes
cada passo que dava
deixava uma fonte
Os anjinhos do céu
bebiam água nela
oh que água tãodoce Nanã
oh que água tãobela$c636e25cbdaed8a6e4fd9053f87311ca5$, NULL, now()),
('a3c75b46-7afe-cb69-9e65-8baf311a5a94', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $ta3c75b467afecb699e658baf311a5a94$Saravá Nanã, Nanã Buruque$ta3c75b467afecb699e658baf311a5a94$, $ca3c75b467afecb699e658baf311a5a94$A água é friapor que?
As ondas gemem por que?
Oh saravá Nanã$ca3c75b467afecb699e658baf311a5a94$, NULL, now()),
('94384574-13c1-2884-c737-44332f35019f', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t9438457413c12884c73744332f35019f$Nanã Buruque$t9438457413c12884c73744332f35019f$, $c9438457413c12884c73744332f35019f$Elaé a luz que ilumina meus caminhos
Elaé a força do meu caminhar
Elaé a estrelamais brilhanteque ilumina minha estrada
A vidainteira
éNanã é Nanã eê
É Nanã Buruquê
éNanã é Nanã eê
É Nanã Buruquê$c9438457413c12884c73744332f35019f$, NULL, now()),
('538c39e1-3ac9-8c26-2ce8-d9feeee0d2bf', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t538c39e13ac98c262ce8d9feeee0d2bf$Nanã - Velha Senhora$t538c39e13ac98c262ce8d9feeee0d2bf$, $c538c39e13ac98c262ce8d9feeee0d2bf$Velha senhora que domina a mina d'água
Me cura a mágoa,
A mãe da vida entardecer
Reza comigo
Num antigo canto banto
Tanto de calma
Faz a alma adormecer
Meu rumo, meu prumo, meu manacá
Iabá santa que encanta aquem lhe olhar
É vulto,neblina, é luar
Na bruma dos manguezais
É chuva que rega de amor
A florda lavanda lilás
É colo,guarida e a beleza...
Tingida nas cores de Oxumarê
Reflete aforça da natureza
Na mina lindada minha Sinda Buruquê
A benção, Nanã
Saluba ê
Que doce, Nanã
Embala ê
A minha alegria
É a de sempre ser dia
De te oferecer… camutuê
Escuta, Nanã
O meu dizer
A luzda manhã
É pra você
A primeira hora é da velha senhora
A benção, Nanã
Saluba ê
Que doce, Nanã
Embala ê
A minha alegriaé a de sempre ser dia de teoferecer... camutuê
Escuta, Nanã
O meu dizer
A luzda manhã
É pra você
A primeira hora é da velha senhora$c538c39e13ac98c262ce8d9feeee0d2bf$, NULL, now()),
('eab7f95b-6781-31a9-228c-017e79dbcf21', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $teab7f95b678131a9228c017e79dbcf21$Nanã - Cordeiro de Nanã$teab7f95b678131a9228c017e79dbcf21$, $ceab7f95b678131a9228c017e79dbcf21$Sou de Nanã ewá, ewá ewá ê...
Sou de Nanã ewá, ewá ewá ê...
Sou de Nanã ewá, ewá ewá ê...
Sou de Nanã ewá, ewá ewá ê...
Fuichamado de cordeiro,
Mas não sou cordeiro não
Preferificarcalado que falar elevar não
O meu silêncio é uma singela oração a minha santa de fé
Meu cantar
Vibram as forças que sustentam meu viver
Meu cantar é um apelo que eu faço a Nanã ê
Sou de Nanã ewá, ewá ewá ê...
Sou de Nanã ewá, ewá ewá ê...
Sou de Nanã ewá, ewá ewá ê...
Sou de Nanã ewá, ewá ewá ê...
O que peço no momento é silêncioe atenção
Quero contar sofrimento que passamos sem razão
O meu lamento se criou na escravidão, que forçado passei
Eu chorei, sofrias duras dores da humilhação
Mas ganhei, pois eu trazia Nanã ê no coração
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê
Sou de Nanã ewá, ewá ewá ê$ceab7f95b678131a9228c017e79dbcf21$, NULL, now()),
('d35cd502-89f8-8cf4-a14d-2f5e5126fe2a', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $td35cd50289f88cf4a14d2f5e5126fe2a$Nanã - Uma súplica a Nanã$td35cd50289f88cf4a14d2f5e5126fe2a$, $cd35cd50289f88cf4a14d2f5e5126fe2a$Eu vou louvar Nanã, eu vou louvar Nanã
Sua beleza refleteem toda manhã
Eu vou louvar Nanã, eu vou louvar Nanã
Com a esperança de paz num novo amanhã
Eu vou louvar Nanã, eu vou louvar Nanã
Sua beleza refleteem toda manhã
Eu vou louvar Nanã, eu vou louvar Nanã
Com a esperança de paz num novo amanhã
Me livreNanã dessa dor que eu carrego no peito
Eu não quero ser tolerado,
O meu povo pede respeito,
Respeito para praticaro amor e a união
Para fazer a caridade, àquele que busca por pão
Sem guerras por religião,
Buscamos um mundo melhor
Não existe melhor ou pior, porque Deus é um só
Nanã!
Eu vou louvar Nanã, eu vou louvar Nanã
Sua beleza refleteem toda manhã
Eu vou louvar Nanã, eu vou louvar Nanã
Com a esperança de paz num novo amanhã
Eu vou louvar Nanã, eu vou louvar Nanã
Sua beleza refleteem toda manhã
Eu vou louvar Nanã, eu vou louvar Nanã
Com a esperança de paz num novo amanhã
Vós que sois a dona da criação
Criea humanidade, sem discriminação
Lave as amarguras Nanã Buruquê
Retireo preconceito, nos ensine o bem a fazer
E antes que o ciclose encerre
E meu corpo para terra voltar
Plantarei asemente de paz por onde eu passar
E antes que o ciclose encerre
E meu corpo para terra voltar
Plantarei asemente de paz por onde eu passar
Nanã!
Eu vou louvar Nanã, eu vou louvar Nanã
Sua beleza refleteem toda manhã
Eu vou louvar Nanã, eu vou louvar Nanã
Com a esperança de paz num novo amanhã
Eu vou louvar Nanã, eu vou louvar Nanã
Sua beleza refleteem toda manhã
Eu vou louvar Nanã, eu vou louvar Nanã
Com a esperança de paz num novo amanhã$cd35cd50289f88cf4a14d2f5e5126fe2a$, NULL, now()),
('3deef256-3144-ef82-dce0-fd7ef57e2873', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t3deef2563144ef82dce0fd7ef57e2873$Nanã - Senhora do Poço$t3deef2563144ef82dce0fd7ef57e2873$, $c3deef2563144ef82dce0fd7ef57e2873$Ela é sinda
É Orixá
Senhora do poço
A mais velha iabá
Ela é sinda
É Orixá
Senhora do poço
A mais velha iabá
Ela é das águas salobras
E vem sempre nos valer
Ela é dona da chuva
Mãe de Obaluaê
Com seu manto roxo
Ilumina o meu viver
Senhora Sant'Anna
Salve Nanã Buruquê
Ela ésinda
É Orixá
Senhora do poço
A mais velha iabá
Ela ésinda
É Orixá
Senhora do poço
A mais velha iabá
Ela édas águas salobras
E vem sempre nos valer
Ela édona da chuva
Mãe de Obaluaê
Com seu manto roxo
Ilumina o meu viver
Senhora Sant'Anna
Salve Nanã Buruquê
Com seu manto roxo
Ilumina o meu viver
Senhora Sant'Anna
Salve Nanã Buruquê
Ela ésinda
É Orixá
Senhora do poço
A mais velha iabá
Ela ésinda
É Orixá
Senhora do poço
A mais velha iabá$c3deef2563144ef82dce0fd7ef57e2873$, NULL, now()),
('505cec1a-d4c1-d410-4562-076328698ed1', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t505cec1ad4c1d4104562076328698ed1$Nanã - A chegada da sinda mais velha$t505cec1ad4c1d4104562076328698ed1$, $c505cec1ad4c1d4104562076328698ed1$O mar estava bem calmo naquela manhã
Eu implorei à Oxalá
Que me dissesse o que eu queria saber
Sobre os encantos de Nanã Buruquê
E um raiode luz veio anunciar
A chegada da sinda mais velha
Senhora Santana de Pai Oxalá
A chegada da sinda mais velha
Senhora Santana de Pai Oxalá
Saluba, Nanã
Me leva nas ondas do mar
Senhora Santana, Nanã Buruquê
Me leva nas ondas do mar
Senhora Santana venha me valer
Me leva nas ondas do mar
Senhora Santana, Nanã Buruquê
Me leva nas ondas do mar
Senhora Santana venha me valer$c505cec1ad4c1d4104562076328698ed1$, NULL, now()),
('7e46be21-bc3f-001e-2ca9-d7f0ba45306c', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t7e46be21bc3f001e2ca9d7f0ba45306c$Nanã - Ponto de Nanã$t7e46be21bc3f001e2ca9d7f0ba45306c$, $c7e46be21bc3f001e2ca9d7f0ba45306c$Oxumarê me deu dois barajás
Na festa de Nanã Buruku
A velha deusa das águas
Quer munguzá
Seu ibirienfeitado com fitase búzios
Um ponto pra assentar
Mandou cantar
Ê saluba!
Ela vem no som da chuva
Dançando devagar seu Ijexá
Senhora da Candelária, yabá
Pra toda a sua nação Iorubá
Ela vem no som da chuva
Dançando devagar seu Ijexá
Senhora da Candelária, yabá
Pra toda a sua nação Iorubá
Oxumarê me deu dois barajás
Na festa de Nanã Buruku
A velha deusa das águas
Quer munguzá
Seu ibirienfeitado com fitase búzios
Um ponto pra assentar
Mandou cantar
Ê saluba!
Ela vem no som da chuva
Dançando devagar seu Ijexá
Senhora da Candelária, yabá
Pra toda a sua nação Iorubá
Ela vem no som da chuva
Dançando devagar seu Ijexá
Senhora da Candelária, yabá
Pra toda a sua nação Iorubá
Pra toda a sua nação Iorubá
Pra toda a sua nação Iorubá$c7e46be21bc3f001e2ca9d7f0ba45306c$, NULL, now()),
('6ed7a561-52f0-e850-1743-95aa07a4a16b', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t6ed7a56152f0e850174395aa07a4a16b$Nanã - Águas sagradas$t6ed7a56152f0e850174395aa07a4a16b$, $c6ed7a56152f0e850174395aa07a4a16b$Me lava Nanã, me lava
Com suas águas, Nanã, sagradas
Me lava Nanã, me lava
Com suas águas, Nanã, sagradas
Lave meus olhos para que eu possa ver
A luzdivina dos meus guias a me proteger
Lave meus ouvidos para que eu possa ouvir
Os ensinamentos de bons caminhos a seguir
Lave minha boca para que eu possa dizer
Mensagens de amor a quem precisa receber
Lave Nanã, o meu coração
Encha elede alegriae retirea aflição
Lave Nanã, o meu coração
Encha elede alegriae retirea aflição
Ô, Nanã Buruquê
As suas águas me dão forças pra vencer
Ô, Nanã Buruquê
Quero em suas águas uma bênção receber$c6ed7a56152f0e850174395aa07a4a16b$, NULL, now()),
('a06798d1-6560-d9d6-31d9-818e1159657d', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $ta06798d16560d9d631d9818e1159657d$Nanã - Na barra da sua saia$ta06798d16560d9d631d9818e1159657d$, $ca06798d16560d9d631d9818e1159657d$É Nanã, É Nanã auê
É Nanã, É Nanã Buruque
É Nanã, É Nanã auê
É Nanã, É Nanã Buruque
No rodar da sua saia,
Manda força pra nossa banda
Pros filhosque tanto lhe pedem
Nanã cortatoda a mironga
Na barra da sua saia,
Carrega filhode umbanda
Com suas águas sagradas
Descarrega nossa banda$ca06798d16560d9d631d9818e1159657d$, NULL, now()),
('0329a54e-29e0-9a53-4476-bc6d682cab85', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t0329a54e29e09a534476bc6d682cab85$Nanã Buruquê -Ponto de Nanã$t0329a54e29e09a534476bc6d682cab85$, $c0329a54e29e09a534476bc6d682cab85$Oxumarê me deu dois barajás
Pra festade Nanã
A velha deusa das águas
Quer mugunzá
Seu ibirienfeitado com fitase búzios
Um ponto pra assentar
Mandou cantar
Ê,Salubá!
Elavem no som da chuva
Dançando devagar seu ijexá
Senhora da Candelária, abá
Pra toda a sua nação Iorubá
Sou de Nanã euá, euá euá ê
Sou de Nanã euá, euá euá ê
Sou de Nanã euá, euá euá ê
Sou de Nanã euá, euá euá ê$c0329a54e29e09a534476bc6d682cab85$, NULL, now()),
('868a8a2d-221b-28b8-19d4-010edcdf6373', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t868a8a2d221b28b819d4010edcdf6373$Nanã Buruquê - Linda flor de Aruanda$t868a8a2d221b28b819d4010edcdf6373$, $c868a8a2d221b28b819d4010edcdf6373$Nanã, linda florde Aruanda
Mamãe mina
Viva Nanã Buruquê
Minha senhora, quanta glória heide receber
Meu caminho está florido
Enfeitado por mãe Buruquê
Sua coroa é linda demais
Tem floresbrancas dos jardinsdos Orixás
Viva Nanã, Senhora Santana
Traz luzpara esse mundo
Traz luzpara nossa Umbanda$c868a8a2d221b28b819d4010edcdf6373$, NULL, now()),
('e4e8bfbb-490f-adbd-3f45-06ab599e2c8e', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $te4e8bfbb490fadbd3f4506ab599e2c8e$Nanã - Luz do dia$te4e8bfbb490fadbd3f4506ab599e2c8e$, $ce4e8bfbb490fadbd3f4506ab599e2c8e$Nanã éluz do dia
Que vem clarear
É pedra de brilhantes
Que não se quebrará
Fontes murmurantes
Estrelasdo mar
Caminhos de rosas brancas oh!
Para Nanã passear$ce4e8bfbb490fadbd3f4506ab599e2c8e$, NULL, now()),
('e4fc31a9-9268-adcc-41c6-09b06a4349bc', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $te4fc31a99268adcc41c609b06a4349bc$Nanã Buruquê - Atraca Nanã$te4fc31a99268adcc41c609b06a4349bc$, $ce4fc31a99268adcc41c609b06a4349bc$Minha mãe é Nanã, cacurucaia, mãe mais velha da Umbanda
elavem chegando de Aruanda, para nos valer
ôô saluba, saluba Nanã Buruquê
elavem chegando com a forçadas águas
venhas nos valer!
Atraca,atraca Nanã, atraca, atraca
Atraca,atraca Nanã, nesse gongá$ce4fc31a99268adcc41c609b06a4349bc$, NULL, now()),
('e2e50a40-1e0c-ca42-dcf8-901e3bc80b4f', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $te2e50a401e0cca42dcf8901e3bc80b4f$Nanã - Mamãe mina$te2e50a401e0cca42dcf8901e3bc80b4f$, $ce2e50a401e0cca42dcf8901e3bc80b4f$Mamãe Mina, Nanã girou no meu gonguê
Mamãe Mina, Nanã afirmou meu mutuê
Mamãe Mina de cacurucaia aiê
Mamãe Mina segura camuto Nanã Buruquê$ce2e50a401e0cca42dcf8901e3bc80b4f$, NULL, now()),
('158baa11-8cc7-3f63-c3fe-b9d09e1dc70e', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t158baa118cc73f63c3feb9d09e1dc70e$Nanã Buruquê - Muito velha / Táta de Mina$t158baa118cc73f63c3feb9d09e1dc70e$, $c158baa118cc73f63c3feb9d09e1dc70e$éuma velha, muito velha
que vem lá da Urucaia
Ela se chama Nanã Buruquê
Ela se chama Nanã Buruquê$c158baa118cc73f63c3feb9d09e1dc70e$, NULL, now()),
('a3b5c176-f3d6-f494-7d16-f6ab450d5fc5', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $ta3b5c176f3d6f4947d16f6ab450d5fc5$Nanã Buruquê - Rezaram$ta3b5c176f3d6f4947d16f6ab450d5fc5$, $ca3b5c176f3d6f4947d16f6ab450d5fc5$Rezaram na terra para chover e o rioencher
Rezaram, na terraquente
só não rezaram pra Nanã Buruquê
éela quem traz achuva
achuva que molha a terra
que faz nascerem os rios
que correm sem parar
éela quem traz achuva
achuva que molha a terra
que faz nascerem os rios
que ligam a terra ao mar$ca3b5c176f3d6f4947d16f6ab450d5fc5$, NULL, now()),
('6966cbc7-0b09-9f8f-db49-7a76c41686ed', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t6966cbc70b099f8fdb497a76c41686ed$Nanã - São flores Nanã, são flores$t6966cbc70b099f8fdb497a76c41686ed$, $c6966cbc70b099f8fdb497a76c41686ed$São flores Nanã, são flores
são floresNanã Burukê
são floresNanã, são flores
do seu filhoObaluaê [2x]
Nas horas e agonía
elesempre vem valer
éseu filhoNanã, é meu pai
eleé Obaluaê
São flores Nanã, são flores
são floresNanã Burukê
são floresNanã, são flores
do seu filhoObaluaê [2x]
A Senhora Santana
éNanã Burukê
éseu filhoNanã, é meu pai
São Roque é Obaluaê$c6966cbc70b099f8fdb497a76c41686ed$, NULL, now()),
('299f5486-367c-72cb-d4bb-ca8f647898dd', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t299f5486367c72cbd4bbca8f647898dd$Nanã - Ela é Nanã Buruquê$t299f5486367c72cbd4bbca8f647898dd$, $c299f5486367c72cbd4bbca8f647898dd$Nanã Nanã
elaé Nanã Buruquê [2x]
asua saia é roxa
asua cinta é de sapê [2x]$c299f5486367c72cbd4bbca8f647898dd$, NULL, now()),
('1f9a4fd7-10a7-50e7-a7b8-9eebe4c1a1ae', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t1f9a4fd710a750e7a7b89eebe4c1a1ae$Nanã Buruquê - Atraca, atraca que aí vem Nanã$t1f9a4fd710a750e7a7b89eebe4c1a1ae$, $c1f9a4fd710a750e7a7b89eebe4c1a1ae$Atraca,atraca que aívem Nanã ê ê
Atraca,atraca que aívem Nanã ê á
Atraca,atraca que aívem Nanã ê ê
Atraca,atraca que aívem Nanã ê á
éNanã rainha do mar
éNanã mamãe Iemanjá
éNanã que vem saravá ê á
éNanã rainha do mar
éNanã mamãe Iemanjá
éNanã que vem saravá ê á$c1f9a4fd710a750e7a7b89eebe4c1a1ae$, NULL, now()),
('c12b44c7-3e0b-c85f-44d6-9a073f09013d', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tc12b44c73e0bc85f44d69a073f09013d$Nanã Buruque - Em busca da vitória$tc12b44c73e0bc85f44d69a073f09013d$, $cc12b44c73e0bc85f44d69a073f09013d$Sou filhoda senhora Nanã
oque eu façoagora
Tô no meio do caminho
em busca da vitória
Cacurucaia da nossa Umbanda
me põe no colo Nanã e me balança
Cacurucaia da nossa Umbanda
me põe no colo Nanã, sou uma criança$cc12b44c73e0bc85f44d69a073f09013d$, NULL, now()),
('f53119df-62e5-6533-5489-3c9b673e732f', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tf53119df62e5653354893c9b673e732f$Nanã Buruquê - Águas Sagradas$tf53119df62e5653354893c9b673e732f$, $cf53119df62e5653354893c9b673e732f$Me lava Nanã, me lava
com suas águas Nanã sagradas
Lave meus olhos para que eu possa ver
aluz divina,dos meus guias ame proteger
lavemeus ouvidos para que eu possa ouvir
os ensinamentos de bons caminhos a seguir
laveminha boca para que eu possa dizer
mensagens de amor a quem precisa receber
Lave Nanã o meu coração
encha ele de alegria e retirea aflição
ôNanã Buruquê
as suas águas me dão forças pra vencer
ôNanã Buruquê
quero em suas águas uma bênção receber$cf53119df62e5653354893c9b673e732f$, NULL, now()),
('ed40661c-6130-a51a-e95d-f29bb78858e2', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $ted40661c6130a51ae95df29bb78858e2$Nanã Buruque - É Nanã$ted40661c6130a51ae95df29bb78858e2$, $ced40661c6130a51ae95df29bb78858e2$éNanã, é Nanã auê
éNanã, é Nanã Buruquê
Ao rodar da sua saia
manda força pra nossa banda
pros filhosque tanto lhe pedem
Nanã cortatoda mironga
Na barra da sua saia
descarrega filhode Umbanda
com suas águas sagradas
descarrega nossa banda$ced40661c6130a51ae95df29bb78858e2$, NULL, now()),
('246a5992-49ef-ee38-1165-98defe82646a', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t246a599249efee38116598defe82646a$Nanã Buruquê - Velha senhora$t246a599249efee38116598defe82646a$, $c246a599249efee38116598defe82646a$Nanã cuida da minha vida
Nanã minha velha senhora
Nanã ê êNanã
Nanã minha Deusa encantada
suas águas me trazem a paz
oseu manto é forçade vida
éa luz do meu amanhecer
em seu colo me sinto criança
nos seus braços eu vou me acolher$c246a599249efee38116598defe82646a$, NULL, now()),
('33224fb4-b629-a59e-2bf3-fbca3714a689', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t33224fb4b629a59e2bf3fbca3714a689$Nanã Buruquê - Orixá da chuva$t33224fb4b629a59e2bf3fbca3714a689$, $c33224fb4b629a59e2bf3fbca3714a689$Orixá da chuva
que cai na serra
que viralama
fertilizaaterra
éNanã buruquê, saluba ê,
éNanã buruquê, saluba á
éNanã Buruquê,
senhora Santana venha nos valer
oprincípio da vida,
Nanã Buruquê é quem pode dizer
omistério da água,
osegredo da terra é Nanã Buruquê
éNanã buruquê, saluba ê,
éNanã buruquê, saluba á
éNanã Buruquê,
senhora Santana venha nos valer$c33224fb4b629a59e2bf3fbca3714a689$, NULL, now()),
('c880c6c3-b552-a6be-949d-bf48e4b24def', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tc880c6c3b552a6be949dbf48e4b24def$Nanã Buruquê - Salúba eu$tc880c6c3b552a6be949dbf48e4b24def$, $cc880c6c3b552a6be949dbf48e4b24def$ê....Salúba eu Nanã
Salúba eu Nanã
amãe dos orixás
ê....salúbaeu Nanã
salúba eu Nanã
avó de todos nós
Senhora da chuva
das águas profundas
senhora do poço
venha nos valer
com seu manto roxo
com sua casa de sapê
avó de Umbanda a mais velha orixá
éNanã Buruquê$cc880c6c3b552a6be949dbf48e4b24def$, NULL, now()),
('376b1ca8-3168-d1a3-3320-72387c4a6544', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t376b1ca83168d1a3332072387c4a6544$Nanã Buruque - Sublimes manhãs$t376b1ca83168d1a3332072387c4a6544$, $c376b1ca83168d1a3332072387c4a6544$Manhãs, sublimes manhãs dos meus dias
lindotodo o meu despertar
Nanã, oh! minha mãe como é bela a minha vida
Nanã, como é bom acordar e tever
sua bênção Nanã, minha mãe Nanã Buruquê
quando, em seu colo me deito
me sinto perfeito,em todo meu ser
oh!minha mãe Nanã que em todas manhãs eu possa lhe ver
Nanã, oh! Nanã Buruquê
sou ainda uma criança em manhã de esperança
com vontade de crescer$c376b1ca83168d1a3332072387c4a6544$, NULL, now()),
('5ba14c20-b018-ea03-7144-fab057a3995a', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t5ba14c20b018ea037144fab057a3995a$Nanã Buruquê - Senhora do céu$t5ba14c20b018ea037144fab057a3995a$, $c5ba14c20b018ea037144fab057a3995a$A chuva fina que cai sem parar
trása energia de Nanã Buruquê
elaé velhinha, é a mamãe de Obaluaiê
com sua saia roxa,devagarinho ela vem caminhando
cheia de fée pureza, os seus filhosela vaiabençoando
óNanã Buruquê,
peço a senhora que ilumine o meu viver
Saluba Nanã, minha senhora do céu
me dê proteção me cobrindo com seu véu$c5ba14c20b018ea037144fab057a3995a$, NULL, now()),
('db09d6e0-50c5-0f14-f99f-40a3992ddf22', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $tdb09d6e050c50f14f99f40a3992ddf22$Nanã - Se a minha mãe é saluba$tdb09d6e050c50f14f99f40a3992ddf22$, $cdb09d6e050c50f14f99f40a3992ddf22$se aminha mãe é Saluba
mas ela é o Orixá mais antigo do céu
Nanã ,Nanã Buruquê
quem é seu filho
agora que eu quero ver [2x]$cdb09d6e050c50f14f99f40a3992ddf22$, NULL, now()),
('9e2d7b77-9294-f55a-84bf-ff83d9a5ebf8', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t9e2d7b779294f55a84bfff83d9a5ebf8$Nanã - Eu vi uma senhora$t9e2d7b779294f55a84bfff83d9a5ebf8$, $c9e2d7b779294f55a84bfff83d9a5ebf8$eu viuma senhora
lána beira da lagoa
de longe jáse via
obrilho da sua coroa[2x]
eraNanã Buruquê
lavava o manto do seu filhoOxumarê [2x]$c9e2d7b779294f55a84bfff83d9a5ebf8$, NULL, now()),
('078d20cc-7f89-a864-1208-87799e02f622', '4f76dcef-433a-b1d1-b74b-cc24a54be4c6', $t078d20cc7f89a864120887799e02f622$Nanã - Cubra com véu Nanã$t078d20cc7f89a864120887799e02f622$, $c078d20cc7f89a864120887799e02f622$cubra com véu Nanã
cubra com véu Nanã
cubra com véu Nanã Buruquê
as chagas do seu filho
só asenhora pode ver [2x]
eleentrou nas matas
eas matas lhe curou
eleentrou nas matas
eas matas lhe curou
hojeé Orixá
eDeus abençou [2x]$c078d20cc7f89a864120887799e02f622$, NULL, now()),
('1ba41743-9571-1314-d8f1-3ae857a9a8e6', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t1ba4174395711314d8f13ae857a9a8e6$Obaluaê - Obaluaê é Bonitinho$t1ba4174395711314d8f13ae857a9a8e6$, $c1ba4174395711314d8f13ae857a9a8e6$Obaluaê é bonitinho
Eleé um velho imponente -2x
Acorda quem está dormindo
Levanta quem está doente - 2x
Obaluaê é o dono da casa
Obaluaê é o dono do mar
Obaluaê ê ê
Obaluaê é quem vai nos ajudar - 2x$c1ba4174395711314d8f13ae857a9a8e6$, NULL, now()),
('94b5e94b-5f0c-c5c3-637a-cd1c34db2a58', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t94b5e94b5f0cc5c3637acd1c34db2a58$Obaluaê - Força que me guia$t94b5e94b5f0cc5c3637acd1c34db2a58$, $c94b5e94b5f0cc5c3637acd1c34db2a58$Ó rei
Que governa o meu mundo
Senhor
Orixá da minha fé
Me cobre com sua palha
Me livrede todo mau
Na força do seu xaxará deixe o seu axé
Meu pai
Nunca me deixe sozinho
Senhor
És a força que me guia
Num campo com lindasflores
Na fé de pai Oxalá
Saudamos a sua coroa Obaluaê (atotô)
Atotô
Salve meu pai
Quem é seu filhobalança
Mais não cai (2x)$c94b5e94b5f0cc5c3637acd1c34db2a58$, NULL, now()),
('ce09f48b-fbc5-5ab4-fb23-e22730bcee6a', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tce09f48bfbc55ab4fb23e22730bcee6a$Obaluaê - Salve a palha do senhor$tce09f48bfbc55ab4fb23e22730bcee6a$, $cce09f48bfbc55ab4fb23e22730bcee6a$Eleé atotô
Eleé atotô
Eleé atotô
Atotô Obaluaê (2x)
Obaluaê me livrede toda maldade
Obaluaê sua palha é felicidade
Orixá da cura a quem devo lealdade
Na linha de umbanda ele prega a caridade
Obaluaê guerreiro de minha fé
Obaluaê deixe todo o seu axé
Para os seus filhoseleprega muito amor
Seu atotô, salve a palha do senhor...
Eleé atotô
Eleé atotô
Eleé atotô
AtotôObaluaê (2x)$cce09f48bfbc55ab4fb23e22730bcee6a$, NULL, now()),
('433b87d5-f65e-0322-ab89-13732e05a192', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t433b87d5f65e0322ab8913732e05a192$Obaluaê - Ele é Xapanã$t433b87d5f65e0322ab8913732e05a192$, $c433b87d5f65e0322ab8913732e05a192$Na pedra fria
No pé do morro
Dizem que mora
Um velho lá- 2x
Eleé curador
Eleé rezador
Eleé Xapanã
Elevai me curar -2x$c433b87d5f65e0322ab8913732e05a192$, NULL, now()),
('59b6ba22-9c12-84a9-77fb-3b0264e92ac0', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t59b6ba229c1284a977fb3b0264e92ac0$Essa casa é de Obaluaiê$t59b6ba229c1284a977fb3b0264e92ac0$, $c59b6ba229c1284a977fb3b0264e92ac0$Força sagrada que eu quero ver
forçasagrada de Obaluaiê
Força sagrada que eu quero ver
forçasagrada de Obaluaiê
A sua casa de pedras
toda coberta de sapê
aonde mora andorinha
écasa de Obaluaiê
tem magia tem mistério
tem mironga tem poder
nas paredes tem pipocas
enos cantos tem dendê
Essa casa é
de Obaluaiê
Essa casa é
de Obaluaiê
Essa casa é
de Obaluaiê
Essa casa é
de Obaluaiê$c59b6ba229c1284a977fb3b0264e92ac0$, NULL, now()),
('07a0bf4b-3140-7117-c75f-25ac23365eb6', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t07a0bf4b31407117c75f25ac23365eb6$Obaluaiê - Dizem que a Umbanda tem mironga$t07a0bf4b31407117c75f25ac23365eb6$, $c07a0bf4b31407117c75f25ac23365eb6$Dizem que aUmbanda tem mironga
se tem mironga táde baixo do gongá
Dizem que aUmbanda tem mironga
se tem mironga táde baixo do gongá
látem mel, látem dendê
látem floresde Obaluaiê
látem mel, látem dendê
látem floresde Obaluaiê$c07a0bf4b31407117c75f25ac23365eb6$, NULL, now()),
('044fc2ca-c31a-c658-b2e2-e50c4915874e', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t044fc2cac31ac658b2e2e50c4915874e$Eu vou chamar Obaluaiê$t044fc2cac31ac658b2e2e50c4915874e$, $c044fc2cac31ac658b2e2e50c4915874e$Casa caiada perdida lána mata
feitade barro com telhado de sapê
Casa caiada perdida lána mata
feitade barro com telhado de sapê
Eu vou chamar, para curar
eu vou chamar Obaluaiê
Eu vou chamar, para curar
eu vou chamar Obaluaiê$c044fc2cac31ac658b2e2e50c4915874e$, NULL, now()),
('c1acb77f-04da-9e85-3a9f-5dce518e90a1', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tc1acb77f04da9e853a9f5dce518e90a1$Obaluaê - Salve a Palha do Senhor$tc1acb77f04da9e853a9f5dce518e90a1$, $cc1acb77f04da9e853a9f5dce518e90a1$Atotô,Baluaê…
Salve a palha do senhor
Xaxará bateu na terraem seu louvor
Atotô,Baluaê…
Salve a palha do senhor
Xaxará bateu na terraem seu louvor
Atotô,Baluaê, salve a palha do senhor
Xaxará bateu na terraem seu louvor
Os filhosde Zambi hoje
Cantam zuelas em seu louvor
Zuelas que contam a história da palha
Que é sagrada ao senhor
ôôôôôôôô
A palha sagrada
Que cobre a luz de seu atotô
E os olhos dos homens
Jamais poderão ver a luz de atotô
Atotô,Baluaê, Atotô Baluaê
Atotô meu pai é Obaluaê
Atotô,Baluaê, Atotô Baluaê
Atotô meu pai é Obaluaê
O velho mais velho é dos Orixás
Que a terraganhou
A terrarezava seus filhoscantavam
Em seu louvor
ôôôôôôôô
A palha da costa enfeitar toda casa
Pra seu atotô
Seus filhoscantavam a zuela que um dia
A terrarezou
Atotô,Baluaê, salve a palha do senhor
Xaxará bateu na terraem seu louvor
Atotô,Baluaê, salve a palha do senhor
Xaxará bateu na terraem seu louvor$cc1acb77f04da9e853a9f5dce518e90a1$, NULL, now()),
('308089cc-0712-89b0-4279-c41a453a3c19', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t308089cc071289b04279c41a453a3c19$Obaluaê - Saravá, Seu Atotô$t308089cc071289b04279c41a453a3c19$, $c308089cc071289b04279c41a453a3c19$Seu Obaluaê
Vem na lei da Umbanda
Seu Obaluaê
Vem saudar a nossa banda
Seu Obaluaê
É o nosso Pai, é o nosso guia
Dentro dessa tenda
A sua luz irradia
É o Orixá maior
Orixá maior
Sua coroa é de rei
É de rei
Saravá, Seu Atotô
Ajuberô
Atotô,Obaluaê
É o Orixá maior
Orixá maior
Sua coroa é de rei
É de rei
Saravá, Seu Atotô
Ajuberô
Atotô,Obaluaê$c308089cc071289b04279c41a453a3c19$, NULL, now()),
('c11dfafe-7584-e860-d3e3-9f16989f1742', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tc11dfafe7584e860d3e39f16989f1742$Obaluaê - Povo do Ayê$tc11dfafe7584e860d3e39f16989f1742$, $cc11dfafe7584e860d3e39f16989f1742$Silêncio
Meu senhor está na terra
O sol em forma de orixá no terreiro baixou
Bradou seu ylá que zuniu feito a morte que berra
Canta povo do ayê
Salve meu paiatotô, atotô, Obaluaê
Canta povo do ayê
Salve meu paiatotô, atotô Obaluaê
Ogum trançou seu maryô com as palhas da costa
Que dançam ao sabor dos caprichos dos ventos de Oyá
Pros males e dores do mundo trazele a resposta
Segredo escondido na força do seu xaxará.
Derramei pipocas ao chão, preparei seu olubajé
Do preto e o branco das contas fizmeu abadá
Ogã retumbou no atabaque um canto de fé
Eu vimeu senhor embalado e trazendo axé
Ogã retumbou no atabaque um canto de fé
Eu vimeu senhor embalado e trazendo axé
É ele o senhor das doenças, da febre que consome
O filhoque vem encantado nas mãos de Nanã
Eu peço licença a Olorum pra dizer o seu nome
É Omolu, Obaluaê, meu paiXapanã
Eu peço licença a Olorum pra dizer o seu nome
É Omolu, Obaluaê, meu paiXapanã
Canta povo do ayê
Salve meu pai atotô, atotô,Obaluaê
Canta povo do ayê
Salve meu pai atotô, atotô,Obaluaê$cc11dfafe7584e860d3e39f16989f1742$, NULL, now()),
('ec077e07-d736-1607-7e5d-8b46ae6fdfe5', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tec077e07d73616077e5d8b46ae6fdfe5$Obaluaê - Os Caminhos de Atotô$tec077e07d73616077e5d8b46ae6fdfe5$, $cec077e07d73616077e5d8b46ae6fdfe5$Seu Atotô,
Olhai pelo mundo em que a praga reinou
Maré de doença se estabeleceu
O seu xaxará nos abençoou
A saúde meu senhor que deu
Olhai pelo mundo em que a praga reinou
Maré de doença se estabeleceu
O seu xaxará nos abençoou
A saúde meu senhor que deu
Me cobre com a palha meu Orixá,
A ti,
Bato cabeça em seu gongá,
Olhai por mim
Se eu perder fé me ajude a encontrar
O que eu perdi,
Senhor da terra só o senhor sabe
O que está por vir
Me cobre com a palha meu Orixá,
A ti,
Bato cabeça em seu gongá,
Olhai por mim
Se eu perder fé me ajude a encontrar
O que eu perdi,
Senhor da terra só o senhor sabe
O que está por vir
Seu Atotô,
Olhai pelo mundo em que a praga reinou
Maré de doença se estabeleceu
O seu xaxará nos abençoou
A saúde meu senhor que deu
Olhai pelo mundo em que a praga reinou
Maré de doença se estabeleceu
O seu xaxará nos abençoou
A saúde meu senhor que deu
Me cobre com a palha meu Orixá,
A ti,
Bato cabeça em seu gongá,
Olhai por mim
Se eu perder fé me ajude a encontrar
O que eu perdi,
Senhor da terra só o senhor sabe
O que está por vir
Me cobre com a palha meu Orixá,
A ti,
Bato cabeça em seu gongá,
Olhai por mim
Se eu perder fé me ajude a encontrar
O que eu perdi,
Senhor da terra só o senhor sabe
O que está por vir$cec077e07d73616077e5d8b46ae6fdfe5$, NULL, now()),
('2b12e44e-c587-6ffe-6779-84298793be87', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t2b12e44ec5876ffe677984298793be87$Obaluaê - Senhor das palhas$t2b12e44ec5876ffe677984298793be87$, $c2b12e44ec5876ffe677984298793be87$éObaluaê, é Obaluaê
Se você está sofrendo
num leitofrio,ecom dor
com pipoca e dendê
muita gente ele curou
Se seu corpo está ferido
enão pode mais suportar
peça proteção a ele
que ele vaite ajuda
éObaluaê, é Obaluaê
Tem o segredo da vida
do começo e do fim
oh meu Senhor das palhas!
tenha "muita dó" de mim
Na procissão das almas
que partem pro infinito
elevai mostrando à elas
outromundo mais bonito$c2b12e44ec5876ffe677984298793be87$, NULL, now()),
('3bcbe8c6-82e6-5340-24f6-08fadfb9b6fd', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t3bcbe8c682e6534024f608fadfb9b6fd$Obaluaê - Louvação à Pai Obaluaê, o Senhor da evolução$t3bcbe8c682e6534024f608fadfb9b6fd$, $c3bcbe8c682e6534024f608fadfb9b6fd$É elequem cura a gente
É o meu Orixá de frente
Meu pai,Obaluaê
É elequem cura a gente
É o meu Orixá de frente
Meu pai,Obaluaê
Salve o senhor das almas
Suas palhas são sagradas
Senhor da evolução
Sua força é divina
E conduz o meu viver
Atotô,Ajuberô
Meu paiObaluaê
É elequem cura a gente
É o meu Orixá de frente
Meu pai,Obaluaê
É elequem cura a gente
É o meu Orixá de frente
Meu pai,Obaluaê
Ê,ê, ê, ê, ê,ê
Meu pai Obaluaê
Ê,ê, ê, ê, ê,ê
Meu pai Obaluaê
Flores purificam almas
Pela fé e devoção
Casinha branca de sapê
É de terra o seu chão
Ajoelho, pai me abraça
Me envolve com sua magia
Essência meu peito invade
Como um solé o novo dia
É ele quem cura a gente
É o meu Orixá de frente
Meu pai,Obaluaê
É ele quem cura a gente
É o meu Orixá de frente
Meu pai,Obaluaê
Ê,ê, ê, ê, ê,ê
Meu pai Obaluaê
Ê,ê, ê, ê, ê,ê
Meu pai Obaluaê
Ê,ê, ê, ê, ê,ê
Meu pai Obaluaê
Ê,ê, ê, ê, ê,ê
Meu pai Obaluaê$c3bcbe8c682e6534024f608fadfb9b6fd$, NULL, now()),
('583ad709-7d7a-dd9c-f019-c8ce7322cb48', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t583ad7097d7add9cf019c8ce7322cb48$Obaluaê - As flores do meu velho$t583ad7097d7add9cf019c8ce7322cb48$, $c583ad7097d7add9cf019c8ce7322cb48$Oh! Como é belo este jardim
Com lindas flores enfeitadas em buquê
Oh! Como é belo este jardim
Com lindas flores enfeitadas em buquê
São ofertadas de todo coração
Ao mestre Obaluaê
São ofertadas de todo coração
Ao mestre Obaluaê
As flores do meu velho
Atotô,meu pai
São lindas e cheirosas
Atotô,meu pai
As flores do meu velho
Atotô,meu pai
Também são milagrosas
Atotô,meu pai
As flores do meu velho
Atotô,meu pai
São lindas e cheirosas
Atotô, meu pai
As flores do meu velho
Atotô, meu pai
Também são milagrosas
Atotô, meu pai
Oh! Como é belo este jardim
Com lindas flores enfeitadas em buquê
Oh! Como é belo este jardim
Com lindas flores enfeitadas em buquê
São ofertadas de todo coração
Ao mestre Obaluaê
São ofertadas de todo coração
Ao mestre Obaluaê
As flores do meu velho
Atotô, meu pai
São lindas e cheirosas
Atotô, meu pai
As flores do meu velho
Atotô, meu pai
Também são milagrosas
Atotô, meu pai
As flores do meu velho
Atotô, meu pai
São lindas e cheirosas
Atotô, meu pai
As flores do meu velho
Atotô, meu pai
Também são milagrosas
Atotô, meu pai$c583ad7097d7add9cf019c8ce7322cb48$, NULL, now()),
('9cd19367-473e-eb2d-eee1-d1f9e951c501', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t9cd19367473eeb2deee1d1f9e951c501$Obaluaê - Meu pai Oxalá é o rei$t9cd19367473eeb2deee1d1f9e951c501$, $c9cd19367473eeb2deee1d1f9e951c501$Meu pai Oxalá
É o rei
Venha me valer
Meu pai Oxalá
É o rei
Venha me valer
O velho Omulu
Atotô, Obaluaê
O velho Omulu
Atotô, Obaluaê
Atotô, Obaluaê
Atotô, babá
Atotô, Obaluaê
Atotô, é orixá
Atotô, Obaluaê
Atotô, babá
Atotô, Obaluaê
Atotô, é orixá$c9cd19367473eeb2deee1d1f9e951c501$, NULL, now()),
('00f4a1b0-0b5e-814b-896d-6d761ee1222a', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t00f4a1b00b5e814b896d6d761ee1222a$Obaluaê - Oxalá é rei do mundo$t00f4a1b00b5e814b896d6d761ee1222a$, $c00f4a1b00b5e814b896d6d761ee1222a$Oxalá é rei do mundo!
Oxalá é meu senhor!
Omulu é o meu santo!
O meu santo protetor!
Oxalá é rei do mundo!
Oxalá é meu senhor!
Omulu é o meu santo!
O meu santo protetor!
Atotô!
Atotô!Atotô!
Atotô,Obaluaê!
Atotô!
Atotô!Atotô!
Atotô,Obaluaê!$c00f4a1b00b5e814b896d6d761ee1222a$, NULL, now()),
('ee736e88-fad2-4c65-3760-e780e57437bd', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tee736e88fad24c653760e780e57437bd$Obaluaê - Traga as pipocas$tee736e88fad24c653760e780e57437bd$, $cee736e88fad24c653760e780e57437bd$Traga as pipocas para ofertar
Obaluaê que vem lhe ajudar
Acredite que o sol voltará a brilhar
osenhor da terrapode lhe curar
Tenha esperança no seu coração
Ele é força!Ele é vida! é a solução!
Traga as pipocas para ofertar
Obaluaê que vem lhe ajudar
Nos dá proteção com as palhas sagradas
na calunga ele faza sua morada
Sua casinha branca é repleta de magia
sua bengala tem luzque nos irradia
Traga as pipocas para ofertar
Obaluaê que vem lhe ajudar$cee736e88fad24c653760e780e57437bd$, NULL, now()),
('73682a85-8d91-5d2e-becf-fe34245a6d3f', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t73682a858d915d2ebecffe34245a6d3f$Obaluaiê - Casa caiada$t73682a858d915d2ebecffe34245a6d3f$, $c73682a858d915d2ebecffe34245a6d3f$Casa caiada perdida lána mata
feitade barro, com telhado de sapê
Eu vou chamar para curar
Eu vou chamar Obaluaê$c73682a858d915d2ebecffe34245a6d3f$, NULL, now()),
('ecf62fbf-0458-6870-8855-cce6d4c4e218', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tecf62fbf045868708855cce6d4c4e218$Obaluaê - Rei das palhas$tecf62fbf045868708855cce6d4c4e218$, $cecf62fbf045868708855cce6d4c4e218$Saravá o reidas palhas
Aruanda está em flor
Para o filhode Nanã
Que Iemanjá criou
Auê meu pai,Atotô
Abaluaê é meu senhor
Auê meu pai,com seu xaxará
Aívem Abaluaê caminhando devagar
Saravá o reidas palhas
Pai da reza e da oração
Que no cruzeiro das almas
Cumpre a sua missão
Ele vem descendo a serra
Andando devagarinho
O velho é muito sábio, conhece bem o caminho
Auê meu pai, Atotô
Abaluaê é meu senhor
Auê meu pai, com seu xaxará
Aívem Abaluaê caminhando devagar$cecf62fbf045868708855cce6d4c4e218$, NULL, now()),
('0ddd2593-435a-d7b8-017c-e3077fcb8871', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t0ddd2593435ad7b8017ce3077fcb8871$Obaluaê - Fé no curador$t0ddd2593435ad7b8017ce3077fcb8871$, $c0ddd2593435ad7b8017ce3077fcb8871$Entreinuma mata fechada
Pois me disseram que lá morava um curador
Era coberto de palhas, o velho Obaluaê
Com um balaio de pipocas
Preparadas no dendê
Era coberto de palha, o velho Obaluaê
Com um balaio de pipocas
Com elas iame benzer
Atotô Atotô
Atotô meu pai
Quem tem fé na sua cura
As mazelas sempre saem$c0ddd2593435ad7b8017ce3077fcb8871$, NULL, now()),
('f8c2d3b4-f5b1-93b7-7ec7-77164b48c6ba', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tf8c2d3b4f5b193b77ec777164b48c6ba$Obaluaê - Eu sou Nagô$tf8c2d3b4f5b193b77ec777164b48c6ba$, $cf8c2d3b4f5b193b77ec777164b48c6ba$Obaluaê, eu sou
eu sou, eu sou Nagô 2x
Eu sou Nagô, eu sou curador
Tiroo feitiçode quem temandou$cf8c2d3b4f5b193b77ec777164b48c6ba$, NULL, now()),
('9ec8394e-a5de-3ca6-6c78-2da48652a6f3', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t9ec8394ea5de3ca66c782da48652a6f3$Obaluaiê - Povo do Ayê$t9ec8394ea5de3ca66c782da48652a6f3$, $c9ec8394ea5de3ca66c782da48652a6f3$Silêncio,meu Senhor está na terra
O sol em forma de orixá no terreirobaixou
Bradou seu iláque zuniu feitoa morte que berra!
(Canta povo do ayê
Salve meu pai Atotô
Atotô Obaluayê) bis
Ogum trança o seu mariô com as palhas da costa
Que dança ao sabor dos caprichos dos ventos de Oyá
Dos males e dores do mundo trazele a resposta
Segredo escondido na força do seu xaxará
Derramei pipocas ao chão
Preparei seu Olubajé
Com preto e o branco das contas, fizmeu abadá
(Ogã retumbou no atabaque um canto de fé.
Eu vimeu Senhor embalado trazendo axé.) bis
É eleSenhor das doenças da febre que consome
O filhoque veio encantado nas mãos de Nanã
(Eu peço licença a Olorum pra dizero seu nome!
É Omolu, Obaluayê, meu paiXapanã.) bis
(Canta povo do ayê
Salve meu paiAtotô
AtotôObaluayê) bis$c9ec8394ea5de3ca66c782da48652a6f3$, NULL, now()),
('69bd3c64-b9c4-de1f-bfdb-ba62a7682df6', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t69bd3c64b9c4de1fbfdbba62a7682df6$Obaluaê - Vem ver, vem ver meu velho$t69bd3c64b9c4de1fbfdbba62a7682df6$, $c69bd3c64b9c4de1fbfdbba62a7682df6$É de palha a roupa de meu pai
É de palha só
É cajado a arma de meu pai
É cajado só...(2x)
Vem ver,vem ver meu velho
Vem com eleaprender
Vem ver,vem ver meu velho
Meu paiObaluaê (2x)
Com ele não tem temporal
Nem distância,nem espinho
Pra cada dor que ele encontra
Tem cura e caminho
Enfrenta assim todo mal
Com muita sabedoria
O que precisa de tempo
Não muda da noitepro dia
Vem ver,vem ver meu velho
Vem com eleaprender
Vem ver,vem ver meu velho
Meu paiObaluaê (2x)$c69bd3c64b9c4de1fbfdbba62a7682df6$, NULL, now()),
('3939e9f0-7e4e-7e0b-c7a7-54ecaf4a3a44', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t3939e9f07e4e7e0bc7a754ecaf4a3a44$Obaluaiê - Se eu ver um velho no caminho$t3939e9f07e4e7e0bc7a754ecaf4a3a44$, $c3939e9f07e4e7e0bc7a754ecaf4a3a44$Se eu ver um velho no caminho eu tomo a bença
Se eu ver um velho no caminho eu tomo a bença
Deus te abençoe
Deus te abençoe
Deus te abençoe Obaluaê
Deus te abençoe [2x]$c3939e9f07e4e7e0bc7a754ecaf4a3a44$, NULL, now()),
('c3020950-6297-8ddd-f079-efed58d36df4', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tc302095062978dddf079efed58d36df4$Obaluaiê - Quem protege esse meu viver$tc302095062978dddf079efed58d36df4$, $cc302095062978dddf079efed58d36df4$Quem protege esse meu viver
émeu pai Obaluaê
émeu pai Obaluaê
Quem vaicuidar de mim quando eu morrer
émeu pai Obaluaê
émeu pai Obaluaê
Quem está presente na ausência da alegria
no mundo da magia me dá forças pra vencer
émeu pai Obaluaê
émeu pai Obaluaê
Quem dá a fé de esperar
esperança de sonhar
ea força de querer
émeu pai Obaluaê
émeu pai Obaluaê
Sou uma criança neste mundo de ilusão
mas segurando asua mão
eu nada tenho a temer
émeu pai Obaluaê
émeu pai Obaluaê
Sou tão felize enquanto eu viver
eu vou pedir a sua benção meu pai
sua benção meu pai Obaluaê
sua benção meu pai Obaluaê$cc302095062978dddf079efed58d36df4$, NULL, now()),
('227df9e6-2af1-adb1-562c-474083b1fe9f', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t227df9e62af1adb1562c474083b1fe9f$Obaluaiê - Morte é coisa séria$t227df9e62af1adb1562c474083b1fe9f$, $c227df9e62af1adb1562c474083b1fe9f$Morte é coisa séria
além da matéria
que se perdeu
eeu ?
Vou mais além
pro além
éonde que o bem
que a vida nos deu pra levar
éganhar abertura
multicolorida,nascer de uma vida
subir
burilar
égalgar pelos campos
talvezmeio azul
não ser preto nem branco
não ser qualquer um
éna morte que tudo é igual
tem valor
caminho de ida, não tem descida
só leva ao Senhor
Atotô Obaluaê
Atotô Obaluaê$c227df9e62af1adb1562c474083b1fe9f$, NULL, now()),
('61c056b5-eb7c-dd4c-3d2e-6ca21bce5967', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t61c056b5eb7cdd4c3d2e6ca21bce5967$Obaluaiê - Silêncio, Atotô$t61c056b5eb7cdd4c3d2e6ca21bce5967$, $c61c056b5eb7cdd4c3d2e6ca21bce5967$Silêncio
Atotô...Atotô...Atotô ooo… (2x)
Suas floressagradas são deborô
que limpam meu corpo e tiram a minha dor
Sua palha divina é seu ajê,
Orixá poderoso Obaluaiê
Silêncio
Atotô...Atotô...Atotô ooo… (2x)
Senhor da terra,
Senhor da vida,
Senhor da chaga,
Senhor da partida…
Seu nome santo
me faz refletir
da vida o que levo
e o que deixo aqui
Silêncio
Atotô...Atotô...Atotô ooo… (2x)$c61c056b5eb7cdd4c3d2e6ca21bce5967$, NULL, now()),
('877dc0f6-008e-b746-92e9-accdf745e3d5', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t877dc0f6008eb74692e9accdf745e3d5$Obaluaiê - Curador da Alma$t877dc0f6008eb74692e9accdf745e3d5$, $c877dc0f6008eb74692e9accdf745e3d5$De joelhos te peço maleime
Proteja seus filhosde fé
Entre as palhas seu mistério
És o senhor da terra
Acalmando a dor da alma
Com seu Xaxará em mãos
Xapanã é luz que guia
Vai seguindo sua missão
Atotô !Ajoberô !
Atotô !Ajoberô ! ( Bis)
Pés descalços na terra
Tiraa quizanga com a mão
Flordo velho, luz divina
Traz a cura pra qualquer irmão
Acalmando a dor da alma
Com seu Xaxará em mãos
Xapanã é luz que guia
Vai seguindo sua missão
Atotô! Ajoberô !
Atotô! Ajoberô.! (Bis)$c877dc0f6008eb74692e9accdf745e3d5$, NULL, now()),
('dd3b92fb-e4a0-c74d-5383-314732bef24c', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $tdd3b92fbe4a0c74d5383314732bef24c$Obaluaiê - Que homem é aquele / Atotô babá$tdd3b92fbe4a0c74d5383314732bef24c$, $cdd3b92fbe4a0c74d5383314732bef24c$Nesse mundo deserto
sem ter nada pra comer
cabacinha no ombro
sem ter nada pra beber
Mas que homem é aquele
atotôObaluaê
vem na féde Oxalá
atotôObaluaê
////////////////////////
atotôObaluaê
atotôObaluaê
atotôObaluaê, atotô babá$cdd3b92fbe4a0c74d5383314732bef24c$, NULL, now()),
('965d9d69-6ae0-e58e-1fc2-9192c8559648', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t965d9d696ae0e58e1fc29192c8559648$Obaluaiê - Omulu - Casinha Branca$t965d9d696ae0e58e1fc29192c8559648$, $c965d9d696ae0e58e1fc29192c8559648$Casinha branca, casinha branca
que eu mandei fazer
para oferecer ao meu paiOmulú
seu atotôObaluaiê
Salve minha mãe Oxum
Salve Nanã Buruquê
Seu atotô Obaluaiê$c965d9d696ae0e58e1fc29192c8559648$, NULL, now()),
('d77e252f-9826-601a-692d-32eb2a54a720', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $td77e252f9826601a692d32eb2a54a720$Obaluaiê - Força sagrada$td77e252f9826601a692d32eb2a54a720$, $cd77e252f9826601a692d32eb2a54a720$Força sagrada que eu quero ver
forçasagrada de Obaluaiê
A sua casa é de pedras
toda coberta de sapê
aonde mora a andorinha
éa casa de obaluaê
tem magia, tem mistério
tem mironga, tem poder
nas paredes tem pipoca
enos cantos tem dendê
Essa casa éde Obaluaiê
Obaluaiê - Se ver um velho no caminho - Atotô é orixá$cd77e252f9826601a692d32eb2a54a720$, NULL, now()),
('683740ef-67f3-96e2-73e9-05d20a17a6e8', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t683740ef67f396e273e905d20a17a6e8$Página16de 17$t683740ef67f396e273e905d20a17a6e8$, $c683740ef67f396e273e905d20a17a6e8$Se ver um velho no caminho peça a benção
Deus te abençõe, Deus teabençõe
Deus te abençõe, Obaluaiê Deus te abençõe
/////////////////////
Meu pai Oxalá é o reivenha nos valer
o velho Omulú, atotô Obaluaiê
atotô Obaluaiê, atotô babá
atotô Obaluaiê, atotô é orixá$c683740ef67f396e273e905d20a17a6e8$, NULL, now()),
('d3dc13ab-cabc-b0fd-7c3c-3b3413c8100d', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $td3dc13abcabcb0fd7c3c3b3413c8100d$Obaluaiê - Traga as pipocas$td3dc13abcabcb0fd7c3c3b3413c8100d$, $cd3dc13abcabcb0fd7c3c3b3413c8100d$Traga as pipocas para ofertar
Obaluaiê que vem lhe ajudar
Acredite que o sol voltará a brilhar
o senhor da terra pode lhe curar
tenha esperança no seu coração
eleé força, ele é vida, é a solução
Traga as pipocas para ofertar
Obaluaiê que vem lhe ajudar
Nos dá proteção com as palhas sagradas
na calunga ele faz a sua morada
sua casinha branca, é repleta de magia
sua bengala tem luz que nos irradia$cd3dc13abcabcb0fd7c3c3b3413c8100d$, NULL, now()),
('64821c7d-f617-4ee2-b6d6-0615855c53bc', 'fc694bba-8c71-f762-b0f3-705b93a5c8ad', $t64821c7df6174ee2b6d60615855c53bc$Obaluaiê - Sete anos no Deserto$t64821c7df6174ee2b6d60615855c53bc$, $c64821c7df6174ee2b6d60615855c53bc$Sete anos no deserto
sem ternada pra comer [2x]
com a sua cabacinha no ombro
mas sem ter água pra beber [2x]
mas ele é Atotô
Obaluaiê [2x]$c64821c7df6174ee2b6d60615855c53bc$, NULL, now()),
('107e055e-fb70-02fb-4ecb-9f7964f0e7a8', '733c52d2-4676-0982-e37c-e8ed27eb14cd', $t107e055efb7002fb4ecb9f7964f0e7a8$Obá - Mãe da Sabedoria$t107e055efb7002fb4ecb9f7964f0e7a8$, $c107e055efb7002fb4ecb9f7964f0e7a8$Akirô Obá yê -2x
Ó mãe da sabedoria
Venha nos valer
Clareia Obá yê -2x
Ó mãe da sabedoria
Venha nos valer
Concentrou os elementos
Gerou nova energia
Criou o conhecimento
Ó mãe da sabedoria
Akirô Obá yê -2x
Ó mãe da sabedoria
Venha nos valer
Clareia Obá yê -2x
Ó mãe da sabedoria
Venha nos valer
Ela é quem reveste a serra
Ela é quem sustenta o mar
É a rainha da Terra
Que se expande pelo ar
Akirô Obá yê -2x
Ó mãe da sabedoria
Venha nos valer
Clareia Obá yê -2x
Ó mãe da sabedoria
Venha nos valer$c107e055efb7002fb4ecb9f7964f0e7a8$, NULL, now()),
('6254810e-f891-a21c-0615-cec394935792', '733c52d2-4676-0982-e37c-e8ed27eb14cd', $t6254810ef891a21c0615cec394935792$Obá - Olha aquele passarinho$t6254810ef891a21c0615cec394935792$, $c6254810ef891a21c0615cec394935792$Olha aquele passarinho
Construiu seu ninho lá no reino de Obá
Como sua mãe, com muito carinho,
Concentrando a terraconstruiu seu lar.
Hoje ele é mestre do conhecimento
E com sabedoria pôde me ensinar
Pra que eu também construa o meu ninho
Nas terras sagradas de mamãe Obá.
Pra que eu também construa o meu ninho
Nas terras sagradas de mamãe Obá.
Olha aquele passarinho
Construiu seu ninho lá no reino de Obá
Como sua mãe, com muito carinho,
Concentrando a terraconstruiu seu lar.
Hoje ele é mestre do conhecimento
E com sabedoria pôde me ensinar
Pra que eu também construa o meu ninho
Nas terras sagradas de mamãe Obá.
Pra que eu também construa o meu ninho
Nas terras sagradas de mamãe Obá.$c6254810ef891a21c0615cec394935792$, NULL, now()),
('7bbb6cfd-8e50-a766-71b9-84d2336bfe68', '733c52d2-4676-0982-e37c-e8ed27eb14cd', $t7bbb6cfd8e50a76671b984d2336bfe68$Obá - Ponto de Obá$t7bbb6cfd8e50a76671b984d2336bfe68$, $c7bbb6cfd8e50a76671b984d2336bfe68$Que luztão linda clareou a mata
Iluminou e estremeceu a serra
Que luztão linda clareou a mata
Iluminou e estremeceu a serra
É mãe Obá vibrando sua espada
Semeando forças, fecundando a Terra
É mãe Obá vibrando sua espada
Semeando forças, fecundando a Terra
Mamãe Obá, akirôayê
Mãe do conhecimento
Mãe celeste do saber
Seiva divina que nos alimenta
AkirôObá, akirô Obá yê$c7bbb6cfd8e50a76671b984d2336bfe68$, NULL, now()),
('25f85017-9c88-3759-8ee5-17e795a7f4c4', '733c52d2-4676-0982-e37c-e8ed27eb14cd', $t25f850179c8837598ee517e795a7f4c4$AkirôObá, akirô Obá yê$t25f850179c8837598ee517e795a7f4c4$, $c25f850179c8837598ee517e795a7f4c4$Gira no terreiro
A minha mãe Obá
Protege os seus filhos
Para a gira concentrar
Firma o seu reino aqui no meu congá
Nos dá sabedoria, venha iluminar,
Com as forças da terra eu vou trabalhar
Me envolve com sua luz, oh minha mãe Obá
Com as forças da terra eu vou trabalhar
Me envolve com sua luz, oh minha mãe Obá
————————————————————————————
Ela trazconhecimento vem me iluminar
Clareia meu pensamento, a minha Mãe Obá
Ela éluz da verdade vem me sustentar
Com sua sabedoria, minha mãe Obá!
Irradiao tempo todo, sabe ensinar,
Dona do conhecimento, a minha Mãe Obá
Dona do conhecimento, a minha Mãe Obá
Irradiao tempo todo, sabe ensinar,
Dona do conhecimento, a minha Mãe Obá
Dona do conhecimento, a minha Mãe Obá$c25f850179c8837598ee517e795a7f4c4$, NULL, now()),
('4b4fbea3-5cd8-2da4-66b4-161fa9c011f1', '733c52d2-4676-0982-e37c-e8ed27eb14cd', $t4b4fbea35cd82da466b4161fa9c011f1$Obá - Mãe da sabedoria$t4b4fbea35cd82da466b4161fa9c011f1$, $c4b4fbea35cd82da466b4161fa9c011f1$Akirô Obá yê
Akirô Obá yê
Oh, mãe da sabedoria
Venha nos valer
Clareia Obá yê
Clareia Obá yê
Oh, mãe da sabedoria
Venha nos valer
Concentrou os elementos
Gerou nova energia
Criou o conhecimento
Oh, mãe da sabedoria
Akirô Obá yê
Akirô Obá yê
Oh, mãe da sabedoria
Venha nos valer
Clareia Obá yê
Clareia Obá yê
Oh, mãe da sabedoria
Venha nos valer
Ela é quem reveste a serra
Ela é quem sustenta o mar
É a rainha da Terra
Que se expande pelo ar
Akirô Obá yê
Akirô Obá yê
Oh, mãe da sabedoria
Venha nos valer
Akirô Obá yê
Akirô Obá yê
Oh, mãe da sabedoria
Venha nos valer$c4b4fbea35cd82da466b4161fa9c011f1$, NULL, now()),
('4b8bbbbe-fc60-da90-94ca-85e33de38f9f', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t4b8bbbbefc60da9094ca85e33de38f9f$Ogum - Filha de Naruê$t4b8bbbbefc60da9094ca85e33de38f9f$, $c4b8bbbbefc60da9094ca85e33de38f9f$Eu sou filhade Naruê
Armada com as espadas de Megê
Ungida pelas mãos de Matinada
Regida pelas leisde Ogum de Lei
Meu protetor é Beira-Mar
Iarano caminho a me guiar
Coragem quem me deu foiRompe-Mato
Ogum me ensinou o que é amar
Ogum, meu pai,vem me valer
Na féde Deus, nada vou temer
Ogum, meu pai,vem me guiar
Na minha estrada caminhar$c4b8bbbbefc60da9094ca85e33de38f9f$, NULL, now()),
('2201eb70-644a-f672-41c6-d407dd028fea', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t2201eb70644af67241c6d407dd028fea$Ogum - Ogum de Lei$t2201eb70644af67241c6d407dd028fea$, $c2201eb70644af67241c6d407dd028fea$Ogum de lei,lei,lei,lei,lei
Ogum de Lei é tatano arerê
Em seu cavalo branco ele vem montado
De espada na mão elevem armado
Elevem armado para o arerê
Elevem armado pra nos proteger
Eleé Ogum, é Ogum de Lei
Eleé Ogum, é Ogum de Lei$c2201eb70644af67241c6d407dd028fea$, NULL, now()),
('91b3c62a-37cd-38d9-c029-be088a2828f7', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t91b3c62a37cd38d9c029be088a2828f7$Ogum - Quem beira rio$t91b3c62a37cd38d9c029be088a2828f7$, $c91b3c62a37cd38d9c029be088a2828f7$Quem beira rio,beirario,beira-mar
O que se ganha de Ogum
Só Ogum pode tirar
Seu Ogum de ronda, é quem vem girar
E vem trazendo folhas,pra descarrega$c91b3c62a37cd38d9c029be088a2828f7$, NULL, now()),
('7f52f702-b338-68d1-8253-92b489cd1b25', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t7f52f702b33868d1825392b489cd1b25$Ogum - Ele Trabalha na areia, ele trabalha no mar$t7f52f702b33868d1825392b489cd1b25$, $c7f52f702b33868d1825392b489cd1b25$Salve Ogum Megê,
Ogum Rompe mato
eOgum Beira mar. (2x)
eletrabalha na areia
eletrabalha no mar. (2x)$c7f52f702b33868d1825392b489cd1b25$, NULL, now()),
('533f1b17-49da-c22b-a56e-4648e4d1b079', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t533f1b1749dac22ba56e4648e4d1b079$Ogum - Quando Ogum partiu pra guerra$t533f1b1749dac22ba56e4648e4d1b079$, $c533f1b1749dac22ba56e4648e4d1b079$Quando Ogum partiupraguerra
Iemanjá chorou - 2x
Quando Ogum voltouvencedor
Iemanjá cantou -2x$c533f1b1749dac22ba56e4648e4d1b079$, NULL, now()),
('0c487314-7223-2ac3-7ab9-b729813921e6', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t0c48731472232ac37ab9b729813921e6$Ogum Xoroquê - Dia 23 A Lua Clareou$t0c48731472232ac37ab9b729813921e6$, $c0c48731472232ac37ab9b729813921e6$Dia23
A luaclareou
Era São Jorge guerreiro
O nosso protetor- 2x
Ogunhê
Ogum Xoroquê -2x
Elevem de Aruanda
Vence demandas
Pra nos proteger
Eleé guerreiro da Umbanda
Vence demandas
É Ogum Xoroquê -2x
Ogunhê
Ogum Xoroquê
Ogunhê
Pra nos proteger$c0c48731472232ac37ab9b729813921e6$, NULL, now()),
('7c94db6a-f279-138f-06cb-af95e684768c', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t7c94db6af279138f06cbaf95e684768c$Ele é Ogum, da madrugada$t7c94db6af279138f06cbaf95e684768c$, $c7c94db6af279138f06cbaf95e684768c$Quando os clarinstocavam
Lá laiálaiá
seu batalhão formava
Eleé Ogum, da madrugada
elevem salvarseus filhos
com o toque de alvorada
Laiá
Laiá
Laiá,laiá laiá
Lalaiálalaiá$c7c94db6af279138f06cbaf95e684768c$, NULL, now()),
('dde3b215-15f3-b547-2ed3-23b41038753e', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tdde3b21515f3b5472ed323b41038753e$Quando Ogum partiu pra guerra$tdde3b21515f3b5472ed323b41038753e$, $cdde3b21515f3b5472ed323b41038753e$Quando Ogum partiu pra guerra
Iemanjá chorou
Quando Ogum partiu pra guerra
Iemanjá chorou
Quando Ogum voltou vencedor
Iemanjá cantou
Quando Ogum voltou vencedor
Iemanjá cantou$cdde3b21515f3b5472ed323b41038753e$, NULL, now()),
('46218645-72ee-a5e2-082a-b217678db774', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t4621864572eea5e2082ab217678db774$Ogum Beira Mar$t4621864572eea5e2082ab217678db774$, $c4621864572eea5e2082ab217678db774$Eu vi...
O Guerreiro da Lua
Correndo na beira da praia
Armadura de prata
Eu vi...
O Guerreiro da Lua
Correndo na beira da praia
Empunhando a espada
(2x)
Eu vi...Ogum Beira-Mar!
Vencendo demanda
Dançando junto de Mãe Iemanjá
(2x)
Desce maré, sobe maré
É Ogum Beira-Mar
Desce maré, sobe maré
A Sereia do Mar$c4621864572eea5e2082ab217678db774$, NULL, now()),
('80cb91cf-9c7f-47f0-8c9f-43251d0a26ef', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t80cb91cf9c7f47f08c9f43251d0a26ef$Ordenança de Ogum$t80cb91cf9c7f47f08c9f43251d0a26ef$, $c80cb91cf9c7f47f08c9f43251d0a26ef$Vem, Orixá Guerreiro! Pai Ogum guarde nosso Terreiro
Vem, (oi)elevem de lá...Jesse jesse, Patakori Orixá
Firma que eu quero vervitóriano Humaitá
É ordenança de Ogum, guerreiro na terrae no mar
Firma que eu quero vervitóriano Humaitá
É ordenança de Ogum, Patakori Orixá!
(2x)Saravá meu Pai Ogum, saravá meu Pai, ogunhê!
Ele vem Beira-Mar, elevem Rompe-Mato
Vem Sete-Ondas, ele vem Megê (Xorokê)
Matinata vem, ele vem de Ronda
Ele vem Iara,Ele vem DeLei, vem Malêi
Vem, Orixá Guerreiro! Pai Ogum guarde nosso Terreiro
Ele Vem, (oi)ele vem de lá...Jesse jesse, Patakori Orixá$c80cb91cf9c7f47f08c9f43251d0a26ef$, NULL, now()),
('b91cb74b-96ba-8fdf-d876-0413880e22b6', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb91cb74b96ba8fdfd8760413880e22b6$Salve Ogum$tb91cb74b96ba8fdfd8760413880e22b6$, $cb91cb74b96ba8fdfd8760413880e22b6$éalvorada
eu ouço o toque de clarins
éde Aruanda
que ele acaba de chegar
salve o guerreiro
reidos campos de batalha
salve Ogum
saravá meu Orixá...(2x)
bato cabeça
pra saudar meu protetor
me ajoelho
em seu nome pra orar
que sua espada
ilumine o meu caminho
que seu escudo
me livre de todo o mal... (2x)
Ogum,
meu cavaleiro de fé
Ogum,
meu pai...$cb91cb74b96ba8fdfd8760413880e22b6$, NULL, now()),
('3cb4986d-c553-ee6e-3560-472ceaea4c1c', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t3cb4986dc553ee6e3560472ceaea4c1c$Meu pai Ogum saravá$t3cb4986dc553ee6e3560472ceaea4c1c$, $c3cb4986dc553ee6e3560472ceaea4c1c$éorixá, é guardião
meu pai Ogum saravá
cravo vermelho, vim teofertar
meu pai Ogum saravá
nas suas ondas ,vou me banhar
meu pai Ogum saravá
édo seu lado, o meu lugar
meu pai Ogum saravá...
salve o grande cavaleiro
dono das ondas do mar
salve o grande guerreiro
que chegou pra trabalhar
elevem de Aruanda
para nos abençoar
saravá seu 7 ondas
que é dono desse congá...$c3cb4986dc553ee6e3560472ceaea4c1c$, NULL, now()),
('7c9d7cb0-5208-628c-e244-965f86a4bf32', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t7c9d7cb05208628ce244965f86a4bf32$Ogum Meu Pai$t7c9d7cb05208628ce244965f86a4bf32$, $c7c9d7cb05208628ce244965f86a4bf32$Ogum, Ogum meu pai
olhaipor nós aqui na terra
Ogum meu pai (2X)
Dia 23 de abril,
os clarinsjávão tocar
abram alas no terreiro,
afalange vaichegar
vou chamar Seu beira mar
Ogum iara, Ogum megê
Sete ondas, Rompe mato,
firmaa gira eu quero ver
Ogum, Ogum meu pai
olhaipor nós aqui na terra
Ogum meu pai (2X)
Lá no céu brilhando alua,
avisteimeu padroeiro
vendo a imagem de São Jorge
rezeipra Ogum guerreiro
as batalhas dessa vida
com meu paihei de vencer
fortemente chega armado
pronto pra me defender
Ogum, Ogum meu pai
olhaipor nós aqui na terra
Ogum meu pai (2X)$c7c9d7cb05208628ce244965f86a4bf32$, NULL, now()),
('6c6adf81-b17f-eba9-c5d4-2507037c35db', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t6c6adf81b17feba9c5d42507037c35db$Ogum - Cavaleiro de Umbanda$t6c6adf81b17feba9c5d42507037c35db$, $c6c6adf81b17feba9c5d42507037c35db$Quem vem lá
Nessa noiteenluarada
Com sua espada empunhada
Sua capa encarnada
Pronto para guerrear
É meu pai
Que chegou láde Aruanda
Vem saudar a nossa banda
Ele vem vencer demanda
Ele vem pra trabalhar
Ó meu pai
Nunca me deixe sozinho
Guie sempre o meu caminho
Venha me abençoar
Ó meu pai
Minha fé em tinão falha
E nos campos de batalha
Está sempre a me ajudar
Eleé Ogum
Cavaleiro de Umbanda
Meu protetor
Mensageiro de Oxalá
É quem me guia
Nas estradas dessa vida
Eleé que me dá guarida
O meu grande Orixá (2x)$c6c6adf81b17feba9c5d42507037c35db$, NULL, now()),
('9f6e55a9-5e7c-84c8-ce36-bb8487cb5334', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t9f6e55a95e7c84c8ce36bb8487cb5334$Ogum e Iemanjá - Vem nos abençoar$t9f6e55a95e7c84c8ce36bb8487cb5334$, $c9f6e55a95e7c84c8ce36bb8487cb5334$Ogum, Ogum meu pai Ogum
Junto com mãe Iemanjá
Vem nos abençoar... (2x)
Meu santo forteque me rege eque me guia
A sua espada dá sentido a minha vida
Ogum guerreiro que me faz teresperança
A sua lança é que me faz vencer demanda
Mamãe sereia como é lindoo seu cantar
Sua energia éque me fazlevantar
Odociaba deixe axé nesse lugar
E leve todo mau pro fundo do mar...
Ogum, Ogum meu pai Ogum
Junto com mãe Iemanjá
Vem nos abençoar... (2x)$c9f6e55a95e7c84c8ce36bb8487cb5334$, NULL, now()),
('beb4aa47-a023-82ff-91f7-84b206c619ac', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tbeb4aa47a02382ff91f784b206c619ac$Ogum - Guerreiro de fato$tbeb4aa47a02382ff91f784b206c619ac$, $cbeb4aa47a02382ff91f784b206c619ac$Vim saudar o Deus da guerra
Salve o reide Aruanda
Só guerreia pela paz
Vence demanda
Eleé grande cavaleiro
Eleé guerreiro de fato
Eleé meu pai na umbanda éRompe Mato (2x)
Sob o luar de prata
Elevem a cavalgar Ogunhê
Desbravando toda mata
Elevem pra trabalhar Ogunhê
É meu reié quem me guia
Nunca deixa seus filhostombar
E nos campos de batalha
Minha fé em tinão falha
Pois eu sou um vencedor (2x)
Ogum - Cavaleiro Imponente$cbeb4aa47a02382ff91f784b206c619ac$, NULL, now()),
('776a1789-4382-d2a4-9f0e-b767ab9cfcff', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t776a17894382d2a49f0eb767ab9cfcff$Página6de 49$t776a17894382d2a49f0eb767ab9cfcff$, $c776a17894382d2a49f0eb767ab9cfcff$É Ogum, é Ogum, é Ogum...
Cavalgando sob a luz da lua elechega imponente
Vem trazendo todo o seu axé aqui nesse congá
Sua capa vermelha, o seu capacete e a espada empunhada...
É Ogum
É Ogum que sempre me protege de todos os males
É quem seca meu pranto em cada momento de dor
Ele está do meu lado em casa batalha vencida...
É Ogum
É uma força que emana no fundo do meu coração
Pra enfrentar as batalhas que o destino forme enviar
Quem vem me proteger, e quem vem me valer
É a falange de Jorge que não me deixa esmorecer
Ele ensina o caminho a seguir pra obter a vitória
Ilumina e guia seu filhoem cada trajetória
Nunca perdi a fé
Pois meu pai eleé...
É Ogum
É Ogum, é Ogum, é Ogum...$c776a17894382d2a49f0eb767ab9cfcff$, NULL, now()),
('8361d4ab-4bd4-f10f-ed0e-e45aa5390aea', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t8361d4ab4bd4f10fed0ee45aa5390aea$Ogum, Cavaleiro da Lua$t8361d4ab4bd4f10fed0ee45aa5390aea$, $c8361d4ab4bd4f10fed0ee45aa5390aea$Ogum, Cavaleiro da Lua
Só ele navega no mar
Só ele navega no mar,
Só ele navega no mar
Só ele navega no mar, Sereia$c8361d4ab4bd4f10fed0ee45aa5390aea$, NULL, now()),
('5a443996-a928-1587-a179-3032cbca9167', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t5a443996a9281587a1793032cbca9167$Ogum - Eu Não Seria Nada$t5a443996a9281587a1793032cbca9167$, $c5a443996a9281587a1793032cbca9167$Eu não serianada
Se não fosse Ogum
Para abrira minha estrada -2x
Valente guerreiro que aqui chegou
Vencedor de demandas
Meu protetor
Em sua trajetória
Meu pailuta contra o mal
Foinos campos de batalha
Que se tornou um general
Eu não serianada
Se não fosse Ogum
Para abrira minha estrada -2x
Salve Ogum de Ronda
Salve Ogum Megê
Saravá Seu Beira-Mar
Ogum Iara e Ogum de Lê
Salve toda falange
Desse valente guerreiro
Que quebra todas as demandas
Aqui dentro do terreiro
Eu não seria nada
Se não fosse Ogum
Para abrira minha estrada - 2x$c5a443996a9281587a1793032cbca9167$, NULL, now()),
('f042e4d6-9a43-ce95-971a-68b4f8bc89fa', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tf042e4d69a43ce95971a68b4f8bc89fa$Ogum Me Escolheu$tf042e4d69a43ce95971a68b4f8bc89fa$, $cf042e4d69a43ce95971a68b4f8bc89fa$Ogum me escolheu
E quem tentou me derrubar
Foiquem perdeu
Ogum me escolheu
E quem tentou me derrubar
Foiquem perdeu
Na Umbanda é São Jorge
Esse nobre cavaleiro
Sua espada vibra fortee protege o meu terreiro
Eleé o pai da honra
Que não deixa eu fraquejar
Executa sua lei
Pelos caminhos de Oxalá
Ogum me escolheu
E quem tentou me derrubar
Foiquem perdeu
Ogum me escolheu
E quem tentou me derrubar
Foiquem perdeu
Saravá seu Matinata, Rompe Mato e Beira-Mar
Ogunhê
Ogum de ronda
E Sete Espadas no gongá
Vou chamar Ogum Iara
Pois não quero mais sofrer
E entregar os meus caminhos para o grande Ogum Megê
Ogum me escolheu
E quem tentou me derrubar
Foiquem perdeu
Ogum me escolheu
E quem tentou me derrubar
Foiquem perdeu
Ogum Orixá protetor$cf042e4d69a43ce95971a68b4f8bc89fa$, NULL, now()),
('be829363-5be0-e234-9923-84cc7d5219aa', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tbe8293635be0e234992384cc7d5219aa$Página 8de 49$tbe8293635be0e234992384cc7d5219aa$, $cbe8293635be0e234992384cc7d5219aa$Ogum guerreiro
meu orixáprotetor
Vencedor de demanda, tem a força na espada
protege filhode umbanda
Meu paisua luze coragem
me dão a certeza de vencer
nos duros caminhos da vida, apesar das feridas
não tenho nada a temer
O O Ogum, o Ogunhê
Cavaleiro de Aruanda
não perco afé em você$cbe8293635be0e234992384cc7d5219aa$, NULL, now()),
('54a33114-cd47-d7af-53c9-40ca2a86da84', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t54a33114cd47d7af53c940ca2a86da84$Ogum - É seu Beira Mar$t54a33114cd47d7af53c940ca2a86da84$, $c54a33114cd47d7af53c940ca2a86da84$É,seu Beira Mar
É,seu Beira Mar
É ordenança de São Jorge na Umbanda
Ele éOgum
É seu Beira Mar
É,seu Beira Mar
É,seu Beira Mar
É ordenança de São Jorge na Umbanda
Ele éOgum
É seu Beira Mar
Travou batalhas pelo imenso mar azul
Oxalá lhe convocou
Por ordem de Olorum
Para na Terra empunhar sua bandeira
De um guerreiro da falange de Ogum
É Beira Mar
É,seu Beira Mar
É,seu Beira Mar
É ordenança de São Jorge na Umbanda
Ele éOgum
É seu Beira Mar
É,seu Beira Mar
É,seu Beira Mar
É ordenança de São Jorge na Umbanda
Ele éOgum
É seu Beira Mar
Hoje virano terreiro
Recebendo os Orixás
Ensinando a cada irmão
A missão que iráprestar
É guardião
De uma casa de caridade
Que propaga pelo mundo
A paz, o amor e a humildade
É Beira Mar
É,seu Beira Mar
É,seu Beira Mar
É ordenança de São Jorge na Umbanda
Eleé Ogum
É seu Beira Mar$c54a33114cd47d7af53c940ca2a86da84$, NULL, now()),
('0898fbf9-2748-8fab-29e8-8925c744a24c', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t0898fbf927488fab29e88925c744a24c$Ogum guerreiro de Umbanda$t0898fbf927488fab29e88925c744a24c$, $c0898fbf927488fab29e88925c744a24c$Ogum guerreiro de Umbanda
Seu ponto venha firmar
Ogum guerreiro de Umbanda
Seu ponto venha firmar
Elepede o sol ea lua
Ô, paranga
Para clarear
Elepede o sol ea lua
Ô, paranga
Para clarear
A coroa de ouro é mareô
A coroa de ouro é mareô
Ogum é tata,é tata
A coroa de ouro é mareô
A coroa de ouro é mareô
A coroa de ouro é mareô
Ogum é tata,é tata
A coroa de ouro é mareô$c0898fbf927488fab29e88925c744a24c$, NULL, now()),
('94e6c8d7-cb5a-b7fa-a954-14e1b66106b4', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t94e6c8d7cb5ab7faa95414e1b66106b4$Ogum - Casa de Guerreiro$t94e6c8d7cb5ab7faa95414e1b66106b4$, $c94e6c8d7cb5ab7faa95414e1b66106b4$Nesta casa de guerreiro
Vim de longe pra rezar
Peço à Deus pelos doentes
Com féem Obatalá
Ogum salve a casa santa
Os presentes e os ausentes
Salve nossas esperanças
Salve velhos e crianças
Preto velho ensinou
Na cartilhade Aruanda, ê
E Ogum não esqueceu
Como vencer a demanda
Ogum, meu pai
Ogunhê
Ogum, meu pai
Ogunhê
A tristezavaiembora
Vaina espada de um guerreiro
E a luzdo romper da aurora
Vaibrilhar neste terreiro
A tristezafoiembora
Foina espada de um guerreiro
E a luzdo romper da aurora
Já brilhouneste terreiro
Ogum, meu pai
Ogunhê
Ogum, meu pai
Ogunhê$c94e6c8d7cb5ab7faa95414e1b66106b4$, NULL, now()),
('0487a6b5-2501-c3c2-f3b3-6c479d1695e2', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t0487a6b52501c3c2f3b36c479d1695e2$Ogum - General de Umbanda$t0487a6b52501c3c2f3b36c479d1695e2$, $c0487a6b52501c3c2f3b36c479d1695e2$Por sete vezes, pai Ogum me levantou
Sete caminhos, com sua mão me guiou
Com sua espada, pronto pra me defender
Meu paiOgum, não deixe filhosofrer
Por sete vezes, pai Ogum me levantou
Sete caminhos, com sua mão me guiou
Com sua espada, pronto pra me defender
Meu paiOgum, não deixe filhosofrer
E quando a lua brilhar,nos campos do Humaitá
Está na hora de saudar, bravo guerreiro de Umbanda
No toque da alvorada, não teme inimigo algum
É vencedor de demanda, general de Umbanda, salve pai Ogum
Ogum, Ogum de Ilê,Ogum Megê, Seu Matinata vem também
Salve Ogum Rompe-Mato, seu Ogum Iarano gongá
Salve Ogum Sete Espadas, salve Seu Beira-Mar
Ogum, Ogum de Ilê,Ogum Megê, Seu Matinata vem também
Salve Ogum Rompe-Mato, seu Ogum Iarano gongá
Salve Ogum Sete Espadas, salve Seu Beira-Mar$c0487a6b52501c3c2f3b36c479d1695e2$, NULL, now()),
('798ac1af-2cc4-4936-ccdb-f3f00e493df1', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t798ac1af2cc44936ccdbf3f00e493df1$Ponto de Ogum - São Jorge$t798ac1af2cc44936ccdbf3f00e493df1$, $c798ac1af2cc44936ccdbf3f00e493df1$Guerreio é no lombo do meu cavalo
Bala vem mas eu não caio, armadura é proteção
Avanço sob a noite,iluminado, lutosem pestanejar
Derrubo sem me esforçar a guarnição
A guimba e a fumaça do meu cigarro
Cega o olho do soldado que pensou em me ferir
Com um sorriso derrubo uma tropa inteira
Mesmo que na dianteira sombra venha me seguir
O gole da cachaça esguicho no ar
Chorando na labuta ouço a corrente se quebrar
E o golpe do destino, esse eu sintomas não caio
Guerreio é no lombo do meu cavalo
Guerreio é no lombo do meu cavalo
Guerreio é no lombo do meu cavalo
Guerreio é no lombo do meu cavalo$c798ac1af2cc44936ccdbf3f00e493df1$, NULL, now()),
('07381ddc-a51f-eb39-f137-b39bfeba8d17', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t07381ddca51feb39f137b39bfeba8d17$Subida de Pai Ogum$t07381ddca51feb39f137b39bfeba8d17$, $c07381ddca51feb39f137b39bfeba8d17$Pode se queixar ao seu general
Pode se queixar ao seu general
Pai Ogum jáembora ele vai torna voltar
seu navio de guerra ele deixou em altomar$c07381ddca51feb39f137b39bfeba8d17$, NULL, now()),
('52e8551c-72aa-ec10-1950-af26101bcd42', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t52e8551c72aaec101950af26101bcd42$Subida Ogum - Seu cavalo eu selei$t52e8551c72aaec101950af26101bcd42$, $c52e8551c72aaec101950af26101bcd42$Seleiselei, seu cavalo eu selei
Seleiselei, seu cavalo eu selei
Pai Ogum jávai embora, seu cavalo eu selei
vaicom Deus e nossa Senhora, seu cavalo eu selei
Seu ordenança mandou lhe avisar
que seu cavalo está pronto para Ogum viajar
Mas como lindo no clarão da lua
seu cavalo branco com a imagem sua$c52e8551c72aaec101950af26101bcd42$, NULL, now()),
('32551326-c6ca-bfb5-18da-80ebc6ea55a1', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t32551326c6cabfb518da80ebc6ea55a1$Vou acender velas para São Jorge$t32551326c6cabfb518da80ebc6ea55a1$, $c32551326c6cabfb518da80ebc6ea55a1$Vou acender velas para São Jorge
A eleeu quero agradecer
evou plantarcomigo niguém pode
para que o mau não possa então vencer
Olho grande em mim não pega
não pega não
não pega em quem tem fé
no coração
Ogum com sua espada
sua capa encarnada
me dá sempre proteção
quem vaipela boa estrada
no fimdessa caminhada
encontra em Deus perdão
lálaiálaiálaiá laiá
vamos saudar São Jorge Cavaleiro$c32551326c6cabfb518da80ebc6ea55a1$, NULL, now()),
('135a8398-b129-db33-ec7b-8ed4f457ce62', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t135a8398b129db33ec7b8ed4f457ce62$Ogum - Ele Jurou Bandeira$t135a8398b129db33ec7b8ed4f457ce62$, $c135a8398b129db33ec7b8ed4f457ce62$Elejurou bandeira,
Eletocou clarim
Elejurou bandeira,
Eletocou clarim
Com seu exército todo
Elelutou por mim
Com seu exército todo
Elelutou por mim
Na beira da praia
Ogum Sete Ondas
Ogum Beira-mar
Na beira da praia
Ogum Sete Ondas
Ogum Beira-mar
Andou de madrugada
Saravá Seu Beira-mar
Saravá Seu Matinata!
Elerodou pião… andou de madrugada
Saravá seu Beira-mar,
Saravá Seu Matinata!
Ogum - Seu sete ondas$c135a8398b129db33ec7b8ed4f457ce62$, NULL, now()),
('379cc532-188e-6177-90a3-f271dd683dae', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t379cc532188e617790a3f271dd683dae$Página13de 49$t379cc532188e617790a3f271dd683dae$, $c379cc532188e617790a3f271dd683dae$Ogum é tibirílánamata, eu vi
Seu sete ondas
quando vem lá de Aruanda
trazendo pemba
prasalvar filhode Umbanda
ôjaponês olha as ondas do mar
ôjapones
olhaas ondas do mar$c379cc532188e617790a3f271dd683dae$, NULL, now()),
('1c752f79-3b67-567f-f71a-a3477ed28229', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t1c752f793b67567ff71aa3477ed28229$Por sete vezes pai Ogum me levantou$t1c752f793b67567ff71aa3477ed28229$, $c1c752f793b67567ff71aa3477ed28229$Por setevezes
paiOgum me levantou
Sete caminhos
com sua mão me guiou
com sua espada
prontopra me defender
meu pai Ogum
não deixe filhosofrer
equando a lua brilhar
nos campos do Humaitá
estána hora de saudar
bravo guerreirode Umbanda
no toque da alvorada não teme inimigo algum
évencedor de demanda
general de Umbanda, salvepai Ogum
Ogum, Ogum de lê
Ogum Megê, Seu Matinata vem também
salveOgum rompe mato
seu Ogum iara no gongá
salveOgum sete espadas
salveSeu beiramar$c1c752f793b67567ff71aa3477ed28229$, NULL, now()),
('50d457e3-6288-90ba-49e8-5687681c52d9', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t50d457e3628890ba49e85687681c52d9$Ogum beira mar o que é que trouxe do mar$t50d457e3628890ba49e85687681c52d9$, $c50d457e3628890ba49e85687681c52d9$Seu Ogum beiramar
oque é que trouxe do mar
Quando ele vem, beirando areia
na mão direitaeletrásum rosário
da mamãe sereia
Meu Pai Ogum vem me proteger$c50d457e3628890ba49e85687681c52d9$, NULL, now()),
('2d127b70-0ed3-7b70-d785-39012fec8869', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t2d127b700ed37b70d78539012fec8869$Página14de 49$t2d127b700ed37b70d78539012fec8869$, $c2d127b700ed37b70d78539012fec8869$Ele cavaleiro de Aruanda, vencedor de demanda
Eleé meu Pai Ogum
Elevem saudar seu filhoscom sua lança na mão
não teme àmau nenhum
Meu PaiOgum
vem me proteger
Eu Pai Ogum
vem me ajudar
O senhor é o Deus da guerra que venceu todas batalhas nos campos do Humaitá
Meu PaiOgum
Meu PaiOgum
vem me proteger
Eu Pai Ogum
vem me ajudar
O senhor é o Deus da guerra que venceu todas batalhas nos campos do Humaitá$c2d127b700ed37b70d78539012fec8869$, NULL, now()),
('1a6df163-362d-b682-e548-a3b65489050d', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t1a6df163362db682e548a3b65489050d$Pontos de Ogum Beira Mar$t1a6df163362db682e548a3b65489050d$, $c1a6df163362db682e548a3b65489050d$aaa...quem vem de lá,a quem vem de lá
Salve o capacete de São Jorge
seu cavalo é corredor,ê ê a
Beiramar, auê Beira mar
Beiramar, auê Beira mar
com sua espada meu pai,eu quero ver
com sua lança meu pai,me proteger
Beiramar, auê Beira mar
Beiramar, auê Beira mar
Ogum já jurou bandeira nos campos do Humaitá
Ogum já venceu demanda, vamos todos saravá
Beira mar, auê Beira mar
Beira mar, auê Beira mar
eu tava na minha banda, eu tava no meu lugar
eu tava na calunga, pra quê foram me chamar
Beira mar, auê Beira mar
Beira mar, auê Beira mar$c1a6df163362db682e548a3b65489050d$, NULL, now()),
('91df2ece-0f18-037a-0ebd-2f0bc818912a', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t91df2ece0f18037a0ebd2f0bc818912a$Ogum - Se meu Pai é Ogum$t91df2ece0f18037a0ebd2f0bc818912a$, $c91df2ece0f18037a0ebd2f0bc818912a$Se meu pai é Ogum, vencedor de demandas
quando chega no reino, é pra salvar filhode Umbanda
Ogum, Ogum iara, Ogum, Ogum iara
Salve os campos de batalhas, salve a sereia do mar
Ogum, Ogum iara, saravá Ogum, Ogum iara
Ogum, ele jávenceu a guerra
veio salvar os seus filhos desta terra
com sua espada e sua lança, ele vem beirando o mar
filhoda virgem Maria, ordenança de Oxalá
Ogum, Ogum iara, Ogum, Ogum iara$c91df2ece0f18037a0ebd2f0bc818912a$, NULL, now()),
('686af72e-6c40-8c5d-73c9-76839c3500e7', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t686af72e6c408c5d73c976839c3500e7$Ogum Rondeiro$t686af72e6c408c5d73c976839c3500e7$, $c686af72e6c408c5d73c976839c3500e7$Ogum é de babaloê
Ogum é de babaloá
Ele ronda de noite e de dia
Ele gira no meu cangirá
No céu ele éSão Jorge
Na terraele éOgum
Na praiaele é Beira Mar
Mas ele girano meu cangirá
Ogum é de babaloê
Ogum é de babaloá
Eleronda de noitee de dia
Elegira no meu cangirá
Saravá minha estrelaguia
Saravá seu Beira Mar
Com sua bandeira branca
Protege meu cangirá$c686af72e6c408c5d73c976839c3500e7$, NULL, now()),
('f00e96e6-ea06-3424-e0e5-2beec965e2a4', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tf00e96e6ea063424e0e52beec965e2a4$Ogum - Dançar Nagô é bom/ Fala de Ogum Naruê/ Zambi ele é Ogum$tf00e96e6ea063424e0e52beec965e2a4$, $cf00e96e6ea063424e0e52beec965e2a4$Ogum me disseque dançar Nagô é bom
dançar Nagô é bom!
_______________________________
oiáiá,falade Ogum Naruê
fala,deOgum Naruê
________________________________
Na luanova e na Umbanda eleé Ogum
Ogunhê! Zambi ele é Ogum$cf00e96e6ea063424e0e52beec965e2a4$, NULL, now()),
('50041509-feb5-6436-c575-36b249f740a8', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t50041509feb56436c57536b249f740a8$Ogum - Jurou a bandeira e tornou a jurar.$t50041509feb56436c57536b249f740a8$, $c50041509feb56436c57536b249f740a8$Ogum, Ogum, Ogum
juroua bandeira e tornou ajurar.
Ogum, Ogum, Ogum
juroua bandeira e tornou ajurar.
Eletem opeito de aço
venceu a guerra no Humaitá
Eletem opeito de aço
venceu a guerra no Humaitá$c50041509feb56436c57536b249f740a8$, NULL, now()),
('b8469f3c-cede-d574-20ef-bd84f9bcc586', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb8469f3cceded57420efbd84f9bcc586$Ogum Naruê - Magia que faz o meu corpo tremer$tb8469f3cceded57420efbd84f9bcc586$, $cb8469f3cceded57420efbd84f9bcc586$Magia, magia que fazo meu corpo tremer
Magia, magia que chega em silênciosem a gente ver
É senhor Ogum
É o reida magia que vem nos socorrer
É o senhor Ogum
Quem vence a magia é Ogum Naruê
Ogunhê!
Magia, magia que fazo meu corpo tremer
Magia, magia que chega em silênciosem a gente ver
É senhor Ogum
É o reida magia que vem nos socorrer
É o senhor Ogum
Quem vence a magia é Ogum Naruê
Ogunhê!$cb8469f3cceded57420efbd84f9bcc586$, NULL, now()),
('9cb03deb-c5f2-bec4-65cf-a50d2bc9ec1f', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t9cb03debc5f2bec465cfa50d2bc9ec1f$Ogum - Ogum Menino$t9cb03debc5f2bec465cfa50d2bc9ec1f$, $c9cb03debc5f2bec465cfa50d2bc9ec1f$Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óiaeu
Oyá! Oyá!
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óiaeu
Oyá! Oyá!
Quando Ogum partiu pra guerra
Ele pediu para Oyá
Oyá, mamãe óia eu
Ogum Menino chegou na cavalaria
Foiordenança da Virgem Maria
A sua fama correu campos e quartéis
Como pode um menino
Saber mais que os coronéis
Veio a revoltade soldado a capitão
Sete meses, sete dias
Jorge ficou na prisão
Jorge fazia sua prece e oração
Pedindo a Virgem Maria
Para lhe dar proteção
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óiaeu
Oyá! Oyá!
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óiaeu
Oyá! Oyá!
Jorge foicondenado
Pelas ruas arrastado
Numa praça da cidade
Teve o pescoço cortado
Jorge dizia:minha mãe olha por mim
Leve meu corpo e minh'alma
Para o infinitosem fim
Os coronéis rezaram epediram perdão
O corpo desapareceu
No meio da multidão
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óia eu
Oyá! Oyá!
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óia eu
Oyá! Oyá!
Hoje Jorge é um santo
É forteOgum guerreiro
Filhoda Virgem Maria
Caçador, é o Orixá
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óia eu
Oyá! Oyá!
Oyá! Oyá!
Oyá! Oyá! Oyá, mamãe óia eu
Oyá! Oyá!$c9cb03debc5f2bec465cfa50d2bc9ec1f$, NULL, now()),
('98bc32b9-f91a-2338-a4a4-61a7301ff18c', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t98bc32b9f91a2338a4a461a7301ff18c$Ogum - Abre a estrada guerreiro /Não me deixe andar só$t98bc32b9f91a2338a4a461a7301ff18c$, $c98bc32b9f91a2338a4a461a7301ff18c$Abre a estrada guerreiro
Zambi mandou abrir
Abre a estrada guerreiro
Zambi mandou abrir
Abre os caminhos
Meu santo padroeiro
Meu São Jorge guerreiro
Que eu vou lhe seguir
Abre os caminhos
Meu santo padroeiro
Meu São Jorge guerreiro
Que eu vou lhe seguir
Abre a estrada guerreiro
Zambi mandou abrir
Abre a estrada guerreiro
Zambi mandou abrir
Abre os caminhos
Meu santo padroeiro
Meu São Jorge guerreiro
Que eu vou lhe seguir
Abre os caminhos
Meu santo padroeiro
Meu São Jorge guerreiro
Que eu vou lhe seguir
Meu São Jorge guerreiro
Que eu vou lhe seguir
Não me deixe andar só
Sua estrada é maior
Que os caminhos que eu andei
Não me deixe andar só
Sua estrada é maior
Que os caminhos que eu andei
Vem trabalhar na Umbanda
Saúdo a sua banda
Saúdo o grande general
Vem trabalhar na Umbanda
Saúdo a sua banda
Saúdo o grande general
Muitas batalhas
Pela estrada escura
Tenho o clarão da lua
E Ogum pra me guardar
Lanceiro, lanceiro
Outros lhe chamam guardião celestial
Lanceiro, lanceiro
Outros lhe chamam guardião celestial
Não me deixe andar só
Sua estrada é maior
Que os caminhos que eu andei
Não me deixe andar só
Sua estrada é maior
Que os caminhos que eu andei
Vem trabalhar na Umbanda
Saúdo a sua banda
Saúdo o grande general
Vem trabalharna Umbanda
Saúdo a sua banda
Saúdo o grande general$c98bc32b9f91a2338a4a461a7301ff18c$, NULL, now()),
('e7834b42-ece1-615d-56f7-75944fc1520e', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $te7834b42ece1615d56f775944fc1520e$Ogum - Ogum Foi Quem Chegou$te7834b42ece1615d56f775944fc1520e$, $ce7834b42ece1615d56f775944fc1520e$Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Com sua espada e sua lança
Me protege todo dia
Meu paié guerreiro de Umbanda
É guardião da estrela guia
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Quando ele vem das águas
Pode ser Seu Sete Ondas
Beira-mar, Ogum de Lei
Ogum Iara,Ogum de Ronda
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Patakori,Ogum Menino
Matinata,Seu Naruê
Sete Espadas, Ogum Nagô
Rompe Mato, Ogum Megê
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Na Umbanda é guerreiro
Ele érei do Humaitá
Vencedor de demandas
Vamos todos saravar
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor
Uôô-ôô!
Foiele quem chegou
Uôô-ôô!
Ogum é meu senhor$ce7834b42ece1615d56f775944fc1520e$, NULL, now()),
('18ea68aa-9dde-0bad-c565-d9ac493f3fd9', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t18ea68aa9dde0badc565d9ac493f3fd9$Ogum de Lei$t18ea68aa9dde0badc565d9ac493f3fd9$, $c18ea68aa9dde0badc565d9ac493f3fd9$Ogum de lei,lei,lei,lei,lei
Ogum de Lei étata no arerê
Ogum de lei,lei,lei,lei,lei
Ogum de Lei étata no arerê
Em seu cavalo branco ele vem montado
De espada na mão ele vem armado
Em seu cavalo branco ele vem montado
De espada na mão ele vem armado
Ele vem armado para o arerê
Ele vem armado pra nos proteger$c18ea68aa9dde0badc565d9ac493f3fd9$, NULL, now()),
('510fb33b-e3bb-2d07-3cca-8719bdd9f448', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t510fb33be3bb2d073cca8719bdd9f448$Ogum Sete Ondas$t510fb33be3bb2d073cca8719bdd9f448$, $c510fb33be3bb2d073cca8719bdd9f448$Estava na beirada praia
Quando eu vi
Sete Ondas passar
Estava na beirada praia
Quando eu vi
Sete Ondas passar
Abra a porta
Gente, que aivem Ogum
Com seu cavalo marinho
Ele vem saravar
Abra a porta
Gente, que aivem Ogum
Com seu cavalo marinho
Ele vem saravar$c510fb33be3bb2d073cca8719bdd9f448$, NULL, now()),
('48bfe8a9-9aa2-83a3-5595-e987e3c62bb1', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t48bfe8a99aa283a35595e987e3c62bb1$Ogum - Mandei Fazer um Capacete de Penas$t48bfe8a99aa283a35595e987e3c62bb1$, $c48bfe8a99aa283a35595e987e3c62bb1$Mandei fazer
Um capacete de pena
Para usar
Antes da alvorada
Mandei fazer
Um capacete de pena
Para usar
Antes da alvorada
Vermelho e branco
Verde e azul
Esse capacete
Tem as cores de Ogum
Vermelho e branco
Verde e azul
Esse capacete
Tem as cores de Ogum
De Ogum Naruê
De Ogum Matinata
De Ogum Naruê
De ogum Matinata
Quando uso o capacete
Ouço otoque da alvorada
Quando uso o capacete
Ouço otoque da alvorada$c48bfe8a99aa283a35595e987e3c62bb1$, NULL, now()),
('c9bce4f5-4475-8357-68be-757751574dbf', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tc9bce4f54475835768be757751574dbf$Se meu pai é Ogum$tc9bce4f54475835768be757751574dbf$, $cc9bce4f54475835768be757751574dbf$Se meu pai éOgum
Vencedor de demandas
Elevem de Aruanda prasalvar filhosde Umbanda
Ogum, Ogum Iara
Salve os campos de batalha
Salve a sereiado mar
Ogum, Ogum Iara
Ogum, ele jávenceu a guerra
Veio salvaros seus filhosaquina Terra
Com sua espada e sua lança
Elevem beirando o mar
Filhoda Virgem Maria
É ordenança de Oxalá
Ogum, Ogum Iara
Salve os campos de batalha
Salve a sereiado mar
Ogum, Ogum Iara$cc9bce4f54475835768be757751574dbf$, NULL, now()),
('0f974188-5ef3-4cd2-de5f-461d60d71785', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t0f9741885ef34cd2de5f461d60d71785$Ogum Iara - Se Meu Pai é Ogum$t0f9741885ef34cd2de5f461d60d71785$, $c0f9741885ef34cd2de5f461d60d71785$Se meu paié Ogum
Vencedor de demanda
Elevem de Aruanda
Pra salvarfilhode Umbanda
Se meu paié Ogum
Vencedor de demanda
Elevem de Aruanda
Pra salvarfilhode umbanda
Ogum Iara
Ogum Iara
Salve os campos de batalha
Salve a sereiado mar
Ogum Iara
Ogum Iara$c0f9741885ef34cd2de5f461d60d71785$, NULL, now()),
('22e4350c-f675-62ae-8c88-e15278b36c62', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t22e4350cf67562ae8c88e15278b36c62$Ogum Beira-mar - Eu vi, Eu vi$t22e4350cf67562ae8c88e15278b36c62$, $c22e4350cf67562ae8c88e15278b36c62$Eu vi,eu vi
Seu Rompe Mato no mar
Eu vi,eu vi
com seu Ogum Beira-mar
Eu vi,eu vi
Seu Rompe Mato no mar
Eu vi,eu vi
com seu Ogum Beira-Mar
Salve as crianças na praia
Salve a sereiano mar
Saravá, Seu Beira-mar
Eleé chefe de congá
Salve as crianças na praia
Salve a sereiano mar
Saravá, Seu Beira-mar
Eleé chefe de congá
Eu vi,eu vi
Seu Rompe Mato no mar
Eu vi,eu vi
com seu Ogum Beira-mar
Eu vi,eu vi
Seu Rompe Mato no mar
Eu vi, eu vi
com seu Ogum Beira-Mar
Salve as crianças na praia
Salve a sereia no mar
Saravá, Seu Beira-mar
Ele é chefe de congá
Salve as crianças na praia
Salve a sereia no mar
Saravá, Seu Beira-mar
Ele é chefe de congá$c22e4350cf67562ae8c88e15278b36c62$, NULL, now()),
('22c284a1-0e62-ccd6-8fe0-076b1969f130', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t22c284a10e62ccd68fe0076b1969f130$Ogum Beira-Mar - São Jorge$t22c284a10e62ccd68fe0076b1969f130$, $c22c284a10e62ccd68fe0076b1969f130$Quando eu vim pra esse chão
Foipra ser menestrel
De viola,brasão e anel
Cruzei mar e sertão
Com uma estrelano céu
Reluzindo no meu chapéu
Vim mostrar a beleza
Mas só vitristeza
E essa estrela acessa
Virou na noite
Um fogaréu
Pra lutarcontra o mal
Me tornei capitão
Parabelo e punhal na mão
Pus em cada arraial
Uma estrela no chão
Com a ponta do meu facão
Nos campos de guerra
Luteipor meus irmãos
Por essa terra
Ogunhê
Tombei na serra
Mas meu sonho não
Aruanda chamou
Eu vireiOrixá
Cavaleiro de Oxalá
Hoje eu sou defensor
Guardião do luar
Sou São Jorge, Ogum Beira-Mar
Aruanda chamou
Eu vireiOrixá
Cavaleiro de Oxalá
Hoje eu sou defensor
Guardião do luar
Sou São Jorge, Ogum Beira-Mar$c22c284a10e62ccd68fe0076b1969f130$, NULL, now()),
('48e59989-3883-4dda-3124-1013883f267e', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t48e5998938834dda31241013883f267e$Ogum - Ogum Xoroquê$t48e5998938834dda31241013883f267e$, $c48e5998938834dda31241013883f267e$Ôh, Ogum
Ôh, Ogunhê, iê,iê
Ôh, Ogum
Ogum Xoroquê, iê,iê,iê,iê!
Ôh, Ogum
Ôh, Ogunhê, iê,iê
Ôh, Ogum
Ogum Xoroquê!
Meu senhor das estradas,
Ogunhê!
Abra meus caminhos,
Ogunhê!
Meu senhor da porteira,
Ogunhê!
Eleé meu pai,
Ogum Xoroquê!
Ôh, Ogum
Ôh, Ogunhê, iê,iê
Ôh, Ogum
Ogum Xoroquê, iê,iê,iê,iê!
Ôh, Ogum
Ôh, Ogunhê, iê,iê
Ôh, Ogum
Ogum Xoroquê!
Meu senhor das estradas,
Ogunhê!
Abra meus caminhos,
Ogunhê!
Meu senhor da porteira,
Ogunhê!
Eleé meu pai, Ogum Xoroquê,iê, iê,iê,iê!
Ôh, Ogum
Ôh, Ogunhê, iê,iê
Ôh, Ogum
Ogum Xoroquê!$c48e5998938834dda31241013883f267e$, NULL, now()),
('b0054e1a-30da-04d4-019b-036fa92cf2c2', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb0054e1a30da04d4019b036fa92cf2c2$Ogum - Bandeira içada / Bandeira linda /Ogum olha sua bandeira$tb0054e1a30da04d4019b036fa92cf2c2$, $cb0054e1a30da04d4019b036fa92cf2c2$Bandeira içada é sinalde uma vitória
nos campos do Humaitá
ena Umbanda vamos todos saravá
lindafalange que sabe guerrear
Seu Beira Mar, Ogum Nagô
Seu Rompe Mato, Seu Ogum de Lê
Ogum Iara,Seu Naruê
e aívem seu Ogum Megê$cb0054e1a30da04d4019b036fa92cf2c2$, NULL, now()),
('fc1c9d59-db50-aa0b-b168-eb2e8b357e2c', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tfc1c9d59db50aa0bb168eb2e8b357e2c$Ogum - Braço armado de Olorum$tfc1c9d59db50aa0bb168eb2e8b357e2c$, $cfc1c9d59db50aa0bb168eb2e8b357e2c$Ogum, Ogum
Ogum, Ogunhê...
Ogum, Ogunhê
é o braço armado do paiOlorum
Cavaleiro de umbanda, é Ogum
quem vence as demandas, é Ogum
é o senhor da lei,é Ogum
quem rege meus caminhos, é Ogum
Ogum, Ogum
Ogum, Ogunhê...
quem guarda as cachoeiras, é Ogum
quem guarda as pedreiras, é Ogum
quem guarda o cemitério, é Ogum
Ogum, Ogunhê
é o braço armado do paiOlorum$cfc1c9d59db50aa0bb168eb2e8b357e2c$, NULL, now()),
('0dceefa7-0408-cf34-e16d-28cbe486f362', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t0dceefa70408cf34e16d28cbe486f362$Ogum - Ogum Valente$t0dceefa70408cf34e16d28cbe486f362$, $c0dceefa70408cf34e16d28cbe486f362$Ogum, valente guerreiro
Vem abrir nosso terreiro
Para a Umbanda começar
Ogum, valente guerreiro
Vem abrir nosso terreiro
Para a Umbanda começar
Xangô, que é dono da pedreira
Mãe Oxum da cachoeira
Iemanjá, rainha do mar
Xangô, que é dono da pedreira
Mãe Oxum da cachoeira
Iemanjá, rainha do mar
Oke, Arô, os caboclos na floresta
A Umbanda está em festa
Para ver Ogum chegar
Okê, Arô, os caboclos na floresta
A Umbanda está em festa
Para ver Ogum chegar
Ogum, Ogum, Ogunhê
Veio salvar a nossa fé
Ogum, Ogum, Ogunhê
Veio salvar a nossa fé
Ogum, valente guerreiro
Vem abrirnosso terreiro
Para a Umbanda começar
Ogum, valente guerreiro
Vem abrirnosso terreiro
Para a Umbanda começar
Xangô, que é dono da pedreira
Mãe Oxum da cachoeira
Iemanjá, rainha do mar
Xangô, que é dono da pedreira
Mãe Oxum da cachoeira
Iemanjá, rainha do mar
Oke, Arô, os caboclos na floresta
A Umbanda está em festa
Para ver Ogum chegar
Okê, Arô, os caboclos na floresta
A Umbanda está em festa
Para ver Ogum chegar
Ogum, Ogum, Ogunhê
Veio salvar a nossa fé
Ogum, Ogum, Ogunhê
Veio salvar a nossa fé$c0dceefa70408cf34e16d28cbe486f362$, NULL, now()),
('1d1ae282-8b07-461b-b8cb-98b51a0357f7', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t1d1ae2828b07461bb8cb98b51a0357f7$Ogum, força sagrada do Divino Criador$t1d1ae2828b07461bb8cb98b51a0357f7$, $c1d1ae2828b07461bb8cb98b51a0357f7$Ogum,
Senhor da guerra,
É sentinela, cavaleiro de Oxalá
Ogum,
É fortaleza,a leisuprema
Patakori, é Orixá!
(Bis)
Grandioso paiguerreiro
Força sagrada do Divino Criador
Ogum reina em meus caminhos
Com suas bênçãos eu jásou um vencedor
Com seu exército
Conduz o meu destino
Meu paiOgum,
Dai-me a paz, traz as vitórias
Aço da espada que refleteem meus caminhos
És minha luz,para meus dias de glória!
Ogum!$c1d1ae2828b07461bb8cb98b51a0357f7$, NULL, now()),
('80091315-5e34-5ae6-ae69-7957797d8996', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t800913155e345ae6ae697957797d8996$Ogum - Ogum de Ronda (cover)$t800913155e345ae6ae697957797d8996$, $c800913155e345ae6ae697957797d8996$Ogum Dilê, Babá
Ogum Megê...
Ogum Maiê, Bará
Ogum Menê
Ogum Dilê, Babá
Ogum Megê...
Ogum Maiê, Bará
Ogum Menê
Na Ronda de Ogum
Meu Santo Protetor
Com o Poder de Sua Espada
Eu defendo o meu amor
É o Guardião da Terra
Major dos Orixás
Ogum é o Deus da Guerra
Mas guerreia pela Paz
Onde eu for,que o mal se esconda
E não saia da onde está
Porque eu tenho Ogum de Ronda
No clarão do meu olhar
Ogum Dilê, Babá
Ogum Megê...
Ogum Maiê, Bará
Ogum Menê...
Ogum Dilê, Babá
Ogum Megê...
Ogum Maiê, Bará
Ogum Menê...
Ehô, ehô, chegou Ogum com seu mariô
Ehô, ehô, é de demanda! Ogum de Ronda chegou
Ehô, ehô, chegou Ogum com seu mariô
Ehô, ehô, é de demanda! Ogum de Ronda chegou...
Ogum Dilê, Babá
Ogum Megê...
Ogum Maiê, Bará
Ogum Menê...
Ogum Dilê, Babá
Ogum Megê...
Ogum Maiê, Bará
Ogum Menê...$c800913155e345ae6ae697957797d8996$, NULL, now()),
('5c248ae7-c746-e2e2-cefd-78dba4aefdde', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t5c248ae7c746e2e2cefd78dba4aefdde$Ogum - Eu não seria nada$t5c248ae7c746e2e2cefd78dba4aefdde$, $c5c248ae7c746e2e2cefd78dba4aefdde$Eu não serianada
Se não fosse Ogum
Para abrira minha estrada
Eu não seria
Eu não serianada
Se não fosse Ogum
Para abrira minha estrada
Valente guerreiro
Aqui chegou
Vencedor de demandas
Meu protetor
Em sua trajetória
Meu pailuta contra o mal
Foinos campos de batalha
Que se tornou um general
Eu não seria
Eu não serianada
Se não fosse Ogum
Para abrira minha estrada
Eu não seria
Eu não serianada
Se não fosse Ogum
Para abrira minha estrada
Salve Ogum de Ronda
Salve Ogum Megê
Saravá Beira-Mar
Ogum Iara e Ogum Dilê
Salve toda falange
Desse glorioso guerreiro
Meu paivence demandas
Aqui dentro do terreiro
Eu não seria
Eu não serianada
Se não fosse Ogum
Para abrira minha estrada$c5c248ae7c746e2e2cefd78dba4aefdde$, NULL, now()),
('921a0da4-cccb-7393-877a-a2d203ca394b', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t921a0da4cccb7393877aa2d203ca394b$Ogum - O filho de Ogum$t921a0da4cccb7393877aa2d203ca394b$, $c921a0da4cccb7393877aa2d203ca394b$Eu sou filhade Naruê
Armada com as espadas de Megê
Ungida pelas mãos de Matinata
Regida pelas leisde Ogum de Lei
Meu protetoré Beira Mar
Iarano caminho a me guiar
Coragem quem me deu foiRompe-Mato
Ogum me ensinou o que é amar
Ogum, meu pai, vem me valer
Na fé de Zambi, nada vou temer
Ogum, meu pai, vem me guiar
Na minha estrada caminhar
Ogum, meu pai, vem me valer
Na fé de Zambi, nada vou temer
Ogum, meu pai, vem me guiar
Na minha estrada caminhar
Eu sou filhade Naruê
Armada com as espadas de Megê
Ungida pelas mãos de Matinata
Regida pelas leisde Ogum de Lei
Meu protetoré Beira Mar
Iarano caminho a me guiar
Coragem quem me deu foiRompe-Mato
Ogum me ensinou o que é amar
Ogum, meu pai, vem me valer
Na fé de Zambi, nada vou temer
Ogum, meu pai, vem me guiar
Na minha estrada caminhar
Ogum, meu pai, vem me valer
Na fé de Zambi, nada vou temer
Ogum, meu pai, vem me guiar
Na minha estrada caminhar$c921a0da4cccb7393877aa2d203ca394b$, NULL, now()),
('252ff341-a83d-ea80-9d1a-39f0e1e24325', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t252ff341a83dea809d1a39f0e1e24325$Ogum - Guerreiro de Umbanda$t252ff341a83dea809d1a39f0e1e24325$, $c252ff341a83dea809d1a39f0e1e24325$Ogum meu guerreirode Umbanda
Cavaleiro supremo
Vencedor de demanda
Ogum meu guerreirode Umbanda
Cavaleiro supremo
Vencedor de demanda
É sentinela de paiOxalá
É remador de Iemanjá
Senhor da lua
Ilumina meus caminhos
Toma conta da minha vida
E me livredos perigos
Senhor da lua
Ilumina meus caminhos
Toma conta da minha vida
E me livredos perigos
Ogum meu guerreirode Umbanda
Cavaleiro supremo
Vencedor de demanda
Ogum meu guerreirode Umbanda
Cavaleiro supremo
Vencedor de demanda
É sentinela de pai Oxalá
É remador de Iemanjá
Senhor da lua
Ilumina meus caminhos
Toma conta da minha vida
E me livredos perigos
Senhor da lua
Ilumina meus caminhos
Toma conta da minha vida
E me livredos perigos$c252ff341a83dea809d1a39f0e1e24325$, NULL, now()),
('bf59f0e3-fc84-a870-dac0-b08e8df81ea1', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tbf59f0e3fc84a870dac0b08e8df81ea1$Ogum - Pisa na linha de Umbanda$tbf59f0e3fc84a870dac0b08e8df81ea1$, $cbf59f0e3fc84a870dac0b08e8df81ea1$Pedimos licença a Zambi
A Oxum e Iemanjá
Para abrirnossos trabalhos
Com a bandeira de Oxalá
Saravá Ogum
Saravá gongá
Saravá Ogum
Saravá gongá
Saravá seu Sete Ondas
Eleé rei,é orixá
Saravá as Almas
Saravá congá
Saravá as Almas
Saravá congá
Pisa na linhade Umbanda
Que eu quero ver
Ogum Sete Ondas
Pisa na linhade Umbanda
Que eu quero ver
Ogum Beira Mar
Pisa na linhade Umbanda
Que eu quero ver
Ogum Iara
Ogum Megê
Seu cangira de Umbanda auê
Ora pisa no reino,ô cangira
Ora pisa no reino,ô cangira
Ora pisa no reino,ô cangira
Tata de Umbanda, ô cangira$cbf59f0e3fc84a870dac0b08e8df81ea1$, NULL, now()),
('956bd000-c604-f2c5-9b65-4b47c09fe389', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t956bd000c604f2c59b654b47c09fe389$Ogum - Ele é cavaleiro santo$t956bd000c604f2c59b654b47c09fe389$, $c956bd000c604f2c59b654b47c09fe389$Eleé cavaleiro santo
Seu cavalo ébranco
Ele égeneral
É forte
Usa armadura
Ele évalente
Luta contra o mal
Ele évalente
Luta contra o mal
A sua espada é reluzente
Pra defender a gente
Não deixar cair
Ele énosso pai Ogum
Ele éJessi Jessi
Ele éPatacore
Ele éJessi Jessi
Ele éPatacore$c956bd000c604f2c59b654b47c09fe389$, NULL, now()),
('98d2b835-14e2-eb06-f3d1-3cdd66f0e246', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t98d2b83514e2eb06f3d13cdd66f0e246$Ogum da Lua - Clareia Umbanda$t98d2b83514e2eb06f3d13cdd66f0e246$, $c98d2b83514e2eb06f3d13cdd66f0e246$Ogum da Lua, o que traz das estrelas?
Meu pai,o que trouxe de lá?
Trouxe uma estrelacadente
Para brilharnesse congá
Clareia Umbanda, clareia
Clareia oHumaitá
Ogum da Lua que trouxe
A luzde Pai Oxalá$c98d2b83514e2eb06f3d13cdd66f0e246$, NULL, now()),
('497f2bfc-e856-a3c8-bd43-a7f73c5b21c9', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t497f2bfce856a3c8bd43a7f73c5b21c9$Ogum - Cavaleiro de Ogum$t497f2bfce856a3c8bd43a7f73c5b21c9$, $c497f2bfce856a3c8bd43a7f73c5b21c9$Ogum, a sua espada brilha
Ogum, a sua espada reluz
Ogum é mensageiro de Umbanda
Ogum é cavaleiro de Jesus
Ogum, Ogum está de ronda
Ogum, Ogum veio rondar
Nos quatro cantos do mundo
Nas sete ondas do mar (Ogum iê)$c497f2bfce856a3c8bd43a7f73c5b21c9$, NULL, now()),
('bf4404da-afec-629f-e1c7-87a4d6097180', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tbf4404daafec629fe1c787a4d6097180$Ogum - A nobreza de um Guerreiro$tbf4404daafec629fe1c787a4d6097180$, $cbf4404daafec629fe1c787a4d6097180$Luar prateado clareiaa Terra, clareiao mar
Luar prateado clareiaos Orixás na Aruanda
Clareia Ogum no Humaitá
Quando eu vim láde Aruanda, pra minha missão cumprir
Foienviado um cavaleiro para ao meu lado eleseguir
E a noiteestrelas brilham, cadentes cruzam o céu
E o sereno que caía,na aba do meu chapéu
Montado em meu cavalo, como o meu pai guerreiro
Nas batalhas dessa vida eu lutocom meu padroeiro
Na noite ele bradou primeiro me deu espada
Pra cortar todos perigos, e abrirtodas estradas
A lança de ponta firme me deu para nunca errar
A pesca e a caça é mais farta,me ensinou compartilhar
O escudo foimaior, me deu pra sobreviver
Travar todas armadilhas, das demandas defender
Capa longa e vermelha, me vestiu pra proteger
E Oxalá é quem me guia,para a fé eu não perder
Lua cheia clareiao mundo inteirocom a sua luz
Faz brilhar em cada um o sentimento que conduz
Para a paz reinar na Terra, como ensinou Jesus
Lua cheia morada de Ogum, do guerreiro vencedor
São Jorge é protetor, e na Umbanda general
Batalha é pela vida,faz o bem vencer o mal
Ogum, Ogum, Ogum
Mandou seus filhoslevarem no coração
Sempre lutaipelos pobres
Pois não há coisa mais nobre, que lutar por seus irmãos$cbf4404daafec629fe1c787a4d6097180$, NULL, now()),
('9a0433a8-846f-c5bb-a8a1-635786b2d60c', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t9a0433a8846fc5bba8a1635786b2d60c$Ogum - Seu cavalo corre / Ogum oiá$t9a0433a8846fc5bba8a1635786b2d60c$, $c9a0433a8846fc5bba8a1635786b2d60c$Seu cavalo corre, sua espada reluz
Sua bandeira cobre, todos filhosde Jesus
Se seu cavalo corre, sua espada reluz
Auê seu Ogum Yara, aos pés da Santa Cruz$c9a0433a8846fc5bba8a1635786b2d60c$, NULL, now()),
('fb48d5f5-4b07-9e39-3382-ec96341df960', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tfb48d5f54b079e393382ec96341df960$Ogum - Ogunhê Cavaleiro de Oxalá$tfb48d5f54b079e393382ec96341df960$, $cfb48d5f54b079e393382ec96341df960$Quando a noite caie a luasai
É quando o cavaleiro
Sai pra guerrear
Ele que vem de Aruanda
Cortando as demandas
O Orixá que comanda
Assim é Ogum, Ogunhê!
Cavaleiro de Umbanda
Quando a noite caie a luasai
É quando o cavaleiro
Sai pra guerrear
É ele que guarda o terreiro
De espada na mão
Montado em seu cavalo
Ele venceu o dragão
Senhor do Humaitá
Assim é Ogum, Ogunhê!
Cavaleiro de Oxalá$cfb48d5f54b079e393382ec96341df960$, NULL, now()),
('f6580e11-5d69-958b-0857-61ea8149478e', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tf6580e115d69958b085761ea8149478e$Ogum - Clareia luar$tf6580e115d69958b085761ea8149478e$, $cf6580e115d69958b085761ea8149478e$A lua que clareia a terra
clareiaa mata, cachoeira, rio emar
A lua que clareia nossa Umbanda
clareiaesse guerreiro quando vem do Humaitá
clareia,clareialuar, clareia,clareia luar
clareia,Pai Ogum, Seu Beira Mar
Clareia Pai Ogum a nossa terra
que vossa luz ilumine os corações
que os seus filhosencontre o amor e o perdão
Essa é a leique o pai deixou pra criação
que sua espada, corte o mal e a paz reinar
nas estradas da vida aonde seus filhosvão passar$cf6580e115d69958b085761ea8149478e$, NULL, now()),
('aef0f128-4593-4e95-0cd8-921fb2b1b953', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $taef0f12845934e950cd8921fb2b1b953$Ogum - Jurou bandeira$taef0f12845934e950cd8921fb2b1b953$, $caef0f12845934e950cd8921fb2b1b953$Ogum jájurou bandeira
Ogum elevai jurar
Ogum jájurou bandeira
nos campos do Humaitá
auê Capitão Marambaia
auê General Guanabara
Ogum meu senhor São Jorge
vamos fazer aliança
meu Pai venha me valer
com sua espada esua lança
auê Capitão Marambaia
auê General Guanabara$caef0f12845934e950cd8921fb2b1b953$, NULL, now()),
('f439173f-c06c-3bc5-202e-85fe67f8fd01', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tf439173fc06c3bc5202e85fe67f8fd01$Ogum - Já tocou clarim$tf439173fc06c3bc5202e85fe67f8fd01$, $cf439173fc06c3bc5202e85fe67f8fd01$Bendito louvado seja, saravá Umbanda, saravá Ogum
jávenceu demanda, Seu Ogum tocou clarim
jávenceu demanda
játocou clarim
jávenceu demanda
seu Ogum tocou clarim$cf439173fc06c3bc5202e85fe67f8fd01$, NULL, now()),
('4862d559-9d89-c9c3-739a-88626b7e7af8', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t4862d5599d89c9c3739a88626b7e7af8$Ogum - Eu não seria nada, se não fosse Ogum$t4862d5599d89c9c3739a88626b7e7af8$, $c4862d5599d89c9c3739a88626b7e7af8$Eu não seria nada
se não fosse Ogum
para abrir
aminha estrada [2x]
Valente guerreiro
aquichegou
vencedor de demandas
meu protetor
Em sua trajetória
meu Pailuta contra o mal
foinos campos de batalha
que se tornou general
Eu não seria nada
se não fosse Ogum
para abrir
aminha estrada [2x]
Salve Ogum de Ronda
salveOgum Megê
salveSeu Beira-mar
Ogum Iara e Ogum Dilê
Salve todas falanges
desse glorioso guerreiro
que vence todas demandas
aquidentro do terreiro
Eu não seria nada
se não fosse Ogum
para abrir
aminha estrada [2x]$c4862d5599d89c9c3739a88626b7e7af8$, NULL, now()),
('64e7fb94-cfc5-04e0-f2c2-faf384e11bf2', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t64e7fb94cfc504e0f2c2faf384e11bf2$Ogum - Nos campos do Humaitá$t64e7fb94cfc504e0f2c2faf384e11bf2$, $c64e7fb94cfc504e0f2c2faf384e11bf2$Nos campos do Humaitá
Ogum guerreou e venceu [2x]
Ganhou divisa de general
foiSão José e Maria quem deu [2x]$c64e7fb94cfc504e0f2c2faf384e11bf2$, NULL, now()),
('0653c250-fcfd-78b8-9481-7e72d965bda3', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t0653c250fcfd78b894817e72d965bda3$Ogum - Bandeira linda de Ogum$t0653c250fcfd78b894817e72d965bda3$, $c0653c250fcfd78b894817e72d965bda3$Bandeira linda de Ogum
que está içada láno Humaitá [2x]
Representando general de Umbanda
Ogum venceu demanda lá no Humaitá [2x]$c0653c250fcfd78b894817e72d965bda3$, NULL, now()),
('e72ae51b-f1f3-c337-bf54-5722b7de2aa4', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $te72ae51bf1f3c337bf545722b7de2aa4$Ogum - Ogum orixá guerreiro$te72ae51bf1f3c337bf545722b7de2aa4$, $ce72ae51bf1f3c337bf545722b7de2aa4$Ogum é guerreiro
que nos livrade todo mal
na Aruanda eleé cavaleiro
oh na Umbanda ele é general
Ogunhê
Quando a Umbanda surgiu
nesse Orixa Oxala confiou
pratomar conta de todos caminhos
em cada canto uma falange ficou
Ogunhê
Ogum é guerreiro
que nos livrade todo mal
na Aruanda eleé cavaleiro
oh na Umbanda ele é general
Ogunhê
Nos campos de Humaita
foionde ele batalhou
pradefender o seus filhosda terra
ecom sua espada a demanda quebrou
Ogunhê
Ogum é guerreiro
que nos livrade todo mal
na Aruanda eleé cavaleiro
oh na Umbanda ele é general
Ogunhê$ce72ae51bf1f3c337bf545722b7de2aa4$, NULL, now()),
('e32eadc3-63ca-bd98-06f3-d7889df31247', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $te32eadc363cabd9806f3d7889df31247$Ogum - Se meu pai é Ogum$te32eadc363cabd9806f3d7889df31247$, $ce32eadc363cabd9806f3d7889df31247$Se meu Pai é Ogum
vencedor de demandas
elevem de Aruanda
prasalvar filhosde Umbanda
Ogum, Ogum Iara
Ogum, Ogum Iara
salveos campos de batalha
salvea sereia do mar
Ogum, Ogum Iara
Saravá Ogum, Ogum Iara$ce32eadc363cabd9806f3d7889df31247$, NULL, now()),
('613dcd35-a6b1-cab6-0c72-f2408307a755', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t613dcd35a6b1cab60c72f2408307a755$Ogum - Ogum me disse que dançar Nago é bom$t613dcd35a6b1cab60c72f2408307a755$, $c613dcd35a6b1cab60c72f2408307a755$Ogum me disse
que dançar Nagô é bom [2x]
que dançar Nagô é bom
que dançar Nagô é bom
que dançar Nagô é bom
que dançar Nagô é bom$c613dcd35a6b1cab60c72f2408307a755$, NULL, now()),
('b8d97f09-67d2-ac71-55a9-c1b8dc1e363d', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb8d97f0967d2ac7155a9c1b8dc1e363d$Ogum - Ogum olha sua bandeira$tb8d97f0967d2ac7155a9c1b8dc1e363d$, $cb8d97f0967d2ac7155a9c1b8dc1e363d$Ogum olha sua bandeira
ébranca, é verde, é encarnada [2x]
Ogum nos campos de batalha
Elevenceu a guerra
sem perder soldados [2x]$cb8d97f0967d2ac7155a9c1b8dc1e363d$, NULL, now()),
('35474a34-1e2f-0639-bdbe-b564623e97d1', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t35474a341e2f0639bdbeb564623e97d1$Ogum - Saravá meu pai$t35474a341e2f0639bdbeb564623e97d1$, $c35474a341e2f0639bdbeb564623e97d1$Oh Ogum iê
saravá meu Pai vem me valer [2x]
Oh livrai-meda dor, da peste e da guerra
proteção meu Pai pranossa terra[2x]
jessi,jessi,jessiéde patakori Ogum
jessi,jessi,jessiOgum meu pai
jessi,jessi,jessiéde patakori Ogum
quem é filhodeOgum não cai [2x]$c35474a341e2f0639bdbeb564623e97d1$, NULL, now()),
('b74da330-56f3-e40b-5dff-0a80caad10b3', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb74da33056f3e40b5dff0a80caad10b3$Ogum - Estava na beira da praia$tb74da33056f3e40b5dff0a80caad10b3$, $cb74da33056f3e40b5dff0a80caad10b3$Estava na beira da praia
mas quando eu vi
seteondas passar [2x]
Abre a portaoh gente
que aívem Ogum
com seu cavalo marinho
elevem saravá [2x]$cb74da33056f3e40b5dff0a80caad10b3$, NULL, now()),
('240f1bb1-8fe2-9d00-195b-c89693ced0c8', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t240f1bb18fe29d00195bc89693ced0c8$Ogum - Mandei fazer um capacete de penas$t240f1bb18fe29d00195bc89693ced0c8$, $c240f1bb18fe29d00195bc89693ced0c8$Mandei fazer
um capacete de penas
para usar
antes da alvorada
vermelho e branco
verde e azul
esse capacete
tem as cores de Ogum [2x]
de Ogum megê
de Ogum matinata
de Ogum megê
de Ogum matinata
Quando uso o capacete
ouço o toque da alvorada [2x]$c240f1bb18fe29d00195bc89693ced0c8$, NULL, now()),
('92f200b3-5697-bd3d-2052-170e554be4b8', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t92f200b35697bd3d2052170e554be4b8$Ogum - Na lua nova na Umbanda ele é Ogum$t92f200b35697bd3d2052170e554be4b8$, $c92f200b35697bd3d2052170e554be4b8$Na lua nova na Umbanda ele é Ogum
Na lua nova na Umbanda ele é Ogum
Ogum iê
Zambi ele é Ogum
Ogum iê
Zambi eleé Ogum [2x]$c92f200b35697bd3d2052170e554be4b8$, NULL, now()),
('996d0533-2086-0700-e0e2-89b1e3a8ed14', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t996d053320860700e0e289b1e3a8ed14$Ogum - Beira Mar, auê Beira Mar$t996d053320860700e0e289b1e3a8ed14$, $c996d053320860700e0e289b1e3a8ed14$Beira-mar, auê beira-mar
Beira-mar, auê beira-mar
Beira-mar, auê beira-mar
Beira-mar, auê beira-mar
Ogum já jurou bandeira
nos campos do Humaitá
Ogum já venceu demanda
vamos todos saravá
Beira-mar, auê beira-mar
Beira-mar, auê beira-mar
Beira-mar, auê beira-mar
Beira-mar, auê beira-mar$c996d053320860700e0e289b1e3a8ed14$, NULL, now()),
('b1c64ad4-de19-b0d2-a07e-afd7cbfe0f08', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb1c64ad4de19b0d2a07eafd7cbfe0f08$Ogum - Lanceiro de Oxalá$tb1c64ad4de19b0d2a07eafd7cbfe0f08$, $cb1c64ad4de19b0d2a07eafd7cbfe0f08$Lanceiro
Lanceiro
Lanceiro de Oxalá [2x]
Bendito louvado seja
orameu Deus
ahora que Ogum nasceu [2x]$cb1c64ad4de19b0d2a07eafd7cbfe0f08$, NULL, now()),
('f3f4f8d5-31b6-ece1-af9f-f0a153fea264', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tf3f4f8d531b6ece1af9ff0a153fea264$Ogum Beira Mar - O que trouxe do mar$tf3f4f8d531b6ece1af9ff0a153fea264$, $cf3f4f8d531b6ece1af9ff0a153fea264$Ogum Beira-mar
oque trouxe do mar
Ogum Beira-mar
oque trouxe do mar
Quando ele vem
vem beirando a areia
na mão direita
eletrás a guia da mamãe sereia
Quando ele vem
vem beirando a areia
na mão direita
eletrás a guia da mamãe sereia$cf3f4f8d531b6ece1af9ff0a153fea264$, NULL, now()),
('fc6a9714-f558-021f-c990-f551f64cff1a', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tfc6a9714f558021fc990f551f64cff1a$Ogum - Na porta da romaria$tfc6a9714f558021fc990f551f64cff1a$, $cfc6a9714f558021fc990f551f64cff1a$Na porta da romaria
eu vium cavaleirode ronda
Na porta da romaria
eu vium cavaleirode ronda
Eletrazia
um escudo no peito e uma lançana mão
Ogum guerreou, venceu a guerra
ematou o dragão
Eletrazia
um escudo no peito e uma lançana mão
Ogum guerreou, venceu a guerra
ematou o dragão$cfc6a9714f558021fc990f551f64cff1a$, NULL, now()),
('81beb7d1-dcbe-fedc-3c21-17578a4dab9e', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t81beb7d1dcbefedc3c2117578a4dab9e$Ogum - Ogum de Ronda$t81beb7d1dcbefedc3c2117578a4dab9e$, $c81beb7d1dcbefedc3c2117578a4dab9e$Auê Ogum Auê
Auê Ogum Saravá (2x)
Pisana linhade Umbanda que eu quero ver Ogum de Ronda
Pisana linhade Umbanda que eu quero ver Ogum quebra mironga (2x)
Auê Ogum Auê
Auê Ogum Saravá (2x)
Pisana linhade Umbanda que eu quero ver Ogum de Ronda
Pisana linhade Umbanda que eu quero ver Ogum quebra mironga (2x)$c81beb7d1dcbefedc3c2117578a4dab9e$, NULL, now()),
('c8549b0a-606d-f422-fba1-5d7026664c5b', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tc8549b0a606df422fba15d7026664c5b$Ogum - Vencedor de Demandas$tc8549b0a606df422fba15d7026664c5b$, $cc8549b0a606df422fba15d7026664c5b$Ogum Cavaleiro de Umbanda
Vencedor de Demandas
Não deixa filhotombar (2x)
No luarele chama a sereia
Risca o ponto na areia
Unindo as forças com o mar
E quando elechega na aldeia
As estrelasclareiam pra ver Ogum trabalhar (2x)$cc8549b0a606df422fba15d7026664c5b$, NULL, now()),
('b51da8bf-ac94-856f-a454-28ebcb38ea1e', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tb51da8bfac94856fa45428ebcb38ea1e$Ogum - Santo Padroeiro$tb51da8bfac94856fa45428ebcb38ea1e$, $cb51da8bfac94856fa45428ebcb38ea1e$Oh, Meu São Jorge Guerreiro
Meu Santo Padroeiro
Que na Umbanda é Ogum
Quem faz sua espada brilharSr. Ogum
Sua lança, seu elmo dourado é Jesus
Oh, Meu São Jorge Guerreiro
Meu Santo Padroeiro
Que na Umbanda é Ogum
Quem faz sua espada brilharSr. Ogum
Sua lança, seu elmo dourado é Jesus
Elejá chegou no terreiro
Vem meu São Jorge Guerreiro
Vem pra Umbanda de luz
Quem faz sua espada brilharSr. Ogum
Sua lança, seu elmo dourado é Jesus$cb51da8bfac94856fa45428ebcb38ea1e$, NULL, now()),
('9164383c-9989-ef32-7e3f-88128316e074', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t9164383c9989ef327e3f88128316e074$Ogum - General de Umbanda - Tenha Fé Nesse Guerreiro$t9164383c9989ef327e3f88128316e074$, $c9164383c9989ef327e3f88128316e074$Ogum é general da Umbanda
Cavaleiro de Aruanda
Vem pra Umbanda vem cá
Não há mal e nem demanda
Que Ogum com sua força
Não consiga derrubar
Vem montado em seu cavalo
7lanças ,Rompe Mato
Ogum Iara vem cá
Tenha medo feiticeiro
Salve São Jorge Guerreiro
Que chegou pra trabalhar
Ogum !
Grande general da Umbanda eu vou louvar !
Tenha fénesse guerreiro
O amor de Sr Ogum espalha luz ao mundo inteiro
Ogum !
Grande general da Umbanda eu vou louvar
Tenha medo Feiticeiro
É do ouro de Oxum a armadura do guerreiro
Saravá Ogum
Vem me ajudar
Saravá Ogum
Vem me proteger
Oisalve Ogum ,salve o povo de Aruanda
Saravá seu 7Luas que chegou no meu terreiro
Ogum - Cavaleiro de Oxalá$c9164383c9989ef327e3f88128316e074$, NULL, now()),
('9fb5d74d-7dae-f639-8850-58f1ace577fe', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t9fb5d74d7daef639885058f1ace577fe$Página42de 49$t9fb5d74d7daef639885058f1ace577fe$, $c9fb5d74d7daef639885058f1ace577fe$Ogum a sua espada é de ouro
Ogum sua bandeira é de paz
Eu seique Ogum é reide Umbanda
quem pede com fé tudo elefaz
Salve Ogum, Ogum, Ogum nesse gongá
Ogum é cavaleiro de Oxalá$c9fb5d74d7daef639885058f1ace577fe$, NULL, now()),
('bd27641f-cef2-388c-a591-68f22e9c59c5', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tbd27641fcef2388ca59168f22e9c59c5$Subida Ogum - Selei seu cavalo$tbd27641fcef2388ca59168f22e9c59c5$, $cbd27641fcef2388ca59168f22e9c59c5$Selei,selei,seu cavalo eu selei
paiOgum jávai embora, seu cavalo eu selei
vaicom Deus e Nossa Senhora, seu cavalo eu selei
Seu ordenança mandou lhe avisar
que seu cavalo está pronto pra Ogum viajar
mas como é lindo no clarãoda lua
seu cavalo branco com a imagem sua$cbd27641fcef2388ca59168f22e9c59c5$, NULL, now()),
('3e4fcb84-4120-c1e7-6f03-40394c07c248', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t3e4fcb844120c1e76f0340394c07c248$Ogum - Bandeira içada$t3e4fcb844120c1e76f0340394c07c248$, $c3e4fcb844120c1e76f0340394c07c248$Bandeira içada é sinalde uma vitória
nos campos do Humaitá
ena Umbanda vamos todos saravá
lindafalange que sabe guerrear
Seu Beira mar, Ogum Nagô
Seu Rompa mato, seu Ogum de lê
Ogum iara,Seu Naruê
eaí vem Seu Ogum Megê$c3e4fcb844120c1e76f0340394c07c248$, NULL, now()),
('c9a0cd5f-1628-0b0f-6764-76d64a375a04', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tc9a0cd5f16280b0f676476d64a375a04$Ogum - Capacete de penas$tc9a0cd5f16280b0f676476d64a375a04$, $cc9a0cd5f16280b0f676476d64a375a04$Mandei fazer, um capacete de penas
para usar,antes da alvorada
Vermelho, branco, verde eazul
esse capacete tem as cores de Ogum
de Ogum Naruê, de Ogum Matinata
quando eu uso o capacete eu ouço toque de alvorada
Ogum - Iemanjá lhe coroou /Ordenança de Oxalá$cc9a0cd5f16280b0f676476d64a375a04$, NULL, now()),
('d8a4d1ff-5dd9-0133-6e74-01b591f8e760', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $td8a4d1ff5dd901336e7401b591f8e760$Página43de 49$td8a4d1ff5dd901336e7401b591f8e760$, $cd8a4d1ff5dd901336e7401b591f8e760$Lá no Humaitá
aonde Ogum guerreou
Foiem alto mar
que Iemanjá lhe coroou
/////////
Beira mar
Beira mar
ésentinela da Oxum
éremador de Iemanjá
Cavaleiro, eleé guerreiro
ordenança de Oxalá
Ogum Maiodé
Ogum Beira Mar$cd8a4d1ff5dd901336e7401b591f8e760$, NULL, now()),
('fd39b6ff-a224-8e7d-bd50-a9902d307032', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tfd39b6ffa2248e7dbd50a9902d307032$Ogum - Defensor do Cruzeiro do Sul - Cavaleiro de ronda$tfd39b6ffa2248e7dbd50a9902d307032$, $cfd39b6ffa2248e7dbd50a9902d307032$Que cavaleiroé aquele
que vem cavalgando sob o céu azul
éseu Ogum Matinata
eleé defensor do Cruzeiro do Sul
erêrê,erera
erêrê seu Cangira
pisana Umbanda
////////////////////
Na porta da romaria
eu vium cavaleiro de ronda
Trazia um escudo no peito euma lança na mão
Ogum guerreou, venceu a guerra ematou odragão$cfd39b6ffa2248e7dbd50a9902d307032$, NULL, now()),
('1e2cb9c5-6391-1a68-caea-3376c2ab3f43', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t1e2cb9c563911a68caea3376c2ab3f43$Ogum - Deus da guerra$t1e2cb9c563911a68caea3376c2ab3f43$, $c1e2cb9c563911a68caea3376c2ab3f43$Eleé cavaleiro de Aruanda
vencedor de demandas
eleé meu pai Ogum
elevem salvar seus filhos
com sua lança na mão
não teme a mal nenhum
meu pai Ogum, vem me proteger
meu pai Ogum, vem me ajudar
osenhor é o Deus da guerra
que venceu todas batalhas
nos campos do Humaitá$c1e2cb9c563911a68caea3376c2ab3f43$, NULL, now()),
('77c026f6-7af1-bbed-6ded-f21ebc4e67fb', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t77c026f67af1bbed6dedf21ebc4e67fb$Ogum Megê - Demandas com fracasso$t77c026f67af1bbed6dedf21ebc4e67fb$, $c77c026f67af1bbed6dedf21ebc4e67fb$Ogum Megê
na minha porteira vaientrar
trazendo a forçada calunga
aonde mora Omolú
cadeado é de ferro
sua espada é de aço
vaicortando as demandas
em mim jogadas com fracasso$c77c026f67af1bbed6dedf21ebc4e67fb$, NULL, now()),
('3f6c044c-fb26-6861-0a1b-92b7ec130903', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t3f6c044cfb2668610a1b92b7ec130903$Ogum - Cavaleiro supremo$t3f6c044cfb2668610a1b92b7ec130903$, $c3f6c044cfb2668610a1b92b7ec130903$Eu ouço o toque do clarim
nos campos do Humaitá
aonde Ogum guerreou
supremo, és um general de Umbanda
ésvencedor de demandas, Oxalá lheordenou
Lutando eternamente pela paz, é pai Ogum
nos campos de batalhas não abandona filhoalgum
valente,em suas mãos o meu destino entreguei
meu pai Ogum, sem o senhor não sou ninguém
Toca alvorada, é hora
cavaleirosupremo de pai Oxalá
guerreirode Aruanda
venha seus filhosguiar$c3f6c044cfb2668610a1b92b7ec130903$, NULL, now()),
('8300bc65-e17b-daf6-c3fc-b6b809ba6d0f', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t8300bc65e17bdaf6c3fcb6b809ba6d0f$Ogum - Sete ondas no congá$t8300bc65e17bdaf6c3fcb6b809ba6d0f$, $c8300bc65e17bdaf6c3fcb6b809ba6d0f$Sete ondas no mar,
Sete ondas na areia
Sete ondas na terra
Sete ondas no congá
Zambura a pemba, o lêlê
Zambura a pemba, o lálá
Zambura a pemba
deixa ovento carregar$c8300bc65e17bdaf6c3fcb6b809ba6d0f$, NULL, now()),
('cb5ac112-b7b2-35b4-0d60-2d98feff8aec', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tcb5ac112b7b235b40d602d98feff8aec$Ogum - Ogum meu pai$tcb5ac112b7b235b40d602d98feff8aec$, $ccb5ac112b7b235b40d602d98feff8aec$Ogum, Ogum meu pai
olhaipor nós aqui na terra
Ogum meu pai
dia23 de abril,os
clarinsjávão tocar
abram alasno terreiro
afalange vai chegar
vou chamar seu beira mar
Ogum iara,Ogum megê
Sete ondas, Rompe mato
firmaa gira,eu quero ver
Ogum, Ogum meu pai
olhaipor nós aqui na terra
Ogum meu pai
láno céu brilhando a lua
avisteimeu padroeiro
vendo a imagem de São Jorge
rezeipra Ogum guerreiro
as batalhas dessa vida
com meu paihei de vencer
fortemente chega armado
pronto pra me defender$ccb5ac112b7b235b40d602d98feff8aec$, NULL, now()),
('46cc5bc9-9d72-509d-5a43-6fa6942611d2', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t46cc5bc99d72509d5a436fa6942611d2$Ogum - Mensagem de Ogum$t46cc5bc99d72509d5a436fa6942611d2$, $c46cc5bc99d72509d5a436fa6942611d2$Vinha caminhando pela estrada
numa noiteenluarada
ao longe ouvi o som de um clarim
Ogum com sua espada embainhada
sua capa encarnada
traziauma mensagem para mim
levaia bandeira da caridade
do amor e da verdade
poresse mundo sem fim
que eu estarei sempre ao seu lado
pronto pra lheajudar
quando precisares de mim
Ogum iê
meu paiOgum está sempre a me proteger
Ogum iê
com ele ao meu lado o mal jamais vaime vencer$c46cc5bc99d72509d5a436fa6942611d2$, NULL, now()),
('8a0a5752-8b4f-84ab-7e5e-d84854ec5be8', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t8a0a57528b4f84ab7e5ed84854ec5be8$Ogum - Ogum tá peleando$t8a0a57528b4f84ab7e5ed84854ec5be8$, $c8a0a57528b4f84ab7e5ed84854ec5be8$aiOdé, diz Ogum tápeleando
aiOdé, diz Ogum tápeleando
aiOdé, diz Ogum tápeleando
aiOdé, diz Ogum tápeleando
em seu cavalo branco
de capacete eespada
eleé seu Ogum Matinada o paranga
ronda de madrugada
Ogum - Seu Rompe mato é general$c8a0a57528b4f84ab7e5ed84854ec5be8$, NULL, now()),
('2f060209-5411-c320-4fbe-5d4348c85cf1', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t2f0602095411c3204fbe5d4348c85cf1$Página47de 49$t2f0602095411c3204fbe5d4348c85cf1$, $c2f0602095411c3204fbe5d4348c85cf1$Ogum iê,
Ogum ieie ea
eleé Ogum Rompe Mato
que vem trabalhar
vem em seu cavalo branco
dos campos do Humaitá
com suas armas de guerra
seu Rompe Mato é general$c2f0602095411c3204fbe5d4348c85cf1$, NULL, now()),
('c71b632a-a59e-9a02-d7c5-8162b4fa207a', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $tc71b632aa59e9a02d7c58162b4fa207a$Ogum Megê - Não me deixe sofrer$tc71b632aa59e9a02d7c58162b4fa207a$, $cc71b632aa59e9a02d7c58162b4fa207a$Ogum Megê
não me deixe sofrer
não me deixe chorar
tantoassim [2x]
quando eu morrer
epassar porAruanda
eu vou pedirpra pai Ogum
saravara nossa banda$cc71b632aa59e9a02d7c58162b4fa207a$, NULL, now()),
('2d74e859-e790-fad0-1e4c-3d201df173f5', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t2d74e859e790fad01e4c3d201df173f5$Subida Ogum - Selei selei$t2d74e859e790fad01e4c3d201df173f5$, $c2d74e859e790fad01e4c3d201df173f5$seleiselei
seu cavalo selei
meu pai ogum javai embora
seu cavalo selei$c2d74e859e790fad01e4c3d201df173f5$, NULL, now()),
('aebce7f2-34b9-d3d5-0d8b-06130b99ed16', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $taebce7f234b9d3d50d8b06130b99ed16$Ogum - Ele vem remando$taebce7f234b9d3d50d8b06130b99ed16$, $caebce7f234b9d3d50d8b06130b99ed16$elevem remando
elevem navegando
com a sua canoa
quando ele chega na praia
aterratoda clareia
eleé Ogum Matinata
seu Matinata
firmaseu ponto na areia
quando ele chega na praia
eleé Ogum da Sereia[2x]$caebce7f234b9d3d50d8b06130b99ed16$, NULL, now()),
('d1527718-b419-a9c6-6d3a-d0ef4ed9de19', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $td1527718b419a9c66d3ad0ef4ed9de19$Ogum - Sua bandeira cobre os filhos de Jesus$td1527718b419a9c66d3ad0ef4ed9de19$, $cd1527718b419a9c66d3ad0ef4ed9de19$Ogum em seu cavalo corre
ea sua espada reluz
Ogum, Ogum Megê
sua bandeira cobre os filhosde Jesus , Ogum iê$cd1527718b419a9c66d3ad0ef4ed9de19$, NULL, now()),
('3b914961-ea82-76fa-e144-3054bd0f3891', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t3b914961ea8276fae1443054bd0f3891$Ogum - Ele venceu a guerra$t3b914961ea8276fae1443054bd0f3891$, $c3b914961ea8276fae1443054bd0f3891$elevenceu a guerra
eletocou clarim [2x]
elejurou justiça
elelutou pormim
são doisirmãos
na madrugada
seu Ogum Beira Mar
eseu Ogum Matinata$c3b914961ea8276fae1443054bd0f3891$, NULL, now()),
('61ac5649-f9ad-69fe-1fe8-deb4c65930a4', '3aa816f2-5a7f-aaa2-ea9a-200a4f71cc6e', $t61ac5649f9ad69fe1fe8deb4c65930a4$Ogum - Senhor das Estradas$t61ac5649f9ad69fe1fe8deb4c65930a4$, $c61ac5649f9ad69fe1fe8deb4c65930a4$oh Ogum
oh Ogum iê
oh Ogum
Ogum Xoroquê
meu senhor das estradas
Ogum iê
abra meus caminhos
Ogum iê
meu senhor da porteira
Ogum iê
eleé meu pai
Ogum Xoroquê$c61ac5649f9ad69fe1fe8deb4c65930a4$, NULL, now()),
('a703df7d-7242-9691-972a-20d848c1efea', '4e5aeee6-7861-cac7-db20-4a43b8402230', $ta703df7d72429691972a20d848c1efea$Oyá Logunan - O Tempo Virou$ta703df7d72429691972a20d848c1efea$, $ca703df7d72429691972a20d848c1efea$O tempo virou,láno fimdo horizonte
Foium lindoclarão,é Oyá que chegou
Elavem com sua espada
Acompanhada das guerreiras
Vem fazercumprir, Oyá
As leisde Oxalá$ca703df7d72429691972a20d848c1efea$, NULL, now()),
('3ce4009c-99e5-8f9d-0cad-594667512e7e', 'dd50b86b-6507-420e-115b-460ed55724c1', $t3ce4009c99e58f9d0cad594667512e7e$Atotô Omulú Obaluaê$t3ce4009c99e58f9d0cad594667512e7e$, $c3ce4009c99e58f9d0cad594667512e7e$2x
Olha aí quem chegou: Oxalá que mandou
Elechega dançando, é o Rei Atotô
2x
Obaluaê, Omulú, Obaluaê
Omulú, Obaluaê...
Velho Omulú que chegou, Atotô!
Sua mãe é Nanã, berço de Iemanjá
Senhor da Calunga, dono do Xaxará
Xapanã é guia, transborda amor e vida
Palhas sagradas lindas
Espalham pipoca no ar$c3ce4009c99e58f9d0cad594667512e7e$, NULL, now()),
('a7d464f6-521d-1c52-c604-8989e87b1a8c', 'dd50b86b-6507-420e-115b-460ed55724c1', $ta7d464f6521d1c52c6048989e87b1a8c$O Velho Omulu Vem Caminhando Devagar$ta7d464f6521d1c52c6048989e87b1a8c$, $ca7d464f6521d1c52c6048989e87b1a8c$O velho Omulu vem caminhando devagar -2x
Apoiado em seu cajado
Elevem nos ajudar -2x
Omulu é dono da terra
Atotô Obaluaê -2x$ca7d464f6521d1c52c6048989e87b1a8c$, NULL, now()),
('16a6aec9-5dac-3d8a-7d1e-1f51db27a047', 'dd50b86b-6507-420e-115b-460ed55724c1', $t16a6aec95dac3d8a7d1e1f51db27a047$Omolu - Elo Divino$t16a6aec95dac3d8a7d1e1f51db27a047$, $c16a6aec95dac3d8a7d1e1f51db27a047$É na terraque a vida há de continuar
Elodivino, gera um cicloa germinar
Guardiã da essência
De toda força ancestral
Omolu quem mora nela
Senhor do espiritual
Debaixo de suas palhas
É o sola me aquecer
E de joelhos
Eu venho agradecer
Por todos os dias
Comigo vircaminhar
Com sua benção e magia
Ser meu pai,meu Orixá
Empunha, meu velho, seu xaxará,
Das doenças que findam a vidavenha nos curar
Flagelos da humanidade
Transforma em perdão e bondade
Silêncio!
Omolú aqui está!
Empunha, meu velho, seu xaxará,
Das doenças que findam a vida venha nos curar
Flagelos da humanidade
Transforma em perdão e bondade
Silêncio!
Omolú aqui está!$c16a6aec95dac3d8a7d1e1f51db27a047$, NULL, now()),
('eb93bda6-b581-4fa9-a013-40989e7eea84', 'dd50b86b-6507-420e-115b-460ed55724c1', $teb93bda6b5814fa9a01340989e7eea84$Omulu - Ele é um velho, é muito velho$teb93bda6b5814fa9a01340989e7eea84$, $ceb93bda6b5814fa9a01340989e7eea84$Ele é um velho
É muito velho
Ele carrega as palhas na mão
Ele é um velho
É muito velho
Ele carrega as palhas na mão
Ele veio do céu
Tá dentro da terra
É força sagrada
Que nos governa
Orixá das palhas
Orixá da dor
Orixá da cura
Orixá do amor
Ele é um velho
É muito velho
Ele carrega as palhas na mão
Ele é um velho
É muito velho
Ele carrega as palhas na mão
Vou fazer um tapete
De doborô
Para oferecer
Ao seu Omulu
E na casa santa
Eu vou entregar
Vou pedir a proteção
Deste grande Orixá
Ele é um velho
É muito velho
Ele carrega as palhas na mão
Ele é um velho
É muito velho
Ele carrega as palhas na mão$ceb93bda6b5814fa9a01340989e7eea84$, NULL, now()),
('a3008782-c14f-29cc-dc7b-3a6870e8ffa2', 'dd50b86b-6507-420e-115b-460ed55724c1', $ta3008782c14f29ccdc7b3a6870e8ffa2$Omulu - Olhai minha vida$ta3008782c14f29ccdc7b3a6870e8ffa2$, $ca3008782c14f29ccdc7b3a6870e8ffa2$Eu peço em nome do Pai
Em nome do Filho e a Pai Omulú
Olhai minha vida meu Pai, olhaiminha vida meu Pai
Olhai minha vida,oh meu reiPai Omulú
Meu Pai,ele é um santo,
Meu Pai é um rei,meu Pai é orixalá
na minha alegria,ou na minha tristeza
aPai Omulú seu filhosempre vai lhebuscar
Eu peço em nome do Pai
Em nome do Filho e a Pai Omulú
Olhai minha vida meu Pai, olhaiminha vida meu Pai
Olhai minha vida,oh meu reiPai Omulú
Meu Pai renasceu de novo
caminhou pelo deserto, fome e sede ele passou
todos os lugares que meu Pai passava
com o seu cajado, seus filhosabençoava
Eu peço em nome do Pai
Em nome do Filho e a Pai Omulú
Olhai minha vida meu Pai, olhaiminha vida meu Pai
Olhai minha vida,oh meu reiPai Omulú$ca3008782c14f29ccdc7b3a6870e8ffa2$, NULL, now()),
('aef3792d-3db7-dc9a-1450-43969202d425', 'dd50b86b-6507-420e-115b-460ed55724c1', $taef3792d3db7dc9a145043969202d425$Omulu - Na pedra fria$taef3792d3db7dc9a145043969202d425$, $caef3792d3db7dc9a145043969202d425$Na pedra fria,no pé do morro
dizem que mora, um velho lá
Ele é curador!,ele é rezador
Ele é Xapana, ele vailhe curar$caef3792d3db7dc9a145043969202d425$, NULL, now()),
('1aacbbb8-960f-4eae-c46e-8cfd707df4e3', 'dd50b86b-6507-420e-115b-460ed55724c1', $t1aacbbb8960f4eaec46e8cfd707df4e3$Omolu - Rei do cemitério$t1aacbbb8960f4eaec46e8cfd707df4e3$, $c1aacbbb8960f4eaec46e8cfd707df4e3$Na porta da calunga tem, um velho que espera
as almas que tiveram, vida aqui na terra
Ele é guardião, reido cemitério
éseu Omulú, esse grande velho
Omulu - Na pedra fria$c1aacbbb8960f4eaec46e8cfd707df4e3$, NULL, now()),
('7a2307ee-e964-30c8-58e2-d2a34ec73336', 'dd50b86b-6507-420e-115b-460ed55724c1', $t7a2307eee96430c858e2d2a34ec73336$Página3 de5$t7a2307eee96430c858e2d2a34ec73336$, $c7a2307eee96430c858e2d2a34ec73336$Na pedra fria
no pé do morro
dizem que mora
um velho lá
Na pedra fria
no pé do morro
dizem que mora
um velho lá
Eleé curador
Eleé rezador
Eleé Xapanã
Elevai lhe curar
Eleé curador
Eleé rezador
Eleé Xapanã
Elevai lhe curar$c7a2307eee96430c858e2d2a34ec73336$, NULL, now()),
('30ce5b23-7917-af4f-5cac-ce43a569db32', 'dd50b86b-6507-420e-115b-460ed55724c1', $t30ce5b237917af4f5cacce43a569db32$Omulu - Seu Omulu, ele é Orixá$t30ce5b237917af4f5cacce43a569db32$, $c30ce5b237917af4f5cacce43a569db32$Seu omulú
Eleé Orixá
seu tesouro é osso
oh cairê,cairá
seu tesouro é osso
oh cairê,cairá [2x]$c30ce5b237917af4f5cacce43a569db32$, NULL, now()),
('d05f2ff6-82dd-4c52-9b8d-0fe21d83ece9', 'dd50b86b-6507-420e-115b-460ed55724c1', $td05f2ff682dd4c529b8d0fe21d83ece9$Omulu - Rei da calunga$td05f2ff682dd4c529b8d0fe21d83ece9$, $cd05f2ff682dd4c529b8d0fe21d83ece9$Eu não quero nem pensar
que um diaeu pensei
pensei que Omolú
não fosse um grande rei
Eleé o reida Calunga
eleé o rei
Omolú foicoroado
pelas graças que elefez
Elemora no Cruzeiro
sua casa não tem teto
não precisa de dinheiro
elemora em campo aberto$cd05f2ff682dd4c529b8d0fe21d83ece9$, NULL, now()),
('b8760cd7-6efc-27bb-a259-fd025c19d15f', 'dd50b86b-6507-420e-115b-460ed55724c1', $tb8760cd76efc27bba259fd025c19d15f$Omulú - Cadê a chave do baú - Omulú é Orixá$tb8760cd76efc27bba259fd025c19d15f$, $cb8760cd76efc27bba259fd025c19d15f$Zum zum zum cadê a chave do baú
Zum zum zum tácom o mestre Omolú
Já mandei caiar,eu já mandei caiar
Já mandei caiarOmolú, já mandei caiar
////////////////////////
seu Omolú ê
seu Omolú ê
seu Omolú ê
Omolú é orixá
saravá seu Omolú
Omolú é Orixá$cb8760cd76efc27bba259fd025c19d15f$, NULL, now()),
('852d62a3-177d-a4b6-0f0c-4ceb433f4556', 'dd50b86b-6507-420e-115b-460ed55724c1', $t852d62a3177da4b60f0c4ceb433f4556$Omulu - Zum zum zum$t852d62a3177da4b60f0c4ceb433f4556$, $c852d62a3177da4b60f0c4ceb433f4556$zum zum zum
cadê a chave do baú
zum zum zum
estácom o velho Omulú$c852d62a3177da4b60f0c4ceb433f4556$, NULL, now()),
('28025482-16a7-b14d-e047-72b1312aac6a', 'e4df098d-ac14-6633-ded8-0d2ab271a4c6', $t2802548216a7b14de04772b1312aac6a$Ossain - Suas ervas podem curar$t2802548216a7b14de04772b1312aac6a$, $c2802548216a7b14de04772b1312aac6a$Pai Ossain das matas
Eu venho para lhe louvar
Ewé, ewé, ewé
Pai Ossain das matas
Eu venho para lhe louvar
Saravá orei das ervas
Filhode pai Oxalá
Saravá orei das ervas
Filhode pai Oxalá
Ewé, ewé, Ossain
Seu canto eu quero escutar
Ewé, ewé, Ossain
Suas ervas podem curar
Ewé, ewé, Ossain
Seu canto eu quero escutar
Ewé, ewé, Ossain
Suas ervas podem curar$c2802548216a7b14de04772b1312aac6a$, NULL, now()),
('0d1db362-9e7e-4a18-f682-bb747dc7d4fe', 'aac65700-2760-4f83-0702-b8009120587d', $t0d1db3629e7e4a18f682bb747dc7d4fe$é Deus, meu Pai Oxalá$t0d1db3629e7e4a18f682bb747dc7d4fe$, $c0d1db3629e7e4a18f682bb747dc7d4fe$Eu nasci pra lutar
Eu nasci pra vencer
Eu nasci pra rezar,
porDeus, por Deus!
Por Deus, por Deus
Por Deus, ai por Deus!
Por Deus, por Deus
Por Deus, ai por Deus!
Ontem estava dormindo,
esonhei...que voava até o céu
voei,voei.
Encontrei a estrelaD'alva
que veio me falar
quem reina no Céu,
na Terra e no Mar.
É Deus, é Deus,
éDeus, meu Pai Oxalá$c0d1db3629e7e4a18f682bb747dc7d4fe$, NULL, now()),
('c96b5414-1664-9301-14a4-5cfac2487872', 'aac65700-2760-4f83-0702-b8009120587d', $tc96b54141664930114a45cfac2487872$Eu Louvo à Deus$tc96b54141664930114a45cfac2487872$, $cc96b54141664930114a45cfac2487872$Eu Louvo à Deus
Quem não Louvou
Eu Louvo à Deus de nascença com Amor
Eu Louvo à Deus
Quem não Louvou
Eu Louvo à Deus Pai Oxalá Emoriô
Emoriô ôôô Emoriô ôôô
Emoriô ôôô Emoriô ôôô
Quando nessa Casa, de Branco entreimeu
PaiOxalá foio primeiro que Louvei
Meu Pai Ogum, Meu Pai Xangô ôôô
Mamãe Oxum, Iemanjá Emoriô
Emoriô ôôô Emoriô ôôô
Emoriô ôôô Emoriô ôôô$cc96b54141664930114a45cfac2487872$, NULL, now()),
('a2ee74c5-71fc-abbc-a372-a044e9d83984', 'aac65700-2760-4f83-0702-b8009120587d', $ta2ee74c571fcabbca372a044e9d83984$Oxalá - No Alto Das Oliveiras$ta2ee74c571fcabbca372a044e9d83984$, $ca2ee74c571fcabbca372a044e9d83984$No altodas oliveiras
Eu viuma pombinha voar - 2x
Voou, voou
Tornou voar
É uma pombinha
Divina Oxalá - 2x$ca2ee74c571fcabbca372a044e9d83984$, NULL, now()),
('e028447f-21b2-fd10-9a06-07fe97ffc59f', 'aac65700-2760-4f83-0702-b8009120587d', $te028447f21b2fd109a0607fe97ffc59f$Pai Oxalá - O Sol e a Lua$te028447f21b2fd109a0607fe97ffc59f$, $ce028447f21b2fd109a0607fe97ffc59f$O sol e alua que brilham no céu
São os ponteiros do tempo
Zambi crioua verdade que dá
Vida a cada momento
Ê...Epa Babá, Epa Babá, Pai Oxalá
Pombinha branca que voa
Pintade amor os meus sentimentos
Ê...Epa Babá, Epa Babá, Pai Oxalá
Divina luza brilhar
Guarde seus filhos eo nosso Gongá$ce028447f21b2fd109a0607fe97ffc59f$, NULL, now()),
('19fd9a2b-25d4-6b59-19ab-d5f924e1fa49', 'aac65700-2760-4f83-0702-b8009120587d', $t19fd9a2b25d46b5919abd5f924e1fa49$Bençãos de Oxalá$t19fd9a2b25d46b5919abd5f924e1fa49$, $c19fd9a2b25d46b5919abd5f924e1fa49$Vem das bençãos de Oxalá
minha força pra viver
são as bençãos de Oxalá
que hoje eu vim agradecer ô
epa Babá
epa Babá
epa Babá
Eu vistobranco
me ajoelho no altar
bato cabeça
pra saudar meu Orixá
forçasuprema
que vem lá de Aruanda
nos abençoe
eilumine a nossa banda
epa Babá
epa Babá
epa Babá
epa Babá$c19fd9a2b25d46b5919abd5f924e1fa49$, NULL, now()),
('d87a78f6-ae4c-189e-e05d-610673e16116', 'aac65700-2760-4f83-0702-b8009120587d', $td87a78f6ae4c189ee05d610673e16116$Oxalá - Foi Zambi$td87a78f6ae4c189ee05d610673e16116$, $cd87a78f6ae4c189ee05d610673e16116$Babá
olha asua banda
babá
salve o seu congá (2x)
foiZambi,
foiZambi
foiZambi
que iluminou esse congá (2x)$cd87a78f6ae4c189ee05d610673e16116$, NULL, now()),
('364f868f-a5a9-7a12-e8ec-7fbe641eb64c', 'aac65700-2760-4f83-0702-b8009120587d', $t364f868fa5a97a12e8ec7fbe641eb64c$Oxalá - Pombinha Divina$t364f868fa5a97a12e8ec7fbe641eb64c$, $c364f868fa5a97a12e8ec7fbe641eb64c$No jardim das oliveiras
no jardim das oliveiras
eu viuma pombinha voar
voou, voou
tornou a voar
é a pombinha divina de Oxalá$c364f868fa5a97a12e8ec7fbe641eb64c$, NULL, now()),
('cb3dc352-e0ed-1a7a-2c8a-8f2e3b63b778', 'aac65700-2760-4f83-0702-b8009120587d', $tcb3dc352e0ed1a7a2c8a8f2e3b63b778$Ponto de Oxalá$tcb3dc352e0ed1a7a2c8a8f2e3b63b778$, $ccb3dc352e0ed1a7a2c8a8f2e3b63b778$Se acaso lhe faltar a fé
E tristeestiver
Corra até seu conga
Faça uma oração irmão
E peça a proteção
A Pai Oxalá
Ele é reidos Orixás
Ele é capaz de reacender
A chama no seu coração
Retira aflição que te faz sofrer
Se acaso lhe faltar a fé
E tristeestiver
Corra até seu conga
Faça uma oração irmão
E peça a proteção
A Pai Oxalá
Ele é reidos Orixás
Ele é capaz de reacender
A chama no seu coração
Retira aflição que te faz sofrer
Na luta contra o mal
Ele tefaz vencer
Basta acreditar, basta você querer
Resgate a sua fé
Para não padecer
Não vai teabandonar
Porque ele ama você
Na luta contra o mal
Ele tefaz vencer
Basta acreditar, basta você querer
Resgate a sua fé
Para não padecer
Não vai teabandonar
Porque eleama você$ccb3dc352e0ed1a7a2c8a8f2e3b63b778$, NULL, now()),
('794c69b7-38a0-044f-92b3-604d59dd4a43', 'aac65700-2760-4f83-0702-b8009120587d', $t794c69b738a0044f92b3604d59dd4a43$Ponto de Oxalá - Hino a Oxalá$t794c69b738a0044f92b3604d59dd4a43$, $c794c69b738a0044f92b3604d59dd4a43$Vou caminhando nas estradas desta vida
E me protegem sete luzes de Orixás
Filhosde Umbanda
Minha féé o que me guia
Nos caminhos de Aruanda
Sob a paz de Oxalá
Filhosde Umbanda
Minha féé o que me guia
Nos caminhos de Aruanda
Sob a paz de Oxalá
Oxalá é paz
Oxalá é o rei
Divino Pai,divina força que me encanta
Nos caminhos de Aruanda
Sua luz é minha lei
Divino Pai,divina força que me encanta
Nos caminhos de Aruanda
Sua luz é minha lei
Vou caminhando nas estradas desta vida
E me protegem sete luzes de Orixás
Filhosde Umbanda
Minha féé o que me guia
Nos caminhos de Aruanda
Sob a paz de Oxalá
Filhosde Umbanda
Minha féé o que me guia
Nos caminhos de Aruanda
Sob a paz de Oxalá
Oxalá é paz
Oxalá é o rei
Divino Pai,divina força que me encanta
Nos caminhos de Aruanda
Sua luz é minha lei
Divino Pai,divina força que me encanta
Nos caminhos de Aruanda
Sua luz é minha lei$c794c69b738a0044f92b3604d59dd4a43$, NULL, now()),
('aaf43d72-8942-dce9-5aec-7eae861f2e48', 'aac65700-2760-4f83-0702-b8009120587d', $taaf43d728942dce95aec7eae861f2e48$Oxalá, Meu Pai / Afoxé de Oxalá$taaf43d728942dce95aec7eae861f2e48$, $caaf43d728942dce95aec7eae861f2e48$Oxalá meu pai
Tem pena de nós, tem dó
Se a volta no mundo é grande
Seu poder ainda é maior
Oxalá meu pai
Tem pena de nós, tem dó
Se a volta no mundo é grande
Seu poder ainda é maior
Debaixo do seu alá misericordioso
Bàbá me dê proteção, escuta minha oração
Me guarda com seu alá,e guarda todo esse povo
Me guarda com seu alá,e guarda todo esse povo
Bàbá é o senhor idoso
É o moço que faz a guerra
É o ar que alimenta o fogo
É a chuva que molha a terra
Cajado e opaxorô
Bàbá me estenda a mão
Aliviaminha dor, enquanto pilao pilão
Vai um cortejo funfun, tocando seu ijexá
A soma de cem é um, uma só voz a cantar
Orun ye
Alá,alá, orun alá
Orun ye
Alá,alá, orun alá
Debaixo do seu alá misericordioso
Bàbá me dê proteção, escuta minha oração
Me guarda com seu alá,e guarda todo esse povo
Me guarda com seu alá,e guarda todo esse povo
Bàbá é o senhor idoso
É o moço que faz a guerra
É o ar que alimenta o fogo
É a chuva que molha a terra
Cajado e opaxorô
Bàbá me estenda a mão
Aliviaminha dor, enquanto pilao pilão
Vai um cortejo funfun, tocando seu ijexá
A soma de cem é um, uma só voz a cantar
Orun ye
Alá,alá, orun alá
Orun ye
Alá,alá, orun alá$caaf43d728942dce95aec7eae861f2e48$, NULL, now()),
('0b4a7572-46c5-87f6-1b8f-fcb1b2677b75', 'aac65700-2760-4f83-0702-b8009120587d', $t0b4a757246c587f61b8ffcb1b2677b75$Oxalá - Estrela do Oriente$t0b4a757246c587f61b8ffcb1b2677b75$, $c0b4a757246c587f61b8ffcb1b2677b75$No oriente uma estrela brilhou
Era a estrela de Oxalá
Oi brilhao sol, e também brilha a lua
Brilhaa imagem sua aqui nesse cazuá$c0b4a757246c587f61b8ffcb1b2677b75$, NULL, now()),
('96bf23bc-8306-5c9f-4d53-0358967c8215', 'aac65700-2760-4f83-0702-b8009120587d', $t96bf23bc83065c9f4d530358967c8215$Oxalá - É do Lado de Lá$t96bf23bc83065c9f4d530358967c8215$, $c96bf23bc83065c9f4d530358967c8215$É do lado de lá
E vem… para o lado de cá
É mensageiro do amor
É,é de Oxalá
É do lado de lá
E vem… para o lado de cá
É mensageiro do amor
É,é de Oxalá
Vem do azul infinito
Onde tem o seu reinode paz
Vamos receber com ternura
A mensagem que ele nos trás
É do lado de lá
E vem… para o lado de cá
É mensageiro do amor
É,é de Oxalá
É do lado de lá
E vem… para o lado de cá
É mensageiro do amor
É,é de Oxalá
Vem do azul infinito
Onde tem o seu reinode paz
Vamos receber com ternura
A mensagem que ele nos trás
Vem do azul infinito
Onde tem o seu reinode paz
Vamos receber com ternura
A mensagem que ele nos trás$c96bf23bc83065c9f4d530358967c8215$, NULL, now()),
('7872cce9-ff8f-64ce-059c-c1087d53d3ac', 'aac65700-2760-4f83-0702-b8009120587d', $t7872cce9ff8f64ce059cc1087d53d3ac$Oxalá - Quanta Força$t7872cce9ff8f64ce059cc1087d53d3ac$, $c7872cce9ff8f64ce059cc1087d53d3ac$Ah! Quanta força tem meu Pai no céu
Quanta grandeza tem meu Pai no mar
Ah! Quanta força tem meu Pai no céu
Quanta grandeza tem meu Pai no mar
Ah! Quanta força,quanta força tem meu Pai
Quanta grandeza tem meu Pai Oxalá
Ah! Quanta força,quanta força tem meu Pai
Quanta grandeza tem meu Pai Oxalá
Ah! Quanta força tem meu Pai no céu
Quanta grandeza tem meu Pai no mar
Ah! Quanta força tem meu Pai no céu
Quanta grandeza tem meu Pai no mar
Ah! Quanta força, quanta força tem meu Pai
Quanta grandeza tem meu Pai Oxalá
Ah! Quanta força, quanta força tem meu Pai
Quanta grandeza tem meu Pai Oxalá$c7872cce9ff8f64ce059cc1087d53d3ac$, NULL, now()),
('93f170ac-aa88-3be7-e447-ff019d0e5584', 'aac65700-2760-4f83-0702-b8009120587d', $t93f170acaa883be7e447ff019d0e5584$Oxalá - Meu Pai, Oxalá$t93f170acaa883be7e447ff019d0e5584$, $c93f170acaa883be7e447ff019d0e5584$Meu Pai, Oxalá,
Obrigado meu paique bom
As voltas do teu abraço,
São laços de luz e som
Meu Pai Oxalá,
Eu sei que estás em mim,
Nas dores da ilusão,
Na força do não e o sim
Peço agora teu amor,
Nesta hora de esperança,
Pra ser livrecomo a flor,
Ser adulto, ser criança
Abençoe a todos nós,
Nossos pais, nossos avós,
Nossos filhos e parentes,
Nossas vidas tão carentes
Meu Pai, Oxalá,
És tudo na criação,
Igualteu poder não há,
Me cura, me dá tua mão
Peço agora teu amor,
Nesta hora de esperança,
Pra ser livrecomo a flor,
Ser adulto, ser criança
Abençoe a todos nós,
Nossos pais, nossos avós,
Nossos filhos e parentes,
Nossas vidas tão carentes
Meu Pai, Oxalá,
És tudo na criação,
Igualteu poder não há,
Me cura, me dá tua mão$c93f170acaa883be7e447ff019d0e5584$, NULL, now()),
('3449df98-fc6b-b0e0-ba65-f04cf7409605', 'aac65700-2760-4f83-0702-b8009120587d', $t3449df98fc6bb0e0ba65f04cf7409605$Hino para Oxalá$t3449df98fc6bb0e0ba65f04cf7409605$, $c3449df98fc6bb0e0ba65f04cf7409605$Vou caminhando nas estradas desta vida
E me protegem sete luzes de Orixás
Filhos de Umbanda
Minha féé o que me guia
Nos caminhos de Aruanda
Sob a paz de Oxalá
Oxalá é paz
Oxalá é o rei
Divino pai
Divina força que me encanta
Nos caminhos de Aruanda
sua luz é minha lei$c3449df98fc6bb0e0ba65f04cf7409605$, NULL, now()),
('b52b2a71-080d-2cb0-8adc-afa2f519b35a', 'aac65700-2760-4f83-0702-b8009120587d', $tb52b2a71080d2cb08adcafa2f519b35a$Oxalá - Não estamos sós$tb52b2a71080d2cb08adcafa2f519b35a$, $cb52b2a71080d2cb08adcafa2f519b35a$Viajeinum lindo sonho
enesse sonho eu encontrei
respostas de tantas perguntas
que sempre busquei
Vi,anjos de muita luz
Vi,meus Orixás com suas falanges
ede um clarão eu percebi aparecer
um lindo ser, preso na cruz
ede um clarão eu percebi aparecer
um lindo ser, preso na cruz
émeu pai Oxalá, Jesus de Nazaré
Ele morreu por nós
E hoje eu tenho certeza
que esse sonho tão lindo
mostrou, que não estamos sós
E hoje eu tenho certeza
que esse sonho tão lindo
mostrou, que não estamos sós$cb52b2a71080d2cb08adcafa2f519b35a$, NULL, now()),
('6c7de5de-0484-1d6e-8008-236c8cd456dc', 'aac65700-2760-4f83-0702-b8009120587d', $t6c7de5de04841d6e8008236c8cd456dc$Oxalá é Luz$t6c7de5de04841d6e8008236c8cd456dc$, $c6c7de5de04841d6e8008236c8cd456dc$Zambi, olhai esse mundo
Que o senhor criou
Com beleza e encanto
Oxalá com o seu manto
A bondade semeou
Zambi, olhai esse mundo
Que o senhor criou
Com beleza e encanto
Oxalá com o seu manto
A bondade semeou
Carregando a cruz
Carregando a dor
Oxalá é luz
Ele é o amor
Carregando a cruz
Carregando a dor
Oxalá é luz
Ele é o amor
Abre as portas do coração
Pra receber meu Pai
Abre as portas do coração
Pra encontrar a paz
Abre as portas do coração
Pra receber meu Pai
Abre as portas do coração
Pra encontrar a paz$c6c7de5de04841d6e8008236c8cd456dc$, NULL, now()),
('31034315-8ecf-7084-1be8-6bba8ad15e50', 'aac65700-2760-4f83-0702-b8009120587d', $t310343158ecf70841be86bba8ad15e50$Oxalá - Passo de Fé$t310343158ecf70841be86bba8ad15e50$, $c310343158ecf70841be86bba8ad15e50$Hoje eu vou pedir, uma vez mais,
De joelhos em terra
Em frente ao gongar
Proteção ao meu pai
Hoje eu vou pedir, uma vez mais,
De joelhos em terra
Em frente ao gongar
Proteção ao meu pai
Oh pai, livrai-me do mal
Se ele vier.
Trazei, sua força, sua paz e seu axé.
Mesmo com desencontros,
Na hora que eu falhar.
No erro procuro o acerto.
Pôr do sol vai iluminar.
Babá caminha comigo
Num passo de fé.
Me traz,a força do branco.
Nas sextas de axé.
Curvado, caminhado lento.
Na mão, o seu paxorô.
O sol ilumina meus olhos
És o meu guia e senhor
Guerreiro no iníciodo dia.
Nas batalhas de Oxaguiã.
O tempo corre envelhece.
Sob a força de Oxalufã.
Tua paz, mandai para o mundo
Tenha piedade de nós.
Tu és luz, é sabedoria
Seja nossa voz.$c310343158ecf70841be86bba8ad15e50$, NULL, now()),
('1559b6c6-47a6-3aad-cf3f-cb4b636de621', 'aac65700-2760-4f83-0702-b8009120587d', $t1559b6c647a63aadcf3fcb4b636de621$Afoxé de Oxalá (Cover)$t1559b6c647a63aadcf3fcb4b636de621$, $c1559b6c647a63aadcf3fcb4b636de621$Debaixo de seu Alá misericordioso
Bàbá me dê proteção
Escuta minha oração
Me guarda com Seu Alá
E guarda todo esse povo
Bàbá é Senhor idoso
É o Moço que faza guerra
É o arque alimenta o fogo
É a chuva que molha a terra
Cajado e Opaxorô
Bàbá me estenda a mão
Aliviaminha dor enquanto pila opilão
Vai um cortejo Funfun
Tocando seu Ijexá
A soma de cem é um
Uma só voz acantar
Orun ye
Alá,Alá,Orun Alá
Orun ye$c1559b6c647a63aadcf3fcb4b636de621$, NULL, now()),
('5c151521-acdf-bd90-0dad-0e9370bce006', 'aac65700-2760-4f83-0702-b8009120587d', $t5c151521acdfbd900dad0e9370bce006$Oxalá - Lá no céu abriu uma porta$t5c151521acdfbd900dad0e9370bce006$, $c5c151521acdfbd900dad0e9370bce006$Lá no céu abriu uma porta
Oxalá apareceu
Lá no céu abriu uma porta
Oxalá apareceu
Vinha com seu manto branco
Derramando suas graças
Abençoando os filhos teus
Vinha com seu manto branco
Derramando suas graças
Abençoando os filhos teus
Lá no céu abriu uma porta
Oxalá apareceu
Lá no céu abriu uma porta
Oxalá apareceu
Vinha com seu manto branco
Derramando suas graças
Abençoando os filhos teus
Vinha com seu manto branco
Derramando suas graças
Abençoando os filhos teus$c5c151521acdfbd900dad0e9370bce006$, NULL, now()),
('7e5f4ce1-72e3-b9cf-1660-c7a421d15fbd', 'aac65700-2760-4f83-0702-b8009120587d', $t7e5f4ce172e3b9cf1660c7a421d15fbd$Oxalá - Tem que ter fé$t7e5f4ce172e3b9cf1660c7a421d15fbd$, $c7e5f4ce172e3b9cf1660c7a421d15fbd$Tem que ter fé
Não baixa a guarda
Tem que ter fé
Que essa vida
O tempo não para
Vinha cansado de viver
Lembre que seu caminho
Nunca foium mar de rosas
Muito menos um mar de espinhos
Vinha cansado de viver
Lembre daquela história
De quem morreu por mim e você
Sem pensar em glórias
Tem que ter fé
Não baixa a guarda
Tem que ter fé
Que essa vida
O tempo não pára
Ouça bem e nunca se esqueça
Tenha félevante a cabeça
Um minuto epreste atenção
Traga paz ao seu coração
Peça aDeus nesse momento
Que ilumine o seu pensamento
O que importa a vida é você
Volte aviver$c7e5f4ce172e3b9cf1660c7a421d15fbd$, NULL, now()),
('54df7ccf-485c-790a-601d-5731014fb715', 'aac65700-2760-4f83-0702-b8009120587d', $t54df7ccf485c790a601d5731014fb715$Oxalá - A força do divino$t54df7ccf485c790a601d5731014fb715$, $c54df7ccf485c790a601d5731014fb715$Maior que Zambi
Maior que Oxalá
Procure nesse mundo
Não encontrará
Maior que Zambi
Maior que Oxalá
Procure nesse mundo
Não encontrará
Zambi é pai
Oxalá é filho
Encontre na Umbanda
A força do divino
Zambi é pai
Oxalá é filho
Encontre na Umbanda
A força do divino
No sofrimento
Na minha dor
FoiZambi e Oxalá
Quem me ajudou
No sofrimento
Na minha dor
FoiZambi e Oxalá
Quem me ajudou$c54df7ccf485c790a601d5731014fb715$, NULL, now()),
('03b46588-c226-1a8b-f63d-73892d4040a4', 'aac65700-2760-4f83-0702-b8009120587d', $t03b46588c2261a8bf63d73892d4040a4$Oxalá - Oxalá nas oliveiras$t03b46588c2261a8bf63d73892d4040a4$, $c03b46588c2261a8bf63d73892d4040a4$Oxalá nas oliveiras
pediu ao Senhor do Mundo
Oxalá nas oliveiras
pediu ao Senhor do Mundo
que plantasse,
que semeasse
acaridade que o Pai determinou
que plantasse,
que semeasse
acaridade que o Pai determinou
Como é lindo,Oxalá!
Como é lindo,Oxalá!
Como é lindo,Oxalá em seu Gongá.
Como é lindo,Oxalá!
Como é lindo,Oxalá!
Como é lindo,Oxalá em seu Gongá.$c03b46588c2261a8bf63d73892d4040a4$, NULL, now()),
('af07a9aa-2078-0b4b-bd63-6c49d20b05c3', 'aac65700-2760-4f83-0702-b8009120587d', $taf07a9aa20780b4bbd636c49d20b05c3$Oxalá - Pai desse mundo$taf07a9aa20780b4bbd636c49d20b05c3$, $caf07a9aa20780b4bbd636c49d20b05c3$Oisalve o pai desse mundo
Salve a coroa de Oxalá
Vem com o seu manto branco
É paide todo santo
Paide todo Orixá$caf07a9aa20780b4bbd636c49d20b05c3$, NULL, now()),
('2b010268-e606-687c-3053-b3ad1d8cba71', 'aac65700-2760-4f83-0702-b8009120587d', $t2b010268e606687c3053b3ad1d8cba71$Oxalá - Lua de Oxalá$t2b010268e606687c3053b3ad1d8cba71$, $c2b010268e606687c3053b3ad1d8cba71$Lua brilhou no céu
Lua brilhou no mar 2x
Oh lua nova, oh lua cheia
Lua clareiaesses filhosde Oxalá 2x$c2b010268e606687c3053b3ad1d8cba71$, NULL, now()),
('33e89e56-d1a2-72cf-e303-1263a9a7b18b', 'aac65700-2760-4f83-0702-b8009120587d', $t33e89e56d1a272cfe3031263a9a7b18b$Oxalá - Abre a porta que ai vem Jesus$t33e89e56d1a272cfe3031263a9a7b18b$, $c33e89e56d1a272cfe3031263a9a7b18b$Abre a porta oh gente
que aí vem Jesus
elevem cansado
com o peso da cruz
Vem de porta em porta
vem de rua em rua
pra salvar as almas
sem culpar nenhuma [2x]$c33e89e56d1a272cfe3031263a9a7b18b$, NULL, now()),
('025d6594-0bad-3ac8-a3e7-cba973604d82', 'aac65700-2760-4f83-0702-b8009120587d', $t025d65940bad3ac8a3e7cba973604d82$Oxalá - Oxalá criou a Terra$t025d65940bad3ac8a3e7cba973604d82$, $c025d65940bad3ac8a3e7cba973604d82$Oxalá criou a terra
Oxalá criou o mar
Oxalá criou o mundo
Onde reinam os Orixás (2x)
A pedra deu pra Xangô
Meu pai,rei ejusticeiro
As matas deu pra Oxóssi
Caçador, velho guerreiro
Grandes campos de batalha
Deu pra Seu Ogum guerreiro
Campinas Pai Oxalá
Deu para Seu Boiadeiro
Mar com pescaria farta
Ele deu pra Iemanjá
Os rios para Oxum
Os ventos para Oyá
Lindos jardins com gramados
Deu pras Crianças brincar
Oxalá criou o mundo onde reinam os Orixás
Oxalá criou a terra
Oxalá criou o mar
Oxalá criou o mundo
Onde reinam os Orixás (2x)
O poço deu pra Nanã
A mais velha Orixá
E o Cruzeiro bendito
Deu pras Almas trabalhar
Finalmente deu as ruas
Com estrelas e luar
Pra Exus e Bombogiras
Nossos caminhos guardar
Oxalá criou a terra
Oxalá criou o mar
Oxalá criou o mundo
Onde reinam os Orixás (2x)$c025d65940bad3ac8a3e7cba973604d82$, NULL, now()),
('fda3e9c1-f142-2868-f5e7-9d2de2fb5b83', 'aac65700-2760-4f83-0702-b8009120587d', $tfda3e9c1f1422868f5e79d2de2fb5b83$Oxalá - Pombinho branco meu pombinho de Oxalá$tfda3e9c1f1422868f5e79d2de2fb5b83$, $cfda3e9c1f1422868f5e79d2de2fb5b83$Pombinho branco
meu pombinho de Oxalá [2x]
Voou voou
foivoar pra Iemanjá [2x]$cfda3e9c1f1422868f5e79d2de2fb5b83$, NULL, now()),
('9cd8859a-cd58-845c-95bc-f5c1de7bddb1', 'aac65700-2760-4f83-0702-b8009120587d', $t9cd8859acd58845c95bcf5c1de7bddb1$Oxalá - Tem pena de nós$t9cd8859acd58845c95bcf5c1de7bddb1$, $c9cd8859acd58845c95bcf5c1de7bddb1$Oxalá meu pai
tem pena de nós tem dó
se a voltano mundo é grande
seu poder ainda é maior [2x]
Meu divino espíritosanto láno céu
venha nos ajudar
meu divino espíritosanto láno céu
venha nos ajudar
éna falange do divinoespírito santo e da Jurema
da Jurema [2x]$c9cd8859acd58845c95bcf5c1de7bddb1$, NULL, now()),
('fd224aa0-2245-969e-f88a-d4d1c3a9d500', 'aac65700-2760-4f83-0702-b8009120587d', $tfd224aa02245969ef88ad4d1c3a9d500$Oxalá - Filhos de Pemba$tfd224aa02245969ef88ad4d1c3a9d500$, $cfd224aa02245969ef88ad4d1c3a9d500$Dia e noite eu vou cantar (Eu vou cantar )
Noite e dia eu vou louvar ( Eu vou louvar )
Vou louvar meu pai Xangô (Kaô meu pai ! Kaô )
Se a mãe sereia me mandar ( Se me mandar )
Nessa linda luade Ogum (De Ogum )
Pra iluminar nosso Congá,
Pai Oxalá sempre tem mais um (2x)
Um filhode pemba que tem fé (Nós temos fé)
Um filhode pemba que tem luz (Nós temos luz )
Pra iluminarnosso Congá,
PaiOxalá sempre tem mais um (2x)$cfd224aa02245969ef88ad4d1c3a9d500$, NULL, now()),
('1b97b461-6ee9-1dff-a15d-ad0296eba49c', 'aac65700-2760-4f83-0702-b8009120587d', $t1b97b4616ee91dffa15dad0296eba49c$Oxalá - Um Minuto pra Compreender$t1b97b4616ee91dffa15dad0296eba49c$, $c1b97b4616ee91dffa15dad0296eba49c$A forçado pensamento
O poder da oração
A chama de um olhar
Que aquece o coração
Milagres que acontecem
sem a gente perceber
Um minuto pra compreender
Um minuto pra compreender
A féque alimenta ao homem
Traz a paz e a devoção
Também alimenta os sonhos
Que enriquecem o coração
Mas tudo issoacontece
Sem a gente perceber
É o amor, infinitoamor de Deus
É o amor, infinitoamor de Deus
Tá na alma
O amor
Nem o tempo pode apagar uma históriade amor
Tá na alma
O amor
Nem o tempo pode apagar uma históriade amor (4x)
A féque alimenta ao homem
Traz a paz e a devoção
Também alimenta os sonhos
Que enriquecem o coração
Mas tudo issoacontece
Sem a gente perceber
É o amor, infinitoamor de Deus
É o amor, infinitoamor de Deus
Tá na alma
O amor
Nem o tempo pode apagar uma históriade amor
Tá na alma
O amor
Nem o tempo pode apagar uma históriade amor (4x)$c1b97b4616ee91dffa15dad0296eba49c$, NULL, now()),
('0e031ae1-8f71-fa22-727c-dfaadbd3c356', 'aac65700-2760-4f83-0702-b8009120587d', $t0e031ae18f71fa22727cdfaadbd3c356$Oxalá - Divindade Suprema$t0e031ae18f71fa22727cdfaadbd3c356$, $c0e031ae18f71fa22727cdfaadbd3c356$Quem dera que o mundo não estivesse assim
Com tanta maldade e injustiça
Meu Deus é o fim
Quem dera que o homem não fizesse assim
Plantando inveja,cobiça e colhendo seu fim
Ô
Ôô! Ôô
Ôô! Ôô
Ôô! Ôô (2x)
Agora
O meu peito se enche e implora
Que eu jogue a tristeza pra fora
É por isso que eu amo cantar
Agora
Lá no céu há um Ser que nos olha
A Divindade Suprema da história
Oxalá é o rei dos Orixás
Agora
Lá no céu há um Ser que nos olha
A Divindade Suprema da história
Oxalá é o rei dos orixás (3x)
Ô
Ôô! Ôô
Ôô! Ôô
Ôô! Ôô (2x)$c0e031ae18f71fa22727cdfaadbd3c356$, NULL, now()),
('6be314af-c047-022c-a1ac-c6f799a0efa4', 'aac65700-2760-4f83-0702-b8009120587d', $t6be314afc047022ca1acc6f799a0efa4$Oxalá - As flores$t6be314afc047022ca1acc6f799a0efa4$, $c6be314afc047022ca1acc6f799a0efa4$A lua brilhoulá no céu
Oxalá foi quem quis assim
E no cair da noite
É que as floresvão se abrir (2x)
Camélia é minha flor
Orquídea amor sem fim
O lírioéa alegria que vem de mim
Violetatraz a noite
A rosa o amor
O cravo foi quem me presenteou$c6be314afc047022ca1acc6f799a0efa4$, NULL, now()),
('e690ec0f-bb70-7ca8-96d6-df68db43837a', 'aac65700-2760-4f83-0702-b8009120587d', $te690ec0fbb707ca896d6df68db43837a$Oxalá - Oxalá no coração$te690ec0fbb707ca896d6df68db43837a$, $ce690ec0fbb707ca896d6df68db43837a$Quando eu venho a Umbanda
épra cumprir uma missão
éde prestar a caridade
éservir a Oxalá, sem nunca dizer que não
Se tu és filhode Umbanda
preste bem muita atenção
Umbanda é o que se dá
édando que se recebe
Oxalá no coração
Tenho meu corpo fechado
tenho uma chave em meu peito
enão há mal que me pegue
meu Deus do céu
não há mal que eu não dê jeito
eu rezo três"padre nosso"
euma Salve Rainha
peço a Deus que me Proteja
Oxalá que me ampare
na força das sete linhas
Saravá Pai Oxalá,
que sempre me deu a mão
esse pai que me ajuda
acumprir minha missão
eu quero papai eu quero
eu quero lhe agradecer
por tudo que tu me destes
eque eu venha a merecer$ce690ec0fbb707ca896d6df68db43837a$, NULL, now()),
('67034810-4019-9867-1f34-c2f2fb24ef0e', 'aac65700-2760-4f83-0702-b8009120587d', $t67034810401998671f34c2f2fb24ef0e$Oxalá - Força do Divino$t67034810401998671f34c2f2fb24ef0e$, $c67034810401998671f34c2f2fb24ef0e$Maior que Zambi
maior que Oxalá
procure nesse mundo
não encontrará
Zambi é pai
Oxalá é filho
encontrei na Umbanda
aforça do Divino
No sofrimento
na minha dor
foiZambi e Oxalá
quem me ajudou$c67034810401998671f34c2f2fb24ef0e$, NULL, now()),
('6fa20260-2c19-35eb-aa7d-c3ee9327a38a', 'aac65700-2760-4f83-0702-b8009120587d', $t6fa202602c1935ebaa7dc3ee9327a38a$Oxalá - Oxalá é luz$t6fa202602c1935ebaa7dc3ee9327a38a$, $c6fa202602c1935ebaa7dc3ee9327a38a$Zambi olhaiesse mundo
que o Senhor criou
Com beleza e encanto
Oxalá com o seu manto
A bondade semeou
Carregando a cruz
carregando a dor
Oxalá é Luz
Ele éo amor
Abra a porta do coração
prareceber meu Pai
Abra a porta do coração
praencontrar a Paz$c6fa202602c1935ebaa7dc3ee9327a38a$, NULL, now()),
('a53a560b-43ec-09c2-c163-9c3372a5fa81', 'aac65700-2760-4f83-0702-b8009120587d', $ta53a560b43ec09c2c1639c3372a5fa81$Oxalá - Pomba da paz$ta53a560b43ec09c2c1639c3372a5fa81$, $ca53a560b43ec09c2c1639c3372a5fa81$Voou uma pomba branca
no céu pelo mundo inteiro
mas foino meu terreiro
que ela descansou
Na coroa de Oxalá
que está neste gongá
dando forçapra meus guias
virtrabalhar
epa babá, epa babá, epa babá
salve amãe Virgem Maria
salve meu paiOxalá
epa babá, epa babá, epa babá
salve todos nossos guias
salve apomba da paz$ca53a560b43ec09c2c1639c3372a5fa81$, NULL, now()),
('f86597cf-359a-739c-9964-de2960da4767', 'aac65700-2760-4f83-0702-b8009120587d', $tf86597cf359a739c9964de2960da4767$Oxalá - Amado pai$tf86597cf359a739c9964de2960da4767$, $cf86597cf359a739c9964de2960da4767$ómeu amado pai, senhor do infinito
olhaipor toda humanidade, e nos abençoai
avolta do mundo é grande meu pai
eo vosso poder é maior
Oxalá - Pombinha branca$cf86597cf359a739c9964de2960da4767$, NULL, now()),
('d0f31f5a-b71c-d2df-99be-0bea4e0251ee', 'aac65700-2760-4f83-0702-b8009120587d', $td0f31f5ab71cd2df99be0bea4e0251ee$Página18de 19$td0f31f5ab71cd2df99be0bea4e0251ee$, $cd0f31f5ab71cd2df99be0bea4e0251ee$pombinha branca
que Oxalá mandou [2x]
naquele pé de laranjeira
pombinha branca pousou [2x]$cd0f31f5ab71cd2df99be0bea4e0251ee$, NULL, now()),
('d7eea9de-84c0-7fd6-d1be-5f1337c479e2', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $td7eea9de84c07fd6d1be5f1337c479e2$Chamado de Oxóssi$td7eea9de84c07fd6d1be5f1337c479e2$, $cd7eea9de84c07fd6d1be5f1337c479e2$Eu estava dormindo, meu pai Oxossi me chamou! Com a força da natureza valei-me okê arô !
Okê arô, Okê arô
Valei-me meu paioxossi caçador meu protetor (2x)
Oio seu brado me acordou
Seu brado me despertou
Seu brado me convocou
Pra ser filhode umbanda e saldar meu protetor
Okê arô, Okê arô
Valei-me meu paioxossi caçador meu protetor (2x)
Oxossi é o reidas matas
É dono do meu caminho
A sua flecha é certeira
Quem éfilhode oxossi nunca vai estarsozinho
Okê arô, Okê arô
Valei-me meu paioxossi caçador meu protetor (2x)$cd7eea9de84c07fd6d1be5f1337c479e2$, NULL, now()),
('77389a33-09fd-3c01-41c6-e3996d6d20fa', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t77389a3309fd3c0141c6e3996d6d20fa$Senhor das matas$t77389a3309fd3c0141c6e3996d6d20fa$, $c77389a3309fd3c0141c6e3996d6d20fa$Sobre o luar de prata
meu senhor das matas
Oxossi caçador
com seu arco e sua flecha
uma voz divina lhe chamam de ibô [2x]
okê arô
okê arô
okê arô
uns lhe chamam ibualama
outros apenas ibô$c77389a3309fd3c0141c6e3996d6d20fa$, NULL, now()),
('b1a86010-e4dd-6e7d-6f9b-50ee8a287091', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tb1a86010e4dd6e7d6f9b50ee8a287091$Okê bamboclinho$tb1a86010e4dd6e7d6f9b50ee8a287091$, $cb1a86010e4dd6e7d6f9b50ee8a287091$Okê bamboclinho, lána mata tem guiné! 2x
Oxóssi é rei,ele é reilá na macáia.
Ele vem de Aruanda, pra saudar esse congá!
Ele ganhou flecha e bodóque,
sua coroa quem lhe deu foiOxalá! 2x
Oxóssi - Guerreiro das matas$cb1a86010e4dd6e7d6f9b50ee8a287091$, NULL, now()),
('43e13883-1054-32c9-eac2-f83b8ea41528', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t43e13883105432c9eac2f83b8ea41528$Página 1de 19$t43e13883105432c9eac2f83b8ea41528$, $c43e13883105432c9eac2f83b8ea41528$Um brado ecoou na mata
A água desce na cascata
O cantar dos pássaros
Anunciam a sua chegada
Salve o grande guerreiro
Salve Oxóssi caçador
Vem saudar sua banda
Nós trazendo a paz e o amor
Okê aro, saravá meu pai
O homem de uma flecha só
Tem a mira certeira
Não é de brincadeira
Atirapra não errar
Salve o dono da mata
Que na luade prata
Vem me abençoar
Não me deixe sozinho
Guie meu caminho
Vem me iluminar
Okê arô saravá Oxóssi
Okê arô Orixá da minha fé
Okê arô saravá Oxóssi
Vem nos trazer o seu axé$c43e13883105432c9eac2f83b8ea41528$, NULL, now()),
('2a955bec-c525-eacc-8154-11b3ba288b58', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t2a955becc525eacc815411b3ba288b58$Oxóssi - Flecha Certeira$t2a955becc525eacc815411b3ba288b58$, $c2a955becc525eacc815411b3ba288b58$Ê ê ê Caboclo
Traz o seu axé
Ê ê ê Caboclo
Vem das matas da Jurema
Para aqueles que tem fé(2x)
Sob o luar de prata
Elevem acaminhar
Desbravando toda a mata
Elevem pra trabalhar
Sua flecha é certeira
Atirapra não errar
Eleé meu paiOxóssi
Sua banda bem saudar
Ê ê ê Caboclo
Traz o seu axé
Ê ê ê Caboclo
Vem das matas da Jurema
Para aqueles que tem fé(2x)$c2a955becc525eacc815411b3ba288b58$, NULL, now()),
('0f435f9a-b2cb-f4ca-30a3-bfd8d9b12f57', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t0f435f9ab2cbf4ca30a3bfd8d9b12f57$Oxossi mora na raiz da gameleira$t0f435f9ab2cbf4ca30a3bfd8d9b12f57$, $c0f435f9ab2cbf4ca30a3bfd8d9b12f57$Oxossi mora na raiz da gameleira
Ogum, mora na lua
Xangô lá na pedreira
Oxossi mora na raizda gameleira
Ogum, mora na lua
Xangô lá na pedreira
Se cobra pia
eu também quero piar
sua flecha e seu bodoque
seu botoque é de Indaiá
Se cobra pia
eu também quero piar
sua flecha e seu bodoque
seu botoque é de Indaiá$c0f435f9ab2cbf4ca30a3bfd8d9b12f57$, NULL, now()),
('4fdab94e-4bfa-2227-b1a5-c90f31a7d9f6', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t4fdab94e4bfa2227b1a5c90f31a7d9f6$Oxossi - Axoxô$t4fdab94e4bfa2227b1a5c90f31a7d9f6$, $c4fdab94e4bfa2227b1a5c90f31a7d9f6$Vou preparar um axoxô
para o reida mata, rei caçador
Meu pai Oxóssi, com sua flecha de prata
Ele vive lána mata
Trás da caça, um bodoque de Indaiá
Okê, okearô
vou lá na mata, vou deixar seu axoxô
Okê, okearô
vou lá na mata, vou deixar seu axoxô$c4fdab94e4bfa2227b1a5c90f31a7d9f6$, NULL, now()),
('f22683df-4c41-190a-9f5a-427636d948fb', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tf22683df4c41190a9f5a427636d948fb$Oxóssi - O Grande Rei$tf22683df4c41190a9f5a427636d948fb$, $cf22683df4c41190a9f5a427636d948fb$Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!
Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!
Irmão de Ogum, filhode Iemanjá
Senhor do conhecimento
É astuto ao caçar
Traz toda força
E fartura em axé
Meu Pai Oxóssi abençoai filhos de fé!!!i
Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!
Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!
Ele é Oxóssi caçuté da juremá
Protetor da fauna e flora
Olha cada pedra do lugar
Com os caboclos ao seu lado
Ajudando a vigiar
Lá na macaia
Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!
Lá na macaia
Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!
Toca o agueré oke arolê
Óh Pai Oxóssi, venha nos defender!!!
Lá no ketu é um rei
Na Umbanda São Sebastião
Venho clamar o seu nome
Mas com toda devoção.
Toca o agueré oke arolê
Óh Pai Oxóssi, venha nos defender!!!
Lá no ketu é um rei
Na Umbanda São Sebastião
Venho clamar o seu nome
Mas com toda devoção.
Lá na macaia
Lá na macaia
Mora um reigrande senhor!!!
Lá na macaia
Mora um reigrande senhor!!!
Orixá de uma flecha só
E Oxalá lhe confiou
Poder de todas as matas
Como um nobre caçador!!!$cf22683df4c41190a9f5a427636d948fb$, NULL, now()),
('eabedac2-b4e5-0af4-1f39-9a8469bfcdfd', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $teabedac2b4e50af41f399a8469bfcdfd$Quem manda na mata é Oxóssi$teabedac2b4e50af41f399a8469bfcdfd$, $ceabedac2b4e50af41f399a8469bfcdfd$Quem manda na mata é Oxóssi
Oxóssi é caçador
Oxóssi é caçador
Quem manda na mata é Oxóssi
Oxóssi é caçador
Oxóssi é caçador
Eu vimeu pai assoviar
Mas eu mandei chamar
Eu vimeu pai assoviar
Mas eu mandei chamar
É de Aruanda auê
É de Aruanda auá
O seu Oxóssi na Umbanda
É de Aruanda auê
É de Aruanda auê
É de Aruanda auá
O seu Oxóssi na Umbanda
É de Aruanda auê$ceabedac2b4e50af41f399a8469bfcdfd$, NULL, now()),
('73f8734c-d708-21f9-d0c8-2dd44b8d8e35', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t73f8734cd70821f9d0c82dd44b8d8e35$Oxossi mora na lua$t73f8734cd70821f9d0c82dd44b8d8e35$, $c73f8734cd70821f9d0c82dd44b8d8e35$Oxossi mora na lua
rodeiao mundo para clarear
Oxossi mora na lua
rodeiao mundo para clarear
Mas eu queriaver Oxossi
para com elefalar
Mas eu queriaver Oxossi
para com elefalar$c73f8734cd70821f9d0c82dd44b8d8e35$, NULL, now()),
('312f744d-2822-feb7-d87a-a958d8df24ef', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t312f744d2822feb7d87aa958d8df24ef$Oxossi - Eu vi chover eu vi relampiar$t312f744d2822feb7d87aa958d8df24ef$, $c312f744d2822feb7d87aa958d8df24ef$Eu vichover eu virelampiar
mas mesmo assim o céu estava azul
Firma seu ponto na folhada Jurema
Oxossi reina de norte asul
Firma seu ponto na folhada Jurema
Oxossi reina de norte asul$c312f744d2822feb7d87aa958d8df24ef$, NULL, now()),
('b1179bec-da56-de55-f2f9-49901870018f', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tb1179becda56de55f2f949901870018f$Oxóssi - Ele é Rei lá na Macaia$tb1179becda56de55f2f949901870018f$, $cb1179becda56de55f2f949901870018f$Oxóssi é rei
Eleé reilá na Macaia
Elevem lá de Aruanda
Saravá este congá
Eleganhou flechae bodoque
Sua coroa, quem lhe deu foiOxalá
Eleganhou flechae bodoque
Sua coroa, quem lhe deu foiOxalá$cb1179becda56de55f2f949901870018f$, NULL, now()),
('40691d5b-8781-1dbb-07e1-2267b4e02ea7', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t40691d5b87811dbb07e12267b4e02ea7$Oxóssi - Flechas de Oxóssi$t40691d5b87811dbb07e12267b4e02ea7$, $c40691d5b87811dbb07e12267b4e02ea7$Oh não se mexe na espada de Ogum
Oh não se mexe na machada de Xangô
Oh não se mexe nas flechas de Oxóssi
que lána mata é reié caçador.
Oh não se mexe nas flechas de Oxóssi
que lána mata é reié caçador.$c40691d5b87811dbb07e12267b4e02ea7$, NULL, now()),
('837e47e3-ee3e-c255-81e7-690ad5b9f2ba', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t837e47e3ee3ec25581e7690ad5b9f2ba$Oxossi - Louvação à Oxóssi e os caboclos de pena$t837e47e3ee3ec25581e7690ad5b9f2ba$, $c837e47e3ee3ec25581e7690ad5b9f2ba$Vinte de janeiro
Dia do meu padroeiro, ele é São Sebastião
A aldeia se prepara para a festa
E a mata se manifesta para a comemoração
Eu vou chamar dona Jurema e Jandira
Jaciara e Jupira para a festacomeçar
Seu Treme Terra, Pedra Preta e Rompe Mato
Seu Guiné, Caboclo Arruda
E o grande Tupinambá
Seu Treme Terra, Pedra Preta e Rompe Mato
Seu Guiné, Caboclo Arruda
E o grande Tupinambá
E vem também a Jureminha
Essa linda caboclinha
Que nos faz emocionar
Seu Pena Verde também estará presente
E vindo lá do oriente
Pena Branca vai chegar
Seu caçador acompanhado de Iracema
Duas irmãs da Jurema
Também vêm nos encantar
Seu Aymoré de braços dados com Juçara
E o brado de Dona Iara
Faz toda mata vibrar
Seu Aymoré de braços dados com Juçara
E o brado de Dona Iara
Faz toda mata vibrar
Kiô,kiô, okê arô!
Saravá meu Pai Oxóssi
Hoje canto em seu louvor
Kiô,kiô, okê arô!
Saravá meu Pai Oxóssi
Hoje canto em seu louvor$c837e47e3ee3ec25581e7690ad5b9f2ba$, NULL, now()),
('f2afef35-513a-575a-67fd-d8c9dd14c0b8', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tf2afef35513a575a67fdd8c9dd14c0b8$Oxóssi, quem é de Oxóssi?$tf2afef35513a575a67fdd8c9dd14c0b8$, $cf2afef35513a575a67fdd8c9dd14c0b8$Oxóssi, quem é de Oxóssi?
Eu sou de Oxóssi, meu pai é reicaçador
guardião da mata virgem, onde ele se criou
A sua flecha, quando atiraé certeira
não há mal que me derrube, minha fé é verdadeira
Oxóssi, quem é de Oxóssi?
Eu sou de Oxóssi, e com muita devoção
nos tropeços desta vida ele me estende a mão
Em meu terreiroestarei pra lhe louvar
salve a Umbanda querida, salve esse grande Orixá$cf2afef35513a575a67fdd8c9dd14c0b8$, NULL, now()),
('2cb830dd-ca47-ff23-666f-473d36ce2abc', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t2cb830ddca47ff23666f473d36ce2abc$Oxóssi - Toda mata tem sua lei$t2cb830ddca47ff23666f473d36ce2abc$, $c2cb830ddca47ff23666f473d36ce2abc$Toda a mata tem sua lei
Onde Oxóssi lá érei
Sob as ordens de Tupã
Ao romper da madrugada
Se reúne a passarada
Pra fazer sua oração
Ao romper da madrugada
Se reúne a passarada
Pra fazer sua oração
As estrelas estão acesas
No gongá da natureza
Pra louvar seu criador
Todo mundo bem contente
A cantar ponto bem dolente
Pra chamar seu protetor
Todo mundo bem contente
Canta ponto bem dolente
Pra chamar seu protetor
A Tupã todos adoram
Vem Oxóssi sem demora
E abençoa os filhosseus
De Iemanjá peço a licença
E também nos trazsua benção
Santa Virgem Mãe de Deus
De Iemanjá peço a licença
E também nos traza benção
Santa Virgem Mãe de Deus$c2cb830ddca47ff23666f473d36ce2abc$, NULL, now()),
('c9a15647-1f7f-8088-6734-77186b6447e2', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tc9a156471f7f8088673477186b6447e2$Oxóssi - Rompendo aurora /Rei da mata$tc9a156471f7f8088673477186b6447e2$, $cc9a156471f7f8088673477186b6447e2$A lua vaisumindo e vem rompendo aurora
clareiaa mata virgem aonde Oxóssi mora
Clareou, clareou
amata virgem aonde Oxóssi mora$cc9a156471f7f8088673477186b6447e2$, NULL, now()),
('69ae8aae-e0a4-8640-508c-d3d4137efb2e', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t69ae8aaee0a48640508cd3d4137efb2e$Oxossi - A Natureza de Pai Oxóssi$t69ae8aaee0a48640508cd3d4137efb2e$, $c69ae8aaee0a48640508cd3d4137efb2e$O sol brilha
Em céu azul que lhe congrace
Iluminando as verdes matas
Para um novo amanhecer
Canta o sabiá
Com gracejo para exaltar
Toda a beleza e a riqueza de encantar
É a jurema
Solo sagrado que Olorum me confiou
Salve a mãe terra
Salve a sua natureza
A macaia é fortaleza
De oxossi o caçador
Salve a mãe terra
Salve a sua natureza
A macaia é fortaleza
De oxossi o caçador
Okê arô,okê okê okê arô
Pai Oxóssi é reide Ketu
Da floresta protetor
Okê arô
Senhor do conhecimento
Pai Oxóssi curador
Okê arô,okê okê okê arô
Pai Oxóssi é reide Ketu
Da floresta protetor
Okê arô
Senhor do conhecimento
Pai Oxóssi curador
O sol brilha
Em céu azul que lhe congrace
Iluminando as verdes matas
Para um novo amanhecer
Canta o sabiá
Com gracejo para exaltar
Toda a beleza e a riqueza de encantar
É a jurema
Solo sagrado que Olorum me confiou
Salve a mãe terra
Salve a sua natureza
A macaia é fortaleza
De Oxóssi o caçador
Salve a mãe terra
Salve a sua natureza
A macaia é fortaleza
De Oxóssi o caçador
Okê arô,okê okê okê arô
Pai Oxóssi é reide Ketu
Da floresta protetor
Okê arô
Senhor do conhecimento
Pai Oxóssi curador
Okê arô,okê okê okê arô
Pai Oxóssi é reide Ketu
Da floresta protetor
Okê arô
Senhor do conhecimento
Pai Oxóssi curador$c69ae8aaee0a48640508cd3d4137efb2e$, NULL, now()),
('ef2b1547-df0c-cba9-a778-faa03af4efa3', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tef2b1547df0ccba9a778faa03af4efa3$Oxóssi - Oxóssi (Cover)$tef2b1547df0ccba9a778faa03af4efa3$, $cef2b1547df0ccba9a778faa03af4efa3$Oxóssi, filhode Iemanjá
Divindade do clã de Ogum
É Ibualama, é Inlé
Que Oxum levou pro rio
E nasceu Logunedé!
Sua natureza é da lua
Na lua Oxóssi é Odé
Odé-Odé, Odé-Odé
Rei de Keto Caboclo da mata Odé-Odé
Odé-Odé, Odé-Odé
Rei de Keto Caboclo da mata Odé-Odé
Quinta-feira o seu ossé
Axoxó, feijão preto, camarão e amendoim
Azul e verde, suas cores
Calça branca rendada
Saia curta estampada
Ojá e couraça prateada
Na mão ofá,iluquerê
Okê arô,Oxóssi, okê, okê
A jurema é a árvore sagrada
Okê arô,Oxóssi, okê okê
Na Bahia é São Jorge
No Rio, São Sebastião
Oxóssi é quem manda
Nas bandas do meu coração
Na Bahia é São Jorge
No Rio, São Sebastião
Oxóssi é quem manda
Nas bandas do meu coração$cef2b1547df0ccba9a778faa03af4efa3$, NULL, now()),
('970196bd-3405-8f14-b477-ff78f829585a', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t970196bd34058f14b477ff78f829585a$Oxóssi - Arqueiro de Luz$t970196bd34058f14b477ff78f829585a$, $c970196bd34058f14b477ff78f829585a$Oh dono da mata
Peço licençapra entrar
Salve o povo da Jurema
Salve todo Juremá
Saravá os Caboclos de pena
Vim ver Oxóssi em seu congá
Oxóssi é morador da macaia
Mira e não falha, vence demanda
Oxóssi é um arqueiro de luz
Oxalá conduz, e a sua flechamanda$c970196bd34058f14b477ff78f829585a$, NULL, now()),
('1e507b21-d8e5-98fd-0cbe-e9cb62fd4665', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t1e507b21d8e598fd0cbee9cb62fd4665$Oxóssi - Grande Caçador$t1e507b21d8e598fd0cbee9cb62fd4665$, $c1e507b21d8e598fd0cbee9cb62fd4665$Grande flecheiro na mão traz um ofá
Com uma única flecha não pode errar
Nas matas ele é o grande caçador
Na Umbanda, é paié protetor
Grande flecheiro na mão traz um ofá
Com uma única flecha não pode errar
Nas matas ele é o grande caçador
Na Umbanda é pai,é protetor
O oke arô, oke arô,oke arô,oke arô
O oke arô, oke arô,oke arô,oke arô
É defensor dos riose cascatas
Ele é paiOxóssi o dono da caça
Na agricultura semeia com amor
Para nos dar fartura,oke arô
É defensor dos riose cascatas
Ele é paiOxóssi o dono da caça
Na agricultura semeia com amor
Para nos dar fartura,
O oke arô
O oke arô, oke arô,oke arô,oke arô
O oke arô, oke arô,oke arô,oke arô$c1e507b21d8e598fd0cbee9cb62fd4665$, NULL, now()),
('4342dd74-db84-850d-3963-961f7f3769c2', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t4342dd74db84850d3963961f7f3769c2$Oxóssi - Luz de Oxóssi$t4342dd74db84850d3963961f7f3769c2$, $c4342dd74db84850d3963961f7f3769c2$É reide Ketu, nas matas caçador
De Ossanhe ganhou as ervas e Ogum quem lhe criou
É reide Ketu, nas matas caçador
De Ossanhe ganhou as ervas e Ogum quem lhe criou
A minha vida ilumina
O pai Oxóssi é quem me guia
Nesse dia eu vou louvar
Meu pai supremo e dono deste gongá
Nesse dia eu vou louvar
Meu pai supremo e dono deste gongá
Eu agradeço por ser seu filho
E se eu andar pelo escuro
Com sua luze sua fartura,meu pai
Meu caminho está seguro
Com sua luze sua fartura,meu pai
Meu caminho está seguro
É reide Ketu, nas matas caçador
De Ossanhe ganhou as ervas e Ogum quem lhe criou
É reide Ketu, nas matas caçador
De Ossanhe ganhou as ervas e Ogum quem lhe criou$c4342dd74db84850d3963961f7f3769c2$, NULL, now()),
('b9667e37-0942-a464-c7ca-129461bb8d04', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tb9667e370942a464c7ca129461bb8d04$Oxóssi - Oxóssi é o nosso protetor$tb9667e370942a464c7ca129461bb8d04$, $cb9667e370942a464c7ca129461bb8d04$Mas como é bonito
Assistirfesta nas matas
Ouvir o som das cascatas
E o lindocanto do sabiá
Que noitelinda
Que bela noite de luar
Sob o clarão da lua
Eu vio pai Oxóssi passar
A mata estava em festa, ô ô ô
Toda coberta de flores
Até os passarinhos cantam em seu louvor
Ele é nosso protetor
Ô ô ô ô ô quanta beleza
Ô ô ô ô quanto esplendor
Como é bom tera certeza
Que o paiOxóssi é nosso protetor
Ô ô ô ô ô quanta beleza
Ô ô ô ô quanto esplendor
Como é bom tera certeza
Que o paiOxóssi é nosso protetor$cb9667e370942a464c7ca129461bb8d04$, NULL, now()),
('437762a8-792a-8ce0-0a56-6ec0e991fbb5', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t437762a8792a8ce00a566ec0e991fbb5$Oxóssi - Senhor das matas$t437762a8792a8ce00a566ec0e991fbb5$, $c437762a8792a8ce00a566ec0e991fbb5$Ó senhor das matas,
Nesta sua paz, eu vou me abrigar,
Sob um sol de igualdade
Vou sentir liberdade
Com o senhor vou caçar.
Vou parar nesse verde de Oxóssi
Esperança pra mim
Entre folhas caindo
Pé no chão vou seguindo
Eu vou viver.
Acordar quando o solno horizonte nascer
Me banhar em seus rios
Libertoa correr
Folhas verdes no frioirãome guardar
Santa paz de Oxóssi
Vai me acompanhar.
Acordar quando o solno horizonte nascer
Me banhar em seus rios
Libertacorrer
Folhas verdes no frioirãome guardar
Santa paz de Oxóssi
Vai me acompanhar$c437762a8792a8ce00a566ec0e991fbb5$, NULL, now()),
('60481abe-de53-3874-ca57-88e5769be607', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t60481abede533874ca5788e5769be607$Oxóssi - Dono da colheita e do pão$t60481abede533874ca5788e5769be607$, $c60481abede533874ca5788e5769be607$E para quem não sabe eu vou dizer
Oxóssi é o nome de São Sebastião
Mas elevive lá na aldeia,lá na mata
Onde ele mora?
Ele éo dono da colheita e do pão
E para sua vida melhorar
E nunca lhefaltaro que comer
Acenda uma vela lá na mata oipara Oxóssi
E reze que ele vem nos proteger$c60481abede533874ca5788e5769be607$, NULL, now()),
('ebb9ce98-7adc-106c-ba05-c46b3866be21', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tebb9ce987adc106cba05c46b3866be21$Oxossi - Guardião da Mata Escura$tebb9ce987adc106cba05c46b3866be21$, $cebb9ce987adc106cba05c46b3866be21$Olha lá no pé da serra onde a palmeira balançou
Oxóssi é Odé, Oxóssi é caçador
Vem ligeirocomo o vento
Manso como céu azul
Sua coroa irradia
A estrelade Umbanda conduz
Radiante igual sol da manhã
Faceiro igualbrilho da lua
A sua flecha não mente
Guardião da Mata Escura
Olha lá no pé da serra onde a palmeira balançou
Oxóssi é Odé, Oxóssi é caçador$cebb9ce987adc106cba05c46b3866be21$, NULL, now()),
('0ac69d41-49a6-e37d-f9cf-9f6aa3a3f029', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t0ac69d4149a6e37df9cf9f6aa3a3f029$Oxóssi - Quem manda na mata é Oxóssi$t0ac69d4149a6e37df9cf9f6aa3a3f029$, $c0ac69d4149a6e37df9cf9f6aa3a3f029$Quem manda na mata é Oxóssi
Oxóssi é caçador, Oxóssi é caçador [2x]
Eu vimeu pai assobiar
elemandou chamar [2x]
éde Aruanda eh
éde Aruanda eh
meus capangueiros de Umbanda
éde Aruanda eh [2x]$c0ac69d4149a6e37df9cf9f6aa3a3f029$, NULL, now()),
('fb6d001e-5681-83b3-0e12-a5e09453e909', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tfb6d001e568183b30e12a5e09453e909$Oxóssi - Naquela estrada de areia$tfb6d001e568183b30e12a5e09453e909$, $cfb6d001e568183b30e12a5e09453e909$Naquela estrada de areia
aonde a lua clareou [2x]
Todo Caboclos pararam
para vera procissão de São Sebastião [2x]
okê okê Caboclo
meu paiCaboclo
éSão Sebastião [2x]$cfb6d001e568183b30e12a5e09453e909$, NULL, now()),
('376b6007-afe4-6cd8-b2ae-5cec70a5c1a2', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t376b6007afe46cd8b2ae5cec70a5c1a2$Oxóssi - Eu vi chover, eu vi relampear$t376b6007afe46cd8b2ae5cec70a5c1a2$, $c376b6007afe46cd8b2ae5cec70a5c1a2$Eu vichover
eu virelampear
mas mesmo assim o céu estava azul
Firma seu ponto
na folhada Jurema
Oxóssi é bamba
do Maracatú [2x]$c376b6007afe46cd8b2ae5cec70a5c1a2$, NULL, now()),
('8eddb614-81eb-1b28-5a2a-417d352a9fd1', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t8eddb61481eb1b285a2a417d352a9fd1$Oxossi - Eu vi a lua$t8eddb61481eb1b285a2a417d352a9fd1$, $c8eddb61481eb1b285a2a417d352a9fd1$Eu via lua
Eu via lua
Eu via lua eu faleicom ela
A luaé linda
A luaé bela
Senhor Oxossi mora dentro dela$c8eddb61481eb1b285a2a417d352a9fd1$, NULL, now()),
('390ad009-0318-aaef-5815-11e3f3a28e83', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t390ad0090318aaef581511e3f3a28e83$Oxóssi - Oxóssi na mata é rei$t390ad0090318aaef581511e3f3a28e83$, $c390ad0090318aaef581511e3f3a28e83$Oxóssi na mata é rei
Oxóssi na mata é
Quem anda dentro da mata
sem deixar mata de pé [2x]
Caboclo não desacata
Caboclo sabe quem é
Ele anda dentro da mata
sem deixar mata de pé
Oxóssi na mata é rei
Oxóssi na mata é
Quem anda dentro da mata
sem deixar mata de pé
Ele tem flecha e bodoque
Ele tem lança e cocar
amata é o seu reino
ena mata reinará$c390ad0090318aaef581511e3f3a28e83$, NULL, now()),
('a559644e-03fd-ad75-cd65-dfa2d0b704ca', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $ta559644e03fdad75cd65dfa2d0b704ca$Oxossi - Oxossi Tupiara$ta559644e03fdad75cd65dfa2d0b704ca$, $ca559644e03fdad75cd65dfa2d0b704ca$Eu viOxóssi na mata caçando
Ele éOxóssi da cachoeira
Seu capacete é de penas de arara
Ele éfilhoda Oxum
Ele éOxóssi Tupiara$ca559644e03fdad75cd65dfa2d0b704ca$, NULL, now()),
('380fa2e1-f78c-b08b-c8c9-8f8e7dd96b5a', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t380fa2e1f78cb08bc8c98f8e7dd96b5a$Oxossi - O Rei das matas$t380fa2e1f78cb08bc8c98f8e7dd96b5a$, $c380fa2e1f78cb08bc8c98f8e7dd96b5a$Sou filhodo guerreiro de uma flecha só
Sou filhode Oxossi caçador
E todo bom guerreiro não anda só
Tem sempre um irmão merecedor
O Rei das Matas
O meu protetor
O Rei das Matas
O meu protetor
Sarava meu paiOxossi
Sua bênção meu senhor
Oke Arô
Sou filhodo guerreiro de uma flecha só
Sou filhode Oxossi caçador
Ele émensageiro do Pai maior
E cumpre sua missão com muito amor
O Rei das Matas
O meu protetor
O Rei das Matas
O meu protetor
Sarava meu paiOxossi
Sua bênção meu senhor
Oke Arô$c380fa2e1f78cb08bc8c98f8e7dd96b5a$, NULL, now()),
('97121408-34c0-e948-e53b-0a92692558e6', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t9712140834c0e948e53b0a92692558e6$Oxossi - Oxossi é bamba no maracatu /Pisa na Aruanda$t9712140834c0e948e53b0a92692558e6$, $c9712140834c0e948e53b0a92692558e6$Eu vichover eu vi relampear
mas mesmo assim o céu estava azul
firmaseu ponto nas folhas da Jurema
Oxossi é bamba no maracatu
/////////////////////////////////////////////
Oxossi sobe serra e desce serra na Aruanda
Pisa na Aruanda auê
Pisa na Aruanda auê
Pisa na Aruanda auê$c9712140834c0e948e53b0a92692558e6$, NULL, now()),
('47e7b25f-12fb-9f3e-f4ed-36cc780cbcd2', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t47e7b25f12fb9f3ef4ed36cc780cbcd2$Oxossi - Viva São Sebastião$t47e7b25f12fb9f3ef4ed36cc780cbcd2$, $c47e7b25f12fb9f3ef4ed36cc780cbcd2$A malvadeza que vieram lhe fazer
amarraram pelos pés
amarraram pelas mãos
atiraram flechas no peito
de meu São Sebastião
viva,viva!
ôviva São Sebastião
Ele émeu paiOxóssi
na coroa do gongá
vem abençoar seu filho
não deixa ele tombar$c47e7b25f12fb9f3ef4ed36cc780cbcd2$, NULL, now()),
('adf12792-a82e-72f3-edf8-9d9c7c050f68', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $tadf12792a82e72f3edf89d9c7c050f68$Oxossi - A terra tremeu$tadf12792a82e72f3edf89d9c7c050f68$, $cadf12792a82e72f3edf89d9c7c050f68$Oxóssi quando vem
elevem aos pés da cruz
trazendo a proteção
para os filhosde Jesus
A terratremeu
aterra tremeu
tremeu a cruz
só não tremeu Jesus
Oxossi - Caçador$cadf12792a82e72f3edf89d9c7c050f68$, NULL, now()),
('a4c1fa14-2e4f-2ce7-feeb-ae70453b3b91', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $ta4c1fa142e4f2ce7feebae70453b3b91$Página16de 19$ta4c1fa142e4f2ce7feebae70453b3b91$, $ca4c1fa142e4f2ce7feebae70453b3b91$Na mata virgem vium grande caçador
Na mata virgem vium grande caçador
Ele dava um brado, kiô,kiô
Ele dava um brado, kiô,kiô
Ele é Oxóssi, okê arô
Ele é Oxóssi, okê arô
Com uma flecha dourada, sua caça acertou
Com uma flecha dourada, sua caça acertou$ca4c1fa142e4f2ce7feebae70453b3b91$, NULL, now()),
('0b08b738-b5e3-765a-e846-bb3b2318cfda', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t0b08b738b5e3765ae846bb3b2318cfda$Oxossi - Senhor das Matas$t0b08b738b5e3765ae846bb3b2318cfda$, $c0b08b738b5e3765ae846bb3b2318cfda$Oh! Senhor das matas
nesta sua paz, eu vou me abrigar
neste chão de igualdade, vou sentir liberdade
com o senhor vou caçar
vou parar nesse verde de Oxossi esperança pra mim
entre folhas caindo, pé no chão vou seguindo
eu vou viver
acordar quando o sol,no horizonte nascer
me banhar nos seus rios,libertoa correr
folhasverdes no frio,irãome guardar
santa paz de Oxossi, vai me agasalhar.$c0b08b738b5e3765ae846bb3b2318cfda$, NULL, now()),
('09c7bd3e-0be9-3c00-889e-1df14c60e240', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t09c7bd3e0be93c00889e1df14c60e240$Oxossi e Ogum -Guerreiros$t09c7bd3e0be93c00889e1df14c60e240$, $c09c7bd3e0be93c00889e1df14c60e240$Engano seu que pensa que ando só
ando em companhia de Ogum,
ando em companhia de Oxóssi
Sou filhode fé,nunca ando sozinho
orixáme guia, abre os meus caminhos
ao dono da mata peço proteção
Orixá guerreiro, São Sebastião
Engano seu que pensa que ando só
ando em companhia de Ogum,
ando em companhia de Oxóssi
Bato o tambor, sigo os preceitos
orixáme guia, São Jorge guerreiro
de espada e flecha não sobra nenhum
oke arô Oxóssi, patacuri Ogum
Oxossi - Filhos da mata$c09c7bd3e0be93c00889e1df14c60e240$, NULL, now()),
('0843d5fa-1297-8b1f-c734-83bfcbea0520', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t0843d5fa12978b1fc73483bfcbea0520$Página 17de 19$t0843d5fa12978b1fc73483bfcbea0520$, $c0843d5fa12978b1fc73483bfcbea0520$Odé, Odé! filhosda mata
Okê arô!meu paié rei
Banho de axé, luade prata
Nas veredas do destino
Caçador eu me tornei
Se engana quem acha
Que o sangue do banto
É moeda de troca
Se liga,não faz
Do meu santo sagrado
Um santo qualquer
Quem pensa que crença
É coisa da moda, acorda, se toca
Precisa bem mais que camisa
Revê tua fé
Confio no arco
E na flecha certeira
Do meu protetor
Se vem o mau tempo
Vou de barra vento
Firmar o tambor
Meu corpo é fechado
Banhado e blindado
Na força da fé
Que nem capoeira
Eu levo rasteira
Mas caio de pé
Quem cultivao bem vai colher
Quando a roda da vida girar
É preciso aprender a perder
Pra entender o valor de ganhar
Acorde mais cedo
E desvende o segredo
Do galo cantar
Ajude teu santo
Pro santo do santo
Poder teajudar$c0843d5fa12978b1fc73483bfcbea0520$, NULL, now()),
('777556d3-62a2-6afe-fe53-829d92c0f01c', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t777556d362a26afefe53829d92c0f01c$Oxossi - Oxossi plantou manacá$t777556d362a26afefe53829d92c0f01c$, $c777556d362a26afefe53829d92c0f01c$Oxossi plantou manacá em aruanda
manacá deu florna umbanda [2x]
para oferecer
aos filhoesdessa banda [2x]$c777556d362a26afefe53829d92c0f01c$, NULL, now()),
('0249bb2e-63f0-4e0a-29ab-e600f40c03c8', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $t0249bb2e63f04e0a29abe600f40c03c8$Oxossi - Foi Zambi quem criou o mundo$t0249bb2e63f04e0a29abe600f40c03c8$, $c0249bb2e63f04e0a29abe600f40c03c8$FoiZambi quem criou o mundo
sóZambi pode governar
foiZambi quem criou
asestrelasque iluminam
Oxossi láno jurema$c0249bb2e63f04e0a29abe600f40c03c8$, NULL, now()),
('aa256ebe-1bc1-3f73-3799-7c9e45b04843', '5ded97da-d6ce-c352-9ffe-80042e55c80d', $taa256ebe1bc13f7337997c9e45b04843$Oxossi - Lua nova quando brilha$taa256ebe1bc13f7337997c9e45b04843$, $caa256ebe1bc13f7337997c9e45b04843$Lua nova quando brilha\nbrilhano romper da aurora [2x]\n\n clareando uma chopana\n aonde Oxossi mora [2x]\n\n
clareouna mata virgem\n uma chopana aonde Oxossi mora [2x]\n$caa256ebe1bc13f7337997c9e45b04843$, NULL, now()),
('d4b04ada-4a91-793a-294e-2a5c1bbd0f36', '845f426a-315f-16b0-d00a-60471b18abf6', $td4b04ada4a91793a294e2a5c1bbd0f36$Oxum - Rainha da Cachoeira$td4b04ada4a91793a294e2a5c1bbd0f36$, $cd4b04ada4a91793a294e2a5c1bbd0f36$A minha mãe Oxum Oraiêiêo
rainhada cachoeira
aDeusa da beleza é minha mãe Oxum
Orixáda natureza. (2x)
aívem mãe Oxum passeando
passeando no clarão da lua. (2x)
mas como é linda
mas como é linda
mamãe Oxum passeando no clarão da lua. (2x)$cd4b04ada4a91793a294e2a5c1bbd0f36$, NULL, now()),
('6985032b-d332-7113-8d88-690a4446c301', '845f426a-315f-16b0-d00a-60471b18abf6', $t6985032bd33271138d88690a4446c301$Oxum - O Som Da Cachoeira Ecoa$t6985032bd33271138d88690a4446c301$, $c6985032bd33271138d88690a4446c301$O som da cachoeira ecoa
ecoa e nos faz arrepiar (2x)
Mas não só o som das águas
éo canto de Oxum
que nos faz emocionar (2x)
Canta Oxum guerreira
canta para os filhosseus
Canta Oxum guerreira
éna beira da cachoeira
que eu sintoo amor seu (2x)$c6985032bd33271138d88690a4446c301$, NULL, now()),
('57956234-8cfd-ab7d-9166-b4c5500628af', '845f426a-315f-16b0-d00a-60471b18abf6', $t579562348cfdab7d9166b4c5500628af$Oxum |Eu Sou da Mina de Ouro$t579562348cfdab7d9166b4c5500628af$, $c579562348cfdab7d9166b4c5500628af$Eu sou da mina
eu sou da mina de ouro
Eu sou da mina
eu sou da mina de ouro
Onde mora mamãe Oxum
guardiã do meu tesouro
Onde mora mamãe Oxum
guardiã do meu tesouro
Mamãe Oxum
rainhacheia de luz
cubra-nos com vosso manto
rogaipor nós à Jesus
Mamãe Oxum
rainhacheia de luz
cubra-nos com vosso manto
rogaipor nós à Jesus$c579562348cfdab7d9166b4c5500628af$, NULL, now()),
('f9b599af-bf7b-5bc8-c80f-9ccc2d48eae8', '845f426a-315f-16b0-d00a-60471b18abf6', $tf9b599afbf7b5bc8c80f9ccc2d48eae8$Oxum -Ayeyeô mamãe Oxum$tf9b599afbf7b5bc8c80f9ccc2d48eae8$, $cf9b599afbf7b5bc8c80f9ccc2d48eae8$Ayeyeô
Ayeyeô mamãe Oxum
Ayeyeô
Ayeyeô mamãe Oxum
Ayeyeô mamãe Oxum
Ayeyeô mamãe Oxum Maré
Ayeyeô mamãe Oxum
Ayeyeô mamãe Oxum Maré$cf9b599afbf7b5bc8c80f9ccc2d48eae8$, NULL, now()),
('f5631f0f-de42-4c74-8a39-19679c52b6f0', '845f426a-315f-16b0-d00a-60471b18abf6', $tf5631f0fde424c748a3919679c52b6f0$Oxum |Oxum Maré$tf5631f0fde424c748a3919679c52b6f0$, $cf5631f0fde424c748a3919679c52b6f0$Ooo, olha minha vida
mamãe Oxum, Oxum maré
mamãe Oxum, Oxum maré
mamãe Oxum, Oxum maré (2x)
Vim pagar minha promessa
com Deus no coração
saravá mamãe Oxum
que é da minha devoção
mamãe Oxum, Oxum maré
mamãe Oxum, Oxum maré
mamãe Oxum, Oxum maré$cf5631f0fde424c748a3919679c52b6f0$, NULL, now()),
('aa50e21e-4c33-d543-fad6-361affa5b93f', '845f426a-315f-16b0-d00a-60471b18abf6', $taa50e21e4c33d543fad6361affa5b93f$Oxum -Deusa da Natureza$taa50e21e4c33d543fad6361affa5b93f$, $caa50e21e4c33d543fad6361affa5b93f$Eu via rainhada beleza, a Deusa da natureza
com seu lindo manto azul
pareciaum céu todo estrelado
erao manto sagrado da nossa mamãe Oxum
eu juroque pensei fosse miragem
ao contemplar aquela imagem, sentigrande emoção
poisela,é a estrelaguia
me abençoava eu sorriae beijasua mão
orayê yêo (2x)
eayê yêo
chora yêyêo
chora yêyêo
chora yêyêo (2x)$caa50e21e4c33d543fad6361affa5b93f$, NULL, now()),
('48268094-bb18-f642-0b87-a13335854b1a', '845f426a-315f-16b0-d00a-60471b18abf6', $t48268094bb18f6420b87a13335854b1a$Ver um dia mãe Oxum$t48268094bb18f6420b87a13335854b1a$, $c48268094bb18f6420b87a13335854b1a$Céu azul e a lua cor de prata
Céu azul e a lua cor de prata
mas como é lindorefletindona cascata
mas como é lindorefletindona cascata
as nuvens do céu, refletindona cascata
overde das matas, refletindona cascata
ah eu queria, ver um dia mãe Oxum
ah eu queria, ver um dia mãe Oxum
refletidana cascata, refletidana cascata$c48268094bb18f6420b87a13335854b1a$, NULL, now()),
('28808ac1-d680-2962-40f3-538a4ed8197a', '845f426a-315f-16b0-d00a-60471b18abf6', $t28808ac1d680296240f3538a4ed8197a$As Águas da Mamãe Oxum$t28808ac1d680296240f3538a4ed8197a$, $c28808ac1d680296240f3538a4ed8197a$(2x)
As águas da Mamãe Oxum
Brilham sob o céu de Aruanda
As águas da Mamãe Oxum
Curam e protegem a sua banda
Ouço melodia na cascata
Rios passeando em um tom superior
Guardo os meus olhos rasos d'água
Para ouvir Mamãe, Ora yê yê ô!
Águas que me cercam me abraçam
Líriosem todo esplendor
Longa foia minha caminhada
Para ouvir Mamãe, Ora yê yê ô!
Longa foia minha caminhada
Para ouvir Mamãe, Ora yê yê ô!$c28808ac1d680296240f3538a4ed8197a$, NULL, now()),
('22b5c649-fa85-8b9c-313c-3150bd5815b8', '845f426a-315f-16b0-d00a-60471b18abf6', $t22b5c649fa858b9c313c3150bd5815b8$Águas de Oxum$t22b5c649fa858b9c313c3150bd5815b8$, $c22b5c649fa858b9c313c3150bd5815b8$Quem dera
Ver minha mãe Oxum na cachoeira
Quem dera
Ver seu lindo bailarpela ribeira(2x)
Ó doce mãe
Com seu abebê sagrado
Fique sempre do meu lado
Nos caminhos que eu passar
Ó Yabá
Deusa da fertilidade
Me traga felicidade
Venha me abençoar
Foinas águas de Oxum
Que eu encontrei o meu caminho
Foinas águas de Oxum
Que eu leveia minha fé
Ó deusa do amor
Ouça meu clamor
Me dê seu axé (2x)$c22b5c649fa858b9c313c3150bd5815b8$, NULL, now()),
('314f2547-146c-e025-51a9-7b48c5cb427d', '845f426a-315f-16b0-d00a-60471b18abf6', $t314f2547146ce02551a97b48c5cb427d$Oxum - A rainha do Ijexá$t314f2547146ce02551a97b48c5cb427d$, $c314f2547146ce02551a97b48c5cb427d$Ela é bela,é rainha... Aieieo
É dona da cachoeira... Aieieo
Ela é mamãe Oxum
A mais bela orixá
Saravá deusa guerreira
A rainha do Ijexá (2x)
Ó mamãe Oxum
Senhora das cachoeiras e cascatas
Eu
Quero adentrar nas matas minha mãe
Pra senhora me abençoar
Ó divindade da beleza
Me traga sua pureza
E sua luz pra me guiar
Yabá
Rainha dos amores
Receba essas flores
Que eu vim lhe ofertar (2x)
Ela é bela,é rainha... Aieieo
É dona da cachoeira... Aieieo
Ela é mamãe Oxum
A mais bela orixá
Saravá deusa guerreira
A rainha do Ijexá (2x)$c314f2547146ce02551a97b48c5cb427d$, NULL, now()),
('47b9a843-f4b0-f912-eb04-b49e61c7a0ff', '845f426a-315f-16b0-d00a-60471b18abf6', $t47b9a843f4b0f912eb04b49e61c7a0ff$Oxum - Doce mãe$t47b9a843f4b0f912eb04b49e61c7a0ff$, $c47b9a843f4b0f912eb04b49e61c7a0ff$Toca um Ijexá pra Oxum
Dançar
Ela segura seu abebê
Pra esse mundo se espelhar (2x)
Nas suas águas
O amor vai transbordar
Na queda da cachoeira
Todo mal vai desaguar
Quem dera um dia
Eu pudesse teabraçar
Trazendo a paz pra minha vida
Pois a fénão vai faltar
Ora aieieo doce mãe
Ora aieieo...
Traz seu axé pra iluminar
E abençoar os filhosseus (2x)$c47b9a843f4b0f912eb04b49e61c7a0ff$, NULL, now()),
('08b7f847-0618-a8b8-9d41-12a79df1ef12', '845f426a-315f-16b0-d00a-60471b18abf6', $t08b7f8470618a8b89d4112a79df1ef12$Oxum menina$t08b7f8470618a8b89d4112a79df1ef12$, $c08b7f8470618a8b89d4112a79df1ef12$Eu via moça na beira d'água
soltaos cabelos Oxum menina
ecaia na água
___________________________
Oh menina! oh menina!
aieieuOxum da mina$c08b7f8470618a8b89d4112a79df1ef12$, NULL, now()),
('d03eaa8e-f370-b691-1445-0beb0789971f', '845f426a-315f-16b0-d00a-60471b18abf6', $td03eaa8ef370b69114450beb0789971f$Oxum - Águas de Oxum$td03eaa8ef370b69114450beb0789971f$, $cd03eaa8ef370b69114450beb0789971f$Se um diaeu fuifeliz
FoiOxum, foiOxum
Quem quis
Se um diaeu fuifeliz
FoiOxum, foiOxum
Quem quis
Beirado mar cadê
Água doce do meu amor
Água me faz viverô
Beijao mar
Quando você me tocou
Dominou meu ser
Quando você me tocou
Dominou meu ser
Levou meu amor
Não quis devolver
Levou meu amor
Não quis devolver
Manda chamar
Manda chamar ê ê manda chamar
Manda chamar ê ê manda chamar
Manda chamar ê ê manda chamar
Manda chamar ê ê manda chamar
Quem ama, se encanta
Bebe o abô como bebe o mel da cana ê
Quem ama, se encanta
Bebe o abô como bebe o mel da cana
Dona Oxum Apará
É quem anda na beirado mar
Dona Oxum Apará
Água rara de se encontrar
Se um diaeu fuifeliz
FoiOxum, foiOxum
Quem quis
Se um diaeu fui feliz
FoiOxum, foiOxum
Quem quis$cd03eaa8ef370b69114450beb0789971f$, NULL, now()),
('19448a29-9472-2d8b-e084-69321375ba85', '845f426a-315f-16b0-d00a-60471b18abf6', $t19448a2994722d8be08469321375ba85$Oxum - Promessa ao Gantois$t19448a2994722d8be08469321375ba85$, $c19448a2994722d8be08469321375ba85$Eu fuiao Gantois
Pagar promessa só.
Levei de ouro maior um adê pra Ieieô.
Eu fuiao Gantois
Pagar promessa só.
Levei de ouro maior um adê pra Ieieô.
Onalewà, minha prece é verdadeira.
Desce evem me abençoar.
Onalewà, minha prece é verdadeira.
Desce evem me abençoar.
Oh, meu Deus, como élindo!
O céu se abre e mãe Oxum vem surgindo.
Oh, meu Deus, como élindo!
O céu se abre e mãe Oxum vem surgindo.$c19448a2994722d8be08469321375ba85$, NULL, now()),
('05f0e51f-60f2-c684-7ef0-b13ee24697bd', '845f426a-315f-16b0-d00a-60471b18abf6', $t05f0e51f60f2c6847ef0b13ee24697bd$Cachoeira da mamãe Oxum$t05f0e51f60f2c6847ef0b13ee24697bd$, $c05f0e51f60f2c6847ef0b13ee24697bd$A cachoeira da mamãe Oxum
étão bonita que da gosto ver
As águas correm, as águas brilham
oh que beleza! oh que maravilha!
aieieu Oxum
me pega, me joga no seu aieieu$c05f0e51f60f2c6847ef0b13ee24697bd$, NULL, now()),
('bce8de75-4449-018c-649d-a552dc5b00fa', '845f426a-315f-16b0-d00a-60471b18abf6', $tbce8de754449018c649da552dc5b00fa$Oxum - Sua mina de ouro$tbce8de754449018c649da552dc5b00fa$, $cbce8de754449018c649da552dc5b00fa$Mamãe olha a mina, mamãe, mamãe olha amina
sua mina de ouro, mamãe Oxum, mamãe olha a mina
De joelhos elevo meu pensamento em oração
suas águas me banham e seu brilhorelfeteminha devoção
ena beirado rio eu levoflores para lheofertar
mãe Oxum é pureza e no seu recanto eu vou me confortar
Oxum - Gira na cachoeira$cbce8de754449018c649da552dc5b00fa$, NULL, now()),
('fe61b370-642d-1493-adb9-7a38ef1016e3', '845f426a-315f-16b0-d00a-60471b18abf6', $tfe61b370642d1493adb97a38ef1016e3$Página6de 29$tfe61b370642d1493adb97a38ef1016e3$, $cfe61b370642d1493adb97a38ef1016e3$Vamos abrira gira na cachoeira
Vamos saudar Oxum
A yê yêo oh mãe
A yê yêo oh mãe
Abre a girana cachoeira
Olha a água descendo a pedreira$cfe61b370642d1493adb97a38ef1016e3$, NULL, now()),
('be9f54d0-eea9-e948-4a70-81694b158447', '845f426a-315f-16b0-d00a-60471b18abf6', $tbe9f54d0eea9e9484a7081694b158447$Eu Vi Mamãe Oxum na Cachoeira$tbe9f54d0eea9e9484a7081694b158447$, $cbe9f54d0eea9e9484a7081694b158447$Eu vimamãe Oxum na cachoeira
Sentada na beirado rio
Colhendo lírio,lírioê
Colhendo lírio,lírioá
Colhendo lírio
Pra enfeitarnosso congá$cbe9f54d0eea9e9484a7081694b158447$, NULL, now()),
('dc2e9213-ca90-7847-529a-78ceda6eee6d', '845f426a-315f-16b0-d00a-60471b18abf6', $tdc2e9213ca907847529a78ceda6eee6d$Oxum - As rosas se despetalaram$tdc2e9213ca907847529a78ceda6eee6d$, $cdc2e9213ca907847529a78ceda6eee6d$As rosas se despetalaram
formando esteirapra mamãe Oxum passar
Seu diadema coberto de estrelas
uma lindacachoeira é força vivano gongá
Mamãe Oxum auê Mamãe Oxum
Leva a mironga dos seus filhospara o mar$cdc2e9213ca907847529a78ceda6eee6d$, NULL, now()),
('47a3a624-ad80-42a9-7cdc-b7ad75dcba64', '845f426a-315f-16b0-d00a-60471b18abf6', $t47a3a624ad8042a97cdcb7ad75dcba64$Oxum Opará - Axé da Guerreira Oxum Opará$t47a3a624ad8042a97cdcb7ad75dcba64$, $c47a3a624ad8042a97cdcb7ad75dcba64$O encontro das águas
Dos riose o mar
Tem o axé da guerreira
Oxum Opará
O encontro das águas
Dos riose o mar
Tem o axé da guerreira
Oxum Opará
É esperta e dengosa
Linda,rica efaceira
Ade, alfange,abebé
Com Oyá é guerreira
Tem feitiçonoolhar
E magia nas mãos
Com Exu no Ifá
É a intuição
Águas doces dos rios
Pororoca no mar
É o encontro de Oxum
Com mamãe Iemanjá
Vibraa força das águas
Rápida como serpente
Oxum Opará
Rios de água corrente
O encontro de Ogum
E Opará a guerreira
São as quedas das águas
Fortes nas cachoeiras
Amor doce das águas
Fecunda o coração
É o ouro de Oxum
Opará éproteção.
O encontro das águas
Dos rios eo mar
Tem o axé da guerreira
Oxum Opará
O encontro das águas
Dos rios eo mar
Tem o axé da guerreira
Oxum Opará$c47a3a624ad8042a97cdcb7ad75dcba64$, NULL, now()),
('b618979c-85d6-4677-2db7-1a1042421be2', '845f426a-315f-16b0-d00a-60471b18abf6', $tb618979c85d646772db71a1042421be2$Oxum - Mamãe Oxum, vim aqui lhe agradecer$tb618979c85d646772db71a1042421be2$, $cb618979c85d646772db71a1042421be2$Mamãe Oxum ,cadê você
Estou na sua casa
Quero lhever
As suas águas mamãe
Que são sagradas
Limpa meu corpo, me faz reviver
Tão cristalina,que me fascina
Coisa mais linda de se ver
Mamãe Oxum, Mamãe Oxum
Vim aqui lhe agradecer
Mamãe Oxum, Mamãe Oxum
Vim aqui lhe agradecer
Pela saúde e aplenitude
Na minha vida,ora, iê,ô
Deusa do amor que semeou
Meu coração e me libertou
És meu tesouro mamãe
Deusa do ouro
Das cachoeiras vem seu poder
Mamãe Oxum, Mamãe Oxum
minha vida é você
Mamãe Oxum, Mamãe Oxum
minha vida é você$cb618979c85d646772db71a1042421be2$, NULL, now()),
('e8f7479a-fb59-79f9-188c-f1d421039ca7', '845f426a-315f-16b0-d00a-60471b18abf6', $te8f7479afb5979f9188cf1d421039ca7$Oxum - Mãe do Amor$te8f7479afb5979f9188cf1d421039ca7$, $ce8f7479afb5979f9188cf1d421039ca7$Mamãe Oxum é dona do ouro e da cachoeira
Mamãe Oxum é fertilidade,elaé oamor
Mamãe Oxum é dona do ouro e da cachoeira
Mamãe Oxum é fertilidade,elaé oamor
É prosperidade, aiê êo
É aconchego, aiê êo
É semente que brota
E se transforma em linda flor
É prosperidade, aiê êo
É aconchego, aiê êo
É semente que brota
E se transforma em linda flor
Água doce é sua pele
É seu reino e seu lar
É faceirae dengosa
A rainha do ijexá
Água doce é sua pele
É seu reino e seu lar
É faceirae dengosa
A rainha do ijexá
É fecundidade, aiêêo
Tu és beleza, aiê êo
Yalode, grande mãe
Terás sempre meu amor
É fecundidade, aiêêo
Tu és beleza, aiê êo
Yalode, grande mãe
Terás sempre meu amor
Mamãe Oxum é dona do ouro e da cachoeira
Mamãe Oxum é fertilidade,elaé oamor
Mamãe Oxum é dona do ouro e da cachoeira
Mamãe Oxum é fertilidade,elaé oamor
Mamãe Oxum é dona do ouro e da cachoeira
Mamãe Oxum é fertilidade,elaé oamor
Mamãe Oxum é dona do ouro e da cachoeira
Mamãe Oxum é fertilidade,elaé oamor
Oxum - Reino Encantado de Oxum Ipondá$ce8f7479afb5979f9188cf1d421039ca7$, NULL, now()),
('5dc1a618-30e0-c536-47cd-f9082585771e', '845f426a-315f-16b0-d00a-60471b18abf6', $t5dc1a61830e0c53647cdf9082585771e$Página9de 29$t5dc1a61830e0c53647cdf9082585771e$, $c5dc1a61830e0c53647cdf9082585771e$Gorjeia a passarada no lindo céu azul,
A saudar o reino encantado de Oxum Ipondá
Por que meu Deus,
No seu mundo eu não posso chegar... ô,ô...
Para ver como é lindo o amanhecer.
Natureza sorrindo,
Primavera florindo
Natureza sorrindo,
Primavera florindo
O seu mundo é de amor, ô, ô
O seu mundo é de paz
Paz e amor
O seu mundo é de amor, ô, ô
O seu mundo é de paz
Guardado
Guardado pelo manto sagrado de Ipondá,
Que venha esse universo abençoar.
Acabe a guerra sem fim,
Tireo ódio, bote o amor
Acabe a guerra sem fim,
Tireo ódio, bote o amor
Que o mundo possa ser
Sempre um jardim em flor
Que o mundo possa ser
Sempre um jardim em flor
Laiá,Laiá, Laiá, Lalaiá
Ô, ô,ô, ô, ô,ô,
Laiá,Laiá, Laiá, Laiá
Ô, ô,ô, ô, ô,ô,
Que o mundo possa ser
Sempre um jardim em flor
Que o mundo possa ser
Sempre um jardim em flor
Guardado
Guardado pelo manto sagrado de Ipondá,
Que venha esse universo abençoar.
Acabe a guerra sem fim,
Tireo ódio, bote o amor
Acabe a guerra sem fim,
Tireo ódio, bote o amor
Que o mundo possa ser
Sempre um jardim em flor
Que o mundo possa ser
Sempre um jardim em flor
Laiá,Laiá, Laiá, Lalaiá
Ô, ô,ô, ô, ô, ô,
Laiá,Laiá, Laiá, Laiá
Ô, ô,ô, ô, ô, ô,
Que o mundo possa ser
Sempre um jardim em flor
Que o mundo possa ser
Sempre um jardim em flor$c5dc1a61830e0c53647cdf9082585771e$, NULL, now()),
('3c036cc6-0875-25c0-ac96-d4656e41e6a0', '845f426a-315f-16b0-d00a-60471b18abf6', $t3c036cc6087525c0ac96d4656e41e6a0$Oxum - Oxum Ipondá$t3c036cc6087525c0ac96d4656e41e6a0$, $c3c036cc6087525c0ac96d4656e41e6a0$Que luz é essa
Que incandeia
Vinda de dentro
Da cachoeira
Ela resplandece
Na lua cheia
Ora iê, iê,ô,ô, ô
Menina sereia
Que luz é essa
Que incandeia
Vinda de dentro
Da cachoeira
Ela resplandece
Na lua cheia
Ora iê, iê,ô,ô, ô
Menina sereia
Ora, iê,o, Ipondá
Ora, iê,o, Ipondá
Ora, iê,o, Ipondá
Guerreira nagô, Oxum Ipondá
ra,iê,o, Ipondá
Ora, iê,o, Ipondá
Ora, iê,o, Ipondá
Guerreira nagô, Oxum Ipondá
Guerreira nagô, Oxum Ipondá
Guerreira nagô, Oxum Ipondá$c3c036cc6087525c0ac96d4656e41e6a0$, NULL, now()),
('e6247720-cae9-df7c-1428-3dae22dbab37', '845f426a-315f-16b0-d00a-60471b18abf6', $te6247720cae9df7c14283dae22dbab37$Oxum - É d'Oxum$te6247720cae9df7c14283dae22dbab37$, $ce6247720cae9df7c14283dae22dbab37$Nessa cidade todo mundo é d'Oxum
Homem, menino, menina, mulher
Toda essa gente irradia magia
Presente na água doce
Presente n'água salgada
E toda a cidade brilha
Seja tenente ou filhode pescador
Ou importante desembargador
Se der presente é tudo uma coisa só
A força que mora n'água
Não fazdistinção de cor
E toda a cidade é d'Oxum
É d'Oxum
É d'Oxum
É d'Oxum
Eu vou navegar
Eu vou navegar nas ondas do mar
Eu vou navegar
É d'Oxum
É d'Oxum$ce6247720cae9df7c14283dae22dbab37$, NULL, now()),
('2930a922-cfca-babb-dbd4-ea37e7c196b2', '845f426a-315f-16b0-d00a-60471b18abf6', $t2930a922cfcababbdbd4ea37e7c196b2$Oxum - Gratidão a Oxum$t2930a922cfcababbdbd4ea37e7c196b2$, $c2930a922cfcababbdbd4ea37e7c196b2$Brilhao ouro, e a tristeza se vai num só instante
trazendo de volta ao semblante,
outra vez a vontade de sonhar
e relembrar, os caminhos de floresque a vida
me dispos como uma saida quando eu só queria chorar
àguas tão claras,olhos de rara beleza
um lindoespelho pra que eu pudesse enxergar
o meu sorriso desabrochar a contento
dando a certeza que tudo vai melhorar
O manto azul que me cobre, é a luz que clareia
e dessa renda, trancei o meu patuá
fiosde esperança me cobrem com sua doçura
toda ternura que só uma mãe sabe dar
Aieieu ô mamãe Oxum
Clareia minha vida clareia
Aieieu ô mamãe Oxum
lava minha alma em sua cachoeira$c2930a922cfcababbdbd4ea37e7c196b2$, NULL, now()),
('5ff87a9b-e765-575a-d776-34ae4ea65f2e', '845f426a-315f-16b0-d00a-60471b18abf6', $t5ff87a9be765575ad77634ae4ea65f2e$Oxum - Eu vi mamãe Oxum chorando/ Segura a banda$t5ff87a9be765575ad77634ae4ea65f2e$, $c5ff87a9be765575ad77634ae4ea65f2e$Eu vi mamãe Oxum, chorando
foiuma lágrima que eu fuiaparar
Ora ieieu oh minha mãe Oxum
deixa nossa banda melhorar$c5ff87a9be765575ad77634ae4ea65f2e$, NULL, now()),
('663c48a9-2076-2745-2b57-79614746872a', '845f426a-315f-16b0-d00a-60471b18abf6', $t663c48a9207627452b5779614746872a$Oxum - Deusa suprema das cachoeiras$t663c48a9207627452b5779614746872a$, $c663c48a9207627452b5779614746872a$Olha eu, olha eu mamãe Oxum
Olha eu, olha eu Oxum Maré, mandê
Olha eu mamãe Oxum
Olha eu Oxum Maré
Mamãe Oxum, rainha da cachoeira
Deusa suprema da pedreira
As suas águas cruzam as águas do mar
E no sussurro do vento é que vem o seu cantar
Olha eu, olha eu mamãe Oxum
Olha eu, olha eu Oxum Maré, mandê
Olha eu mamãe Oxum
Olha eu Oxum Maré
Vou levar presente pra mãe santa do oriente
Pra que ela tão formosa, vem enfeitaro luar
E com seu olhar, iluminarmeu caminhar$c663c48a9207627452b5779614746872a$, NULL, now()),
('4f7e1356-ed0a-640f-308b-2dd4f7eace6a', '845f426a-315f-16b0-d00a-60471b18abf6', $t4f7e1356ed0a640f308b2dd4f7eace6a$Oxum - Oxum Aparecida$t4f7e1356ed0a640f308b2dd4f7eace6a$, $c4f7e1356ed0a640f308b2dd4f7eace6a$Oxum, Aparecida!
Cuida da minha vida, me trazo seu axé!
O seu manto me cobre de amor e de carinho,
Vem tirartodo espinho que em meu coração fezmoradia
Na cachoeira recebo o seu axé dourado,
Me conduza ao sagrado da fé que em minh'alma irradia$c4f7e1356ed0a640f308b2dd4f7eace6a$, NULL, now()),
('a73c0017-aa2c-1b58-a519-579186e497fa', '845f426a-315f-16b0-d00a-60471b18abf6', $ta73c0017aa2c1b58a519579186e497fa$Oxum - Brilhou a estrela matutina$ta73c0017aa2c1b58a519579186e497fa$, $ca73c0017aa2c1b58a519579186e497fa$Oxum aiêiêô, Oxum aiêiêô
Oxum aiêiêô, Oxum aiêiêô
AiêiôOxum, Oxum aiêiêô
AiêiôOxum, Oxum aiêiêô
Brilhoua estrela matutina
Rolaram pedras de Xangô
Quem será essa menina
Que a lua iluminou
Canta no clarão da lua
Dança no calordo sol
Todo o ouro se ilumina
Pra saudar Oxum menina
Oxum é mãe maior
Saravá Oxum Menina
Oxum é mãe maior
Saravá Oxum Menina
Oxum é mãe maior$ca73c0017aa2c1b58a519579186e497fa$, NULL, now()),
('2ea55f89-83f7-db8c-7db1-0b1b764e2d4f', '845f426a-315f-16b0-d00a-60471b18abf6', $t2ea55f8983f7db8c7db10b1b764e2d4f$Oxum - No céu uma estrela vem brilhando$t2ea55f8983f7db8c7db10b1b764e2d4f$, $c2ea55f8983f7db8c7db10b1b764e2d4f$No céu uma estrela vem brilhando
Nas águas o amor refletindo
Aiêiê Oxum
De alegria estou sorrindo
Aiêiê Oxum
De alegria estou sorrindo
Também na cachoeira
Tem a forçada Oxum
Oxum é minha mãe
E meu paié Ogum
Também na cachoeira
Tem a forçada Oxum
Oxum é minha mãe
E meu paié Ogum
Aiêiê ô
No céu uma estrela vem brilhando
Nas águas o amor refletindo
Aiêiê Oxum
De alegria estou sorrindo
Aiêiê Oxum
De alegria estou sorrindo
Também na cachoeira
Tem a forçada Oxum
Oxum é minha mãe
E meu paié Ogum
Também na cachoeira
Tem a força da Oxum
Oxum é minha mãe
E meu pai é Ogum
Aiê iêô$c2ea55f8983f7db8c7db10b1b764e2d4f$, NULL, now()),
('51f0b00d-cc65-8b0d-3f88-835da8c0f383', '845f426a-315f-16b0-d00a-60471b18abf6', $t51f0b00dcc658b0d3f88835da8c0f383$Oxum - Oxum, deusa linda$t51f0b00dcc658b0d3f88835da8c0f383$, $c51f0b00dcc658b0d3f88835da8c0f383$Ó deusa linda
Tens o perfume da flor
Oxum é rainha
E hoje canto em seu louvor
Ó deusa linda
Tens o perfume da flor
Oxum é rainha
E hoje canto em seu louvor
Iemanjá lhedeu a vida
Oxalá quem lhe criou
De Xangô fostes a esposa
Para Oxóssi o grande amor
De Exu ganhastes o jogo
E Ifáte abençoou
És a mãe graciosa
Dona do ouro
Que me encantou
Ó deusa linda
Tens o perfume da flor
Oxum é rainha
E hoje canto em seu louvor
Ó deusa linda
Tens o perfume da flor
Oxum é rainha
E hoje canto em seu louvor
Oraiêiêo, mãe soberana
Me traga o seu amor
Enxugue o meu pranto
E aliviea minha dor
Em sua cachoeira
Eu vou com muita fé
Abençoe os seus filhos
E nos dê o seu axé
Ó deusa linda
Tens o perfume da flor
Oxum é rainha
E hoje canto em seu louvor
Ó deusa linda
Tens o perfume da flor
Oxum é rainha
E hoje canto em seu louvor$c51f0b00dcc658b0d3f88835da8c0f383$, NULL, now()),
('d2e0dd6b-e0b4-9177-1d40-c86d353760f3', '845f426a-315f-16b0-d00a-60471b18abf6', $td2e0dd6be0b491771d40c86d353760f3$Oxum - Eu vi mamãe Oxum na cachoeira$td2e0dd6be0b491771d40c86d353760f3$, $cd2e0dd6be0b491771d40c86d353760f3$Eu vimamãe Oxum na cachoeira
Sentada na beira do rio
Eu vimamãe Oxum na cachoeira
Sentada na beira do rio
Colhendo lírio,lírioê
Colhendo lírio,lírioá
Colhendo lírio
Pra enfeitarnosso gongá
Colhendo lírio,lírioê
Colhendo lírio,lírioá
Colhendo lírio
Pra enfeitarnosso gongá$cd2e0dd6be0b491771d40c86d353760f3$, NULL, now()),
('19516cd3-ec0e-f162-8d35-f87b667e77d5', '845f426a-315f-16b0-d00a-60471b18abf6', $t19516cd3ec0ef1628d35f87b667e77d5$Oxum - Melodia d'água$t19516cd3ec0ef1628d35f87b667e77d5$, $c19516cd3ec0ef1628d35f87b667e77d5$A cachoeira da minha mãe é tão linda
Brilham meus olhos ao admirar
O som das águas ao correr,me fascina
A cachoeira parece cantarolar
Corre água na cascata
Rios banham as matas
Até chegar no mar
Corre água, faz melodia
É o som que contagia
Pra mamãe Oxum dançar$c19516cd3ec0ef1628d35f87b667e77d5$, NULL, now()),
('f36d180e-1003-76df-e57a-286286f57c4a', '845f426a-315f-16b0-d00a-60471b18abf6', $tf36d180e100376dfe57a286286f57c4a$Oxum - Oxum Menina$tf36d180e100376dfe57a286286f57c4a$, $cf36d180e100376dfe57a286286f57c4a$Brilhoua estrela matutina
Rolaram pedras de Xangô
Quem será essa menina
Que a lua iluminou
Canta no clarão da lua
Dança no calordo sol
Todo ouro se ilumina
Pra saudar Oxum Menina
Pois Oxum é Mãe Maior
Saravá, Oxum Menina
Ôoo, ôoo, ôo...$cf36d180e100376dfe57a286286f57c4a$, NULL, now()),
('4b07d4d1-fdf1-35ee-54da-076c39ecfd5b', '845f426a-315f-16b0-d00a-60471b18abf6', $t4b07d4d1fdf135ee54da076c39ecfd5b$Oxum - O céu estava chuvoso$t4b07d4d1fdf135ee54da076c39ecfd5b$, $c4b07d4d1fdf135ee54da076c39ecfd5b$O céu estava chuvoso
A cachoeira está radiante
É Olorum quem manda água
Só pra ver se Oxum cante - BIS
Aieieô canta o seu canto
Aieieô canta sem parar
Quanto mais Oxum canta
Faz a chuva aumentar -BIS
Oxum canta e canta bem alto
Tão alto,que chega aos Orixás
Que dela se aproxima
Para ouviro seu cantar -BIS
Oxum - É de mamãe Oxum$c4b07d4d1fdf135ee54da076c39ecfd5b$, NULL, now()),
('efbc99fb-a487-f607-8263-f9587b822990', '845f426a-315f-16b0-d00a-60471b18abf6', $tefbc99fba487f6078263f9587b822990$Página18de 29$tefbc99fba487f6078263f9587b822990$, $cefbc99fba487f6078263f9587b822990$A água que correlá na cachoeira
éde mamãe Oxum
aieieu Umbanda (3X)
aieieu
opassarinho
que constróiseu ninho com carinho
éde mamãe Oxum
aieieu Umbanda (3X)
aieieu$cefbc99fba487f6078263f9587b822990$, NULL, now()),
('8ad56801-eb8f-226b-5389-0d6d7d66686c', '845f426a-315f-16b0-d00a-60471b18abf6', $t8ad56801eb8f226b53890d6d7d66686c$Oxum - Uma flôr Oxum$t8ad56801eb8f226b53890d6d7d66686c$, $c8ad56801eb8f226b53890d6d7d66686c$Caminhando pela mata
refletidanacascata
viuma flôrsemirar [2x]
Era de grande beleza
possuia talpureza
perfumava todo ar[2x]
Foinessa exato momento
que como um sonho eu contemplo
aOxum a se banhar
esó então eu percebi
que a lindaflôrque vi
eraa Deusa do ijexá
aiêiêu
aiêiêu
foina água da cascata
que a Oxum apareceu$c8ad56801eb8f226b53890d6d7d66686c$, NULL, now()),
('8a2ad1f7-9f2e-7a43-d136-df69bbb5e2b5', '845f426a-315f-16b0-d00a-60471b18abf6', $t8a2ad1f79f2e7a43d136df69bbb5e2b5$Oxum - Eu vi a mamãe Oxum de branco na cachoeira$t8a2ad1f79f2e7a43d136df69bbb5e2b5$, $c8a2ad1f79f2e7a43d136df69bbb5e2b5$Eu via mamãe Oxum
de branco na cachoeira [2x]
Eu perguntei
oque elafazia
estou esperando Ogum
para jurarbandeira [2x]$c8a2ad1f79f2e7a43d136df69bbb5e2b5$, NULL, now()),
('59687b7d-5e1e-92db-f30c-1223d1ad117c', '845f426a-315f-16b0-d00a-60471b18abf6', $t59687b7d5e1e92dbf30c1223d1ad117c$Oxum - A cachoeira da mamãe Oxum$t59687b7d5e1e92dbf30c1223d1ad117c$, $c59687b7d5e1e92dbf30c1223d1ad117c$A cachoeira da mamãe Oxum
étão bonita que dá gosto ver[2x]
As águas rolam
as águas brilham
mas que beleza minha mãe
que maravilha [2x]
aieieuminha mãe
me leva nos braços aieieu[2x]$c59687b7d5e1e92dbf30c1223d1ad117c$, NULL, now()),
('2ae9f757-9009-dcc9-9797-0f00031dc637', '845f426a-315f-16b0-d00a-60471b18abf6', $t2ae9f7579009dcc997970f00031dc637$Oxum - Aieieu , É no bailar, baila Oxum$t2ae9f7579009dcc997970f00031dc637$, $c2ae9f7579009dcc997970f00031dc637$aieieu
aieieu[2x]
éno bailar
bailaOxum
éno bailar
bailaOxum [2x]$c2ae9f7579009dcc997970f00031dc637$, NULL, now()),
('36ae7d3b-16f8-e73c-1f3a-ebd56faace40', '845f426a-315f-16b0-d00a-60471b18abf6', $t36ae7d3b16f8e73c1f3aebd56faace40$Oxum - Oxum do meu coração$t36ae7d3b16f8e73c1f3aebd56faace40$, $c36ae7d3b16f8e73c1f3aebd56faace40$Em seus riossó viharmonia
em seus só vigratidão
Oxum do meu coração
Oxum do meu coração
Me lava em suas águas de amor
me leva em seus braços oh mãe!
me leva pra evolução
transborda o meu coração
Te vejo nas cachoeiras
tevejo nos riossem fim
acada passo que dou
estou com Oxum onde vou
Oxum - Chega assim de repente$c36ae7d3b16f8e73c1f3aebd56faace40$, NULL, now()),
('09cee785-6c88-4096-f2b5-00a07e0dea00', '845f426a-315f-16b0-d00a-60471b18abf6', $t09cee7856c884096f2b500a07e0dea00$Página20de 29$t09cee7856c884096f2b500a07e0dea00$, $c09cee7856c884096f2b500a07e0dea00$Oxum, chega assim de repente
Abre o peito da gente, que transborda em amor
Oxum, chega assim de repente
Traz nas mãos uma flor,para o meu jardim (2x)
Oxum vem cuidar de mim
Joga fora essa dor,que não tem mais fim
Ora iêiê,ê ê ê Oxum
Vem cuidar dessa dor, que não tem mais fim
Ora iê iê,ê ê ê Oxum
Vem cuidar dessa dor, que não tem mais fim..$c09cee7856c884096f2b500a07e0dea00$, NULL, now()),
('bca964ea-4509-d42f-6c59-4ff4a80c4bb0', '845f426a-315f-16b0-d00a-60471b18abf6', $tbca964ea4509d42f6c594ff4a80c4bb0$Oxum - Foi na beira do rio$tbca964ea4509d42f6c594ff4a80c4bb0$, $cbca964ea4509d42f6c594ff4a80c4bb0$Foina beira do rio,na beira do rio
aonde Oxum chorou
foina beira do rio,na beira do rio
aonde Oxum chorou
chora aieieu
olhaios filhosseus
chora aieieu
olhaios filhosseus$cbca964ea4509d42f6c594ff4a80c4bb0$, NULL, now()),
('ae1be69d-ff88-75b8-eb4c-484cea2a7211', '845f426a-315f-16b0-d00a-60471b18abf6', $tae1be69dff8875b8eb4c484cea2a7211$Oxum - Canta Oxum$tae1be69dff8875b8eb4c484cea2a7211$, $cae1be69dff8875b8eb4c484cea2a7211$Eu vimamãe Oxum
cantando na cachoeira
dançando toda faceira
tãolinda como elafaz
equando ela canta
Xangô senta na pedreira
Oxossi lá na ribeira
nem vento não venta mais
aie! ieo! minha mãe
aie! ieo! mamãe Oxum
aie! ieo! moça bonita, demais !
Canta Oxum
aliviameu coração
me tirada solidão
me traz paz$cae1be69dff8875b8eb4c484cea2a7211$, NULL, now()),
('6ecd5835-bbdf-72c2-7ecf-02c59267d56e', '845f426a-315f-16b0-d00a-60471b18abf6', $t6ecd5835bbdf72c27ecf02c59267d56e$Oxum - Filho de Oxum$t6ecd5835bbdf72c27ecf02c59267d56e$, $c6ecd5835bbdf72c27ecf02c59267d56e$Sou filhodo amor,
O maior bem do mundo
Sou filhodo sol,
Que clareiaonde é escuro
Sou filhoda lua,da cachoeira e do mar (e do mar )
Sou filhoda terra,das estrelas e do ar
Sou filhode Oxum e levo o meu axe
Sou filhode Oxum e Jesus de Nazaré
Sou filhoda noite
Sou filhodo dia
Se eu choro de noite tenho féno outro dia
Sou filhode Oxum
E Jesus de Nazaré
Sou filhode Oxum
E Jesus de Nazaré$c6ecd5835bbdf72c27ecf02c59267d56e$, NULL, now()),
('69af287d-849b-c006-5be0-945a16449ea0', '845f426a-315f-16b0-d00a-60471b18abf6', $t69af287d849bc0065be0945a16449ea0$Oxum - Maior Tesouro, Oxum$t69af287d849bc0065be0945a16449ea0$, $c69af287d849bc0065be0945a16449ea0$E não há maior tesouro
Do que ver Oxum bailar
Toda coberta de ouro
Seus olhos vai encantar
Desce do céu agora,
Uma luz a me guiar
Faz do meu coração
Um lago doce para ser seu lar
Refletida em seu espelho, Ora iê iê
Oxum vem me iluminar
E não há maior tesouro
Do que ver Oxum bailar
Toda coberta de ouro
Seus olhos vai encantar
Nas Margens de um grande rio
Aonde nasce os mais lindos lírios
Ela se banha,
E o sol empresta o seu calor
vestindo raios dourados
Oxum se enfeita de amor.$c69af287d849bc0065be0945a16449ea0$, NULL, now()),
('80851d13-ca23-bef2-1710-f4caf980673c', '845f426a-315f-16b0-d00a-60471b18abf6', $t80851d13ca23bef21710f4caf980673c$Oxum -Ela é Ouro Só$t80851d13ca23bef21710f4caf980673c$, $c80851d13ca23bef21710f4caf980673c$São tantas histórias
Lindas histórias de amor
Muitas são vividas com alegria ou com dor
O amor constrói, Ilumina e fortalece
Traz o equilíbrioE a paz a quem merece
Mamãe Oxum a mais pura e divina
Essência do amor Que está presente em minha vida
Seus olhos negros Me protegem lá do céu
Guiando meus passos Esteja onde eu estiver
Ela é ouro só, Ela é ouro só,
Ela é ouro só Seu amor é ouro só
Divino amor Que protege e irradia
Divina Agua a mais pura e cristalina
Divino Sol que aquece esse amor
Divina Lua e seu feitiçoencantador
Divino Ouro que representa essa riqueza
Do amor de Oxum
A seus filhose a natureza
Mamãe Oxum tirou do centro da terra
Seu coração de ouro para eliminar a guerra
Ela é ouro só, Ela é ouro só,
Ela é ouro só Seu amor é ouro só$c80851d13ca23bef21710f4caf980673c$, NULL, now()),
('41d0c551-8c3f-2329-3e51-c7c4899f3317', '845f426a-315f-16b0-d00a-60471b18abf6', $t41d0c5518c3f23293e51c7c4899f3317$Oxum -Meu canto para Oxum$t41d0c5518c3f23293e51c7c4899f3317$, $c41d0c5518c3f23293e51c7c4899f3317$Aie ieô
Ora ie ieô
Aie ieô
Hoje eu venho me banhar
Para me abençoar
Ora ie ieô
Quando a dor nos pega fortee lancinante
E as lágrimas percorrem meu semblante
A tirogo minha mãe
Abençoe os seus filhos
Faça com que essa dor pare num instante
Se minhas dúvidas alteram o caminhar
Nas suas águas vou para me encontrar
Sinto de volta a vida
São lavadas as feridas
E começo a sentirmeu corpo renovar
Aie ieô
Ora ie ieô
Aie ieô
Hoje eu venho me banhar
Para me abençoar
Ora ie ieô
Ao manter-me no aconchego do teu rio
Águas límpidas que nos remetem ao frio
Nos seus braços eu me entrego
Sinto todo o amor
E num momento de energia vem o seu calor
Com a certeza de tera fé renovada
E nada mais atrapalhar a caminhada
Já não existe as feridas
Já não há mais mal algum
E com toda a minha força
Eu canto para Oxum
Aie ieô
Ora ie ieô
Aie ieô
Hoje eu venho me banhar
Para me abençoar
Ora ie ieô.$c41d0c5518c3f23293e51c7c4899f3317$, NULL, now()),
('65182d14-4185-3511-5247-6c31c3dde4b0', '845f426a-315f-16b0-d00a-60471b18abf6', $t65182d144185351152476c31c3dde4b0$Oxum - Doce mel de amor$t65182d144185351152476c31c3dde4b0$, $c65182d144185351152476c31c3dde4b0$Brilhoque reluz
sua força assim me guia
por tudo agradeço a mãe Oxum, Oxum
água doce oraieie Oxum
doce mel de amor
émeu bem maior
cachoeira oh linda mãe, eu sou filhoteu
eu me entrego a ti
ouro da minha vida
minha mãe querida
lindabela flor
Hummmm Oxum (8x)
Água doce oraieeeo Oxummmmm
doce mel de amor oooo....
émeu bem maior oooo...
cachoeira olinda mãe, eu sou filhoteu
eu me entrego a tioooo....
ouro da minha vida ooo...
minha mãe querida
lindabela flor...
Hummmm Oxum (8x)
Água doce oraeieeeo Oxummmmm....$c65182d144185351152476c31c3dde4b0$, NULL, now()),
('8e3b922b-d8df-03cd-afbe-07537120b1c3', '845f426a-315f-16b0-d00a-60471b18abf6', $t8e3b922bd8df03cdafbe07537120b1c3$Oxum - Que luz é aquela /banquinho de ouro$t8e3b922bd8df03cdafbe07537120b1c3$, $c8e3b922bd8df03cdafbe07537120b1c3$Meu Deus, mas que luz é aquela?
que vem lá do altoda pedreira
oh meu Deus
éa coroa, da mamãe Oxum
iluminando toda cachoeira
oh meu Deus
/////////////////////////////////////////////
No alto da cachoeira
tem um lindo jacutá
tem um banquinho de ouro
pra mamãe Oxum sentar
Oraieieu mamãe Oxum
Oraieieu mamãe Oxum
Oraieieu mamãe Oxum
Oxum maré$c8e3b922bd8df03cdafbe07537120b1c3$, NULL, now()),
('485b6124-3903-531a-1384-81e259ef5899', '845f426a-315f-16b0-d00a-60471b18abf6', $t485b61243903531a138481e259ef5899$Oxum - Pedido à cascata$t485b61243903531a138481e259ef5899$, $c485b61243903531a138481e259ef5899$Se a água da cascata pudesse falar
pediriaao luar, pra levaruma mensagem a Oxalá
que acabem as guerras e o mundo viva de amor
emeus caminhos sejam cobertos de flores
Quanta beleza
no pedido à cascata
provocou chuva de prata
era opranto do luar
aimeu deus!
aimeu deus que bom seria!
toda a terrasorririase a água pudesse falar
Oraieieu$c485b61243903531a138481e259ef5899$, NULL, now()),
('262cd75c-1776-c7e9-7cee-8fd731a9ee40', '845f426a-315f-16b0-d00a-60471b18abf6', $t262cd75c1776c7e97cee8fd731a9ee40$Oxum - Vitória Traçada$t262cd75c1776c7e97cee8fd731a9ee40$, $c262cd75c1776c7e97cee8fd731a9ee40$Lá na pedreira uma luz brilhou
reluziuna cascata
dona do ouro, éa deusa do amor
mamãe Oxum rainha iluminada
As suas águas me banham
limpam meu corpo, levam todo o mal de mim
com sua pureza toma conta da minha vida
me cubra com seu manto, me traga paz e alegria
É lindover, sua imagem sagrada
na cachoeira minha vitóriafoitraçada$c262cd75c1776c7e97cee8fd731a9ee40$, NULL, now()),
('ba9160f3-7cfa-6eac-3ccc-b148e18c50fe', '845f426a-315f-16b0-d00a-60471b18abf6', $tba9160f37cfa6eac3cccb148e18c50fe$Oxum - Colhendo Lírio$tba9160f37cfa6eac3cccb148e18c50fe$, $cba9160f37cfa6eac3cccb148e18c50fe$Eu vimamãe Oxum na cachoeira
sentada na beirado rio
colhendo lírio,lírioê
colhendo lírio,lírioa
colhendo líriopra enfeitarnosso congá$cba9160f37cfa6eac3cccb148e18c50fe$, NULL, now()),
('4bf43686-2f80-8984-0aa6-9e53b844bdc6', '845f426a-315f-16b0-d00a-60471b18abf6', $t4bf436862f8089840aa69e53b844bdc6$Oxum - Mamãe Oxum chorou$t4bf436862f8089840aa69e53b844bdc6$, $c4bf436862f8089840aa69e53b844bdc6$Chora...
na beirada cachoeira
onde é sua morada
mamãe Oxum chorou
éuma virgem imaculada
aieieuOxum Maré
vibram seus filhoscom fé
alua brilhalá no céu,
ea cachoeira clareou
aonde mamãe Oxum chorou
chorou, chorou
chorou, chorou$c4bf436862f8089840aa69e53b844bdc6$, NULL, now()),
('63b526e6-7f0f-0ab9-7528-433097c1d28d', '845f426a-315f-16b0-d00a-60471b18abf6', $t63b526e67f0f0ab97528433097c1d28d$Oxum - Deusa do Ijexá$t63b526e67f0f0ab97528433097c1d28d$, $c63b526e67f0f0ab97528433097c1d28d$Deusa do ijexá
émamãe Oxum
vem me ajudar
oraieieu
Derrama sobre mim
suas águas sagradas
põe no meu destino
apaz tão desejada$c63b526e67f0f0ab97528433097c1d28d$, NULL, now()),
('3d19fab3-f560-771f-e154-da5882682fbc', '845f426a-315f-16b0-d00a-60471b18abf6', $t3d19fab3f560771fe154da5882682fbc$Oxum - Pedido na Cachoeira$t3d19fab3f560771fe154da5882682fbc$, $c3d19fab3f560771fe154da5882682fbc$Ora ieieuoh! minha mãe
Ora ieieu,vem me valer!
na queda da cachoeira
eu faziaminha prece
Mãe oxum me proteger!
E com seu manto sagrado
me cubra e me ampare, oh! minha mãe
tireas dores da minha vida
me dê a paz e a caridade
ecom sua beleza me dê a proteção
Mamãe Oxum me estenda a vossa mão
eu bato minha cabeça pra louvar a mãe senhora
que com o seu abebê é tãofaceira e tão formosa
asua dança encanta
por onde ela passar
oh!mãe sagrada de Umbanda
olhe o meu caminhar!
ora ieieu....
hoje aqui eu venho lhe agradecer
mãe Oxum me deu a mão
me deu sua proteção
hoje eu tenho certeza em meu viver
equando eu errar eu pedirei o seu perdão
mãe Oxum na Umbanda, Senhora da Conceição$c3d19fab3f560771fe154da5882682fbc$, NULL, now()),
('fe8dff8c-94df-6c40-9321-f8e5697717ee', '845f426a-315f-16b0-d00a-60471b18abf6', $tfe8dff8c94df6c409321f8e5697717ee$Oxum - Sua estrela brilha / Aiê iêu Oxum Maré$tfe8dff8c94df6c409321f8e5697717ee$, $cfe8dff8c94df6c409321f8e5697717ee$Oxum Maré iaô
Oxum Maré iaô
no fundo do mar
sua estrela brilha
oiaô
oiaô
Oxum Maré iaô
//////////////////////////////
aieieu
aieieu mamâe Oxum
aieieu mamãe Oxum
aieieu Oxum Maré$cfe8dff8c94df6c409321f8e5697717ee$, NULL, now()),
('f234c8c8-5c48-b2cc-1154-900a4e5e73d9', '845f426a-315f-16b0-d00a-60471b18abf6', $tf234c8c85c48b2cc1154900a4e5e73d9$Oxum - Mãe divina$tf234c8c85c48b2cc1154900a4e5e73d9$, $cf234c8c85c48b2cc1154900a4e5e73d9$As águas caem
do altoda pedreira
um lindo véu
ame banhar
levando os males
da minha vida
correndo o rio
eentregando para o mar
É a minha mãe Oxum
elaé minha mãe Divina
vem me encantar
na cachoeira com o seu lindo bailar$cf234c8c85c48b2cc1154900a4e5e73d9$, NULL, now()),
('e7d19a5a-cdb0-37e8-771a-cab6c3a86418', '845f426a-315f-16b0-d00a-60471b18abf6', $te7d19a5acdb037e8771acab6c3a86418$Oxum - Olhai seus filhos$te7d19a5acdb037e8771acab6c3a86418$, $ce7d19a5acdb037e8771acab6c3a86418$Mamãe Oxum ôô
ajoealhada na cachoeira
chora aieieu
chora aieieu
chora aieieu
olhaipor todos filhosseus$ce7d19a5acdb037e8771acab6c3a86418$, NULL, now()),
('3b5c89ce-4660-daf7-6569-72234c511c86', '845f426a-315f-16b0-d00a-60471b18abf6', $t3b5c89ce4660daf7656972234c511c86$Oxum - Não chore filho de Umbanda / A Umbanda gira$t3b5c89ce4660daf7656972234c511c86$, $c3b5c89ce4660daf7656972234c511c86$Eu chorei,
aos pés da mamãe Oxum, eu chorei
disseram que eu viviaa chorar
disseram que eu viviaa sofrer
não chore filhode Umbanda
um dia tu vai vencer
/////////////////////////////////////////////////
Não chore filhode Umbanda
não chore que aqui estou
para cobrirte com meu manto
ealiviarsua dor
eu vou correr a minha gira
epedi ao povo do mar
para livrartedas mirongas
na féde pai Oxalá
ômironguê, ô mirongá
aUmbanda gira, deixa a gira girar$c3b5c89ce4660daf7656972234c511c86$, NULL, now()),
('1c0dd4e1-230a-af58-5a08-45b931592a70', '845f426a-315f-16b0-d00a-60471b18abf6', $t1c0dd4e1230aaf585a0845b931592a70$Oxum - É de mamãe Oxum$t1c0dd4e1230aaf585a0845b931592a70$, $c1c0dd4e1230aaf585a0845b931592a70$A água que corre lá na cachoeira
éde mamãe Oxum
aieieuUmbanda....
opassarinho que constrói seu ninho com carinho
éde mamãe Oxum
aieieuumbanda...$c1c0dd4e1230aaf585a0845b931592a70$, NULL, now()),
('e4cac5fa-7d28-bb4f-2584-87b5cb971b07', '845f426a-315f-16b0-d00a-60471b18abf6', $te4cac5fa7d28bb4f258487b5cb971b07$Oxum - Nos traga a paz$te4cac5fa7d28bb4f258487b5cb971b07$, $ce4cac5fa7d28bb4f258487b5cb971b07$Na cascata da mamãe Oxum
deixo as águas caírem sobre mim
minha Senhora da Conceição
olhaios filhosque aqui estão
eeu também sou filhoseu
nos traga apaz mamãe Oxum, ora ieieu$ce4cac5fa7d28bb4f258487b5cb971b07$, NULL, now()),
('74212580-84f5-8361-ade9-397d5deb228b', '845f426a-315f-16b0-d00a-60471b18abf6', $t7421258084f58361ade9397d5deb228b$Oxum - Solta os cabelos Oxum menina$t7421258084f58361ade9397d5deb228b$, $c7421258084f58361ade9397d5deb228b$Eu via moça na beira d'água
soltaos cabelos Oxum menina e caia n'água$c7421258084f58361ade9397d5deb228b$, NULL, now()),
('c9b25d36-da97-e446-2f28-94764c5e5ba0', '845f426a-315f-16b0-d00a-60471b18abf6', $tc9b25d36da97e4462f2894764c5e5ba0$Oxum - Ver um dia mãe Oxum$tc9b25d36da97e4462f2894764c5e5ba0$, $cc9b25d36da97e4462f2894764c5e5ba0$Céu azul e a luacor de prata
mas como élindo refletindona cascata
as nuvens do céu, refletindona cascata
overde das matas, refletindona cascata
ah eu queria verum dia mãe Oxum
refletidanacascata, refletidana cascata$cc9b25d36da97e4462f2894764c5e5ba0$, NULL, now()),
('9fe322dc-ccfb-d1da-8847-0a62ad65fe01', '845f426a-315f-16b0-d00a-60471b18abf6', $t9fe322dcccfbd1da88470a62ad65fe01$Oxum - Olhai os filhos seus$t9fe322dcccfbd1da88470a62ad65fe01$, $c9fe322dcccfbd1da88470a62ad65fe01$Foina beira do rio
aonde Oxum chorou
Chora ieieu
olhaios filhosseus$c9fe322dcccfbd1da88470a62ad65fe01$, NULL, now()),
('4b09319b-1f8a-d36b-37ca-9708518cd17d', '845f426a-315f-16b0-d00a-60471b18abf6', $t4b09319b1f8ad36b37ca9708518cd17d$Oxum - Sob o clarão da lua$t4b09319b1f8ad36b37ca9708518cd17d$, $c4b09319b1f8ad36b37ca9708518cd17d$Sob o clarão da lua\n as águas da cascata\n parecem de prata\n \n mas olha que lindovéu\n que vem das nuvens da
Oxum\n que vem do céu [2x]\n\naie ieu minha mãe\n dona do ouro\n \n aie ieuminha mãe\n és meu tesouro [2x]$c4b09319b1f8ad36b37ca9708518cd17d$, NULL, now()),
('5c57556d-658d-2550-016f-eade7e0155a1', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $t5c57556d658d2550016feade7e0155a1$Oxumaré - Eu vejo um arco-iris eu vejo um tesouro$t5c57556d658d2550016feade7e0155a1$, $c5c57556d658d2550016feade7e0155a1$O tempo fechou,
O céu escureceu
Choveu, choveu
Choveu, choveu (2x)
E as 7 cores,
Se estenderam pela eternidade,
Anunciando o finalda tempestade, (2x)
E quando a chuva parou,
Eu vio sol nascer,
Eu vio arco írisde Oxumarê (2x)
Não foi ninguém que contou,
Estava lá pra ver,
Eu vio arco írisde Oxumarê, (2x)
Eu vejo um arco íris,
Eu vejo um tesouro,
Eu vejo uma serpente,
Toda feitade ouro. (2x)$c5c57556d658d2550016feade7e0155a1$, NULL, now()),
('b1c3e6b4-199f-8491-c711-c5deeea1efa7', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $tb1c3e6b4199f8491c711c5deeea1efa7$Oxumarê - As Cores e Dores de Oxumarê$tb1c3e6b4199f8491c711c5deeea1efa7$, $cb1c3e6b4199f8491c711c5deeea1efa7$Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
É o Deus da terra
Vem em forma de serpente
Ele é cobra ele é gente
É o inícioe o fim da fé
Orixá encantado
Ele é adualidade
Serpenteando toda terra
Traz com ele a saudade
Tu és riqueza
És início,prosperidade
Representa os movimentos
De Ewá és ametade.
Divino Pai
Que nasceu com duas formas
Uma é bela como o arco-íris
E a outra é uma cobra
E foiaí
Que Nanã lhe abandonou
Mas por ordem de Olorum
Iemanjá quem lhe criou
Te ensinou o caminho
Do mistério e duplicidade
Conhecimento, vida e morte
Do amor e a maldade.
Quando a chuva cai
E escorre pelo chão
Vai levando todo sofrimento
Vai limpando meu coração
Tua faca de cobre
Quando o firmamento riscou
Transformou a chuva em cores
Transformou a dor no amor
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê$cb1c3e6b4199f8491c711c5deeea1efa7$, NULL, now()),
('fbd32091-a823-7c27-1af7-984cc2a0e550', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $tfbd32091a8237c271af7984cc2a0e550$Oxumarê - O Sol Brilhou Na Umbanda$tfbd32091a8237c271af7984cc2a0e550$, $cfbd32091a8237c271af7984cc2a0e550$O sol brilhouna Umbanda
Choveu, ventou
Um arco-írisno céu
O sol brilhouna Umbanda
Choveu, ventou
Um arco-írisno céu
Mas vejam só, que coisa linda
Oxumarê no terreirode Umbanda
Mas vejam só, que coisa linda
Oxumarê no terreirode Umbanda
Arerê,Arerê, Oxumarê
Arerê,Arerê, Oxumarê
Arerê,Arerê, Oxumarê
Arerê,Arerê, Oxumarê$cfbd32091a8237c271af7984cc2a0e550$, NULL, now()),
('6f3957d5-0b11-1525-d070-afa56a464dca', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $t6f3957d50b111525d070afa56a464dca$Oxumarê - As cores e dores de Oxumarê$t6f3957d50b111525d070afa56a464dca$, $c6f3957d50b111525d070afa56a464dca$Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
É o Deus da terra
Vem em forma de serpente
Ele é cobra ele é gente
É o inícioe o fim da fé
Orixá encantado
Ele é a dualidade
Serpenteando toda terra
Traz com ele a saudade
Tu és riqueza
És início,prosperidade
Representa os movimentos
De Ewá és a metade.
Divino Pai
Que nasceu com duas formas
Uma é bela como o arco-íris
E a outra é uma cobra
E foiaí
Que Nanã lhe abandonou
Mas por ordem de Olorum
Iemanjá quem lhe criou
Te ensinou o caminho
Do mistério e duplicidade
Conhecimento, vida e morte
Do amor e a maldade.
Quando a chuva cai
E escorre pelo chão
Vai levando todo sofrimento
Vai limpando meu coração
Tua faca de cobre
Quando o firmamento riscou
Transformou a chuva em cores
Transformou a dor no amor
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê
Orixá e rei,da antiga Daomé.
É o dono da vidência
É meu pai Oxumarê$c6f3957d50b111525d070afa56a464dca$, NULL, now()),
('25968b4d-d774-bea9-c9a8-1031bac3463f', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $t25968b4dd774bea9c9a81031bac3463f$Oxumarê - Choveu, choveu$t25968b4dd774bea9c9a81031bac3463f$, $c25968b4dd774bea9c9a81031bac3463f$Choveu, choveu 7 dias sem parar
Tudo ficoualagado, com as lágrimas de Oxalá.
Consultei Babalawô e também os Orixás
Pra saber o que fazer, pra essa chuva acabar.
E na tábua de Ifá,descobri o que fazer.
Uma entrega muito linda,pra meu Pai Oxumarê.
Alguida com muitos búzios, laços para enfeitar.
Na queda da cachoeira , me pediram pra entregar.
Arrieibaticabeça, chamei por Oxumarê.
A run boboi meu Pai Bessem, venha para nos valer
O sol então brilhou mais forte
E do céu eu vi descer
Um arco iristão brilhante
Nele estava Oxumarê.
A run boboy Oxumarê
A run boboy Oxumarê
A run boboy Oxumarê
Oh meu Pai venha me valer!$c25968b4dd774bea9c9a81031bac3463f$, NULL, now()),
('fa076ced-7bb8-eb75-5c84-dcd0b920d292', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $tfa076ced7bb8eb755c84dcd0b920d292$Canto para Oxumarê$tfa076ced7bb8eb755c84dcd0b920d292$, $cfa076ced7bb8eb755c84dcd0b920d292$Arrobobói Oxumaré
Contas verde-amarelas
São fios que firmam a fé
Arrobobói Oxumaré
Contas verde-amarelas
São guias que firmam a fé
No caminho de Oxumaré
Pedrinha de ouro reluzia
E até quem nunca teve fé
Acreditou no que não via
Rosário de conta e reza braba
É amuleto pra livrar
Quem da solidão virouescrava
E era um céu de oxumaré
E a vida era um rio que corria
Pra dança incessante das marés
Quem não tinha medo se atrevia
Serpente se move e desafia
Um olho te rende outro te cega
Homem mulher ninguém sossega
E veio a cor de Oxumaré
E quem é de santo aprecia
Se arrepia do pelo até o pé
Arco-írisque brilha é profecia
O céu encantado sobre a terra
Ilumina e mostra o tesouro
Quem é de paz, não faz a guerra
Arrobobói Oxumaré
Contas verde-amarelas
São fios que firmam a fé
Arrobobói Oxumaré
Contas verde-amarelas
São guias que firmam a fé$cfa076ced7bb8eb755c84dcd0b920d292$, NULL, now()),
('019e6d3c-655f-d001-06ca-7e7b48c949e5', 'ff90bc57-689a-9af6-54b5-1c66af310ceb', $t019e6d3c655fd00106ca7e7b48c949e5$Oxumarê -Filho de Nanã, irmão de Obaluaê$t019e6d3c655fd00106ca7e7b48c949e5$, $c019e6d3c655fd00106ca7e7b48c949e5$Oxumarê, Oxumarê
Eleé filhode Nanã
éirmão de Obaluaê [2x]
Com sua serpente sagrada
que ficaem sua mão
asua dança encantada
mostra o céu e o chão
Salve o reido arco-íris
Arroboboi Oxumarê
na cabeceira de um rio
setecores vinascer
Oxumarê, Oxumarê
Eleé filhode Nanã
éirmão de Obaluaê$c019e6d3c655fd00106ca7e7b48c949e5$, NULL, now()),
('e26ddfae-b41d-8e99-41fc-05ae5f2d70b0', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te26ddfaeb41d8e9941fc05ae5f2d70b0$Preto velho - Prece as Santas Almas$te26ddfaeb41d8e9941fc05ae5f2d70b0$, $ce26ddfaeb41d8e9941fc05ae5f2d70b0$Preto velho saudou as almas
No Cruzeiro erezou pra você
Na boca da mata saudou a Jurema
Os Caboclos e pediu pra você
Preto velho saudou as almas
No Cruzeiro erezou pra você
Na boca da mata saudou a Jurema
Os Caboclos e rezou pra você
Trabalhou, Trabalhou
Trabalhou e rezou pra você
Trabalhou, Trabalhou
Trabalhou e pediu pra você
Trabalhou, Trabalhou
Trabalhou e rezou pra você
Trabalhou, Trabalhou
Trabalhou e pediu pra você$ce26ddfaeb41d8e9941fc05ae5f2d70b0$, NULL, now()),
('5340eef9-7171-20c9-86ee-eca43736d323', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t5340eef9717120c986eeeca43736d323$Preto velho - Mãe Maria chegou de Aruanda$t5340eef9717120c986eeeca43736d323$, $c5340eef9717120c986eeeca43736d323$Mãe Maria chegou de Aruanda
espalhando rosas pelo chão
(2x)
com apemba ela faz o seu ponto
com seu rosário eladá proteção
(2x)
afumaça do cachimbo da vovó
sobre pro céu só não vê quem não quer
(2x)
pretavelha trabalha trabalha
etiraa mironga debaixo do pé
(2x)$c5340eef9717120c986eeeca43736d323$, NULL, now()),
('759e2de1-a70d-b184-e0d0-5990322a7323', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t759e2de1a70db184e0d05990322a7323$Vó Maria Conga - Folhas De Guiné$t759e2de1a70db184e0d05990322a7323$, $c759e2de1a70db184e0d05990322a7323$Maria Conga, com suas folhasde guiné
Seu galhinho de arruda, o seu vence demandas
Deixa o manacá em flor-2x
Vem ládas matas, trabalhar com muito amor
Nesta Umbanda querida, vem prestar a caridade
Para a glóriado senhor - 2x$c759e2de1a70db184e0d05990322a7323$, NULL, now()),
('4c354db0-871b-5bcd-27c1-af0db5bf6402', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4c354db0871b5bcd27c1af0db5bf6402$Preta Velha - Negra Cambinda$t4c354db0871b5bcd27c1af0db5bf6402$, $c4c354db0871b5bcd27c1af0db5bf6402$Negra Cambinda
Fala na línguanagô
Negra da costa rica
Filhade Babalaô - 2x
Negra fuma
Negra dança
Na batida do tambor
Negra toma sua marafo
Saravando o Seu Protetor- 2x
É na macumba ê
É na macumba a - 2x
Negra da costa rica
Vamos todos saravá -2x
É na macumba ê
É na macumba a - 2x
Negra da costa rica
Vamos todos saravá -2x$c4c354db0871b5bcd27c1af0db5bf6402$, NULL, now()),
('67977dba-204a-11a3-6697-b0ae498acb60', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t67977dba204a11a36697b0ae498acb60$Preto Velho - Pai Antero - Curimba de Pai Antero$t67977dba204a11a36697b0ae498acb60$, $c67977dba204a11a36697b0ae498acb60$Pedi licençaa mamãe Oxum
Pedi licençaa papai Oxalá
Pedi licençaao Senhor do Bonfim
Pra paiAntero virtrabalhar(2x)
Quem vem lá? É de paz
Quem vai chegar no congá
É um baiano formoso
É paiAntero que vem saravá (2x)
Pedi licençaa mamãe Oxum
Pedi licençaa papai Oxalá
Pedi licençaao Senhor do Bonfim
Pra paiAntero virtrabalhar(2x)
Quem vem lá? É de paz
Quem vai chegar no congá
É um baiano formoso
É paiAntero que vem saravá (2x)$c67977dba204a11a36697b0ae498acb60$, NULL, now()),
('af30afff-cea2-3582-b8a0-1cd561ec42f2', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $taf30afffcea23582b8a01cd561ec42f2$Preto Velho - Pai Joaquim cadê pai Mané$taf30afffcea23582b8a01cd561ec42f2$, $caf30afffcea23582b8a01cd561ec42f2$PaiJoaquim cadê pai Mané
Mané foina mata apanha guiné (2x)
Diga a eleque quando vier
que suba a escada e não bata o pé (2x)$caf30afffcea23582b8a01cd561ec42f2$, NULL, now()),
('2d5a07ae-4c7d-579d-c337-bdfd4aa82bf8', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t2d5a07ae4c7d579dc337bdfd4aa82bf8$Vovó Cambinda$t2d5a07ae4c7d579dc337bdfd4aa82bf8$, $c2d5a07ae4c7d579dc337bdfd4aa82bf8$Segura o touro Cambinda
amarra no mourão
que o touroé brabo Cambinda
amarra no mourão (2x)
Meu Santo Antonio é pequenino auê
me abre as portas do céu auê
Cambinda estremeceu auê
mas se manteve em pé$c2d5a07ae4c7d579dc337bdfd4aa82bf8$, NULL, now()),
('f0f9620d-6fdc-05c3-f6b0-c7714251d074', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tf0f9620d6fdc05c3f6b0c7714251d074$Preto Velho - Minha cachimba tem mironga$tf0f9620d6fdc05c3f6b0c7714251d074$, $cf0f9620d6fdc05c3f6b0c7714251d074$Minha cachimba tem mironga
minha cachimba tem dendê (2x)
Quem dúvida da minha cachimba
que venha ver, que venha ver. (2x)$cf0f9620d6fdc05c3f6b0c7714251d074$, NULL, now()),
('40136a68-8389-1432-543b-f48fd992dfd1', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t40136a6883891432543bf48fd992dfd1$Preto Velho - Adorei as Almas$t40136a6883891432543bf48fd992dfd1$, $c40136a6883891432543bf48fd992dfd1$Adorei asAlmas
asAlmas me atenderam (2x)
eraas Santas Almas
ládo cruzeiro. (2x)$c40136a6883891432543bf48fd992dfd1$, NULL, now()),
('69eb9d61-15ea-6daa-9c64-2e40bec7d47b', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t69eb9d6115ea6daa9c642e40bec7d47b$Preto Velho - Olha Preto está trabalhando$t69eb9d6115ea6daa9c642e40bec7d47b$, $c69eb9d6115ea6daa9c642e40bec7d47b$Na aroera de São Benedito
Santo Antonio mandou me chamar (2x)
Olha Preto está trabalhando
olhabranco só estáolhando (2x)$c69eb9d6115ea6daa9c642e40bec7d47b$, NULL, now()),
('36e40b12-e690-1bee-22b0-d85e4d14b64c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t36e40b12e6901bee22b0d85e4d14b64c$Pai Chico$t36e40b12e6901bee22b0d85e4d14b64c$, $c36e40b12e6901bee22b0d85e4d14b64c$Conhecedor da reza que acalenta
É benzedor, o coração esquenta
Pai Chico vem, Preto Velho vem
Mironga com fé:Preto Velho tem
Pai Chico vem, Preto Velho vem
Cajado na mão: Preto Velho tem
Andando na beira do cafezal
Cuidando dos novos a trabalhar
Assim Preto Velho dizia:
“Livrai-nosda fome e de todo o má”$c36e40b12e6901bee22b0d85e4d14b64c$, NULL, now()),
('8dcf40ba-5a16-2195-651a-ba9572692017', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t8dcf40ba5a162195651aba9572692017$Pai João$t8dcf40ba5a162195651aba9572692017$, $c8dcf40ba5a162195651aba9572692017$(2x)
Foiele, nascido e criado na chibata
Preto Velho de joelhos ensinou
(2x)
Aquele que hoje vem de Aruanda
Pai João, (oi)tá caindo “fulô”
Pai João, (oi)meu Pai João
Pai João de joelhos ensinou
Pai João, (oi)meu Pai João
Pai João, tá caindo “fulô”$c8dcf40ba5a162195651aba9572692017$, NULL, now()),
('2fb25c53-07c5-a889-9d07-2f21160b384c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t2fb25c5307c5a8899d072f21160b384c$Página4de 65$t2fb25c5307c5a8899d072f21160b384c$, $c2fb25c5307c5a8899d072f21160b384c$(2x)Prest’enção na mironga, na cachimba do Pai
(2x)A fumaça vem, a fumaça vai...
(2x)“Bença” Pai Benedito, “bença” Cacarucai
A fumaça vem, a fumaça vai...
A alegria vem, a tristezavai
Caridade vem, (oi)sofrimento vai
Preto Velho vem, da senzala sai
(2x)“Bença” Pai Benedito, “bença” Cacarucai$c2fb25c5307c5a8899d072f21160b384c$, NULL, now()),
('adc11a14-f00c-68d7-d84f-dba5b468b848', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tadc11a14f00c68d7d84fdba5b468b848$Vovó Maria Conga$tadc11a14f00c68d7d84fdba5b468b848$, $cadc11a14f00c68d7d84fdba5b468b848$(2x)Maria Conga me ensinou a rezar
(2x)Vovó veio de longe me ensinar a rezar
Eu era curumim, mal sabia andar
Vovó veio de longe pra me alumiar
Ela apanhou rosário,lenço e o patuá
Benzeu galho de arruda e começou a rezar:
“Com 2 te butaram, com 3 eu te tiro
Com o poder de Oxalá e do Espírito Santo Divino”$cadc11a14f00c68d7d84fdba5b468b848$, NULL, now()),
('a8063719-e47e-c558-8c5f-9e608c5827aa', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta8063719e47ec5588c5f9e608c5827aa$Pai Joaquim de Aruanda$ta8063719e47ec5588c5f9e608c5827aa$, $ca8063719e47ec5588c5f9e608c5827aa$Ele Vem de Aruanda (ô meu Pai),Ele é Pai Joaquim (ô meu Pai)
Sua luz é divina (ô meu Pai), Toma conta de mim (ô meu Pai)
No Cruzeiro das Almas (ô meu Pai), Firmei minha fé (ô meu Pai)
Era teto de estrelas (ô meu Pai), Eu fiquei de pé (ômeu Pai)
Dei a mão aos irmãos (ômeu Pai),Nessa longa jornada (ô meu Pai)
Preto Velho ajudou (ômeu Pai),Até na debandada (ô meu Pai)
Hoje estamos aqui (ô meu Pai), No amor da Umbanda (ô meu Pai)
Preto Velho ensinou (ô meu Pai), Joaquim de Aruanda (ômeu Pai)$ca8063719e47ec5588c5f9e608c5827aa$, NULL, now()),
('931bf674-65aa-7810-c8d1-64504892bb50', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t931bf67465aa7810c8d164504892bb50$Pontos de Preto velho - Viva 13 de maio!$t931bf67465aa7810c8d164504892bb50$, $c931bf67465aa7810c8d164504892bb50$Dia treze de maio
é o diade amor e verdade
Dia trêsde maio meu pai
é o diada liberdade
////////////////////////////////
No dia treze de maio
tava tocando tambor
quando a princesa me chamou
levanta preto cativeiro acabou
/////////////////////////////////
Preto na sua senzala
batia sua caixa, deu viva iaiá
Preto na sua senzala
batia sua caixa, deu viva ioiô
viva iaiá,viva ioiô
viva nossa senhora, cativeiro acabou
///////////////////////////////////
Numa noite linda que tinha luar
Preto velho orou a Zambi
pra cativeiro acabar
trabalha preto, trabalhou
trabalha preto, trabalhou
trabalha preto, cativeiro acabou$c931bf67465aa7810c8d164504892bb50$, NULL, now()),
('43e17260-306a-98f9-f6b4-83a866dcccfa', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t43e17260306a98f9f6b483a866dcccfa$Preto Velho - É Congo!$t43e17260306a98f9f6b483a866dcccfa$, $c43e17260306a98f9f6b483a866dcccfa$Ah, é Congo! (2x)
Preto Velho de Aruanda
Vem chegando nessa banda (2x)
Louvados sejam
Os vovôs e as vovós
Eles andam devagar
E acompanham a todos nós
A sua luz
Ilumina o caminho
Com sua misericórdia
Não deixa ninguém sozinho
Ah, é Congo! (2x)
Preto Velho de Aruanda
Vem chegando nessa banda (2x)
Com sabedoria
Trazem orientação
Que aliviam nossas dores
E acalmam o coração
Ó protetores
Minhas velhas entidades
Agradeço sua força
Salve a vossa caridade
É Congo!
Ah, é Congo! (2x)
Preto Velho de Aruanda
Vem chegando nessa banda (2x)$c43e17260306a98f9f6b483a866dcccfa$, NULL, now()),
('920f5823-542e-2e05-5c36-fde3ceea7cc4', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t920f5823542e2e055c36fde3ceea7cc4$Lá no oriente numa terra ardente$t920f5823542e2e055c36fde3ceea7cc4$, $c920f5823542e2e055c36fde3ceea7cc4$Lá no orientenuma terraardente
aonde nasce o sol
Lá no orientenuma terraardente
aonde nasce o sol
Lá no oriente,lános pés de Angola
na Linha das Almas, aonde os velhinhos moram
Lá no oriente,lános pés de Angola
na Linha das Almas, aonde os velhinhos moram$c920f5823542e2e055c36fde3ceea7cc4$, NULL, now()),
('6a4ff33a-0c16-c863-18ed-c0c17a9f97bd', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6a4ff33a0c16c86318edc0c17a9f97bd$Tia Maria com Tia Mariana$t6a4ff33a0c16c86318edc0c17a9f97bd$, $c6a4ff33a0c16c86318edc0c17a9f97bd$TiaMaria com Tia Mariana
amarra a saia com a palha da cana
Mas se a palha da cana arrebenta
TiaMaria "suncê" não me engana
Quê quê requê quê
Preta-velha do comparece
Quê quê requê quê
Preta-velha do comparece$c6a4ff33a0c16c86318edc0c17a9f97bd$, NULL, now()),
('0c359de9-d189-59a9-4ce5-4e1b69c4e5ca', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t0c359de9d18959a94ce54e1b69c4e5ca$Pai Cipriano - Bate tambor na Umbanda$t0c359de9d18959a94ce54e1b69c4e5ca$, $c0c359de9d18959a94ce54e1b69c4e5ca$Bate tambor na Umbanda
praver meu velho chegar
Bate tambor na Umbanda
praver meu velho chegar
eleé Pai Cipriano
eleé Pai Cipriano
mensageiro de Oxalá
eleé Pai Cipriano
eleé Pai Cipriano
mensageiro de Oxalá$c0c359de9d18959a94ce54e1b69c4e5ca$, NULL, now()),
('4897c707-768a-5ed2-aa0f-ef5401aea177', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4897c707768a5ed2aa0fef5401aea177$Homenagem às Santas Almas$t4897c707768a5ed2aa0fef5401aea177$, $c4897c707768a5ed2aa0fef5401aea177$Muriquinho pequenino
Muriquinho pequenino
Parente de quiçamba na cacunda
Purugunta, onde vai?
Purugunta onde vai,ô parente
Pro quilombo do dumbá!
Purugunta, onde vai?
Purugunta onde vai,ô parente
Pro quilombo do dumbá!
Ê,chora chora Congo
Ê devera!
Chora Congo, chora
Ê,chora chora Congo
Ê cambada!
Chora Congo, chora…$c4897c707768a5ed2aa0fef5401aea177$, NULL, now()),
('8125d7e3-3b08-d532-7c7c-a41afa76a589', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t8125d7e33b08d5327c7ca41afa76a589$Preto velho - Cativeiro já acabou$t8125d7e33b08d5327c7ca41afa76a589$, $c8125d7e33b08d5327c7ca41afa76a589$Preto na senzala bateu sua caixa deu viva iaiá
Preto na senzala bateu sua caixa de viva ioiô
Viva iaiá
Viva ioiô
Viva nossa Senhora
ocativeiro jáacabou$c8125d7e33b08d5327c7ca41afa76a589$, NULL, now()),
('81dd6832-f700-9b52-f20a-ab92c11a4720', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t81dd6832f7009b52f20aab92c11a4720$Preto velho - Cativeiro, oi cativeiro$t81dd6832f7009b52f20aab92c11a4720$, $c81dd6832f7009b52f20aab92c11a4720$Cativeiro.…
oicativeiro
Cativeiro…
oicativeiro
meu cativerá
aiaiai meu cativeiro
meu cativerá
aiaiai meu cativeiro$c81dd6832f7009b52f20aab92c11a4720$, NULL, now()),
('a685efd8-464a-45a5-4411-543d956ee5a9', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta685efd8464a45a54411543d956ee5a9$Umbanda é Assim (Preto Véio Me Viu)$ta685efd8464a45a54411543d956ee5a9$, $ca685efd8464a45a54411543d956ee5a9$(2x)
Eu andava no frio,andava com fome
Eu andava sozinho, e num tinha nem nome
Preto Véio me viu:"ô mizifiovem cá
Dá um abraço no véio, que eu vô ajudá"
Umbanda é assim, Oxalá ensinou:
"Quem tem 2 só tem 1,
quem não tem já ganhou"
(2x)
Preto Véio guia pera caridade
Quando acaba cachimba é que fica saudade
(2x)
Preto Véio me viu, Preto Véio tevê
Preto Véio é amigo, vai ajudá suncê$ca685efd8464a45a54411543d956ee5a9$, NULL, now()),
('a9bec241-57b2-8aed-45d7-b256502bfb19', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta9bec24157b28aed45d7b256502bfb19$Vovó Benedita de Aruanda$ta9bec24157b28aed45d7b256502bfb19$, $ca9bec24157b28aed45d7b256502bfb19$(2x)
Eu vium lindo sorriso
Tão puro, chamava por mim
(2x)
Vovó Benedita de Aruanda
Serena, me disse assim
“O amor nasce da caridade
A dor da senzala ensinou
Fio,procure bondade
Em tudo que o Pai nos deixou”
Chibata doía demais
Vovó toda vida perdoou
Fio...Ô, meu fio...
Vovó Benedita abençoou$ca9bec24157b28aed45d7b256502bfb19$, NULL, now()),
('cea42bdb-069e-1cdb-f0bb-1b9297a82a73', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tcea42bdb069e1cdbf0bb1b9297a82a73$Mãe Maria do Quilombo$tcea42bdb069e1cdbf0bb1b9297a82a73$, $ccea42bdb069e1cdbf0bb1b9297a82a73$Sinta o cheiro do café, arruda e guiné
Mãe Maria do Quilombo vem trazer o seu axé (2x)
Ao toque do ijexa,o tambor vai ecoar
Trazendo mãe Maria pro trabalho começar
Ela trazo seu rosário,cachimbo e proteção
Traz a força do cruzeiro, muito amor e gratidão
Históriasda senzala vovó vai te contar
Fazer muita mironga para seus fios ajudar
Aqui nesse jacutá vovó vaisarava
Agradecer as almas santas e nosso pai Oxalá
Sinta o cheiro do café, arruda e guiné
Mãe Maria do Quilombo vem trazer o seu axé (2x)$ccea42bdb069e1cdbf0bb1b9297a82a73$, NULL, now()),
('fa5a73e1-9894-fe7a-6938-d2431c8f9b5d', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tfa5a73e19894fe7a6938d2431c8f9b5d$Preto velho - Saravá Pai Joaquim de Angola$tfa5a73e19894fe7a6938d2431c8f9b5d$, $cfa5a73e19894fe7a6938d2431c8f9b5d$elevem chegando de Aruanda
elevem trazendo seu axé
saravá Pai Joaquim de Angola
vem saudar os seus filhosde fé (2x)
no seu toco ele senta sorrindo
seu abraço transmite amor
a fumaça que sai do cachimbo
acalma o meu peito e me tira a dor (2x)$cfa5a73e19894fe7a6938d2431c8f9b5d$, NULL, now()),
('65f6352b-2dfd-e72d-beb2-1d5153022691', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t65f6352b2dfde72dbeb21d5153022691$Preto velho - Saravá Vovô Chico$t65f6352b2dfde72dbeb21d5153022691$, $c65f6352b2dfde72dbeb21d5153022691$saravá o Vovô Chico que chegou agora
saravá o reido Congo a banda vem saudar
elevem de Aruanda pra quebrar demanda
salve o grande feiticeirochefe de congá (2x)
salve o negro velho mandingueiro
salve o chefe do terreiro
a festavai começar
elevem dançando agachadinho
depois senta em seu banquinho
e começa a rezar
aíé que começa a mironga
juntocom Maria Congá
elecomeça a trabalhar
elevem prestar a caridade
o amor e a bondade
a todos que precisar (2x)
Ô Ô Ô
saravá o Vovô Chico que chegou agora
saravá o reido Congo a banda vem saudar
elevem de Aruanda pra quebrar demanda
salve o grande feiticeirochefe de congá (2x)$c65f6352b2dfde72dbeb21d5153022691$, NULL, now()),
('8a9f96d7-5ce4-933c-d3a5-5d84329cc63a', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t8a9f96d75ce4933cd3a55d84329cc63a$Na Calada da Noite (Preto Velho)$t8a9f96d75ce4933cd3a55d84329cc63a$, $c8a9f96d75ce4933cd3a55d84329cc63a$bate tambor na calada da noite ó negro
bate tambor até o dia clarear
bate tambor na calada da noite ó negro
bate tambor para louvar seu Orixá
o negro é vida, é história, é lamento
um povo sofridoque viveu a escravidão
vindos da Africa,onde tinham liberdade
pra viver num mundo novo de tortura e opressão
bate tambor na calada da noite ó negro
bate tambor até o dia clarear
bate tambor na calada da noite ó negro
bate tambor para louvar seu orixá
e e e...senzala
e e e...senzala e
e e e...senzala
bate tambor, o negro se libertou
e e e senzala
e e e senzala e
ee e senzala
bate tambor, hoje não existe tanta dor$c8a9f96d75ce4933cd3a55d84329cc63a$, NULL, now()),
('a2c1052f-85ec-ff1d-e393-82c6273f1368', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta2c1052f85ecff1de39382c6273f1368$Preta velha - Negra mirongueira$ta2c1052f85ecff1de39382c6273f1368$, $ca2c1052f85ecff1de39382c6273f1368$De xale no ombro
Palheiro na boca
E rosário na mão
Ela vem de Aruanda
Saudar nossa banda
E trazerproteção
Um toco de vela
Banco de madeira
E saia carijó
Ela fazcaridade
Só traz a bondade
E desata onó
Ela é mirongueira auê
Ela é feiticeiraauê
Ela é Vó Luiza auê
Vem pra trabalhar (2x)$ca2c1052f85ecff1de39382c6273f1368$, NULL, now()),
('adb16ef8-6536-8678-4089-dd87b98cf7aa', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tadb16ef8653686784089dd87b98cf7aa$Lamento de um preto velho$tadb16ef8653686784089dd87b98cf7aa$, $cadb16ef8653686784089dd87b98cf7aa$Um gritofortena senzala ecoou
Era a voz de um negro forte
Que o açoite suportou
Ele lutava contra a leida escravidão
E no toque do tambor
Deixava a sua aflição
Ele cantava, ele rezava
Pedia a Zambi o fim de todo sofrimento
Ele cantava, ele rezava
Pedia a Zambi pra ouviro seu lamento
Quanto suor, que vida dura
Era no tronco, sua maior amargura
Chorou de dor mais não perdeu a fé
E hoje libertovem trazer o seu axé...
Ôôôô
Ôôôô
Pai Joaquim vem saudar a sua banda
Ôôôô
Força que vem de Aruanda (2x)$cadb16ef8653686784089dd87b98cf7aa$, NULL, now()),
('18e78ab4-3b6c-2d67-7d33-ec5699572736', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t18e78ab43b6c2d677d33ec5699572736$Preto velho -Pai Joaquim$t18e78ab43b6c2d677d33ec5699572736$, $c18e78ab43b6c2d677d33ec5699572736$Ele é preto velho
Ele vem saravá
Ele vem de Aruanda
Vem para trabalhar
É diade alegria
Vamos todos cantar
Com o pai Joaquim
Que acabou de chegar (2x)$c18e78ab43b6c2d677d33ec5699572736$, NULL, now()),
('6a4f3f62-aa8d-af91-78c1-ab2cbd781beb', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6a4f3f62aa8daf9178c1ab2cbd781beb$Cruzeiro Divino/Adorei as Almas$t6a4f3f62aa8daf9178c1ab2cbd781beb$, $c6a4f3f62aa8daf9178c1ab2cbd781beb$Lá no cruzeiro divino
Aonde as almas vão rezar
As almas choram de alegria
Quando os filhosse combinam
E de tristezaquando não quer combinar
As almas choram de alegria
Quando os filhosse combinam
E de tristezaquando não quer combinar
_______________________________
Adorei as almas
As almas me atenderam
Adorei as almas
As almas me atenderam
Era santas almas
Lá do Cruzeiro
Era santas almas
Lá do Cruzeiro$c6a4f3f62aa8daf9178c1ab2cbd781beb$, NULL, now()),
('e0b8beba-d537-4496-2cb9-2d056157d1a1', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te0b8bebad53744962cb92d056157d1a1$Pai Benedito De Aruanda - Ele Vem Na Fé De Oxalá$te0b8bebad53744962cb92d056157d1a1$, $ce0b8bebad53744962cb92d056157d1a1$PaiBenedito, Vem de Aruanda
Mas ele vem na fé de Oxalá -2x
Sua missão é muito grande
Espalhar a caridade
Seus filhosabençoar -2x$ce0b8bebad53744962cb92d056157d1a1$, NULL, now()),
('9400001f-a85e-b617-0cf0-35935bf08273', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t9400001fa85eb6170cf035935bf08273$Preto Velho Senta no Toco$t9400001fa85eb6170cf035935bf08273$, $c9400001fa85eb6170cf035935bf08273$Preto velho senta no toco
Faz o sinalda cruz
Pede proteção a Zambi
Para os filhosde Jesus
Preto velho senta no toco
Faz o sinalda cruz
Pede proteção a Zambi
Para os filhosde Jesus
Cada conta do seu rosário
É um filhoque aliestá
Se não fosse os Pretos velhos, eu não sabia caminhar
Cada conta do seu rosário
É um filhoque aliestá
Se não fosse os Pretos velhos, eu não sabia caminhar$c9400001fa85eb6170cf035935bf08273$, NULL, now()),
('480ab962-c9ae-bddf-146b-73c65d2289f3', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t480ab962c9aebddf146b73c65d2289f3$Preto Velho - Navio Negreiro$t480ab962c9aebddf146b73c65d2289f3$, $c480ab962c9aebddf146b73c65d2289f3$Navio Negreiro no fundo do mar
Navio Negreiro no fundo do mar
Correntes pesadas na areia a arrastar
Correntes pesadas na areia a arrastar
A negra escrava se pôs a cantar
A negra escrava se pôs a cantar
Saravá minha Mãe Iemanjá!
Saravá minha Mãe Iemanjá!
Virou a caçamba de fundo pro mar
Virou a caçamba de fundo pro mar
E quem me salvou foiMãe Iemanjá!
E quem me salvou foiMãe Iemanjá!
Saravá minha Mãe Iemanjá!
Saravá minha Mãe Iemanjá!$c480ab962c9aebddf146b73c65d2289f3$, NULL, now()),
('7b550e9f-3bb9-9e59-46ea-e3d2f2f62a19', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t7b550e9f3bb99e5946eae3d2f2f62a19$Pai Joaquim - Meu senhor da senzala$t7b550e9f3bb99e5946eae3d2f2f62a19$, $c7b550e9f3bb99e5946eae3d2f2f62a19$Meu senhor da senzala
meu sinhozinho
elevem cansado
meu Pai Joaquim
Um gritode liberdade
negro, ecoou
quando Oxalá chamou
recebeu, toda a paz pela humildade
hoje elenos trása caridade
Luanda, ô Luanda
como é tão lindoPai Joaquim
em nossa banda$c7b550e9f3bb99e5946eae3d2f2f62a19$, NULL, now()),
('c64f4c1b-8ca5-1cc8-35f4-6aa56fe3b6cf', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc64f4c1b8ca51cc835f46aa56fe3b6cf$Preto Velho - Ê, Luanda!$tc64f4c1b8ca51cc835f46aa56fe3b6cf$, $cc64f4c1b8ca51cc835f46aa56fe3b6cf$Ê Luanda,
Ê Luanda,
Terra da macumba, do batuque e do canjerê
Terra da macumba, do batuque e do canjerê
Eu vou chamar vovô
Eu vou chamar vovó
Eu vou chamar vovô
Eu vou chamar vovó
Luanda
Ê Luanda,
Ê Luanda,
Terra da macumba, do batuque e do canjerê
Terra da macumba, do batuque e do canjerê
Eu vou chamar vovô
Eu vou chamar vovó
Eu vou chamar vovô
Eu vou chamar vovó$cc64f4c1b8ca51cc835f46aa56fe3b6cf$, NULL, now()),
('04bfe00b-fd2a-6b0d-01eb-ebfffe89d234', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t04bfe00bfd2a6b0d01ebebfffe89d234$Vovó Maria do Rosário - O Galo cantou$t04bfe00bfd2a6b0d01ebebfffe89d234$, $c04bfe00bfd2a6b0d01ebebfffe89d234$O galo cantou
quando Jesus nasceu
Mas também, ele cantou
Quando Maria do Rosário aqui chegou
Viva aleluia,vivaaleluia
Viva aleluiae Maria do Rosário$c04bfe00bfd2a6b0d01ebebfffe89d234$, NULL, now()),
('a76e72f0-4d83-2fee-2e72-2e9d324485ac', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta76e72f04d832fee2e722e9d324485ac$Pai Joaquim de Angola - Libertação$ta76e72f04d832fee2e722e9d324485ac$, $ca76e72f04d832fee2e722e9d324485ac$No toco o Preto velho rezava
para acabar a escravidão
Rezava pra Nossa Senhora, Mãe Oxum
com seu rosáriona mão
Com muita emoção Pai Joaquim implora
aNossa Senhora sua libertação
Cativeiroacabou, quem (vai chegar / jáchegou) agora
Neste terreiroé Pai Joaquim de Angola$ca76e72f04d832fee2e722e9d324485ac$, NULL, now()),
('40aa9e19-7687-21bc-2fc8-2350069c397f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t40aa9e19768721bc2fc82350069c397f$Vovó Joana$t40aa9e19768721bc2fc82350069c397f$, $c40aa9e19768721bc2fc82350069c397f$Vovó camba, vem de Angola
prasenzala do senhor
vem servindo de muamba
prafilhade seu doutor
Vovó camba ficoumoça
eCambinda carregou
quando veio da sua senzala
muita coisa ensinou
éVovó Joana
no terreirode Umbanda
elavem de Aruanda
elavem trabalhar
O seu ponto de tuiaé seguro
elasabe também fazer cura
elaesconde qualquer criatura
dentro do seu gongá$c40aa9e19768721bc2fc82350069c397f$, NULL, now()),
('2a5f8aaf-2b3a-1f00-3eb1-1dcf93b30984', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t2a5f8aaf2b3a1f003eb11dcf93b30984$Vovó Maria Redonda - Filho se suncê precisar$t2a5f8aaf2b3a1f003eb11dcf93b30984$, $c2a5f8aaf2b3a1f003eb11dcf93b30984$"fio"se "suncê" "precisá"
é só pensar na vovó que ela vem lhe ajudar
Pensa numa estrada longa "ziofio"
láno seu jacutá
Numa casinha branca "zinfio"
a vovó tá lá
Sentada num banquinho tosco "zinfio"
com sua rosário na mão
pensa na vovó Maria Redonda
fazendo oração.$c2a5f8aaf2b3a1f003eb11dcf93b30984$, NULL, now()),
('7aafd8d1-8557-9e59-c878-f55438874f3b', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t7aafd8d185579e59c878f55438874f3b$Preto Velho - Preto só na cor$t7aafd8d185579e59c878f55438874f3b$, $c7aafd8d185579e59c878f55438874f3b$mas acabou, cativeiro acabou
mas acabou, cativeiro acabou
jáfuipreso na senzala, apanhei de ferroquente
e subi de morro à cima, e tinhaperna doente
mas acabou, cativeiro acabou
mas acabou, cativeiro acabou
conversava com a lua e a estrela respondia
tem paciência meu velho, cativeiroacaba um dia
mas acabou, cativeiro acabou
mas acabou, cativeiro acabou
eu cantei minha toada, o que foi meu padecer
por isso que nego tem um conselho pra suncê
mas acabou, cativeiro acabou
mas acabou, cativeiro acabou
eu andava sem dinheiro e nem tinha palitó
toda roupa que ganhava só era farrapo só
mas acabou, cativeiro acabou
mas acabou, cativeiro acabou
preto hoje tem anel, tem diploma, tem galão
na altasociedade o branco lhe estende a mão
mas acabou, cativeiroacabou
mas acabou, cativeiroacabou
preto hoje é chamado na casa de seu doutor
para beber vinhos finos e ganhar ramos de flor
mas acabou, cativeiroacabou
mas acabou, cativeiroacabou
preto jácasa com branca porque viram o seu valor
ea sogra ainda dizque ele é preto só na cor
mas acabou, cativeiroacabou
mas acabou, cativeiroacabou$c7aafd8d185579e59c878f55438874f3b$, NULL, now()),
('53bb6d69-3d3f-9b83-3de2-e346742dbd44', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t53bb6d693d3f9b833de2e346742dbd44$Pretas Velhas - Mironguê$t53bb6d693d3f9b833de2e346742dbd44$, $c53bb6d693d3f9b833de2e346742dbd44$Mironguê, mironguê, mironguê o babá
Mironguê, mironguê, mironguê o mamaeiê
TiaMaria Cambinda, Vovó Maria de Guiné
chamou Maria Redonda e Maria Cangomé
Mironguê, mironguê, mironguê o babá
Mironguê, mironguê, mironguê o mamaeiê
Fuicom Maria Benguelita e Maria de Luanda
visitarMaria Conga, todas elas têm mironga
Mironguê, mironguê, mironguê o babá
Mironguê, mironguê, mironguê o mamaeiê
Mãe Maria do Rosário, Vovó Maria da Guia
TiaMaria Cambuta, munanganga da Bahia
Mironguê, mironguê, mironguê o babá
Mironguê, mironguê, mironguê o mamaeiê$c53bb6d693d3f9b833de2e346742dbd44$, NULL, now()),
('65bec713-890d-0fac-76df-05f1000fe5de', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t65bec713890d0fac76df05f1000fe5de$Preto Velho - Rei do Congo$t65bec713890d0fac76df05f1000fe5de$, $c65bec713890d0fac76df05f1000fe5de$Rei do Congo está aqui, reido Congo está lá
Rei do Congo tem sua maxamba no reino de pai Oxalá
Saravá seu rei do Congo, salve sua canzuá
Saravá seu rei de Ganga, povo de Angola, Angolá
Rei do Congo está aqui, reido Congo está lá
Rei do Congo tem sua maxamba no reino de pai Oxalá
Eu chamei seu reido Congo para firmar meu gongá
trazera sua falange pra segurar meu canjirá
Rei do Congo está aqui, reido Congo está lá
Rei do Congo tem sua maxamba no reino de pai Oxalá$c65bec713890d0fac76df05f1000fe5de$, NULL, now()),
('167cb1a4-58cc-d8aa-47c9-b840ae9753fe', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t167cb1a458ccd8aa47c9b840ae9753fe$Preto Velho -Na linha de Africano$t167cb1a458ccd8aa47c9b840ae9753fe$, $c167cb1a458ccd8aa47c9b840ae9753fe$Na linha de Africano
niguém pode atravessar
Na linha de Africano
niguém pode atravessar
oh segura pemba eê
oh segura pemba eá
oh segura pemna no congá$c167cb1a458ccd8aa47c9b840ae9753fe$, NULL, now()),
('1e7a9b74-70e5-71c8-2626-9122022e733a', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t1e7a9b7470e571c826269122022e733a$Pai Benedito quando andou pelas estradas$t1e7a9b7470e571c826269122022e733a$, $c1e7a9b7470e571c826269122022e733a$PaiBenedito quando andou pelas estradas
faziasua cura com fé
Elefazia uma prece a Jesus
ealiviava seus filhosde fé
Paibenedito, eleé chefe de terreiro
Paibenedito, eleé chefe de gongá
Pai benedito, ele carrega a sua pemba
Pai benedito também tem seu patuá$c1e7a9b7470e571c826269122022e733a$, NULL, now()),
('f0b3d47b-738f-7067-84d2-d716c1063c68', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tf0b3d47b738f706784d2d716c1063c68$Preto Velho - Linha de Kongo$tf0b3d47b738f706784d2d716c1063c68$, $cf0b3d47b738f706784d2d716c1063c68$Arreia Kongo, arreia Kongo
Arreia Kongo, chama Preto velho para trabalhar
se a Umbanda lhe chama, é Kongo ê
se a Umbanda lhe chama, é Kongo ah
se a Umbanda lhe chama, chama Preto velho para trabalhar$cf0b3d47b738f706784d2d716c1063c68$, NULL, now()),
('aa508662-11b0-373b-1a98-d664002de726', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $taa50866211b0373b1a98d664002de726$Preta Velha - Cambinda mamãe ê$taa50866211b0373b1a98d664002de726$, $caa50866211b0373b1a98d664002de726$Cambinda mamãe ê
Cambinda mamãe ah
Cambinda mamãe ê
Cambinda mamãe ah
Segura a Cambinda que eu quero ver
Filhode pemba não tem querer
Segura a Cambinda que eu quero ver
Filhode pemba não tem querer$caa50866211b0373b1a98d664002de726$, NULL, now()),
('64d10296-f388-234e-9b60-97c74eee3146', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t64d10296f388234e9b6097c74eee3146$Pretos Velhos - Tia Maria$t64d10296f388234e9b6097c74eee3146$, $c64d10296f388234e9b6097c74eee3146$Êh, Tia Maria
Preta Velha da Bahia
Êh, Tia Maria
Preta Velha da Bahia
Segura a barra da saia
Dança na ponta do pé
E quando pega no rosário
Traça Umbanda e Candomblé
Tia Maria
Êh, Tia Maria
Preta Velha da Bahia
Rezadeira de quebranto
Mau-olhado e desencanto
Feiticeira,curandeira
Dobradora de Junqueira
Tia Maria;
Êh, Tia Maria
Preta Velha da Bahia
Êh, Tia Maria
Preta Velha da Bahia
E quem segurar o seu ponto
Sua pemba e muita fé
E quem quiser falarcom ela
Ganha figa de guiné
Tia Maria;
Êh, Tia Maria
Preta Velha da Bahia
Êh, Tia Maria
Preta Velha da Bahia$c64d10296f388234e9b6097c74eee3146$, NULL, now()),
('70580474-cf76-bcbb-4e2c-2b6308bec432', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t70580474cf76bcbb4e2c2b6308bec432$Pretos Velhos - Senhora do Rosário / O galo cantou$t70580474cf76bcbb4e2c2b6308bec432$, $c70580474cf76bcbb4e2c2b6308bec432$Senhora do Rosário
Foi quem me trouxe aqui
Senhora do Rosário
Foi quem me trouxe aqui
A água do mar é santa
Eu vi,eu vi,eu vi
A água do mar é santa
Eu vi,eu vi,eu vi$c70580474cf76bcbb4e2c2b6308bec432$, NULL, now()),
('8128df63-9212-0c16-b5f2-972591e0244e', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t8128df6392120c16b5f2972591e0244e$Preto Velho - Pai Miguel das Almas$t8128df6392120c16b5f2972591e0244e$, $c8128df6392120c16b5f2972591e0244e$Ele é um velho mandingueiro
Que vem na Umbanda trabalhar
Ele é um velho mandingueiro
Que vem na Umbanda trabalhar
Saravá meu Pai Miguel
Saravá pemba e gongá
Saravá meu Pai Miguel
Saravá pemba e gongá
Foina féde Oxalá que Pai Xangô lhe enviou
E com a força de Ajuberô
Pai Miguel das Almas vem salvar
E com a força de Ajuberô
Pai Miguel das Almas vem salvar
Ele é um velho mandingueiro
Que vem na Umbanda trabalhar
Ele é um velho mandingueiro
Que vem na Umbanda trabalhar
Saravá meu Pai Miguel
Saravá pemba e gongá
Saravá meu Pai Miguel
Saravá pemba e gongá
Com sua balança na mão a justiça elevem trazer
Sua curimba e sua cachimba
Tem mironga e tem poder
Sua curimba e sua cachimba
Tem mironga e tem poder
Ô, atotô,kaô! salve o meu Pai Miguel,
Saravá o meu vovô
Ô, atotô,kaô! salve o meu Pai Miguel,
Saravá o meu vovô
Ele é um velho mandingueiro
Que vem na Umbanda trabalhar
Ele é um velho mandingueiro
Que vem na Umbanda trabalhar
Saravá meu Pai Miguel
Saravá pemba e gongá
Saravá meu Pai Miguel
Saravá pemba e gongá$c8128df6392120c16b5f2972591e0244e$, NULL, now()),
('9d974cc0-fd18-0d3d-6696-4373ff74650a', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t9d974cc0fd180d3d66964373ff74650a$Pretos Velhos -Vovó Maria Redonda$t9d974cc0fd180d3d66964373ff74650a$, $c9d974cc0fd180d3d66964373ff74650a$Filho,se suncê precisá
É só pensar na vovó, que ela vem te ajudar
Filho,se suncê precisá
É só pensar na vovó, que ela vem te ajudar
Pensa numa estrada longa, zifio
Lá no seu jacutá
E numa casinha branca, zifio
Que a vovó tá lá
Sentada num banquinho tosco, zifio
Com a sua rosário na mão
Pensa na Vovó Maria Redonda, fazendo oração
Pensa na Vovó Maria Redonda, fazendo oração
Filho,se suncê precisá
É só pensar na vovó, que ela vem te ajudar
Filho,se suncê precisá
É só pensar na vovó, que ela vem te ajudar
Pensa numa estrada longa, zifio
Lá no seu jacutá
E numa casinha branca, zifio
Que a vovó tá lá
Sentada num banquinho tosco, zifio
Com a sua rosário na mão
Pensa na Vovó Maria Redonda, fazendo oração
Pensa na Vovó Maria Redonda, fazendo oração
Filho,se suncê precisá
É só pensar na vovó, que ela vem te ajudar
Filho,se suncê precisá
É só pensar na vovó, que ela vem te ajudar$c9d974cc0fd180d3d66964373ff74650a$, NULL, now()),
('3536cadb-b685-39ea-74c2-87151e2d01e2', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t3536cadbb68539ea74c287151e2d01e2$Pai Joaquim Veio de Angola$t3536cadbb68539ea74c287151e2d01e2$, $c3536cadbb68539ea74c287151e2d01e2$Pai Joaquim ê, Pai Joaquim, eá
Pai Joaquim ê, Pai Joaquim, eá
Pai Joaquim veio de Angola
Pai Joaquim é de Angola, Angolá
Pai Joaquim cadê Pai Mané
Tá na mata apanhando guiné
Pai Joaquim cadê Pai Mané
Tá na mata apanhando guiné
Diga a ele que quando vier
Que suba a escada e não bata o pé
Diga a ele que quando vier
Que suba a escada e não bata o pé
Pai Joaquim ê, Pai Joaquim, eá
Pai Joaquim ê, Pai Joaquim, eá
Pai Joaquim ê, Pai Joaquim, eá
Pai Joaquim ê, Pai Joaquim, eá$c3536cadbb68539ea74c287151e2d01e2$, NULL, now()),
('1accb51f-e290-2d16-81e6-696f2330e3ad', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t1accb51fe2902d1681e6696f2330e3ad$Pretos Velhos - Adorei aos Vencedor$t1accb51fe2902d1681e6696f2330e3ad$, $c1accb51fe2902d1681e6696f2330e3ad$Ôôô!
Ô...ôôôô…
Nego jáé livre,adorei aos vencedor
Ôôô!
Ô...ôôôô…
Bênção vovó, sua bênção meu vovô…
Negro
Sofreu tanto no açoite
Tão cruel era o feitor
Que abusava da maldade
Causando revolta e dor
Povo preto foivalente
Guerreiro trabalhador
Mesmo estando em cativeiro
Sua fé os libertou
Dos grilhões, das amarguras
Alma leve leva a cura
Correntes de crueldade
Se quebram com amor e caridade
Correntes de crueldade
Se quebram com amor e caridade
Ôôô!
Ô...ôôôô…
Nego jáé livre,adorei aos vencedor
Ôôô!
Ô...ôôôô…
Bênção vovó, sua bênção meu vovô…$c1accb51fe2902d1681e6696f2330e3ad$, NULL, now()),
('7115b93d-2ebf-daf3-9a76-e1b17d9960ed', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t7115b93d2ebfdaf39a76e1b17d9960ed$Pretos Velhos - Vivia livre na África$t7115b93d2ebfdaf39a76e1b17d9960ed$, $c7115b93d2ebfdaf39a76e1b17d9960ed$Vivialivrena África (eu vivia!)
Me prenderam dentro de um navio negreiro
Me trouxeram, pra morrer no mar
Enquanto o navio afundava, toda negaiada rezava
Quando senti,uma mão me carregava
Era uma mão doce, Oxalá é quem mandava
Foi aíque eu percebi quem era a Mãe d’água
Mamãe Iemanjá, rainha do mar, e toda negaiada
Foi aíque eu percebi quem era a Mãe d’água
Mamãe Iemanjá, rainha do mar, e toda negaiada
Vivialivrena África (eu vivia!)
Me prenderam dentro de um navio negreiro
Me trouxeram pra morrer no mar
Enquanto o navio afundava, toda negaiada rezava
Quando senti,uma mão me carregava
Era uma mão doce, Oxalá é quem mandava
Foi aíque eu percebi quem era a Mãe d’água
Mamãe Iemanjá, rainha do mar, e toda negaiada
Foi aíque eu percebi quem era a Mãe d’água
Mamãe Iemanjá, rainha do mar, e toda negaiada$c7115b93d2ebfdaf39a76e1b17d9960ed$, NULL, now()),
('46791c15-3c4c-9089-d677-31d088cbc0d7', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t46791c153c4c9089d67731d088cbc0d7$Almas - Adorei as Almas$t46791c153c4c9089d67731d088cbc0d7$, $c46791c153c4c9089d67731d088cbc0d7$Adorei, adorei
Adorei as almas, adorei
Adorei, adorei
Adorei as almas, adorei
Negro vem láde Aruanda,
Vem trazer a sua luz
Com a sua humildade
Negro trazfelicidade
Traz a paz e o amor
Adorei, adorei
Adorei as almas, adorei
Adorei, adorei
Adorei as almas, adorei
Com os seus ensinamentos,
Com a sua proteção
Negro cura os enfermos
E desfaz todo lamento
Purificao coração
Adorei, adorei
Adorei as almas, adorei
Adorei, adorei
Adorei as almas, adorei
Agradeço a nossa Umbanda
Agradeço a Oxalá
Pela oportunidade
De fazer a caridade
Agradeço ao meu bom Deus
Adorei, adorei
Adorei as almas, adorei
Adorei, adorei
Adorei as almas, adorei$c46791c153c4c9089d67731d088cbc0d7$, NULL, now()),
('266619d7-1797-beff-62e5-b2733c6b0e20', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t266619d71797beff62e5b2733c6b0e20$Pretos Velhos - Vovó Joana$t266619d71797beff62e5b2733c6b0e20$, $c266619d71797beff62e5b2733c6b0e20$O seu ponto de cuia é seguro,
Ela sabe também fazer cura,
Ela esconde qualquer criatura
Dentro do seu congá.
Êh, cacurucaia!
Saravá, Vovó Joana!
Vovó Cambá,
Vem de angola pra senzala do sinhô.
Vem servindo de mucama
Pra filhado seu doutor.
Vovó Camba ficoumoça
E Zambi jácarregou.
Quando veio de sua senzala
Muita coisa ensinou.
É Vovó Joana,
No terreirode Umbanda,
Ela vem de Aruanda,
Ela vem trabalhar$c266619d71797beff62e5b2733c6b0e20$, NULL, now()),
('5ede2fa2-e73c-eb1c-4109-adb292da1ed2', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t5ede2fa2e73ceb1c4109adb292da1ed2$Pai Chico -Olha eu, camarada$t5ede2fa2e73ceb1c4109adb292da1ed2$, $c5ede2fa2e73ceb1c4109adb292da1ed2$Olha eu, camarada
Camarada meu
Olha eu, camarada
Camarada meu
É o Pai Chico
Que chegou aqui agora
Candomblé bato no Keto
Umbanda bato em Angola
É o Pai Chico
Que chegou aqui agora
Candomblé bato no Keto
Umbanda bato em Angola
Olha eu, camarada
Camarada meu
Olha eu, camarada
Camarada meu
É o Pai Chico
Que chegou aqui agora
Candomblé bato no Keto
Umbanda bato em Angola
É o Pai Chico
Que chegou aqui agora
Candomblé bato no Keto
Umbanda bato em Angola
O Pai Chico é preto
Ôh, cambina!
Mora no roseiral
Ôh, cambina!
O Pai Chico é preto
Ôh, cambina!
Mora no roseiral
Ôh, cambina!
Eleé chefe de mesa
Ôh, cambina!
Leva todo o mal
Eleé chefe de mesa
Ôh, cambina!
Leva todo o mal
O Pai Chico é preto
Ôh, cambina!
Mora no roseiral
Ôh, cambina!
Eleé chefe de mesa
Ôh, cambina!
Leva todo o mal
Olha eu, camarada
Camarada meu
Olha eu, camarada
Camarada meu
Olha eu, camarada
Camarada meu
Olha eu, camarada
Camarada meu$c5ede2fa2e73ceb1c4109adb292da1ed2$, NULL, now()),
('a231d8c8-550b-f240-ab79-73d6423796cb', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta231d8c8550bf240ab7973d6423796cb$Pretos Velhos - Vovó Maria da Guia$ta231d8c8550bf240ab7973d6423796cb$, $ca231d8c8550bf240ab7973d6423796cb$Vovó Maria da Guia
Traz as forças láda Bahia.
Vovó Maria da Guia
Traz as forças láda Bahia.
Preta velha rezadeira,
Todo mal ela desfaz,
Preta velha mirongueira,
A razão da minha paz.
Na sua sacola ela traz
Um galhinho de vence-demanda,
Aroeira, rosas brancas
E um rosário de guiné.
No cruzeiro abençoado,
Trabalha pra quem tem fé.
Vovó Maria da Guia
Traz as forças láda Bahia.
Vovó Maria da Guia
Traz as forças láda Bahia.
Preta velha rezadeira,
Todo mal ela desfaz,
Preta velha mirongueira,
A razão da minha paz.
Na sua sacola ela traz
Um galhinho de vence-demanda,
Aroeira, rosas brancas
E um rosário de guiné.
No cruzeiro abençoado,
Trabalha pra quem tem fé.$ca231d8c8550bf240ab7973d6423796cb$, NULL, now()),
('30f9f9bb-75dc-f9c5-e512-4f1d24b99fd6', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t30f9f9bb75dcf9c5e5124f1d24b99fd6$Pai Joaquim de Aruanda - Firma ponto, minha gente$t30f9f9bb75dcf9c5e5124f1d24b99fd6$, $c30f9f9bb75dcf9c5e5124f1d24b99fd6$Firma ponto minha gente!
Preto velho vaichegar
Ele vem de Aruanda
Ele vem pra trabalhar
Firma ponto minha gente!
Preto velho vaichegar
Ele vem de Aruanda
Ele vem pra trabalhar
Saravá, pai Joaquim!
Saravá, saravá, saravá!
Ele chegou no terreiro
Ele vem nos ajudar
Saravá, pai Joaquim!
Saravá, saravá, saravá!
Ele chegou no terreiro
Ele vem nos ajudar.$c30f9f9bb75dcf9c5e5124f1d24b99fd6$, NULL, now()),
('9def1950-67b6-646a-c7eb-a77c80b344ef', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t9def195067b6646ac7eba77c80b344ef$Vovó Maria Conga -Abre Este Terreiro$t9def195067b6646ac7eba77c80b344ef$, $c9def195067b6646ac7eba77c80b344ef$Que Deus esteja presente
Em todos os trabalhos de agora
Afastai os obsessores
Protegei-nos Nossa Senhora
Abre esse terreiro
Abre esse gongar
Chegou Maria Conga
Vamos trabalhar
Abre esse terreiro
Abre esse gongar
Chegou Maria Conga
Vamos trabalhar
Maria Conga no altar divino
Lá das alturas neste chão desceu
Maria Conga no altar divino
Lá das alturas neste chão desceu
Maria Conga veio no terreiro
Para saravar todos netinhos seus
Maria Conga veio no terreiro
Para saravar todos netinhos seus
Abre esse terreiro
Abre esse gongar
Chegou Maria Conga
Vamos trabalhar
Abre esse terreiro
Abre esse gongar
Chegou Maria Conga
Vamos trabalhar
Maria Conga no altar divino
Lá das alturas neste chão desceu
Maria Conga no altar divino
Lá das alturas neste chão desceu
Maria Conga veio no terreiro
Para saravar todos netinhos seus
Maria Conga veio no terreiro
Para saravar todos netinhos seus
Abre esse terreiro
Abre esse gongar
Chegou Maria Conga
Vamos trabalhar
Pai Cipriano - Preto Velho de Fé$c9def195067b6646ac7eba77c80b344ef$, NULL, now()),
('9b6d6bfa-8edc-5123-0987-ba9182cd2088', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t9b6d6bfa8edc51230987ba9182cd2088$Página 27de 65$t9b6d6bfa8edc51230987ba9182cd2088$, $c9b6d6bfa8edc51230987ba9182cd2088$Segura com fé
Na mão de Cipriano
Pra colher flores
Ou espinhos retirar
Ele nos traza luz divina de Aruanda
O brilhoda estrelaguia, a benção de Oxalá
Se o caminho é de paz, Cipriano é amor
Vou segurar com féna mão do meu vovô!
Se o caminho é de paz, Cipriano é amor
Vou segurar com féna mão do meu vovô!$c9b6d6bfa8edc51230987ba9182cd2088$, NULL, now()),
('26cc9aa9-c4c1-7d98-2aa8-20a993e50ef1', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t26cc9aa9c4c17d982aa820a993e50ef1$Vovó Cambinda - Terreiro de Vovó Cambinda$t26cc9aa9c4c17d982aa820a993e50ef1$, $c26cc9aa9c4c17d982aa820a993e50ef1$Hoje é dia das almas benditas
No terreiroda Vovó Cambinda
Ela chega vestida de chita
Na Umbanda essa velha é tão linda
Apoiada em sua bengala
Traz o peso do seu cativeiro
Vai sentar em seu velho banquinho
Que está no canto do terreiro
Auê, auê, com seu balancear
Vem chegando, Vó Cambinda
Caminhando devagar
Auê, auê, com seu balancear
Vem chegando, Vó Cambinda
Caminhando devagar
Traz coitépara tomar seu café
E a pemba pro ponto riscar
Ela vaiacender seu cachimbo
Com a fumaça o terreiroincensar
Olho grande, quebranto demanda
Essa velha é quem sabe rezar
Com guiné, alecrim e arruda
E a forçado seu patuá
Auê, auê, com seu balancear
Vem chegando, Vó Cambinda
Caminhando devagar
Auê, auê, com seu balancear
Vem chegando, Vó Cambinda
Caminhando devagar
Pretos Velhos - Vó Benedita$c26cc9aa9c4c17d982aa820a993e50ef1$, NULL, now()),
('872e760b-9436-a4df-eb15-b14a8c9b84a6', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t872e760b9436a4dfeb15b14a8c9b84a6$Página28de 65$t872e760b9436a4dfeb15b14a8c9b84a6$, $c872e760b9436a4dfeb15b14a8c9b84a6$Oh, salve a luz
E as Santas Almas do congá
Saravá Vó Benedita
Que vem nesse chão pisar
Oh, salve a luz
E as Santas Almas do congá
Saravá Vó Benedita
Que vem nesse chão pisar
No cativeiro
Ela nasceu
E na senzala
Sobreviveu
No cativeiro
Ela nasceu
E na senzala
Sobreviveu
Vó Benedita
Ela chega de mansinho
Ela falabem baixinho
Pra ajudar filhos de fé
Saravá Vó Benedita
Ela trazo seu axé
Vó Benedita
Ela chega de mansinho
Ela falabem baixinho
Pra ajudar filhos de fé
Saravá Vó Benedita
Ela trazo seu axé
Oh, salve a luz
E as Santas Almas do congá
Saravá Vó Benedita
Que vem nesse chão pisar
Oh, salve a luz
E as Santas Almas do congá
Saravá Vó Benedita
Que vem nesse chão pisar$c872e760b9436a4dfeb15b14a8c9b84a6$, NULL, now()),
('f74783ac-fef4-18c2-5c2b-8191ef39a056', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tf74783acfef418c25c2b8191ef39a056$Pretos Velhos - Se suncê precizá$tf74783acfef418c25c2b8191ef39a056$, $cf74783acfef418c25c2b8191ef39a056$Fio,se suncê precizá
É só pensá na vovó
Que ela vem teajudá
Pensa numa estrada longa, zifio
Lá no seu jacutá
E numa casinha branca, zifio
Que a vovó tá lá
Sentada num banquinho tosco, zifio
Com a sua rosário na mão
Pensa na Vovó Maria Redonda
Fazendo Oração$cf74783acfef418c25c2b8191ef39a056$, NULL, now()),
('efeaea1c-4312-f769-32a0-f3df77fd5d8e', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tefeaea1c4312f76932a0f3df77fd5d8e$Vovó Luiza - Cacurucaia$tefeaea1c4312f76932a0f3df77fd5d8e$, $cefeaea1c4312f76932a0f3df77fd5d8e$Cacurucaia, auê, auê,
Vovó Luiza, auê, auê,
Cacurucaia, auê, auê,
Vovó Luiza, auê, auê,
Vovó Luiza quando vem lá de Aruanda,
Trazendo pemba pra salvar filhosde Umbanda,
Com sua saiacarijó e de babado,
Trazendo o rosário sagrado.
Com sua saiacarijó e de babado,
Trazendo o rosário sagrado.
Cacurucaia, auê, auê,
Vovó Luiza, auê, auê,$cefeaea1c4312f76932a0f3df77fd5d8e$, NULL, now()),
('12a78548-df30-6107-7795-7cf016ec3cdb', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t12a78548df30610777957cf016ec3cdb$Pretos Velhos - Vovó Maria Redonda$t12a78548df30610777957cf016ec3cdb$, $c12a78548df30610777957cf016ec3cdb$Fio,se suncê precisá
É só pensar na vovó
Que elavem te ajudar
Fio,se suncê precisá
É só pensar na vovó
Que elavem te ajudar
Pensa numa estrada longa, zifio
Lá no seu jacutá
E numa casinha branca zifio
Que a vovó tá lá
Sentada num banquinho tosco, zifio
Com a sua rosário na mão
Pensa na vovó Maria Redonda
Fazendo oração
Pensa na vovó Maria Redonda
Fazendo oração$c12a78548df30610777957cf016ec3cdb$, NULL, now()),
('4f7f42a3-70ca-624f-e7d5-68ab523cbed7', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4f7f42a370ca624fe7d568ab523cbed7$Pretos Velhos - Pai Benedito$t4f7f42a370ca624fe7d568ab523cbed7$, $c4f7f42a370ca624fe7d568ab523cbed7$Pai Benedito é preto, ô sinhadona
Ele mora no roseiral
Pai Benedito é preto, ô sinhadona
Ele mora no roseiral
Ele é preto e tem coroa, sinhadona
Ele é chefe de gongá
Ele é preto e tem coroa, sinhadona
Ele é chefe de gongá
Pai Benedito é preto ô sinhadona
Ele mora no roseiral
Pai Benedito é preto ô sinhadona
Ele mora no roseiral
Ele é preto e tem coroa, sinhadona
Ele é chefe de gongá
Ele é preto e tem coroa, sinhadona
Ele é chefe de gongá
Olha meu são Benedito, ô babá,
Olha ele vem de bantu ô babá
Olha meu são Benedito, ô babá,
Olha ele vem de bantu ô babá
Cadê meu cafungé
Ele táno cafungá,
Olha viva meu são Benedito,
Oi,que vem, ô,no meu jacutá
Olha meu são Benedito, ô babá,
Olha ele vem de bantu ô babá
Olha meu são Benedito, ô babá,
Olha ele vem de bantu ô babá
Cadê meu cafungé
Ele táno cafungá,
Olha viva meu são Benedito,
Oi,que vem, ô,no meu jacutá$c4f7f42a370ca624fe7d568ab523cbed7$, NULL, now()),
('f857a0ff-a68d-e8f5-1901-a8f635758ac1', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tf857a0ffa68de8f51901a8f635758ac1$Pretos Velhos - Vovó Catarina de Angola$tf857a0ffa68de8f51901a8f635758ac1$, $cf857a0ffa68de8f51901a8f635758ac1$Ecoou
Um canto vindo de longe
Ecoou
Ecoou
Um canto vindo de longe
Ecoou
Um lindo dia uma luz no céu brilhou
Sob a estrela guia, iluminada chegou
A preta velha de Aruanda, luz divina
Recebeu de oxalá o nome de Catarina
A preta velha de Aruanda, luz divina
Recebeu de oxalá o nome de catarina
É lua cheia, é lua nova
Louvada seja,vovó Catarina de Angola
É lua cheia, é lua nova
Louvada seja,vovó Catarina de Angola
Ecoou
Um canto vindo de longe
Ecoou
Ecoou
Um canto vindo de longe
Ecoou
Um lindo dia uma luz no céu brilhou
Sob a estrela guia, iluminada chegou
A preta velha de Aruanda, luz divina
Recebeu de Oxalá o nome de Catarina
A preta velha de Aruanda, luz divina
Recebeu de Oxalá o nome de Catarina
É lua cheia, é lua nova
Louvada seja,vovó Catarina de Angola
É lua cheia, é lua nova
Louvada seja,vovó Catarina de Angola$cf857a0ffa68de8f51901a8f635758ac1$, NULL, now()),
('a43e5850-1e97-3840-3a9d-525a77b65e1a', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta43e58501e9738403a9d525a77b65e1a$Pretos Velhos - Santas Almas$ta43e58501e9738403a9d525a77b65e1a$, $ca43e58501e9738403a9d525a77b65e1a$Bateram na porta do céu
São Pedro abriu para ver quem é
Mas era as almas, mas era as almas
que se pesavam na balança de Miguel
________________________________________
A balança de São Miguel
elabalanceou
Aimeu São Miguel!
foielaquem me salvou
_____________________________________
Minha Santa Rita
édia, é dia
édia do rosário de Maria
ôviva as almas! ô viva as almas
ôviva as almas, e o rosário de Maria$ca43e58501e9738403a9d525a77b65e1a$, NULL, now()),
('05464009-fe12-c55f-32ee-009414f22a24', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t05464009fe12c55f32ee009414f22a24$Preto Velho chegou de Angola$t05464009fe12c55f32ee009414f22a24$, $c05464009fe12c55f32ee009414f22a24$Preto velho chegou de angola
Preto velho chegou pra ajudar
Preto velho trouxe as flores
que as crianças foram buscar
Essas floresvão iluminar,
oterreiroe esse gongá
Com força e sabedoria
elesvêem para abençoar$c05464009fe12c55f32ee009414f22a24$, NULL, now()),
('c68fca1f-169d-06fd-3fa0-c5ff0157e7d0', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc68fca1f169d06fd3fa0c5ff0157e7d0$Pretos Velhos - Almas$tc68fca1f169d06fd3fa0c5ff0157e7d0$, $cc68fca1f169d06fd3fa0c5ff0157e7d0$As Almas tem ,as almas dá.
As Almas dá pra quem sabe aproveitar.
As Almas tem ,as almas dá.
As Almas dá para quem sabe aproveitar.
Vamos pedir,vamos implorar
As almas dá para quem sabe aproveitar
Vamos pedir,vamos implorar
As almas dá para quem sabe aproveitar
As Almas tem ,as almas dá.
As Almas dá pra quem sabe aproveitar.
As Almas tem ,as almas dá.
As Almas dá para quem sabe aproveitar.
Vamos pedir,vamos implorar
As almas dá para quem sabe aproveitar
Vamos pedir,vamos implorar
As almas dá para quem sabe aproveitar
Abre a porta do céu, São Pedro
Deixa as almas trabalhar
Abre a porta do céu, São Pedro
Deixa as almas trabalhar
Oh, Virgem Imaculada
Olha, Nossa Senhora da Conceição
Oh, Virgem Imaculada
Olha, Nossa Senhora da Conceição$cc68fca1f169d06fd3fa0c5ff0157e7d0$, NULL, now()),
('3537293c-b3b0-6596-a5b6-365819fa5f39', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t3537293cb3b06596a5b6365819fa5f39$Preto Velho - Banquinho$t3537293cb3b06596a5b6365819fa5f39$, $c3537293cb3b06596a5b6365819fa5f39$Sentado num banquinho eu vi
Um Preto Velho chorando
Sentado num banquinho eu vi
Um Preto Velho chorando
Ele chorava
Pelos filhosdo terreiro
Que só procuram a Umbanda
Quando estão em desespero
Ele chorava
Pelos filhosdo terreiro
Que só procuram a Umbanda
Quando estão em desespero
Preto Velho reza
Preto Velho faz mironga
Vence a demanda dos filhos
E segura a sua banda
Os filhos fazem
Sem nada dizer
E o mais velho ficapensando
No que possa acontecer
Preto Velho lembra
Do tempo do cativeiro
Preto Velho chora
Pelos filhosdo terreiro
Preto Velho lembra
Do tempo do cativeiro
Preto Velho chora
Pelos filhosdo terreiro
Preto Velho reza
Preto Velho fazmironga
Vence a demanda dos filhos
E segura a sua banda
Os filhosfazem
Sem nada dizer
E o mais velho ficapensando
No que possa acontecer
Preto Velho lembra
Do tempo do cativeiro
Preto Velho chora
Pelos filhosdo terreiro
Preto Velho lembra
Do tempo do cativeiro
Preto Velho chora
Pelos filhosdo terreiro$c3537293cb3b06596a5b6365819fa5f39$, NULL, now()),
('c1c68861-1cf2-fbb8-c2f0-ff9f8dc01c0b', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc1c688611cf2fbb8c2f0ff9f8dc01c0b$Preto Velho - Pai José de Aruanda$tc1c688611cf2fbb8c2f0ff9f8dc01c0b$, $cc1c688611cf2fbb8c2f0ff9f8dc01c0b$O Pai José vem de Aruanda
E vem benzendo os seus filhoscom guiné
O Pai José vem de Aruanda
E vem benzendo os seus filhoscom guiné
Se na Aruanda ele afirma o seu ponto
No seu terreirotem sua força e o seu axé
Se na Aruanda ele afirma o seu ponto
No seu terreirotem sua força e o seu axé
O Pai José vem de Aruanda
E vem benzendo os seus filhoscom guiné
O Pai José vem de Aruanda
E vem benzendo os seus filhoscom guiné
Se na Aruanda ele afirma o seu ponto
No seu terreirotem sua força rseu axé
Se na Aruanda ele afirma o seu ponto
No seu terreirotem sua força rseu axé$cc1c688611cf2fbb8c2f0ff9f8dc01c0b$, NULL, now()),
('47295d9c-50a5-74a0-5fe9-882a60ac9d26', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t47295d9c50a574a05fe9882a60ac9d26$Tia Maria da Bahia - Caminho da fé$t47295d9c50a574a05fe9882a60ac9d26$, $c47295d9c50a574a05fe9882a60ac9d26$Salve Pai Oxalá
Em seu nome essa Preta Velha eu vou saravá
Pai Oxalá
Salve Pai Oxalá
Em seu nome essa Preta Velha eu vou saravá
O seu nome é Tia Maria
A Bahia é o seu lugar
Quem foique disse que ela não foimãe
Porque não viu seus meninos adotar
Trabalhava noite e dia
E a alegriaestava sempre em seu olhar
A vida foidura a ela
Mas de sol em solnão deixou nada faltar
Hoje na Umbanda ela gira
E em sua companhia todos querem ficar
Com sua farofade linguiça
Sua figa de Guiné
Também reza o patuá
TiaMaria
Ô, Tia Maria
Eu venho a tirezar
Ô, Tia Maria
Pois eu sei no caminho da luz
Você vaime guiar
Pai Oxalá
Salve Pai Oxalá
Em seu nome essa Preta Velha eu vou saravá
Pai Oxalá
Salve Pai Oxalá
Em seu nome essa Preta Velha eu vou saravá$c47295d9c50a574a05fe9882a60ac9d26$, NULL, now()),
('ed5d8dcd-cab0-e1b2-7aac-b39b84131f42', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ted5d8dcdcab0e1b27aacb39b84131f42$Pai José de Aruanda - Senzala de fé$ted5d8dcdcab0e1b27aacb39b84131f42$, $ced5d8dcdcab0e1b27aacb39b84131f42$Vim da senzala e nela tenho fé
Vim da senzala e nela tenho fé
Hoje venho na Umbanda, meu nome é Pai José
Hoje venho na Umbanda, meu nome é Pai José
Traga meu cachimbo e a cachaça do lado
Com a fumaça do cachimbo tudo de ruim será tirado
Tome um gole de marafo e faça um pedido
Com a graça do Pai Maior, ele será atendido
Se precisar, lhe estenderei a mão
Peça sempre às santas almas muita paz e proteção
Vim da senzala e nela tenho fé
Vim da senzala e nela tenho fé
Hoje venho na Umbanda, meu nome é Pai José
Hoje venho na Umbanda, meu nome é Pai José
Traga meu cachimbo e a cachaça do lado
Com a fumaça do cachimbo tudo de ruim será tirado
Tome um gole de marafo e faça um pedido
Com a graça do Pai Maior, ele será atendido
Se precisar, lhe estenderei a mão
Peça sempre às santas almas muita paz e proteção
Vim da senzala e nela tenho fé
Vim da senzala e nela tenho fé
Hoje venho na Umbanda, meu nome é Pai José
Hoje venho na Umbanda, meu nome é Pai José$ced5d8dcdcab0e1b27aacb39b84131f42$, NULL, now()),
('451d487d-4e2c-93a6-b105-3b941c078132', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t451d487d4e2c93a6b1053b941c078132$Preto Velho - Esperança para um novo amanhecer$t451d487d4e2c93a6b1053b941c078132$, $c451d487d4e2c93a6b1053b941c078132$Ecoou um canto fortena senzala
Ecoou um canto fortena senzala
Negro canta, negro dança
Liberdade fez valer
Não existe sofrimento, não existe mais chibata
Só existe a esperança para um novo amanhecer
Ecoou um canto fortena senzala
Ecoou um canto fortena senzala
Negro canta, negro dança
Liberdade fez valer
Não existe sofrimento, não existe mais chibata
Só existe a esperança para um novo amanhecer
Povo negro, povo forte
Trabalhavam pro senhor
E sofriam as maldades praticadas pelo feitor
O sangue, o suor e a lágrima
Renovavam a força pra lida
Pois sabiam que o sofrimento purificava pra nova vida
Ecoou um canto fortena senzala
Ecoou um canto fortena senzala
Negro canta, negro dança
Liberdade fez valer
Não existe sofrimento, não existe mais chibata
Só existe a esperança para um novo amanhecer
Do Congo ou de Angola ou de Mina
Bahia, Aruanda ou Cambinda
São os velhinhos da Umbanda
Que encaminham nossas vidas
Esqueceram o terrorda senzala
Do cativeiro, as crueldades
E voltaram pra essa terra
Pra prestar a caridade
Ecoou um canto fortena senzala
Ecoou um canto fortena senzala
Negro canta, negro dança
Liberdade fez valer
Não existe sofrimento, não existe mais chibata
Só existe a esperança para um novo amanhecer$c451d487d4e2c93a6b1053b941c078132$, NULL, now()),
('d92fd678-3bcb-2eeb-56c1-522ebd2a2c98', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $td92fd6783bcb2eeb56c1522ebd2a2c98$Preto Velho - Meu cativeiro$td92fd6783bcb2eeb56c1522ebd2a2c98$, $cd92fd6783bcb2eeb56c1522ebd2a2c98$Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
No tempo da escravidão
Preto Velho muito trabalhou
Mas não tinha o que pensar
Levava problemas para o senhor
Mas não tinha no que pensar
Levava problemas para o senhor
E quando chegava a tardinha
Preto Velho batia tambor
E quando chegava a tardinha
Preto Velho batia tambor
Depois iapara a senzala
Saravar Ogum, saravar pai Xangô
Depois iapara a senzala
Saravar Ogum, saravar pai Xangô
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
Eu choro meu cativeiro
Meu cativeiro,meu "cativerá"
No tempo da escravidão
Preto Velho muito trabalhou
Mas não tinha no que pensar
Levava problemas para o senhor
Mas não tinha no que pensar
Levava problemas para o senhor
E quando chegava a tardinha
Preto Velho batia tambor
E quando chegava a tardinha
Preto Velho batia tambor
Depois iapara a senzala
Saravar Ogum, saravar pai Xangô
Depois iapara a senzala
Saravar Ogum, saravar pai Xangô$cd92fd6783bcb2eeb56c1522ebd2a2c98$, NULL, now()),
('8aded38e-d34d-ee91-868c-d8ddabaf106e', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t8aded38ed34dee91868cd8ddabaf106e$Preto Velho - Fui pedir às Santas Almas$t8aded38ed34dee91868cd8ddabaf106e$, $c8aded38ed34dee91868cd8ddabaf106e$Eu andava perambulando
Sem ter nada pra comer,
Fui pedir às santas almas
Para vir me socorrer
Eu andava perambulando
Sem ter nada pra comer,
Fui pedir às santas almas
Para vir me socorrer
"Foi"as almas que me "ajudou"
"Foi"as almas que me "ajudou"
Meu divino espíritosanto
Viva a Deus Nosso Senhor
"Foi"as almas que me "ajudou"
"Foi"as almas que me "ajudou"
Meu divino espíritosanto
Viva a Deus Nosso Senhor
"Foi"as almas que me "ajudou"
"Foi"as almas que me "ajudou"
Meu divino espíritosanto
Viva a Deus Nosso Senhor
"Foi"as almas que me "ajudou"
"Foi"as almas que me "ajudou"
Meu divino espíritosanto
Viva a Deus Nosso Senhor
Quem pede às almas
As almas "dá"
Filhode pemba é que não sabe aproveitar
Quem pede às almas
As almas "dá"
Filhode pemba é que não sabe aproveitar
Eu andava perambulando
sem ternada pra comer,
Fui pedir às santas almas
para virme socorrer
Eu andava perambulando
sem ternada pra comer,
Fui pedir às santas almas
para virme socorrer
Foi"as almas que me "ajudou"
Foi"as almas que me "ajudou"
Meu divino espíritosanto
Viva a Deus Nosso Senhor
Foi"as almas que me "ajudou"
Foi"as almas que me "ajudou"
Meu divino espíritosanto
Viva a Deus Nosso Senhor
Quem pede às almas
As almas "dá"
Filhode pemba é que não sabe aproveitar
Quem pede às almas
As almas "dá"
Filhode pemba é que não sabe aproveitar$c8aded38ed34dee91868cd8ddabaf106e$, NULL, now()),
('6286f05b-79e1-a2c4-c25d-310d3c5d0c95', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6286f05b79e1a2c4c25d310d3c5d0c95$Preto Velho - Luz no caminhar$t6286f05b79e1a2c4c25d310d3c5d0c95$, $c6286f05b79e1a2c4c25d310d3c5d0c95$Se do seu rosto um pranto rolar,um pranto rolar
saiba que não estás sozinho
Segure na mão do Vovô e da Vovó
que eles abrirão seus caminhos
Todo caminhar tem suas tormentas,
nenhuma estrada ésó de flor
Mas suncê pode contar com a Vovó
que ela tirarásua dor
Quem tem fé nas Santas Almas
não sentirá a escuridão
Com a fumaça do cachimbo do Vovô
teráluz em seu coração$c6286f05b79e1a2c4c25d310d3c5d0c95$, NULL, now()),
('bf981982-2865-33e8-2e42-d68288ab73f4', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tbf981982286533e82e42d68288ab73f4$Preto Velho - Que fumaça cheirosa, vovô!$tbf981982286533e82e42d68288ab73f4$, $cbf981982286533e82e42d68288ab73f4$Que fumaça cheirosa, vovô
Sai do seu cachimbo
Que fumaça cheirosa, vovô
Sai do seu cachimbo
Não sei se é arruda, vovô
Ou manjericão
Só sei que esta fumaça, vovô
Faz bem ao meu coração
Só sei que esta fumaça, vovô
Faz bem ao meu coração
Meu Pai Antônio de Angola
Protetor,bondoso guia
Meu Pai Antônio de Angola
Protetor,bondoso guia
Ele trazno patuá
O feitiçoda Bahia
Ele trazno patuá
O feitiçoda Bahia
Que fumaça cheirosa, vovô
Sai do seu cachimbo
Que fumaça cheirosa, vovô
Sai do seu cachimbo
Não sei se é arruda, vovô
Ou manjericão
Só sei que esta fumaça, vovô
Faz bem ao meu coração
Só sei que esta fumaça, vovô
Faz bem ao meu coração
Enquanto a senzala dormia
A sua oração fazia
Enquanto a senzala dormia
A sua oração fazia
Ajoelhado pedia clemência
A Jesus e àVirgem Maria
Ajoelhado pedia clemência
A Jesus e àVirgem Maria$cbf981982286533e82e42d68288ab73f4$, NULL, now()),
('06baf3e1-aea4-bbc3-1a76-ea3aff19ac9c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t06baf3e1aea4bbc31a76ea3aff19ac9c$Preto Velho - Aruanda$t06baf3e1aea4bbc31a76ea3aff19ac9c$, $c06baf3e1aea4bbc31a76ea3aff19ac9c$O sol de Aruanda
Já raiou na nossa Umbanda
E são os pretos de Oxalá
Trazendo a paz para nos amparar
E são os pretos de Oxalá
Trazendo a paz para nos amparar
Oh, é o céu, é Aruanda
Preto Velho vem vencer demanda
Oh, é o céu, é Aruanda
Preto Velho vem vencer demanda
O sol de Aruanda
Já raiou na nossa Umbanda
E são os pretos de Oxalá
Trazendo a paz para nos amparar$c06baf3e1aea4bbc31a76ea3aff19ac9c$, NULL, now()),
('4438833a-8b4f-f374-7cd6-e4e6c6111ba5', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4438833a8b4ff3747cd6e4e6c6111ba5$Pai Benedito - A vida de um Preto velho$t4438833a8b4ff3747cd6e4e6c6111ba5$, $c4438833a8b4ff3747cd6e4e6c6111ba5$ekongo e,e kongo a
Preto velho com sua cachimba na boca
soltaa fumaça pro ar
Aquele tempo da senzala
me leva a imaginar
avida de um Preto velho
que vivia só pra trabalhar
Acorrentado, amarrado no tronco
chicotada nas costas doíam
As lágrimas de sofrimento
em seu tristerosto corriam
As lagrimas de sofrimento
em seu tristerosto corriam
O tempo passou
negro escravo se libertou
cantando, sorrindo e dançando
pois a felicidadechegou
Hoje encontro na Umbanda
esse preto velhinho bendito
Quando chego no terreiro
peço a bênção ao vovô Benedito$c4438833a8b4ff3747cd6e4e6c6111ba5$, NULL, now()),
('59745501-250b-8b11-a79c-c04619fd239b', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t59745501250b8b11a79cc04619fd239b$Pretos Velhos - Minhas Almas$t59745501250b8b11a79cc04619fd239b$, $c59745501250b8b11a79cc04619fd239b$Eu louvei, louvei
Eu louvei, Senhor
Eu louvei a Terra
E o seu Criador
Eu louvei, louvei
Eu louvei, Senhor
Eu louvei a Terra
E o seu Criador
Minhas Almas
Santas Almas
Olha a minha oração
Minhas Almas
Santas Almas
Olha a minha oração
Olha minha oração
Minhas Almas
Olha minha oração
Olha minha oração
Minhas Almas
Olha minha oração$c59745501250b8b11a79cc04619fd239b$, NULL, now()),
('c8fc977a-b3d2-b67a-04db-1542df53ba98', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc8fc977ab3d2b67a04db1542df53ba98$Preto Velho - Na areia, na areia$tc8fc977ab3d2b67a04db1542df53ba98$, $cc8fc977ab3d2b67a04db1542df53ba98$Preto velho
Você mora longe
Preto velho
Diga qual o seu nome (2x)
Eu também moro longe
Bem pertinho de você
Diga qual o seu nome
Preto velho,eu quero saber (2x)
Na areia,na areia
Preto velho,na areia
Na areia,na areia
Saravá, mamãe sereia (2x)$cc8fc977ab3d2b67a04db1542df53ba98$, NULL, now()),
('2a089777-8f8e-2e12-2977-d33c740ab831', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t2a0897778f8e2e122977d33c740ab831$Preto Velho - Pai José -Filho de São Benedito$t2a0897778f8e2e122977d33c740ab831$, $c2a0897778f8e2e122977d33c740ab831$Que preto é esse?
Que preto tão bonito!
Eleé o Pai José
Filhode São Benedito$c2a0897778f8e2e122977d33c740ab831$, NULL, now()),
('fc51b520-b554-83fe-3c8e-0802857ddfb6', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tfc51b520b55483fe3c8e0802857ddfb6$Preta Velha - A velha Conga$tfc51b520b55483fe3c8e0802857ddfb6$, $cfc51b520b55483fe3c8e0802857ddfb6$A velha Conga
Preta mina da guiné (Quem é?)
Quando vem de Aruanda
Saravá Umbanda, saravá congá
Elagira na terra
Elagira no mar
Pra seus filhosabençoar$cfc51b520b55483fe3c8e0802857ddfb6$, NULL, now()),
('6caa4404-4e5b-6db9-ee88-dddaf506db76', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6caa44044e5b6db9ee88dddaf506db76$Preta Velha - Mãe Maria de Minas$t6caa44044e5b6db9ee88dddaf506db76$, $c6caa44044e5b6db9ee88dddaf506db76$Salve Mãe Maria de Minas
Mãe Maria de Minas Gerais (Refrão)
Preta Velha rezadeira
Qualquer nó ela desfaz
Preta Velha mirongueira
É a razão da minha paz
Da sua urucaia ela traz
Um cachimbo que vence demanda
Sete pembas, rosas brancas
Um rosário de Guiné
No cruzeiro abençoado
Trabalha pra quem tem fé
(Refrão)$c6caa44044e5b6db9ee88dddaf506db76$, NULL, now()),
('bd7aedc3-3a7b-03a7-bd59-9e71ea239014', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tbd7aedc33a7b03a7bd599e71ea239014$Preta Velha - Mironguê$tbd7aedc33a7b03a7bd599e71ea239014$, $cbd7aedc33a7b03a7bd599e71ea239014$Mironguê, mironguê, mironga
Bate cabeça pra vovó Maria Conga (Refrão)
Arriouno terreiro,linhade Congô e Nagô
Saravá Iofá,saravá meu protetor
Meu São Benedito, que aqui chegou
Vem trazer vovó, vem trazervovô (bis)
Que hoje tem lua cheia, eê no céu
Que hoje tem lua cheia, eê no mar
Afirma ponto pai, afirma ponto mãe
Adorei as Almas, as almas vem me ajudar
Figa de guiné, arruda e patuá
Sua saia tem mironga
Maria Conga está no Congá
Que hoje tem lua cheia, eê no céu
Que hoje tem lua cheia, eê no mar
(Refrão)$cbd7aedc33a7b03a7bd599e71ea239014$, NULL, now()),
('037ffe9b-a38c-7be3-3848-935af4f8a340', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t037ffe9ba38c7be33848935af4f8a340$Preto Velho - Pai João da Mata - Pra fazer andor$t037ffe9ba38c7be33848935af4f8a340$, $c037ffe9ba38c7be33848935af4f8a340$Preto Velho vem de longe
Vem descendo a pedreira
Bebeu água da fonte
Se benzeu na cachoeira
Pai João da Mata
Ele é rezador
Com sua machada
Corta madeira pra fazer andor
Pra fazer andor (2x)
Pra fazer capela pra Jesus Cristo Nosso Senhor$c037ffe9ba38c7be33848935af4f8a340$, NULL, now()),
('6efc8a23-8a84-eb9a-9c26-4b484912c81f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6efc8a238a84eb9a9c264b484912c81f$Preto Velho - Pai Jeremias - Estrela guia$t6efc8a238a84eb9a9c264b484912c81f$, $c6efc8a238a84eb9a9c264b484912c81f$Uma estrela guia, segue os passos de Pai Jeremias
No caminho de volta quando ele veio do seu Cazuá
A noite tava clara pegou a bengala e foi caminhar
Foi no topo do morro com nosso senhor ele foiconversar$c6efc8a238a84eb9a9c264b484912c81f$, NULL, now()),
('469338e5-dff7-27d6-cd63-79bc1d604916', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t469338e5dff727d6cd6379bc1d604916$Preto Velho - Pai José$t469338e5dff727d6cd6379bc1d604916$, $c469338e5dff727d6cd6379bc1d604916$Quem quiser ver, que veja auê
Quem quiser ver, que veja auá
Eu sou negro feiticeiro,eu vim aqui pra trabalhar
Eu sou filhode Angola, o meu pai é da Guiné
Minha mãe é de Carangola e eu me chamo Pai José$c469338e5dff727d6cd6379bc1d604916$, NULL, now()),
('95660266-1122-c576-4727-a6e002218f9f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t956602661122c5764727a6e002218f9f$Preto Velho - Não queiram calar nossos tambores$t956602661122c5764727a6e002218f9f$, $c956602661122c5764727a6e002218f9f$Não queiram calar nossos tambores não
deixem os Pretos velhos trabalhar
Pai Benedito vem com as Almas, Vovó Catarina de Aruanda
Pai Joaquim vem saravá
Pega um toco, acende um pito,coloca o café pro Vovô
salve os velhos da Umbanda que cativeiroacabou (2X)
não queiram calarnossos tambores não
deixem os Pretos velhos trabalhar
Pai Benedito mirongueiro, Vovó Catarina de Aruanda
Pai Joaquim velho rezador
Risca a pemba, faz mironga, pega o galho de guiné
é que adorei as almas, nas almas eu tenho fé (2X)$c956602661122c5764727a6e002218f9f$, NULL, now()),
('afc91eb2-01bd-5848-7efe-bc6c9634ba27', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tafc91eb201bd58487efebc6c9634ba27$Pai Cipriano - Lá na rua da amargura$tafc91eb201bd58487efebc6c9634ba27$, $cafc91eb201bd58487efebc6c9634ba27$Lá na rua da amargura
PaiCipriano chefe da feitiçaria(2x)
Sapo martelo
aranha caranguejeira
corujão na vida alheia
se enroscou na sua teia
na grécia antiga
todo humano era mal
negaram água a São Lázaro
etoda Grécia virou sal$cafc91eb201bd58487efebc6c9634ba27$, NULL, now()),
('fcfe31a9-6f84-fa8b-e9c3-c542c69354b9', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tfcfe31a96f84fa8be9c3c542c69354b9$Preto Velho -Pai Joaquim cadê os pretos velhos$tfcfe31a96f84fa8be9c3c542c69354b9$, $cfcfe31a96f84fa8be9c3c542c69354b9$PaiJoaquim ...
...digaele que quando que vir
que suba a escada e não bata com o pé
cadê pai Mané
tána mata colhendo café
cadê pai João
tána mata colhendo feijão
cadê vovó Conga
tána mata fazendo mironga
cadê tiaMaria
tána mata lavando a bacia
cadê pai Cipriano
tána mata, ficoutrabalhando
cadê pai José
tána mata colhendo guiné
cadê pai Jacó
tána mata passando um ebó
cadê pai Crispim
tána mata colhendo alecrim
paiJoão cadê paiJoaquim
tána mata colhendo aipim$cfcfe31a96f84fa8be9c3c542c69354b9$, NULL, now()),
('de4c9fdd-32f9-cdc9-b692-74ef90bee499', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tde4c9fdd32f9cdc9b69274ef90bee499$Preto Velho -Eu vou chamar vovô$tde4c9fdd32f9cdc9b69274ef90bee499$, $cde4c9fdd32f9cdc9b69274ef90bee499$eh Luanda
eh Luanda
terrada macumba, do batuque
do canjerê
eu vou chamar vovô
eu vou chamar vovó
eu vou chamar vovô
eu vou chamar vovó$cde4c9fdd32f9cdc9b69274ef90bee499$, NULL, now()),
('a9d2bf73-da3d-c1bf-450d-bb936616df97', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta9d2bf73da3dc1bf450dbb936616df97$Preto Velho - Bahia oh Áfria vem cá nos ajudar$ta9d2bf73da3dc1bf450dbb936616df97$, $ca9d2bf73da3dc1bf450dbb936616df97$Bahia oh Áfria
vem cá, vem nos ajudar [2x]
forçabaiana
forçaafricana
forçaDivina
vem cá, vem cá [2x]$ca9d2bf73da3dc1bf450dbb936616df97$, NULL, now()),
('6bd80dea-445a-f5d2-0d4a-ed3e6cd9d662', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6bd80dea445af5d20d4aed3e6cd9d662$Preto-Velho - Negra Cambinda$t6bd80dea445af5d20d4aed3e6cd9d662$, $c6bd80dea445af5d20d4aed3e6cd9d662$Negra cambinda
negra da Costa do mar
negra da Costa linda
filhadeyalorixá
na macumba eh
na macumba ah
na macumba eh
na macumba ah
nego fuma, nego dança
na batidado tambor
nego bebe seu marafo
saravá seu protetor$c6bd80dea445af5d20d4aed3e6cd9d662$, NULL, now()),
('5b7064e2-09c2-9267-bb07-109bbf12d920', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t5b7064e209c29267bb07109bbf12d920$Preto Velho - Foi lá no cruzeiro das Almas$t5b7064e209c29267bb07109bbf12d920$, $c5b7064e209c29267bb07109bbf12d920$Foilá
no cruzeirodas Almas
onde as Almas foram rezar [2x]
As Almas choram de alegria
quando os filhossecombinam
também choram de tristeza
quando não querem combinar [2x]
Preto Velho - É João Baiano$c5b7064e209c29267bb07109bbf12d920$, NULL, now()),
('836dc138-9f91-e2da-1a9b-01e8988c3fbd', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t836dc1389f91e2da1a9b01e8988c3fbd$Página46de 65$t836dc1389f91e2da1a9b01e8988c3fbd$, $c836dc1389f91e2da1a9b01e8988c3fbd$Elenasceu na África,ele é africano
veiopra Bahia, é João Baiano
Elenasceu na Áfricacom muita alegria
Saravá a áfrica,saravá Bahia$c836dc1389f91e2da1a9b01e8988c3fbd$, NULL, now()),
('c601b7c2-b5ff-bbee-24a8-006158f40f85', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc601b7c2b5ffbbee24a8006158f40f85$Preto Velho Vovô Chico - Nego "véio" da Bahia$tc601b7c2b5ffbbee24a8006158f40f85$, $cc601b7c2b5ffbbee24a8006158f40f85$éna palma da mão
éna palma da mão
Vovô Chico chega no terreiro
batendo asua bengala no chão
Vovô Chico é mirongueiro
nego véio da Bahia
caminha fumando cachimbo
etocando viola durante o dia
Com o seu chapéu de palha
vaiandando devagarinho
sempre carregando com ele para o seu descanso
um simples banquinho
bate tambor
bate tambor
Vovô Chico chega no terreiro
trazendo harmonia bondade e amor
Também trás a caridade
para todos filhosseus
Vovô Chico é mais um grande velho
que é iluminado por Deus$cc601b7c2b5ffbbee24a8006158f40f85$, NULL, now()),
('3a8f11a9-d02f-6c6f-94b3-a8acdd6b18e4', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t3a8f11a9d02f6c6f94b3a8acdd6b18e4$Preta Velha - Jardim de vovó$t3a8f11a9d02f6c6f94b3a8acdd6b18e4$, $c3a8f11a9d02f6c6f94b3a8acdd6b18e4$Vovó eu planteino seu jardim
Guiné, arruda, e alecrim
Tem margarida e também picão
copo de leitee manjericão
todos os dias antes de irtrabalhar
vou até o seu jardim, a sua benção tomar$c3a8f11a9d02f6c6f94b3a8acdd6b18e4$, NULL, now()),
('baa3f26f-0087-c94e-0e30-2e7fd923cbbd', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tbaa3f26f0087c94e0e302e7fd923cbbd$Preto-Velho - Vovó não quer casca de coco no terreiro$tbaa3f26f0087c94e0e302e7fd923cbbd$, $cbaa3f26f0087c94e0e302e7fd923cbbd$Vovó não quer
casca de coco no terreiro
Casca de coco faz lembrar
otempo do cativeiro[2x]$cbaa3f26f0087c94e0e302e7fd923cbbd$, NULL, now()),
('c9090025-ab9b-8542-8234-8e6c94b08c27', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc9090025ab9b854282348e6c94b08c27$Preto-Velho -Ai vovó eu tenho medo$tc9090025ab9b854282348e6c94b08c27$, $cc9090025ab9b854282348e6c94b08c27$aiVovó eu tenho medo
aiVovó eu tenho medo
aiVovó eu tenho medo
Da fumaça do cachimbo
descobrir omeu segredo [2x]$cc9090025ab9b854282348e6c94b08c27$, NULL, now()),
('928a1af8-cb6d-0a2f-7dce-ec088761269d', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t928a1af8cb6d0a2f7dceec088761269d$Preto Velho - Meu senhor da Senzala - Pai Joaquim$t928a1af8cb6d0a2f7dceec088761269d$, $c928a1af8cb6d0a2f7dceec088761269d$Meu senhor da senzala
meu senhorzinho
elevem cansado
meu Pai Joaquim [2x]
Um gritode liberdade
negro ecoou
quando Oxalá chamou
recebeu
toda paz pela humildade
hojeele nos traza caridade
Luanda
oh Luanda
como é tãolindo
PaiJoaquim em nossa banda [2x]$c928a1af8cb6d0a2f7dceec088761269d$, NULL, now()),
('4d7fbcc6-607f-445b-bf69-a4a70077d650', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4d7fbcc6607f445bbf69a4a70077d650$Pretos Velhos - Vó Toninha- Velha Mandingueira$t4d7fbcc6607f445bbf69a4a70077d650$, $c4d7fbcc6607f445bbf69a4a70077d650$auê, auê, auê Vovó
Vó Toninha vem de minas, vem pra desatar o nó
Essa velha mandingueira, chega com seu patuá
na sacola trása pemba, para seu ponto firmar
sua bengala tem magia, sua reza tem poder
Vovó corta as demandas, quem duvida venha ver
auê, auê, auê Vovó
Vó toninha vem de minas, vem pra desatar o nó
Fuma cigarro de palha, com galinho de arruda na mão
muitos filhoslhe consultam e recebem sua proteção
atabaque firmaa gira,batam palmas e vamos cantar
Vó Toninha se levanta sorridente pra dançar$c4d7fbcc6607f445bbf69a4a70077d650$, NULL, now()),
('5d801892-d07e-bab9-322d-acb269d79009', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t5d801892d07ebab9322dacb269d79009$Preto Velho -Alguém me avisou$t5d801892d07ebab9322dacb269d79009$, $c5d801892d07ebab9322dacb269d79009$Foram me chamar
eu estou aqui
oque que há
Foram me chamar
eu estou aqui
oque que há
Eu vim de lá
Eu vim de lá
pequenininho
Mas eu vim de lá
pequenininho
Alguém me avisou
prapisar nesse chão
devagarinho [2x]$c5d801892d07ebab9322dacb269d79009$, NULL, now()),
('1486eb5b-a218-2830-dc2c-e2b5eb50ba7c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t1486eb5ba2182830dc2ce2b5eb50ba7c$Preto Velho -Atravessa o rio nas costas do jacaré$t1486eb5ba2182830dc2ce2b5eb50ba7c$, $c1486eb5ba2182830dc2ce2b5eb50ba7c$Pretovelho quando vem
elenão vem a pé
atravessa orio
nas costas do jacaré$c1486eb5ba2182830dc2ce2b5eb50ba7c$, NULL, now()),
('e1582891-764e-71fc-4a5b-595f192e25b7', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te1582891764e71fc4a5b595f192e25b7$Preto Velho -Keguele Keguele Xango, ele é filho da cobra coral$te1582891764e71fc4a5b595f192e25b7$, $ce1582891764e71fc4a5b595f192e25b7$Keguele keguele Xangô
eleé filhoda cobra coral
Keguele keguele Xangô
eleé filhoda cobra coral
Olha pretotá trabalhando
Olha branco, não tá
táolhando
Olha pretotá trabalhando
Olha branco, não tá
táolhando$ce1582891764e71fc4a5b595f192e25b7$, NULL, now()),
('879ddf02-c466-dfa4-0861-48d0cdbb2758', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t879ddf02c466dfa4086148d0cdbb2758$Preto Velho -Maria Conga se eu pedir você me dá$t879ddf02c466dfa4086148d0cdbb2758$, $c879ddf02c466dfa4086148d0cdbb2758$Maria Conga se eu pedirvocê me dá
Maria Conga se eu pedirvocê me dá
Um pedaço do seu lenço pra fazer meu patuá
Um pedaço do seu lenço pra fazer meu patuá
rêrê rê rê
rêrê rê rêrê rá
Um pedaço do seu lenço pra fazer meu patuá
Um pedaço do seu lenço pra fazer meu patuá$c879ddf02c466dfa4086148d0cdbb2758$, NULL, now()),
('536df1e2-f1d2-76c8-6853-dc053a386e04', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t536df1e2f1d276c86853dc053a386e04$Preto Velho - Vovó Maria Redonda - Fio, se suncê precisar$t536df1e2f1d276c86853dc053a386e04$, $c536df1e2f1d276c86853dc053a386e04$Fio
se suncê precisa
ésó pensar na Vovó
que ela vem lheajudar
Fio
se suncê precisa
ésó pensar na Vovó
que ela vem lheajudar
Pensa numa estrada longa, zifio
láno seu Jacutá
enuma casinha branca zifio
que a Vovó tálá
Sentada num banquinho tosco, zifio
com seu rosáriona mão
pensa na Vovó Maria Redonda
fazendo oração [2x]$c536df1e2f1d276c86853dc053a386e04$, NULL, now()),
('4a16c54f-3841-3ef6-28bf-66e9cc796bd4', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4a16c54f38413ef628bf66e9cc796bd4$Preto Velho - Andou andou andou, preto-velho trabalhador$t4a16c54f38413ef628bf66e9cc796bd4$, $c4a16c54f38413ef628bf66e9cc796bd4$Andou andou andou
Preto-velho trabalhador
Andou andou andou
Preto-velho trabalhador
Preto-velho desceu a serra
Oxalá foiquem mandou
Preto-velho desceu a serra
Oxalá foiquem mandou$c4a16c54f38413ef628bf66e9cc796bd4$, NULL, now()),
('bbf6c0a1-2a3d-687f-c51f-e80afd0555a4', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tbbf6c0a12a3d687fc51fe80afd0555a4$Preto Velho - Numa noite linda, noite de luar$tbbf6c0a12a3d687fc51fe80afd0555a4$, $cbbf6c0a12a3d687fc51fe80afd0555a4$Numa noite linda
noitede luar
Preto-velho orou a Zambi
pracativeiro acabar
Numa noite linda
noitede luar
Preto-velho orou a Zambi
pracativeiro acabar
trabalha Zé, trabalhou
trabalha Zé, trabalhou
trabalha Zé
que o cativeiroacabou
trabalha Zé, trabalhou
trabalha Zé, trabalhou
trabalha Zé
que o cativeiroacabou$cbbf6c0a12a3d687fc51fe80afd0555a4$, NULL, now()),
('6d5688de-165c-5dae-ebb7-8404782198e8', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6d5688de165c5daeebb78404782198e8$Preto Velho -Vovó Cambina - Segredo da Lua$t6d5688de165c5daeebb78404782198e8$, $c6d5688de165c5daeebb78404782198e8$Vovó Cambina tem
tem um segredo da Lua
Vovó Cambina tem
tem um segredo da Lua
Olha seus filhosVovó
esses que moram na rua
Olha seus filhosVovó
esses que moram na rua$c6d5688de165c5daeebb78404782198e8$, NULL, now()),
('f6745bb2-35a1-a36a-a9d5-e3428e58725f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tf6745bb235a1a36aa9d5e3428e58725f$Preto Velho -Subida -A sineta do céu bateu$tf6745bb235a1a36aa9d5e3428e58725f$, $cf6745bb235a1a36aa9d5e3428e58725f$A sineta do céu bateu
Oxalá já dizque é hora
A sineta do céu bateu
Oxalá já dizque é hora
Eu vou eu vou eu vou
Fica com Deus e Nossa Senhora
Eu vou eu vou eu vou
Fica com Deus e Nossa Senhora$cf6745bb235a1a36aa9d5e3428e58725f$, NULL, now()),
('d3b9d3fb-8193-e095-57d7-dd873d2d1862', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $td3b9d3fb8193e09557d7dd873d2d1862$Preto Velho -Vovó Joana - Lição de vovó$td3b9d3fb8193e09557d7dd873d2d1862$, $cd3b9d3fb8193e09557d7dd873d2d1862$Vó Joana tem a luz de Nzambi para trabalhar
Vovó ensina aos seus filhos
como é fácilcaminhar
Com humildade e respeito
dessa missão todos vão se lembrar
que a jornada é difícil
mas étão fácilcaminhar
Andar com amor e a fé
andar sempre pronto a ensinar
andar prestando a caridade
essa é a missão que vovó vem nos dar$cd3b9d3fb8193e09557d7dd873d2d1862$, NULL, now()),
('3c5643b1-89e8-c073-143b-1740f1198662', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t3c5643b189e8c073143b1740f1198662$Preto Velho -Preto Velho tem muita mironga$t3c5643b189e8c073143b1740f1198662$, $c3c5643b189e8c073143b1740f1198662$Preto Velho tem muita mironga
Xangô na pedreira mandou lhe chamar (2x)
Põe o velho pra trabalhar
Deixa o velho mirongar (2x)$c3c5643b189e8c073143b1740f1198662$, NULL, now()),
('82345cad-2ed6-e356-66e9-cd4aab7b67c8', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t82345cad2ed6e35666e9cd4aab7b67c8$Preto Velho -Nego velho chorou$t82345cad2ed6e35666e9cd4aab7b67c8$, $c82345cad2ed6e35666e9cd4aab7b67c8$Nego velho chorou
No tronco e na senzala (2x)
Pedindo a Zambi forças
Pra aguentar a chibatada (2x)
Nego velho chorou
No tronco e na senzala (2x)
Hoje vem no terreiro
Pra ensinar a caridade (2x)$c82345cad2ed6e35666e9cd4aab7b67c8$, NULL, now()),
('fe8bcb0a-d1ee-337e-9d06-8bc8192d3439', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tfe8bcb0ad1ee337e9d068bc8192d3439$Preto velho - Pai Joaquim de Angola$tfe8bcb0ad1ee337e9d068bc8192d3439$, $cfe8bcb0ad1ee337e9d068bc8192d3439$Pai Joaquim de Angola é mirongueiro
Chega no terreirodescalço de pés no chão
Firma a mironga nas contas do seu rosário
Risca ponto de trabalho,nas forças de pai Ogum
Com suas ervas ele trazseu benzimento
Com toda sabedoria, aliviao sofrimento
Com suas ervas ele trazseu benzimento
Com toda sabedoria, aliviao sofrimento...$cfe8bcb0ad1ee337e9d068bc8192d3439$, NULL, now()),
('e5685865-c4e2-b880-0439-4808e3b892fc', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te5685865c4e2b88004394808e3b892fc$Preto Velho -Pai Benedito é preto ô Sinhadona$te5685865c4e2b88004394808e3b892fc$, $ce5685865c4e2b88004394808e3b892fc$Pai Benedito é preto ô Sinhadona
elemora no roseiral
Pai Benedito é preto ô Sinhadona
elemora no roseiral
Ele épreto e tem coroa, Sinhadona
eleé chefe de gongá
Ele épreto e tem coroa, Sinhadona
eleé chefe de gongá
Pai Benedito é preto ô Sinhadona
elemora no roseiral
Pai Benedito é preto ô Sinhadona
elemora no roseiral
Ele épreto e tem coroa, Sinhadona
eleé chefe de gongá
Ele épreto e tem coroa, Sinhadona
eleé chefe de gongá$ce5685865c4e2b88004394808e3b892fc$, NULL, now()),
('e76b90b5-9a01-37d9-e3cf-3361fbe6b0c7', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te76b90b59a0137d9e3cf3361fbe6b0c7$Preto Velho - Pai Malaquias$te76b90b59a0137d9e3cf3361fbe6b0c7$, $ce76b90b59a0137d9e3cf3361fbe6b0c7$O navio de São Salvador
chegou da Bahia tão carregado
Trouxe cravo
Trouxe rosa
Pai Malaquias que vinha de lá
Trouxe cravo
Trouxe rosa
Pai Malaquias que vinha de lá$ce76b90b59a0137d9e3cf3361fbe6b0c7$, NULL, now()),
('84b0947b-536a-9821-2ec8-aed0ba1093b9', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t84b0947b536a98212ec8aed0ba1093b9$Preto Velho - Se é da Bahia eu quero ver descer$t84b0947b536a98212ec8aed0ba1093b9$, $c84b0947b536a98212ec8aed0ba1093b9$Se é da Bahia
eu quero ver descer
Se é da Bahia
eu quero ver descer
Cadê Vovó
Cadê você
Cadê Vovó
Cadê você$c84b0947b536a98212ec8aed0ba1093b9$, NULL, now()),
('60248376-8ea7-6591-3894-b63792d1561f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t602483768ea765913894b63792d1561f$Preto Velho - Marcas do Tempo$t602483768ea765913894b63792d1561f$, $c602483768ea765913894b63792d1561f$Preto velho pisa, pisa devagar
Antigamente corria igualvocê
A muito tempo ele jásabe esperar
Coisa que hoje você tem que aprender
A sua estrada tem muita mironga
Tem muita historiaboa de aprender
Em cada igreja que passa ele ora
Pedindo a Virgem que interceda por você (2x)
Preto velho pisa, pisa devagar
Antigamente corria igualvocê
A muito tempo ele jásabe esperar
Coisa que hoje você tem que aprender
De sol à sol como escravo se entregava
A vida dura, você tinha que ver
E a noitinha na senzala ele rezava
Pedindo a Zambi mais um dia pra viver (2x)
Preto velho pisa, pisa devagar
Antigamente corria igualvocê
A muito tempo ele jásabe esperar
Coisa que hoje você tem que aprender
Oi salve Deus ,salve as almas benditas
Quem acredita vai saber entender
Que cada lagrima do velho quando rola
Faz aliviaros pecados de você (2x)$c602483768ea765913894b63792d1561f$, NULL, now()),
('e75b62d2-8eda-f4f0-e23c-707e70432131', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te75b62d28edaf4f0e23c707e70432131$Preto Velho - Saravá senzala$te75b62d28edaf4f0e23c707e70432131$, $ce75b62d28edaf4f0e23c707e70432131$Saravá senzala! Saravá terreiro
negro chegou na Umbanda lembrando do cativeiro
Saravá senzala! Saravá terreiro
negro chegou na Umbanda lembrando do cativeiro
Saravá Ximango toco
Salve Martin de Ongá
Viva Pai José da Costa
que vem de Angola, Angolá
Saravá senzala! Saravá terreiro
negro chegou na Umbanda lembrando do cativeiro
Saravá senzala! Saravá terreiro
negro chegou na Umbanda lembrando do cativeiro
Salve Dom Pedro segundo
Salve a princesa Isabel
marimbondo faz zoada
abelha é quem faz mel
Saravá senzala! Saravá terreiro
negro chegou na Umbanda lembrando do cativeiro
Saravá senzala! Saravá terreiro
negro chegou na Umbanda lembrando do cativeiro
Ogã batino tambor
negro faz angorossi
no dia 13 de maio
louvando a papai NZambi$ce75b62d28edaf4f0e23c707e70432131$, NULL, now()),
('009622af-1ae4-3c72-4088-d7ebe21a9657', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t009622af1ae43c724088d7ebe21a9657$Preta Velha - Maria Conga$t009622af1ae43c724088d7ebe21a9657$, $c009622af1ae43c724088d7ebe21a9657$Vamos ver
Vamos "oiá", Vamos ver
Maria Conga como ganha coroa
Vamos ver
Apanha o pano da costa e tráspro peji
uma garrafa de dendê, um galho e um ori
Ogã da um alujápra todos "ouvi"
chama Maria Conga está pronto o amori
Ogã da um alujápra todos "ouvi"
chama Maria Conga está pronto o amori$c009622af1ae43c724088d7ebe21a9657$, NULL, now()),
('e5919c94-e861-dffb-91d1-5c51e199f863', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te5919c94e861dffb91d15c51e199f863$Preta Velha - Maria Conga - Rainha do cateretê$te5919c94e861dffb91d15c51e199f863$, $ce5919c94e861dffb91d15c51e199f863$Todo diaera dia de choro e de muita dor
mesmo assim uma escrava chegava de bom humor
quem chorava passava asorrir
quem caía ficava de pé
elaé a esperança, o amor ea fé
Na passagem de um mundo pro outro seu povo sentiu
eaquela tão sua alegrianão mais existiu
eladisse que iriavoltar
precisando pode lhechamar
pra Aruanda atabaque pode tocar
Conga, vó Maria Conga
que saudade de você
Conga vó Maria Conga
estou chamando por você
Preta velha feiticeirarainha do cateretê$ce5919c94e861dffb91d15c51e199f863$, NULL, now()),
('89d19d06-3586-8fd7-106a-91d7f9ca3d65', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t89d19d0635868fd7106a91d7f9ca3d65$Preto Velho - Cipriano das almas$t89d19d0635868fd7106a91d7f9ca3d65$, $c89d19d0635868fd7106a91d7f9ca3d65$Quem é aquele velhinho
que vem no caminho de terra batida
descalço a andar
Com sete guizos no bolso
seu chapéu de palha, seu ponto não falha
como ele não há
Mas eleé,
Cipriano das almas
que anda mundo a fora
sem teronde chegar
Que pisa devagar
mas com tanta firmeza no chão
preto velho chega no terreiro
dando sua proteção$c89d19d0635868fd7106a91d7f9ca3d65$, NULL, now()),
('8a8aef77-7d83-aa3c-8a1d-e27616225584', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t8a8aef777d83aa3c8a1de27616225584$Preta Velha - Vovó Maria Redonda - Fazendo oração$t8a8aef777d83aa3c8a1de27616225584$, $c8a8aef777d83aa3c8a1de27616225584$"fio"se"suncê" precisar
ésó pensar na vovó
que ela vem lheajudar
pensa numa estrada longa "ziofio"
láno seu jacutá
numa casinha branca "zinfio"
avovó tálá
sentada num banquinho tosco "zinfio"
com sua rosáriona mão
pensa na Vovó Maria redonda
fazendo oração.$c8a8aef777d83aa3c8a1de27616225584$, NULL, now()),
('a6891ee2-0833-cec6-0f9c-0a9f0abd6ccc', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $ta6891ee20833cec60f9c0a9f0abd6ccc$Preto Velho - Vamos saravá no gongá$ta6891ee20833cec60f9c0a9f0abd6ccc$, $ca6891ee20833cec60f9c0a9f0abd6ccc$Preto velho que veio de Angola vamos saravá no gongá
aê,aê, aê vamos saravá no gongá
pretovelho que veio de Cambinda
pretovelho que veio de Luanda
pretovelho que veio ládo Congo
prasaravá filhode Umbanda
Preto velho que veio de Angola vamos saravá no gongá
aê,aê, aê vamos saravá no gongá
pretovelho é Pai Benedito
pretovelho é João Serrador
pretovelho é ximango toco
que veio na angoma saravá pai Xangô$ca6891ee20833cec60f9c0a9f0abd6ccc$, NULL, now()),
('65b6dc74-c8b6-a2a2-964d-00f7f43cac4f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t65b6dc74c8b6a2a2964d00f7f43cac4f$Preto Velho - Libertação Pai Jaquim de Angola$t65b6dc74c8b6a2a2964d00f7f43cac4f$, $c65b6dc74c8b6a2a2964d00f7f43cac4f$No toco o preto velho rezava
para acabar a escravidão
rezava pra nossa senhora, mãe Oxum
com seu rosáriona mão
Com muita emoção, paiJoaquim implora
anossa senhora, sua libertação
Cativeiroacabou, quem já chegou agora
neste terreiroépai Joaquim de Angola
Preto Velho - Risca ponto, faz mironga - Chorar chorei - Que preto é esse$c65b6dc74c8b6a2a2964d00f7f43cac4f$, NULL, now()),
('67e34a56-0dfc-c5fb-2559-4e6020192d3c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t67e34a560dfcc5fb25594e6020192d3c$Página 56de 65$t67e34a560dfcc5fb25594e6020192d3c$, $c67e34a560dfcc5fb25594e6020192d3c$O Preto velho que nasceu no cativeiro
hoje baixa no terreiro
de cachimbo e pé no chão
Segura a pemba
riscaponto, faz mironga
saravá Maria conga
saravá meu pai João
/////////////////
Chorar, chorar, chorei
cantar, cantar, cantei
Preto velho senta no toco
filhode pemba não bambeia
procurei nos quatro cantos
só pra ver se tem areia
////////////////
Que preto é esse, calunga
que chegou agora, o calunga
é pai Joaquim, o calunga
que veio de Angola, calunga$c67e34a560dfcc5fb25594e6020192d3c$, NULL, now()),
('dcee3e98-5604-c9a3-a52e-5dc23b7df8a0', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tdcee3e985604c9a3a52e5dc23b7df8a0$Preto Velho - Pai José Mineiro - Aruanda$tdcee3e985604c9a3a52e5dc23b7df8a0$, $cdcee3e985604c9a3a52e5dc23b7df8a0$Que preto é esse que carreava boi
que preto é esse que vem de Minas Gerais
Que preto é esse que trabalhava o dia inteiro
mas ele é pai José Mineiro
O sofrimento que esse velhinho passava
ninguém nunca vai saber
mas a cada chicotada que pai José levava
elenão chorava, ele só rezava
Aruanda, Aruanda
Aruanda que dia isso vai terminar
Aruanda, Aruanda,
Aruandavenha me ajudar
Ao treze de maio sua prece foi ouvida
paiJosé Mineiro nunca mais foi sofredor
agora elevem trabalhar na Umbanda
e hoje faz parte de Aruanda
Aruanda, Aruanda,
Aruanda, cativeiro acabou
Aruanda, Aruanda
Aruanda, viva Deus nosso senhor$cdcee3e985604c9a3a52e5dc23b7df8a0$, NULL, now()),
('9cd918d0-180f-0355-9af9-1e5e3be4674f', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t9cd918d0180f03559af91e5e3be4674f$Preto Velho - Luanda$t9cd918d0180f03559af91e5e3be4674f$, $c9cd918d0180f03559af91e5e3be4674f$êLuanda...
Terra da magia, do batuque e do canjerê
eu vou chamar Vovô,
eu vou chamar Vovó$c9cd918d0180f03559af91e5e3be4674f$, NULL, now()),
('e367b282-652d-3c60-606d-e20918d3a345', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $te367b282652d3c60606de20918d3a345$Preto Velho - Navio negreiro$te367b282652d3c60606de20918d3a345$, $ce367b282652d3c60606de20918d3a345$Navio negreiro vem beirando o mar
trazendo os africanos para trabalhar
Saravá povo de Umbanda
negro abre sua giraem qualquer lugar$ce367b282652d3c60606de20918d3a345$, NULL, now()),
('cbaf9464-37b4-5acb-ce9b-ffc4ced98634', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tcbaf946437b45acbce9bffc4ced98634$Preta Velha - Maria do Rosário - O galo cantou$tcbaf946437b45acbce9bffc4ced98634$, $ccbaf946437b45acbce9bffc4ced98634$O galo cantou
quando jesus nasceu
mas também, ele cantou
quando Maria do Rosário aqui chegou
vivaaleluia,viva aleluia
vivaaleluia e Maria do Rosário$ccbaf946437b45acbce9bffc4ced98634$, NULL, now()),
('c834cd40-f9e1-c9a2-d9a7-7e98374a368c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc834cd40f9e1c9a2d9a77e98374a368c$Preta Velha - Vó Toninha$tc834cd40f9e1c9a2d9a77e98374a368c$, $cc834cd40f9e1c9a2d9a77e98374a368c$auê, auê, auê Vovó
Vó Toninha vem de Minas
vem pra desatar o nó
essa velha mandingueira
chega com seu patuá
na sacola trás apemba
para seu ponto riscar
sua bengala tem magia
sua reza tem poder
vovó corta as demandas
quem duvida venha ver!
fuma cigarro de palha
com galinho de arruda na mão
muitos filhoslhe consultam
erecebem sua proteção
atabaque firma a gira
batam palmas e vamos cantar
Vó Toninha se levanta
sorridentepra dançar$cc834cd40f9e1c9a2d9a77e98374a368c$, NULL, now()),
('1300151b-0f49-76ec-bf6b-70fbc6f2b694', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t1300151b0f4976ecbf6b70fbc6f2b694$Preta Velha - Nega Cambinda$t1300151b0f4976ecbf6b70fbc6f2b694$, $c1300151b0f4976ecbf6b70fbc6f2b694$Nega Cambinda
nega da costa do mar
nega da costa mina
filhade yalorixá
na macumba ê
na macumba á
negro canta, negro dança
na batida do tambor
negro bebe seu marafo
saravá seu protetor$c1300151b0f4976ecbf6b70fbc6f2b694$, NULL, now()),
('68152c8c-c05c-9adb-0c94-dd47db4dc3a6', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t68152c8cc05c9adb0c94dd47db4dc3a6$Preta Velha - Vovó Luiza$t68152c8cc05c9adb0c94dd47db4dc3a6$, $c68152c8cc05c9adb0c94dd47db4dc3a6$Cacurucaia, auê auê
Vovó Luiza, auê auê
Vovó Luiza quando vem láde Aruanda
trazendo pemba pra salvar filhode Umbanda
com sua saia carijóe de babado
trazendo um rosário sagrado$c68152c8cc05c9adb0c94dd47db4dc3a6$, NULL, now()),
('98f3dd7a-598e-e033-60b1-6224ba07a670', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t98f3dd7a598ee03360b16224ba07a670$Preto Velho - Clarão na mata$t98f3dd7a598ee03360b16224ba07a670$, $c98f3dd7a598ee03360b16224ba07a670$Deu um clarão na mata
eu pensava que era dia
mas era as almas, mas era as almas
mas era as almas e o rosário de Maria$c98f3dd7a598ee03360b16224ba07a670$, NULL, now()),
('4d106319-22c0-3878-ce76-9d71ab978b51', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4d10631922c03878ce769d71ab978b51$Preto Velho - Pai Joaquim - Pedido a Nzambi$t4d10631922c03878ce769d71ab978b51$, $c4d10631922c03878ce769d71ab978b51$Negro, gemia na senzala de dor
açoitepor dias e dias durou
seu lamento em noitesfriasecoou
com braços fortes,plantava mas não podia desfrutar
da riqueza que a terra tinhapra dar
osom das correntes,
melodias a lhe torturar
no céu, jánão percebia a lua brilhar
eo mar se calou ao vê-lo chorar
pedindo a Nzambi supremo
pra virlhe salvar
ómeu senhor
tenha piedade de mim, por favor!
elá do alto,uma luzbranca desceu
com a fortefé do negro
omilagre aconteceu
em Aruanda tem a liberdade que tantopedia
hoje elevem no terreirotrabalhar com alegria
Pai Joaquim de Angola,
libertoda escravidão
vem abençoar nossa banda
enos dar sua proteção$c4d10631922c03878ce769d71ab978b51$, NULL, now()),
('4f878d16-6234-d436-0b3f-71cd5b575c6b', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t4f878d166234d4360b3f71cd5b575c6b$Preto Velho - Lágrimas de um Preto Velho$t4f878d166234d4360b3f71cd5b575c6b$, $c4f878d166234d4360b3f71cd5b575c6b$As lágrimas, de um Preto Velho
correm nos ólhos, mas vem do coração
Cada lágrima é a dor de um filhoseu
eo sem pranto é um manto de perdão
Preto velho já foimoço já sofreu
na féde Zambi ele venceu a escravidão
Oh que beleza nossa Umbanda iluminada
tãodesprezada por sinhá e por sinhor
mas nossa Umbanda cada vez ficamais linda
com os conselhos da Vovó e do Vovô
mas nossa Umbanda cada vez ficamais linda
com os conselhos da Vovó e do Vovô$c4f878d166234d4360b3f71cd5b575c6b$, NULL, now()),
('2f5d32af-3926-0e7e-0c5f-7fd99282a388', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t2f5d32af39260e7e0c5f7fd99282a388$Preto Velho - Negra Cambinda$t2f5d32af39260e7e0c5f7fd99282a388$, $c2f5d32af39260e7e0c5f7fd99282a388$Nega Cambinda, nega da costa do mar
nega da costa mina, filhade yalorixá
na macumba ê,na macumba á
negro canta, negro dança, na batida do tambor
negro bebe seu marafo, saravá seu protetor$c2f5d32af39260e7e0c5f7fd99282a388$, NULL, now()),
('980ab232-3748-b71a-15d0-b3eb3b777124', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t980ab2323748b71a15d0b3eb3b777124$Preta velha Feiticeira$t980ab2323748b71a15d0b3eb3b777124$, $c980ab2323748b71a15d0b3eb3b777124$ôbaiana, ô baiana
Preta velha feiticeira
com seu punhal na cinta desafia
com seu marafo do lado ela sorria
com o seu chapéu de palha
seu azeitede dendê
sua pimenta malagueta sinhá dona
vem fazer seu canjerê
que zoa, que zoa, que zoa$c980ab2323748b71a15d0b3eb3b777124$, NULL, now()),
('9efec11d-9596-0249-18df-420817b3fc5d', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t9efec11d9596024918df420817b3fc5d$Preto Velho - Linda senzala / O batuque não pode parar$t9efec11d9596024918df420817b3fc5d$, $c9efec11d9596024918df420817b3fc5d$òsenzala, ò que lindasenzala
de angola ê êê, de angola a aa
Preto velho chegou da Bahia
obatuque não pode parar
eletrás seu colarde missanga
ea guia de pai Oxalá
ôôô...o batuque não pode parar
ôôô ...firmaa girade pai Oxalá$c9efec11d9596024918df420817b3fc5d$, NULL, now()),
('c46882b8-fbc7-845d-8fb9-179a1dab5e92', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc46882b8fbc7845d8fb9179a1dab5e92$Preto Velho - Arreia Kongo$tc46882b8fbc7845d8fb9179a1dab5e92$, $cc46882b8fbc7845d8fb9179a1dab5e92$Arreiakongo, arreiakongo
arreiakongo, chama Preto Velho para trabalhar
se aUmbanda lhechama é kongo ê
se aUmbanda lhechama é kongo á
se aUmbanda lhechama
chama Preto Velho para trabalhar$cc46882b8fbc7845d8fb9179a1dab5e92$, NULL, now()),
('2d8a8d3e-74cb-98bc-cb69-e9b419817adf', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t2d8a8d3e74cb98bccb69e9b419817adf$Preto Velho - Estava dormindo, cambinda me chamou$t2d8a8d3e74cb98bccb69e9b419817adf$, $c2d8a8d3e74cb98bccb69e9b419817adf$estava dormindo
Cambinda me chamou [2x]
acorda meu nego
ocativeiroacabou [2x]$c2d8a8d3e74cb98bccb69e9b419817adf$, NULL, now()),
('7576d946-a3c0-b0aa-feaf-7ad820a40479', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t7576d946a3c0b0aafeaf7ad820a40479$Preto Velho - Vovó Maria Redonda$t7576d946a3c0b0aafeaf7ad820a40479$, $c7576d946a3c0b0aafeaf7ad820a40479$oh lavem ela
arrastando sua chinela
aventaltodo branco
ea colher de pau na mao
elaé cozinheira
elaé mucamba
éMaria Redonda
que segura a nossa banda [2x]$c7576d946a3c0b0aafeaf7ad820a40479$, NULL, now()),
('71be0b1d-c485-d83c-5eff-bb0eeb629e65', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t71be0b1dc485d83c5effbb0eeb629e65$Preto Velho - Preto Velho não vai a cidade$t71be0b1dc485d83c5effbb0eeb629e65$, $c71be0b1dc485d83c5effbb0eeb629e65$Preto velho não vaia cidade porque
anda devagar [2x]
anda devagar
édevagarinho
anda devagar
Preto velho édevagarinho [2x]$c71be0b1dc485d83c5effbb0eeb629e65$, NULL, now()),
('15d8b37b-98b6-4696-0b3b-cca995a17022', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t15d8b37b98b646960b3bcca995a17022$Preto Velho - Lá vem vovó descendo a serra$t15d8b37b98b646960b3bcca995a17022$, $c15d8b37b98b646960b3bcca995a17022$lávem vovó
descendo a serra com a sua sacola
vem com seu patúa
vem com a sua mandinga
elavem de Angola [2x]
eu quero ver vovó
eu quero ver
eu quero ver
se filhodepemba tem querer [2x]$c15d8b37b98b646960b3bcca995a17022$, NULL, now()),
('6bd81bec-d25e-4456-ad11-affba4550b7b', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6bd81becd25e4456ad11affba4550b7b$Preto Velho - Vovó Catarina de Angola$t6bd81becd25e4456ad11affba4550b7b$, $c6bd81becd25e4456ad11affba4550b7b$ecoou
um canto vindo de longe ecoou [2x]
em um lindodia
uma luzno céu brilhou
com a estrela guia
iluminada chegou
apreta velha de Aruanda luzdivina
recebeu de Oxalá o nome de Catarina [2x]
élua cheia
élua nova
louvada seja
vovó Catarina de Angola [2x]
Preto Velho - Minhas Almas$c6bd81becd25e4456ad11affba4550b7b$, NULL, now()),
('c64df3aa-50dd-4474-9510-8cb56606eac5', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tc64df3aa50dd447495108cb56606eac5$Página 62de 65$tc64df3aa50dd447495108cb56606eac5$, $cc64df3aa50dd447495108cb56606eac5$minhas Almas
Santas Almas
olha a minha oração [2x]
olha minhas Santas Almas
olha minha oração [2x]
eu louvei louvei
eu louvei ao senhor
eu louvei as terras
de São Salvador$cc64df3aa50dd447495108cb56606eac5$, NULL, now()),
('6605d82b-96d9-e1d7-8627-6ca33173d5e8', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t6605d82b96d9e1d786276ca33173d5e8$Preto Velho - Vovó Maria Benta$t6605d82b96d9e1d786276ca33173d5e8$, $c6605d82b96d9e1d786276ca33173d5e8$com o seu cachimbo
ea pemba na mão [2x]
essa preta velha africana
tem bom coração [2x]
sentada no seu toco
ninguém sabe a força que elatem
mas elaé Maria Benta
que na umbanda nunca fez mal a ninguém [2x]$c6605d82b96d9e1d786276ca33173d5e8$, NULL, now()),
('facc7a03-bb63-68b9-970f-5c721d870b7e', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tfacc7a03bb6368b9970f5c721d870b7e$Preto Velho - Lamentos de Preto Velho$tfacc7a03bb6368b9970f5c721d870b7e$, $cfacc7a03bb6368b9970f5c721d870b7e$iêiê
iêiá
iêiê
iêiê
iêiá
amuito tempo se ouvia
um lamentar de dor
chorava cativeiro
não bate meu senhor
iêiê
iêiá
iêiê
iêiê
iêiá
hoje trássua mironga
épra proteger
épra nos defender
chamamos de pretos-velhos
trásseu rosário pra benzer
iêiê
iêiá
iêiê
iêiê
iêiá
foiZambi quem mandou
mandou eu trabalhar oh [2x]
não chora mais cativeiro
negro não vai mais chorar
iêiê
iêiá
iêiê
iêiê
iêiá$cfacc7a03bb6368b9970f5c721d870b7e$, NULL, now()),
('ad2545fd-94b0-07fb-1a91-151222f6023c', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tad2545fd94b007fb1a91151222f6023c$Preto Velho - Tanto sofrimento$tad2545fd94b007fb1a91151222f6023c$, $cad2545fd94b007fb1a91151222f6023c$Cansado de tanto sofrimento
da minha cruz carregar
subi láno morro do cruzeiro
eu fuipedir ao pai pra trocar
aminha que era leve eu deixeina subida
echegando láem cima
comecei a procurar
mas só havia
mais pesada e mais sofrida
conformado e arrependido
com a maior eu vou voltar$cad2545fd94b007fb1a91151222f6023c$, NULL, now()),
('5008ad61-1fab-cc16-9ffb-fd9055947a45', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t5008ad611fabcc169ffbfd9055947a45$Preto Velho - Vovó Eufrázia$t5008ad611fabcc169ffbfd9055947a45$, $c5008ad611fabcc169ffbfd9055947a45$Ela vem do cruzeiro das almas
évovó Eufrázia trazendo mironga
elavem saravar na umbanda
évovó Eufrázia fazendo mironga
elavem, vem saravar
évovó Eufrázia , veio mirongar
elaveio saravar na umbanda
évovó Eufrázia, trazendo mironga$c5008ad611fabcc169ffbfd9055947a45$, NULL, now()),
('70047c7c-575b-ff7c-30a0-1fca4113e389', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $t70047c7c575bff7c30a01fca4113e389$Preto Velho - Construi uma casa tão linda$t70047c7c575bff7c30a01fca4113e389$, $c70047c7c575bff7c30a01fca4113e389$Eu construí uma casa tão linda
com tijolo,cimento e vergalhão [2x]
mas bateu chuva , bateu vendo
ejogou minha casa no chão [2x]
Preto-velho me ensina
oque eu tenho que fazer
poiso vento não derruba
vossa casa de sapê [2x]
oh tem dendê , tem dendê
Preto-velho tem dendê
na sua casa de sapê$c70047c7c575bff7c30a01fca4113e389$, NULL, now()),
('ff36957b-190e-6c95-c73c-173599c72d4e', '1133e4d7-5f35-9e21-9c76-9518b0c3488e', $tff36957b190e6c95c73c173599c72d4e$Preto Velho - Nego velho chegou$tff36957b190e6c95c73c173599c72d4e$, $cff36957b190e6c95c73c173599c72d4e$Preto velho chegou aqui
Preto velho chegou do mar
Preto velho tráza canoa, preto velho
que eu vou remar
ah preto velho
que eu vou remar, ahhh preto velho$cff36957b190e6c95c73c173599c72d4e$, NULL, now()),
('d7a3031f-dbed-b2bd-3b1f-ae4f10792cb8', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $td7a3031fdbedb2bd3b1fae4f10792cb8$Xangô -Trovejou lá no céu$td7a3031fdbedb2bd3b1fae4f10792cb8$, $cd7a3031fdbedb2bd3b1fae4f10792cb8$Trovejou láno céu e o mundo balanceou - 2x
Ó Cristo,o mundo balanceou -2x
Só não balanceou
A coroa de Xangô - 2x$cd7a3031fdbedb2bd3b1fae4f10792cb8$, NULL, now()),
('e2f567d5-78e4-770d-237d-abaa71fe1792', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $te2f567d578e4770d237dabaa71fe1792$Xangô Mora Nas Pedreiras$te2f567d578e4770d237dabaa71fe1792$, $ce2f567d578e4770d237dabaa71fe1792$Xangô ô ôô ô ô -2x
Meu Pai,Xangô
Xangô mora nas pedreiras
Quem manda relampear
Kaô Kabecilê meu Pai
Vamos todos saravá -2x
Xangô ô ôô ô ô -2x
Meu Pai,Xangô$ce2f567d578e4770d237dabaa71fe1792$, NULL, now()),
('28838a72-a884-9929-d632-522be55181f4', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t28838a72a8849929d632522be55181f4$Xangô, meu pai na Umbanda$t28838a72a8849929d632522be55181f4$, $c28838a72a8849929d632522be55181f4$Xangô, meu pai na Umbanda
Vem de Aruanda, eleé meu orixá
No altode uma pedreira
Elefaz justiçapra seus filhosajudar (2x)
Xangô na sua aldeia
Não há maldade, só o amor pode reinar
Tu me ensinaste a fazera caridade
E pela terra,aUmbanda exaltar
Meu paicom sua machada
Elenão ataca, ésó para me guardar
E no seu livroeleescreve o meu destino
Meu paiXangô ilumina meus caminhos
Eleé Xangô, Kaô Kaô
Vencedor de demandas ele é meu protetor
Eleé Xangô, Kaô Kaô
Vencedor de demandas ele é meu protetor
O Raio de Xangô$c28838a72a8849929d632522be55181f4$, NULL, now()),
('a2546f72-77bf-c01b-ad83-a480ee173969', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $ta2546f7277bfc01bad83a480ee173969$Página 1de 31$ta2546f7277bfc01bad83a480ee173969$, $ca2546f7277bfc01bad83a480ee173969$Quando a justiçaé divina
Forte é o brado de Xangô
Hoje seu Machado me ilumina
Sambará, Alafim, seu Agodô
2x
O raio caiu forte,fez fogueira
Foi o brado de Xangô no altoda pedreira
Livrona mão, filhosde pé
Peço justiça,proteção, Axé
2x
Bato no peito porque a pedra rolou
Caô Cabecile, Pai Xangô!$ca2546f7277bfc01bad83a480ee173969$, NULL, now()),
('95ab237b-b5ee-055f-2225-3c8e0922569c', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t95ab237bb5ee055f22253c8e0922569c$Xangô - Braço forte$t95ab237bb5ee055f22253c8e0922569c$, $c95ab237bb5ee055f22253c8e0922569c$Vejam que pedreira linda
é a morada de meu pai Xangô
eleé o rei da justiça
meu pai de fé,meu protetor
quando me encontro perdido
a eleeu peço sua proteção
sintologo um grande alívio
e lherezo firme uma oração
sintologo um grande alívio
e lherezo firme uma oração
Ele é meu pai, é meu senhor
é meu braço forte,é meu pai Xangô
Ele é meu pai, é meu senhor
é meu braço forte,é meu pai Xangô
Uma oferenda eu faço
levo na pedreira para lhe ofertar
um buquê de líriosbrancos
e uma gamela com seu amalá
peço paz para a humanidade
e que todos possam se encontrar
esse é o pedido que faço
ao meu pai de fé, Xangô Ayrá
esse é o pedido que faço
ao meu pai de fé, Xangô Ayrá
eleé meu pai,é meu senhor
é meu braço forte,é meu pai xangô
Ele é meu pai, é meu senhor
é meu braço forte,é meu pai Xangô
Saravá Xangô$c95ab237bb5ee055f22253c8e0922569c$, NULL, now()),
('e25d4af4-7cf9-85dc-2744-9f7632df1088', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $te25d4af47cf985dc27449f7632df1088$Página2de 31$te25d4af47cf985dc27449f7632df1088$, $ce25d4af47cf985dc27449f7632df1088$Saravá Xangô
Saravá Xangô
Saravá Xangô
Meu pai kaô
Meu pai kaô (2x)
Hoje eu vim saudar meu protetor
Vim bater minha cabeça
E cantar em seu louvor...
Ôôôô
Saravá o grande justiceiro
Ó meu pai, meu padroeiro
Venha me abençoar...
Saravá Xangô
Saravá Xangô
Saravá Xangô
Meu pai kaô
Meu pai kaô (2x)$ce25d4af47cf985dc27449f7632df1088$, NULL, now()),
('f6b9e6b3-cf9e-44aa-5bbb-986c164e1b4a', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tf6b9e6b3cf9e44aa5bbb986c164e1b4a$Xangô - Meu protetor$tf6b9e6b3cf9e44aa5bbb986c164e1b4a$, $cf6b9e6b3cf9e44aa5bbb986c164e1b4a$A terratremeu
Eu vio céu trovejar
Um brado forte ecoou lána pedreira
Vem trazendo o justiceiroda nação nagô
Um brado forte ecoou lána pedreira
Vem trazer meu padroeiro saravá Xangô
Ó grande Obá
Opanixé Kaô
Bato cabeça pra saudar meu protetor
Ojuobá, maleme meu senhor
Que sua machada tirea minha aflição
Guie o meu coração
Nos caminhos que eu passar (2x)
Obá Ko so kaô, kaô, kaô
Meu Orixá de fé
Tu és a leida terra
Nos deixe seu axé (2x)$cf6b9e6b3cf9e44aa5bbb986c164e1b4a$, NULL, now()),
('cd17b07d-9209-e013-91e1-b3b569199f69', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tcd17b07d9209e01391e1b3b569199f69$Xangô - Rei de Oyó$tcd17b07d9209e01391e1b3b569199f69$, $ccd17b07d9209e01391e1b3b569199f69$Xangô, e Xangô
Não deixa seu filhotombar
Com a sua machada vem me abençoar (2x)
Ouvi um brado
Lá do altoda pedreira
Uma luz que irradia
Vinda lá de Aruanda
A água
Que desce da cachoeira
Traz o homem que me guia
Pra saudar a nossa banda (2x)
Kaô Xangô
Salve o Deus do trovão
Saravá o reide Oyó
Dono do meu coração
Traga a sua justiça
Me livredos inimigos
Tirea minha aflição...
Xangô, e Xangô
Não deixa seu filhotombar
Com a sua machada vem me abençoar (2x)$ccd17b07d9209e01391e1b3b569199f69$, NULL, now()),
('73a120a5-04de-56b1-3e41-3147bd186fb3', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t73a120a504de56b13e413147bd186fb3$Xangô - Pedreira de Xangô$t73a120a504de56b13e413147bd186fb3$, $c73a120a504de56b13e413147bd186fb3$Rolou uma pedra na pedreira
Pedreira de meu pai Xangô (2x)
Rei da justiça
O senhor da tempestade
O seu lema é a verdade
Caridade e muito amor... Ôôôô
Ilumine o meu caminho
Não me deixe andar sozinho
Faça a pedra virarflor...$c73a120a504de56b13e413147bd186fb3$, NULL, now()),
('f69e3f38-fef6-d94a-3dd2-aa9a20631dbe', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tf69e3f38fef6d94a3dd2aa9a20631dbe$Meu pai Xangô$tf69e3f38fef6d94a3dd2aa9a20631dbe$, $cf69e3f38fef6d94a3dd2aa9a20631dbe$No alto da pedreira eu vipedra rolar
no centro da mata ouvi trovão roncar
caô, caô
eleé meu paiXangô
caô, caô
eleé meu paiXangô
um raio de fogo surgiu
etudo iluminou
então ao meu pai pedi
vitórianos caminhos que vou
Xangô senhor da verdade
que faz justiçaem nossa terra
com seu machado destróio mal
trazendo a paz, findando a guerra
caô, caô
eleé meu pai Xangô
caô, caô
eleé meu pai Xangô$cf69e3f38fef6d94a3dd2aa9a20631dbe$, NULL, now()),
('4b6d836e-241b-72a6-1a31-febdc807d9cd', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t4b6d836e241b72a61a31febdc807d9cd$Xangô é rei$t4b6d836e241b72a61a31febdc807d9cd$, $c4b6d836e241b72a61a31febdc807d9cd$Xangô é rei
Eleé rei de Nagô
Oh batam palmas pra coroa de Xangô$c4b6d836e241b72a61a31febdc807d9cd$, NULL, now()),
('e0d8a158-36b2-5e81-5f83-4d1bda58b767', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $te0d8a15836b25e815f834d1bda58b767$Xangô na pedra sentado$te0d8a15836b25e815f834d1bda58b767$, $ce0d8a15836b25e815f834d1bda58b767$Oh que estrelatão linda
que brilhano firmamento
Xangô na pedra sentado
vaiescrevendo e vailendo
Kaô kabecile, kaô ka
Kaô kabecile, kaô ka
Kaô kabecile, kaô ka
Kaô kabecile, kaô ka
Para seu filhoele ensina
com muito amor e bondade
Que avida não vale nada
se não se faz caridade
Kaô kabecile, kaô ka
Kaô kabecile, kaô ka
Kaô kabecile, kaô ka
Kaô kabecile, kaô ka$ce0d8a15836b25e815f834d1bda58b767$, NULL, now()),
('b0c1f609-b75c-51d1-12cd-98ebc90cc7a1', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tb0c1f609b75c51d112cd98ebc90cc7a1$Xangô - Que mata é essa que o leão não entra$tb0c1f609b75c51d112cd98ebc90cc7a1$, $cb0c1f609b75c51d112cd98ebc90cc7a1$Que mata é essa que o leão não entra
Que pau é esse que o machado não arrebenta
Que pedra é essa que o corisco não cortou
éa pedreira de meu pai Xangô
Que pedra é essa que o corisco não cortou
éa pedreira de meu pai Xangô$cb0c1f609b75c51d112cd98ebc90cc7a1$, NULL, now()),
('2e7c771e-c460-36b3-4742-3cc5a05bd251', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t2e7c771ec46036b347423cc5a05bd251$A morada de Xangô Airá$t2e7c771ec46036b347423cc5a05bd251$, $c2e7c771ec46036b347423cc5a05bd251$Em cima da serra
tem outra serra
tem outra serra onde ninguém vailá
Em cima da serra
tem outra serra
tem outra serra onde ninguém vailá
éa morada de Xangô Airá,
éa morada de Xangô Airá
éa morada de Xangô Airá,
éa morada de Xangô Airá$c2e7c771ec46036b347423cc5a05bd251$, NULL, now()),
('3eb53468-3405-9a5a-f6be-ea31b1b4fca5', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t3eb5346834059a5af6beea31b1b4fca5$Xangô - No alto daquela pedreira$t3eb5346834059a5af6beea31b1b4fca5$, $c3eb5346834059a5af6beea31b1b4fca5$No alto daquela pedreira
tem um lírioque é de Xangô
No alto daquela pedreira
tem um lírioque é de Xangô
kaô, kaô, kaô kabiecilê$c3eb5346834059a5af6beea31b1b4fca5$, NULL, now()),
('f1efd3fe-c878-c337-5d9b-61d53a8e6386', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tf1efd3fec878c3375d9b61d53a8e6386$Xangô - Por detrás daquela serra$tf1efd3fec878c3375d9b61d53a8e6386$, $cf1efd3fec878c3375d9b61d53a8e6386$Por detrás daquela serra
Tem uma linda cachoeira
Por detrás daquela serra
Tem uma linda cachoeira
éde meu Pai Xangô
que arrebentou sete pedreiras
éde meu Pai Xangô
que arrebentou sete pedreiras
Foiágua nascendo na fonte e espinho na flor
Do seu medo escondido nasceu a coragem de ser vencedor
Punhal na mão, no peito um escudo mais fiel
De quem na terraconcebeu o céu
São sete pedreiras que ele aprendeu a quebrar
Na faísca da furia,no raio da chuva à luz do luar
Lavou ocorpo com o vinho amargo do suor
E fezdo proprio bem, de todos os males, talvez o menor
Por detrás daquela serra
Tem uma lindacachoeira
Por detrás daquela serra
Tem uma lindacachoeira
éde meu Pai Xangô
que arrebentou sete pedreiras
éde meu Pai Xangô
que arrebentou sete pedreiras$cf1efd3fec878c3375d9b61d53a8e6386$, NULL, now()),
('080f9c25-e4db-a040-11b2-c649e0ded014', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t080f9c25e4dba04011b2c649e0ded014$Meu Pai São João Batista é Xangô$t080f9c25e4dba04011b2c649e0ded014$, $c080f9c25e4dba04011b2c649e0ded014$Meu Pai São João Batista éXangô
édono do meu destino até o fim
Meu Pai São João Batista éXangô
édono do meu destino até o fim
Se um diame faltar,a féem meu senhor
que roleessas pedreiras sobre mim
Se um diame faltar,a féem meu senhor
que roleessas pedreiras sobre mim$c080f9c25e4dba04011b2c649e0ded014$, NULL, now()),
('989f9da7-2fb4-937d-85f2-d7a7c7c44635', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t989f9da72fb4937d85f2d7a7c7c44635$Xangô - Estava dormindo sobre a pedra$t989f9da72fb4937d85f2d7a7c7c44635$, $c989f9da72fb4937d85f2d7a7c7c44635$Estava dormindo sobre a pedra
quando a Umbanda lhe chamou
Estava dormindo sobre a pedra
quando a Umbanda lhe chamou
Acorda, que já hora
evem ouvir o lindobrado de Xangô
Acorda, que já hora
evem ouvir o lindobrado de Xangô$c989f9da72fb4937d85f2d7a7c7c44635$, NULL, now()),
('51863ada-7a45-35ef-4439-1d9659d4b028', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t51863ada7a4535ef44391d9659d4b028$Xangô - Deixa essa pedreira aí$t51863ada7a4535ef44391d9659d4b028$, $c51863ada7a4535ef44391d9659d4b028$Xangô meu Pai
deixa essa pedreira aí
Xangô meu Pai
deixa essa pedreira aí
Umbanda ta lhechamando
deixa essa pedreira aí
Umbanda ta lhechamando
deixa essa pedreira aí$c51863ada7a4535ef44391d9659d4b028$, NULL, now()),
('c99fc707-8b8c-f0d9-0486-0f037700c7f3', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tc99fc7078b8cf0d904860f037700c7f3$Xangô - Seu Alafin Seu Agodô$tc99fc7078b8cf0d904860f037700c7f3$, $cc99fc7078b8cf0d904860f037700c7f3$Pega o seu livroe vai ler
pega na pena vaiescrever
Pega o seu livroe vai ler
pega na pena vaiescrever
kaô , kaô
saravá na Umbanda seu Alafin seu Agodô
kaô , kaô
saravá na Umbanda seu Alafin seu Agodô$cc99fc7078b8cf0d904860f037700c7f3$, NULL, now()),
('475c34be-1600-2460-9fca-403ec4681c56', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t475c34be160024609fca403ec4681c56$Xangô - A força da Machada$t475c34be160024609fca403ec4681c56$, $c475c34be160024609fca403ec4681c56$Na beira do rio
Ouvi sabiá cantar
Na beira do rio
Ouvi sabiá cantar
Era Pai Xangô
Lá do alto da pedreira
Soltou o seu bradar
Me deu o equilíbrio
Pra minha vida então andar
Soltou o seu bradar
Me deu o equilíbrio
Pra minha vida então andar
Era Pai Xangô
Lá do alto da pedreira
Soltou o seu bradar
Me deu o equilíbrio
Pra minha vida então andar
Soltou o seu bradar
Me deu o equilíbrio
Pra minha vida então andar
Com sua força e justiça
Equilibrao meu caminhar
Me dá a mão meu Pai
Pra que a forçada machada
Eu possa aqui ganhar
Com sua força e justiça
Equilibrao meu caminhar
Me dá a mão meu Pai
Pra que a força da machada
Eu possa aqui ganhar$c475c34be160024609fca403ec4681c56$, NULL, now()),
('a102128f-285e-0dc4-e8f2-f1a952ed060f', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $ta102128f285e0dc4e8f2f1a952ed060f$Xangô - Forças de Xangô$ta102128f285e0dc4e8f2f1a952ed060f$, $ca102128f285e0dc4e8f2f1a952ed060f$Salve seu Sete Pedreiras, saravá meu pai Xangô
Ele é o dono da justiça,a benção meu pai agô
Kaô Kaô Kaô meu pai
Oh lé lélé meu pai é reina Umbanda e no Candomblé
Salve Xangô nas pedreiras, salve o corisco e o trovão
Salve a pena dourada, salve a força do leão
Salve o céu, salve a terra,salve papai Oxalá
Salve a força do machado de meu paiXangô Ayrá$ca102128f285e0dc4e8f2f1a952ed060f$, NULL, now()),
('6e0f424a-2645-e7e6-2370-08bd8b11f640', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t6e0f424a2645e7e6237008bd8b11f640$Xangô Aganjú$t6e0f424a2645e7e6237008bd8b11f640$, $c6e0f424a2645e7e6237008bd8b11f640$Saravá velho São Pedro, ô kizoa
(Zoa, kizoa, zoá)
Com sua chave na mão, ô kizoa
(Zoa, kizoa, zoá)
Saravá velho São Pedro, ô kizoa
(Zoa, kizoa, zoá)
Com sua chave na mão, ô kizoa
(Zoa, kizoa, zoá)
Velho São Pedro
Tem a chave de Aruanda
É quem abre a porta do céu
E guia o pescador nas ondas
Lá no terreiroele é Xangô Aganju
Dia 29 de junho
Filhos de fé tedão louvor
Saravá velho São Pedro, ô kizoa
(Zoa, kizoa, zoá)
Com sua chave na mão, ô kizoa
(Zoa, kizoa, zoá)
Saravá velho São Pedro, ô kizoa
(Zoa, kizoa, zoá)
Com sua chave na mão, ô kizoa
(Zoa, kizoa, zoá)
Velho São Pedro
Tem a chave de Aruanda
É quem abre a porta do céu
E guia o pescador nas ondas
Lá no terreiroele é Xangô Aganju
Dia 29 de junho
Filhos de fé tedão louvor
Saravá velho São Pedro, ô kizoa
(Zoa, kizoa, zoá)
Com sua chave na mão, ô kizoa
(Zoa, kizoa, zoá)
Saravá velho São Pedro, ô kizoa
(Zoa, kizoa, zoá)
Com sua chave na mão, ô kizoa
(Zoa, kizoa, zoá)$c6e0f424a2645e7e6237008bd8b11f640$, NULL, now()),
('3ee2b175-bfa8-4359-2b25-699e6f246207', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t3ee2b175bfa843592b25699e6f246207$Xangô - Xangô Agodô$t3ee2b175bfa843592b25699e6f246207$, $c3ee2b175bfa843592b25699e6f246207$Xangô, kaô...
Maleme, meu Pai Xangô...
Ô, maleme ê,ô maleme á
Kaô Cabecile, obá!
Ô maleme ê, ô maleme á
Kaô kabecile, obá!
Ô maleme ê, ô maleme á
Kaô kabecile, obá!
É Xangô de agodô
Alafie sambará
Ele vem na nossa banda, kaô Kabecile obá
Ô maleme ê, ô maleme á
Kaô Kabecile, obá!
Ô maleme ê, ô maleme á
Kaô Kabecile, obá!
Vou pedir a Pai Xangô
Para ele me ajudar
Dá maleme nesta banda
Kaô Kabecile obá!
Ô maleme ê, ô maleme á
Kaô kabecile, obá!
Ô maleme ê, ô maleme á
Kaô kabecile, obá!
Ele veio de tão longe
Nesta banda saravar
Ele veio da pedreira
Kaô cabecile obá
Ô maleme ê, ô maleme á
Kaô cabecile, obá!
Ô maleme ê, ô maleme á
Kaô cabecile, obá!
Ele é meu Pai Xangô
Ele é chefe de gongá
Firma ponto nesta banda
Kaô Kabecile, obá!
Ô maleme ê, ô maleme á
Kaô Kabecile, obá!
Ô maleme ê, ô maleme á
Kaô Kabecile, obá!
Xangô, kaô…
Maleme, meu Pai Xangô!
Xangô, kaô…
Maleme... meu Pai Xangô$c3ee2b175bfa843592b25699e6f246207$, NULL, now()),
('20f5480b-8fcc-580c-0726-077ecc403c3d', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t20f5480b8fcc580c0726077ecc403c3d$Xangô - Pedra Rolou$t20f5480b8fcc580c0726077ecc403c3d$, $c20f5480b8fcc580c0726077ecc403c3d$Pedra rolou, Pai Xangô
Lá na pedreira
Segura a pedra meu Pai
Na cachoeira
Pedra rolou Pai Xangô
Lá na pedreira
Segura a pedra meu Pai
Na cachoeira
Tenho meu corpo fechado
Xangô é meu protetor
Segura a pemba meu filho
Pai de cabeça chegou
Tenho meu corpo fechado
Xangô é meu protetor
Segura a pemba meu filho
Pai de cabeça chegou$c20f5480b8fcc580c0726077ecc403c3d$, NULL, now()),
('a60a6550-1765-5008-98d4-15c36997f67e', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $ta60a65501765500898d415c36997f67e$Xangô - Meu Pai Xangô$ta60a65501765500898d415c36997f67e$, $ca60a65501765500898d415c36997f67e$Meu pai,teu maleme eu peço agora
Me ajude a mandar essa dor embora
Meu pai,teu maleme eu peço agora
Me ajude a mandar essa dor embora
Por caminhos ocultos andei
E confesso, de time esqueci
Consequências dos erros paguei
E minha fémuitas vezes perdi
Tua justiçaentão me alcançou
Me mostrou qual caminho seguir
Caridade, bondade e amor
Foicontigo meu pai,que aprendi
Airá,Aganju, Alafim,Obaim ou Baru
Meu pai,Xangô!
Modé, Alufan, Agodô, Afonjá, Intilé
Meu pai,Xangôôôô…
Oh, Xangô, teu amor é o que me guia
Sem tua força, seique eu não conseguiria
Vou cantar e mandar pra todo o meu povo
A axé do meu pai,oh Senhor de Oyó!$ca60a65501765500898d415c36997f67e$, NULL, now()),
('1aad2518-67e7-414c-9d62-f865d8b37d33', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t1aad251867e7414c9d62f865d8b37d33$Xangô - Braço Forte$t1aad251867e7414c9d62f865d8b37d33$, $c1aad251867e7414c9d62f865d8b37d33$Vejam que pedreira linda
É a morada de meu pai Xangô
Ele é o reida justiça
Meu pai de fé,meu protetor
Quando eu me encontro perdido
A ele eu peço sua proteção
Sinto logo um grande alívio
E lhe rezo firme uma oração
Sinto logo um grande alívio
E lhe rezo firme uma oração
Ele é meu pai,é meu senhor
É meu braço forte,é meu pai Xangô
Ele é meu pai,é meu senhor
É meu braço forte,é meu pai Xangô
Uma oferenda eu faço
Levo na pedreira para lhe ofertar
Um buquê de líriosbrancos
E uma gamela com seu amalá
Peço paz para a humanidade
E que todos possam se encontrar
Esse é o pedido que faço
Ao meu pai de fé,Xangô Ayrá
Esse é o pedido que faço
Ao meu pai de fé,Xangô Ayrá
Ele é meu pai,é meu senhor
É meu braço forte,é meu pai Xangô
Ele é meu pai,é meu senhor$c1aad251867e7414c9d62f865d8b37d33$, NULL, now()),
('38a6759a-fc2f-8b76-241f-0b14453f735c', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t38a6759afc2f8b76241f0b14453f735c$Xangô Justiceiro$t38a6759afc2f8b76241f0b14453f735c$, $c38a6759afc2f8b76241f0b14453f735c$Ele mora na pedreira
Mas vem aqui no congá
Quase toda quarta-feira
Mandado por Oxalá
Quase toda quarta-feira
Mandado por Oxalá
Xangô é justiceiro
E veio de Aruanda
Baixar neste terreiro
Os filhosde Umbanda
Xangô é justiceiro
E veio de Aruanda
Baixar neste terreiro
Os filhosde Umbanda
Salve seus filhosde fé
Com o seu babalaô
Que jásabem como é
A justiçade Xangô
Ele mora na pedreira
Mas vem aqui no congá
Quase toda quarta-feira
Mandado por Oxalá$c38a6759afc2f8b76241f0b14453f735c$, NULL, now()),
('a2279b26-33b7-88d8-2894-28019ce450fa', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $ta2279b2633b788d8289428019ce450fa$Xangô - Altar pra Xangô$ta2279b2633b788d8289428019ce450fa$, $ca2279b2633b788d8289428019ce450fa$Hoje vou louvar meu pai e cantar com muito Amor
Das pedras que me lançaram, fizum altar pra Xangô
Hoje vou louvar meu pai e cantar com muito Amor
Das pedras que me lançaram, fizum altar pra Xangô
Seu machado traz justiça,corta o mau do meu caminho
Nunca me deixa sozinho e me dá forças pra lutar
Ele é o Rei da pedreira, pai do fogo da verdade
Que queima toda maldade , pra seus filhos ajudar
Hoje vou louvar meu pai e cantar com muito Amor
Das pedras que me lançaram, fizum altar pra Xangô
Hoje vou louvar meu pai e cantar com muito Amor
Das pedras que me lançaram, fizum altar pra Xangô
Seu machado traz justiça,corta o mau do meu caminho
Nunca me deixa sozinho e me dá forças pra lutar
Ele é o Rei da pedreira, Pai do fogo da verdade
Que queima toda maldade , pra seus filhos ajudar
Hoje vou louvar meu pai e cantar com muito Amor
Das pedras que me lançaram, fizum altar pra Xangô
Hoje vou louvar meu pai e cantar com muito Amor
Das pedras que me lançaram, fizum altar pra Xangô$ca2279b2633b788d8289428019ce450fa$, NULL, now()),
('40c4df07-5990-6cb2-77fb-5a7fd32e66cd', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t40c4df0759906cb277fb5a7fd32e66cd$Xangô - Gino da cobra coral$t40c4df0759906cb277fb5a7fd32e66cd$, $c40c4df0759906cb277fb5a7fd32e66cd$oGino, olha a sua banda
oGino, olha o seu gongá
Aonde o rouxinou cantava,
Aonde Xangô morava
Ele éGino da cobra coral
Ele éGino da cobra coral
Ele éGino da cobra coral,Kaô$c40c4df0759906cb277fb5a7fd32e66cd$, NULL, now()),
('291b8d7c-0bba-d473-f3cc-99b537b1b475', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t291b8d7c0bbad473f3cc99b537b1b475$Xangô - Oração$t291b8d7c0bbad473f3cc99b537b1b475$, $c291b8d7c0bbad473f3cc99b537b1b475$Meu pai,tu és reina Umbanda
O teu brado na pedreira é um trovão
A tieu clamo por justiça
Me ponho de joelhos, pra falarem oração
A tieu clamo por justiça
Me ponho de joelhos, pra falarem oração
Na terra os homens brigam por vaidade
Esquecem sua origem
Esquecem sua missão
De plantar na vida a caridade
Que é ocaminho da verdade, na Umbanda é redenção
Pois unidos somos bem mais fortes
Nós somos a voz de uma só nação
De paz amor ehumildade
Pra Xangô bato cabeça
Pedindo orientação
Kaô, Xangô
Xangô, Kaô
Me mostre o caminho pra eu cumprir minha missão
Kaô Xangô
Xangô, Kaô
Entrego minha vida e meu destino em tuas mãos$c291b8d7c0bbad473f3cc99b537b1b475$, NULL, now()),
('5094b4b2-42f3-7176-ae18-216f559ee655', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t5094b4b242f37176ae18216f559ee655$Xangô - Gameleira Branca$t5094b4b242f37176ae18216f559ee655$, $c5094b4b242f37176ae18216f559ee655$É de Xoroquê a porteira de entrada de Olorum de Dê
É de Xorocô a madeira sagrada de Xangô
É de Xoroquê a porteira de entrada de Olorum de Dê
É de Xorocô a madeira sagrada de Xangô
Pra quem tem licença a porteirado mundo nunca tranca
Pra quem tem a benção do dono da gameleira branca
Pra quem tem licença a porteirado mundo nunca tranca
Pra quem tem a benção do dono da gameleira branca
Bate na porteira, pará vaiabrir
Põe na gameleira, coral e cauri
Já deu na peneira de mãe Maceline e paiAurélio
É cajá de espada, ninguém passa ali
Essa é a minha estrada
Eu sei porque eu vi
Ela foiriscada na árvore do Xangô mais velho
É de Xoroquê a porteira de entrada de Olorum de Dê
É de Xorocô a madeira sagrada de Xangô
É de Xoroquê a porteirade entrada de Olorum de Dê
É de Xorocô a madeira sagrada de Xangô
Pra quem tem licença a porteira do mundo nunca tranca
Pra quem tem a benção do dono da gameleira branca
Pra quem tem licença a porteira do mundo nunca tranca
Pra quem tem a benção do dono da gameleira branca$c5094b4b242f37176ae18216f559ee655$, NULL, now()),
('f5123836-4e17-b09f-cca1-ec23e860f462', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tf51238364e17b09fcca1ec23e860f462$Xangô - Saudação a Xangô$tf51238364e17b09fcca1ec23e860f462$, $cf51238364e17b09fcca1ec23e860f462$Quando o Leão rugir
O Leão rugir
E o fortebrado eu escutar
De cima de um Otá
Pai Xangô já vem chegando
Ele vem chegando
Para leiexecutar
Na mão direita trazseu livroe seu Oxê
E na esquerda
Traz a pemba de Oxalá
Vem na Umbanda pra cruzar todos os seus filhos
Fazendo justiça com ordem de Orumilá
Quem planta o bem
Receberá lindos caminhos
Deste Orixá reida justiça verdadeira
Quem planta o mal
Pode esperar sua resposta
Meu Pai Xangô
Bacaô lána pedreira$cf51238364e17b09fcca1ec23e860f462$, NULL, now()),
('cf26a4da-63fb-279b-28f2-2820127968ba', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tcf26a4da63fb279b28f22820127968ba$Xangô - Lírio branco$tcf26a4da63fb279b28f22820127968ba$, $ccf26a4da63fb279b28f22820127968ba$Fuibuscar um líriobranco
Na pedreira de Xangô
Trouxe também outras flores
Que meu pai abençoou
Fuibuscar um líriobranco
Na pedreira de Xangô
Trouxe também outras flores
Que meu pai abençoou
Quem gostar de lindas flores
E ainda não achou
Vá buscá-las com carinho
Na linda primavera de meu paiXangô
Vá buscá-las com carinho
Na linda primavera de meu paiXangô
Fuibuscar um líriobranco
Na pedreira de Xangô
Trouxe também outras flores
Que meu pai abençoou
Fui buscar um líriobranco
Na pedreira de Xangô
Trouxe também outras flores
Que meu pai abençoou
Quem gostar de lindas flores
E ainda não achou
Vá buscá-las com carinho
Na linda primavera de meu pai Xangô
Vá buscá-las com carinho
Na linda primavera de meu pai Xangô$ccf26a4da63fb279b28f22820127968ba$, NULL, now()),
('9cd29b41-ff5f-6ba9-a743-3ea6d594399c', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t9cd29b41ff5f6ba9a7433ea6d594399c$Xangô - Sonho divino$t9cd29b41ff5f6ba9a7433ea6d594399c$, $c9cd29b41ff5f6ba9a7433ea6d594399c$Um dia eu tive um sonho
Que jamais me esqueci
Caminhava pelos montes
Sem saber onde ir
Rio,campos, cachoeiras
Até que encontrei
A pedreira mais bela
Que um dia eu avistei
Ao sentir sua energia
Então me emocionei
Pus os joelhos em terra
E logo saravei
Ao bater minha cabeça
E fazer uma oração
Do alto da pedreira
Surgiu o deus do trovão
Senhor do fogo
A benção, meu pai
Vim pedir o seu malei
Para não errar jamais
Senhor do fogo
A benção, meu pai
Vim pedir o seu malei
Para não errar jamais
Foi um belo sonho
Que guardo e sei de cór
Era o pai da justiça
Senhor Xangô, rei de Oyó
E por toda a minha vida
Cantarei em seu louvor
Pedindo misericórdia, proteção e o seu amor
Senhor do fogo
A benção, meu pai
Vim pedir o seu malei
Para não errar jamais
Senhor do fogo
A benção, meu pai
Vim pedir o seu malei
Para não errar jamais$c9cd29b41ff5f6ba9a7433ea6d594399c$, NULL, now()),
('a9cc85e9-a8bc-8f10-aad5-b61ccc16bf88', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $ta9cc85e9a8bc8f10aad5b61ccc16bf88$Xangô - Maleme$ta9cc85e9a8bc8f10aad5b61ccc16bf88$, $ca9cc85e9a8bc8f10aad5b61ccc16bf88$Se eu errei
Aqui estou
Pedindo maleme
Meu paiXangô
Se eu errei
Aqui estou
Pedindo maleme
Meu paiXangô
Mandai a faísca de um raio
Pra me iluminar
Segura pedra na pedreira
Não deixa rolar
Kaô, meu pai
Os seus filhosbambeiam
Mas não caem
Kaô, meu pai
Os seus filhosbambeiam
Mas não caem$ca9cc85e9a8bc8f10aad5b61ccc16bf88$, NULL, now()),
('08bafc45-8028-d79c-c48d-665daa94c2e7', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t08bafc458028d79cc48d665daa94c2e7$Xangô - Agodô vem com machado na mão$t08bafc458028d79cc48d665daa94c2e7$, $c08bafc458028d79cc48d665daa94c2e7$Xangô tem sua aldeia lána mata
Onde os Caboclos dançam ao som do trovão
É água sob a pedra na cascata
Quando vejo sua machada, bater um raiono chão
Rompe o silênciotrovoada
Pelo céu escuro faz clarão
Voa pelo ar a passarada
Pois o gritode Xangô é o rugido do leão
Agodô, Agodô vem com machado na mão
Reza fortefilhode Umbanda
Se merecer é sim
Sem merecer é não
Traz em seu braço direito,olivroda leipra justiça executar
Aide quem não obedecer, duvidar ou não crerda força desse Orixá
Lá no altodaquela pedreira
Vigiando a terra inteira
Olhando com atenção
Quem pensa que é brincadeira
Xangô faz a cachoeira, transformar-se em um vulcão
Agodô, Agodô vem com machado na mão
Reza fortefilhode Umbanda
Se merecer é sim
Sem merecer é não$c08bafc458028d79cc48d665daa94c2e7$, NULL, now()),
('b6784a32-4b6d-b110-4c61-ae6d1a278f77', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tb6784a324b6db1104c61ae6d1a278f77$Xangô - Mora nas pedreiras /Xangô é pai$tb6784a324b6db1104c61ae6d1a278f77$, $cb6784a324b6db1104c61ae6d1a278f77$Dizem que Xangô mora nas pedreiras
Mas não é lá sua morada verdadeira
Xangô mora na cidade de luz
Onde mora Nossa Senhora, Oxumarê e Jesus$cb6784a324b6db1104c61ae6d1a278f77$, NULL, now()),
('fd1fc486-9fb0-d263-0f10-83f2e534e604', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tfd1fc4869fb0d2630f1083f2e534e604$Xangô - Louvação a Xangô$tfd1fc4869fb0d2630f1083f2e534e604$, $cfd1fc4869fb0d2630f1083f2e534e604$No alto da sua pedreira
água minou
formou -se em cachoeira
onde seu filhose banhou
kaô, kaô meu pai Xangô
da sua pedreira, o seu filhocantou
em louvação aXangô
Ele cantou com alegria
cantou com fé e emoção
Ele cantou pro seu pai láda pedreira
com inspiração
kaô, kaô meu pai Xangô
da sua pedreira o seu filhocantou
em louvação aXangô$cfd1fc4869fb0d2630f1083f2e534e604$, NULL, now()),
('0d64b6b5-56b1-db43-16e1-209a7c141483', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t0d64b6b556b1db4316e1209a7c141483$Xangô - Dono do meu destino$t0d64b6b556b1db4316e1209a7c141483$, $c0d64b6b556b1db4316e1209a7c141483$Meu Pai São João Batista é Xangô
édono do meu destino até o fim
Se um dia me faltara féem meu senhor
que role esta pedreira sobre mim
Meu Pai Xangô chegou no reino
Meu Pai Xangô é Orixá
Se um dia me faltara féem meu senhor
que role esta pedreira sobre mim$c0d64b6b556b1db4316e1209a7c141483$, NULL, now()),
('7cd24fb8-5ea8-4ba5-8cb9-a0a79cff65fe', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t7cd24fb85ea84ba58cb9a0a79cff65fe$Xangô - Quem rola pedra na pedreira é Xangô$t7cd24fb85ea84ba58cb9a0a79cff65fe$, $c7cd24fb85ea84ba58cb9a0a79cff65fe$Quem rola pedra na pedreira é Xangô
Quem rola pedra na pedreira é Xangô
vibrouna coroa de Zambi
vibrouna coroa de Zambi
vibrouna coroa de Zambi
Kaô$c7cd24fb85ea84ba58cb9a0a79cff65fe$, NULL, now()),
('5feeb2cb-357f-7c0a-3611-329fa7d39091', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t5feeb2cb357f7c0a3611329fa7d39091$Xangô - Bate palma pra coroa de Xangô$t5feeb2cb357f7c0a3611329fa7d39091$, $c5feeb2cb357f7c0a3611329fa7d39091$Xangô é rei
eleé reide Nagô
Xangô é rei
eleé reide Nagô
Batam palmas pra coroa de Xangô [2x]$c5feeb2cb357f7c0a3611329fa7d39091$, NULL, now()),
('aad8dfdd-8503-aef4-b4a6-36483eaf2214', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $taad8dfdd8503aef4b4a636483eaf2214$Xangô - Oh Gino olha sua banda$taad8dfdd8503aef4b4a636483eaf2214$, $caad8dfdd8503aef4b4a636483eaf2214$Oh Gino
Olha a sua banda
Oh Gino
Olha o seu gongá
Aonde oroxinol cantava
Aonde Xangô morava
Aonde oroxinol cantava
Aonde Xangô morava
Eleé Gino da Cobra Coral
Eleé Gino da Cobra Coral
Eleé Gino da Cobra Coral
CaôôôÔ…$caad8dfdd8503aef4b4a636483eaf2214$, NULL, now()),
('2dae6d20-8b6c-9e28-0c6d-c5c9e1c51f03', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t2dae6d208b6c9e280c6dc5c9e1c51f03$Xangô - Xangô morava na pedreira$t2dae6d208b6c9e280c6dc5c9e1c51f03$, $c2dae6d208b6c9e280c6dc5c9e1c51f03$Xangô morava na pedreira
eveio escrever em uma pedra
eleescreveu a justiça
quem deve paga
quem merece recebe [2x]$c2dae6d208b6c9e280c6dc5c9e1c51f03$, NULL, now()),
('914f8218-4fd8-09bf-1575-e2ea9c763594', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t914f82184fd809bf1575e2ea9c763594$Xangô - Kaô meu Xangô Ayrá$t914f82184fd809bf1575e2ea9c763594$, $c914f82184fd809bf1575e2ea9c763594$Xangô meu, Xangô menino
da linhade Oxalá
nos dê seu axé pra nós, oh Xangô
kaô meu Xangô Ayrá
dê forçapara seus filhos
protejaseu abaçá
segura sua pedreira Xangô
não deixe a pedra rolar$c914f82184fd809bf1575e2ea9c763594$, NULL, now()),
('677ad807-dc07-cc37-617e-e0a3593da422', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t677ad807dc07cc37617ee0a3593da422$Xangô - Xangô meu pai deixa essa pedreira aí$t677ad807dc07cc37617ee0a3593da422$, $c677ad807dc07cc37617ee0a3593da422$Xangô meu pai
deixa essa pedreira aí
Xangô meu pai
deixa essa pedreira aí
Umbanda ta lhe chamando
deixa essa pedreira aí
Umbanda ta lhe chamando
deixa essa pedreira aí$c677ad807dc07cc37617ee0a3593da422$, NULL, now()),
('701fdd35-c616-5bd2-5c90-0929041c243e', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t701fdd35c6165bd25c900929041c243e$Xangô Ayrá - Visita de Oxalá no palácio de Xangô$t701fdd35c6165bd25c900929041c243e$, $c701fdd35c6165bd25c900929041c243e$ôôôôôô Babalaô
me diga como será
avisitade Oxalá
no palácio de Xangô
Duro será o caminho
respondeu eu adivinho
Exú irálhe tentar
terásdor e sofrimento
grande será o tormento
éo que diz o Ifá
Previsão realizada
Oxalá teve as pernas quebradas
na prisão de Obadioió
7anos se passaram
tudo era só tristeza
tudo era um pranto só
Querendo saber o que há
Xangô consulta o Ifá
que lhe respondeu então
voltee solte Oxalá
que em sua prisão ainda está
conquiste o seu perdão
No reino de Xangô a paz voltou
ovelho Oxalá nem pode caminhar
Obá para o seu erro reparar
lheoferece um companheiro
que é chamado de Ayrá
Obá para o seu erro reparar
lheoferece um companheiro
que é chamado de Ayrá
ôôôôôô Babalaô
me diga como será
avisitade Oxalá
no palácio de Xangô$c701fdd35c6165bd25c900929041c243e$, NULL, now()),
('eba26d8f-0ecc-6126-a348-7a8deadaf34b', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $teba26d8f0ecc6126a3487a8deadaf34b$Xangô - Estava olhando uma pedreira e uma pedra rolou$teba26d8f0ecc6126a3487a8deadaf34b$, $ceba26d8f0ecc6126a3487a8deadaf34b$Estava olhando uma pedreira
euma pedra rolou [2x]
Ela veiorolando
bateu em meus pés
ese fezuma flôr[2x]
Quem foi que disse
que eu não sou filhode Xangô [2x]
Filhode pai Xangô
ninguém joga no chão [2x]$ceba26d8f0ecc6126a3487a8deadaf34b$, NULL, now()),
('06c7cb5b-f460-73d8-6075-5a08eff3ca2f', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t06c7cb5bf46073d860755a08eff3ca2f$Xangô - Olha meu destino Xangô$t06c7cb5bf46073d860755a08eff3ca2f$, $c06c7cb5bf46073d860755a08eff3ca2f$Olha meu destino Xangô
que afinaleu sou filhode kaô
pra esse seu menino agô
nascido igual pra justiçado Senhor
Tiraos espinhos
do caminho onde eu passar
andar sozinho
édifícilde chegar
Que pedras lançadas se tornem flôr
rolando perfumadas pela estrada que eu for
Que pedras lançadas se tornem flôr
rolando perfumadas pela estrada que eu for
élíriobranco de paz
rosa vermelha do amor
épai Xangô que nos traz
centelhas da pedra flôr[2x]$c06c7cb5bf46073d860755a08eff3ca2f$, NULL, now()),
('cb8af76f-97ae-5e8c-52c5-533d9363ef77', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tcb8af76f97ae5e8c52c5533d9363ef77$Xangô - Meu pai São João Batista ele é Xangô$tcb8af76f97ae5e8c52c5533d9363ef77$, $ccb8af76f97ae5e8c52c5533d9363ef77$Meu paiSão João Batista eleé Xangô
senhor do meu destino até o fim
meu paiSão João Batista eleé Xangô
senhor do meu destino até o fim
Se um dia me faltara fé no meu Senhor
que role essa pedreira sobre mim
Se um dia me faltara fé no meu Senhor
que role essa pedreira sobre mim$ccb8af76f97ae5e8c52c5533d9363ef77$, NULL, now()),
('f990730c-9afc-0d02-a079-2afab9ab5808', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tf990730c9afc0d02a0792afab9ab5808$Xangô - Ele é o rei dos astros$tf990730c9afc0d02a0792afab9ab5808$, $cf990730c9afc0d02a0792afab9ab5808$Eleé o rei dos astros
mas o seu nome é São Jerônimo
Elevem no ronco do trovão
Lewi
mas o seu nome é Xangô Lewi$cf990730c9afc0d02a0792afab9ab5808$, NULL, now()),
('c9d0e219-5352-e41e-fa92-1a97852a3c74', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tc9d0e2195352e41efa921a97852a3c74$Xangô - Estão queimando vela$tc9d0e2195352e41efa921a97852a3c74$, $cc9d0e2195352e41efa921a97852a3c74$Xangô, meu Pai
amarra os "inimigo"e dá um nó
Xangô, meu Pai
amarra os inimigos no cipó
estão queimando vela
prame derrubar
eu jáfiqueidoente, meu pai
sem poder andar
agora estou aqui
épra saudar Xangô
que vireessa macumba, meu Pai
no peitode quem mandou$cc9d0e2195352e41efa921a97852a3c74$, NULL, now()),
('8ed24a9a-eff1-4a15-2f00-429f392651e0', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t8ed24a9aeff14a152f00429f392651e0$Xangô - Luar na Pedreira$t8ed24a9aeff14a152f00429f392651e0$, $c8ed24a9aeff14a152f00429f392651e0$Xangô, Xangô
Luar lána pedreira de Xangô (2x)
Eu vino clarão do luar
Eu vi
Eu vilá na pedreira pedra rolar(2x)
Eu vina Lua cheia
No altolá da pedreira
Xangô falando conselhos pra nos ajudar (2x)
Não deixe omal entrarna sua vida
Não deixe essa semente germinar (2x)
Não plante essa semente
modifique o seu presente
Só assim colherá os bons frutosque a vida trará
Xangô - Chamado de Fé$c8ed24a9aeff14a152f00429f392651e0$, NULL, now()),
('08398a62-cb9d-cd23-6310-402c744ef9a1', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t08398a62cb9dcd236310402c744ef9a1$Página 24de 31$t08398a62cb9dcd236310402c744ef9a1$, $c08398a62cb9dcd236310402c744ef9a1$Chamei meu paiXangô
Pra ele vim me ajudar
Ele é meu protetor
Mal nenhum vai me pegar (2x)
Chamei meu paiXangô
Porque sentiuma carga densa encomodar
Meu corpo arrepiou
Essa demanda nao vaime derrubar
Meu pai Xangô bradou
E o seu canto ecoou pelo ar
O céu relampejou
E um raioanunciou que Iansâ vem guerrear
Meu pai Xangô bradou
E o seu canto ecoou pelo ar
Quando ecoou na encruza
Marabô e a Padilha respondeu com a gargalhada
Quando ecoou na encruza
Marabô e a Padilha respondeu com a gargalhada$c08398a62cb9dcd236310402c744ef9a1$, NULL, now()),
('45c69d8d-c697-aa01-89f1-02c34a23176e', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t45c69d8dc697aa0189f102c34a23176e$Xangô - Rei Nagô$t45c69d8dc697aa0189f102c34a23176e$, $c45c69d8dc697aa0189f102c34a23176e$A onde o Tambor mora
A onde eu vou tocar
É na aldeia .É na aldeia
É na aldeia do Rei Nagô
É na aldeia eu faleipra vocês
É na aldeia eu faleipra vocês
É na aldeia do Rei Nago
Nago me dê licença
Em sua aldeia eu posso entrar
Na sua aldeia é onde tem felicidade
E o mau não entra lá
Na sua aldeia é onde todo povo canta
Com amor aos seus orixás ( Ooooo).
É na aldeia. É na aldeia
E na aldeia do Rei Nagô
É na aldeia eu faleipra vocês
E na aldeia eu faleipra vocês
E na aldeia do Rei Nagô$c45c69d8dc697aa0189f102c34a23176e$, NULL, now()),
('e16b6b85-3d00-40b4-6b79-7adc637b71f0', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $te16b6b853d0040b46b797adc637b71f0$Xangô - Xangô o vencedor$te16b6b853d0040b46b797adc637b71f0$, $ce16b6b853d0040b46b797adc637b71f0$Foiágua nascendo na fonte,espinho na flor
do seu medo escondido nasceu a coragem de ser vencedor
punhal na mão e no peito, um escudo mais fiel
de quem na terraconcebeu o céu
Foisete pedreiras que ele aprendeu a quebrar
na faísca,na fúria,no raio,na chuva, na luz do luar
lavou o corpo com o vinho amargo do suor
efez do próprio bem, de todos males talvezo menor
Por de trás daquela serra
tem uma linda cachoeira
É de meu Pai Xangô
que arrebentou sete pedreiras$ce16b6b853d0040b46b797adc637b71f0$, NULL, now()),
('7fa676db-e4c9-4a0d-cf2d-15fc746e3d9b', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t7fa676dbe4c94a0dcf2d15fc746e3d9b$Xangô - Brado de Xangô$t7fa676dbe4c94a0dcf2d15fc746e3d9b$, $c7fa676dbe4c94a0dcf2d15fc746e3d9b$Ele bradou na aldeia,
bradou na cachoeira em noite de luar
do altoda pedreira, vem fazer justiça
pra nos ajudar
Ele bradou na aldeia, caô caô
eaqui vaibradar, caô caô
eleé Xangô da pedreira
elenasceu na cachoeira lá no Juremá$c7fa676dbe4c94a0dcf2d15fc746e3d9b$, NULL, now()),
('b4b598bc-4432-81a1-98d3-0a1e3bdbd8a8', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tb4b598bc443281a198d30a1e3bdbd8a8$Xangô - Meu pai Xangô$tb4b598bc443281a198d30a1e3bdbd8a8$, $cb4b598bc443281a198d30a1e3bdbd8a8$No alto da pedreira eu vipedra rolar
No centro da mata ouvi trovão roncar
caô, caô
eleé meu paiXangô
um raio de fogo surgiu
etudo iluminou
então ao meu Pai pedi
vitórianos caminhos que vou
Xangô senhor da verdade
que faz justiçaem nossa terra
com seu machado destróio mal
trazendo a paz, findando a guerra
caô, caô
eleé meu paiXangô$cb4b598bc443281a198d30a1e3bdbd8a8$, NULL, now()),
('34a7a769-fc8d-4588-e986-c96e5ee9fb0d', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t34a7a769fc8d4588e986c96e5ee9fb0d$Subida Xangô - Seu filho lhe pede / Xangô é santo$t34a7a769fc8d4588e986c96e5ee9fb0d$, $c34a7a769fc8d4588e986c96e5ee9fb0d$Meu pai Xangô chegou no reino
meu pai Xangô já vaigirar
Olha seu filholhepede oh Pai
não deixa o filhotombar
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Quem quiser ver Xangô
vaino reino da Glória
Xangô é santo minha gente
Ele aqui não demora$c34a7a769fc8d4588e986c96e5ee9fb0d$, NULL, now()),
('f53c5681-465b-1185-3a5f-181f6a63734b', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tf53c5681465b11853a5f181f6a63734b$Xangô - Justiça Maior$tf53c5681465b11853a5f181f6a63734b$, $cf53c5681465b11853a5f181f6a63734b$Pedra rola da pedreira
em cima de quem errou
justiçaquem faz é ele
porque eleé Xangô
com seu leão do lado
com seu machado na mão
Ele cortamironga
pra seus filhos,trás proteção
justiçamaior é de meu pai Xangô
justiçaverdadeira
O seu brado é tão alto
ecoa na pedreira$cf53c5681465b11853a5f181f6a63734b$, NULL, now()),
('3e58ce0c-6517-52b8-8b05-da5e7002c693', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t3e58ce0c651752b88b05da5e7002c693$Xangô - As Pedras$t3e58ce0c651752b88b05da5e7002c693$, $c3e58ce0c651752b88b05da5e7002c693$As pedras, que formam as pedreiras
são banhadas por cachoeiras
étão lindo admirar
As pedras, também vemos lá no mar
mergulhadas sob as águas
de nossa mãe Iemanjá
As pedras, obras da natureza
representam a firmeza
pertencem ao meu pai Xangô
as pedras ,que surgem em meus caminhos
acompanhadas de espinhos
me ensinam a ser vencedor
as pedras, para mim não são barreiras
para mim são a certeza
que xangô é meu protetor$c3e58ce0c651752b88b05da5e7002c693$, NULL, now()),
('da8cfb4a-183c-e183-6cc9-2e5b17c03f2c', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tda8cfb4a183ce1836cc92e5b17c03f2c$Xangô Sete Pedreiras$tda8cfb4a183ce1836cc92e5b17c03f2c$, $cda8cfb4a183ce1836cc92e5b17c03f2c$Estrelalá no céu brilhou
então surgiu meu pai Xangô
kaô,kaô, kaô
com seu machado ele bradou
Orixá justoe fiel
de bondade e pureza
que mostra sua força
em seus trovões de grande beleza
Eleé Xangô
édas Sete pedreiras
vem junto com Oxóssi
emãe Oxum na cachoeira$cda8cfb4a183ce1836cc92e5b17c03f2c$, NULL, now()),
('13334444-499c-5015-f1af-a5d647cc4ffe', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t13334444499c5015f1afa5d647cc4ffe$Xangô - Acorda que já é hora$t13334444499c5015f1afa5d647cc4ffe$, $c13334444499c5015f1afa5d647cc4ffe$Estava dormindo sobre a pedra
quando a Umbanda me chamou
Acorda, que jáé hora
evem ouvir o lindobrado de Xangô
Xangô - Braço forte$c13334444499c5015f1afa5d647cc4ffe$, NULL, now()),
('c2c431d2-587d-b715-a098-26810b2addf3', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tc2c431d2587db715a09826810b2addf3$Página 28de 31$tc2c431d2587db715a09826810b2addf3$, $cc2c431d2587db715a09826810b2addf3$Vejam que pedreira linda
éa morada de meu pai Xangô
eleé o rei da justiça
meu pai de fé,meu protetor
quando me encontro perdido
aele eu peço sua proteção
sintologo um grande alívio
elhe rezo firmeuma oração
Ele é meu pai,é meu senhor
émeu braço forte,é meu paiXangô
Uma oferenda eu faço
levo na pedreira para lheofertar
um buquê de líriosbrancos
euma gamela com seu amalá
peço paz pra hunanidade
eque todos possam se encontrar
esse é o pedido que faço
ao meu pai de fé,Xangô Airá$cc2c431d2587db715a09826810b2addf3$, NULL, now()),
('d72868f2-c958-d595-643a-0fe7f3d3ac2f', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $td72868f2c958d595643a0fe7f3d3ac2f$Xangô - Quem confia não cai$td72868f2c958d595643a0fe7f3d3ac2f$, $cd72868f2c958d595643a0fe7f3d3ac2f$No alto daquela lindapedreira
meu pai Xangô bradou
elá no céu trovoada roncou
lélé lékaô
Xangô kaô meu pai
quem confia na sua justiça
balança mas não cai$cd72868f2c958d595643a0fe7f3d3ac2f$, NULL, now()),
('fc76093d-2f0b-7c97-e66b-c0dd6da5220c', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tfc76093d2f0b7c97e66bc0dd6da5220c$Página29de 31$tfc76093d2f0b7c97e66bc0dd6da5220c$, $cfc76093d2f0b7c97e66bc0dd6da5220c$Que mata é essa que o leão não entra
que pau é esse que omachado não arrebenta
que pedra é essa que ocorisco não cortou
éa pedreira de meu paiXangô$cfc76093d2f0b7c97e66bc0dd6da5220c$, NULL, now()),
('fc30e679-194c-2b46-dba6-6838b8f85af6', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $tfc30e679194c2b46dba66838b8f85af6$Xangô - Dizem que Xangô mora na pedreira$tfc30e679194c2b46dba66838b8f85af6$, $cfc30e679194c2b46dba66838b8f85af6$dizem que Xangô
mora na pedreira
mas não élá
sua morada verdadeira [2x]
Xangô mora
em uma cidade de luz
onde mora Santa Bárbara
Oxumarê e Jesus [2x]$cfc30e679194c2b46dba66838b8f85af6$, NULL, now()),
('aa430282-23f7-b948-002b-344ae49b52e2', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $taa43028223f7b948002b344ae49b52e2$Xangô - Por trás daquela serra$taa43028223f7b948002b344ae49b52e2$, $caa43028223f7b948002b344ae49b52e2$portrás daquela serra
tem uma lindacachoeira [2x]
éde meu pai Xangô
que arrebentou sete pedreiras [2x]$caa43028223f7b948002b344ae49b52e2$, NULL, now()),
('5f4d6ca5-293f-4240-29de-4e0fb14d45f9', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $t5f4d6ca5293f424029de4e0fb14d45f9$Xangô - A sua machadinha é de ouro$t5f4d6ca5293f424029de4e0fb14d45f9$, $c5f4d6ca5293f424029de4e0fb14d45f9$asua machadinha é de ouro
éde ouro , é de ouro
machadinha que corta demanda
émachadinha de Xangô$c5f4d6ca5293f424029de4e0fb14d45f9$, NULL, now()),
('e47c0daa-7d51-a653-7e90-014fa2b96d98', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $te47c0daa7d51a6537e90014fa2b96d98$Xangô - Eu estava no lajedo$te47c0daa7d51a6537e90014fa2b96d98$, $ce47c0daa7d51a6537e90014fa2b96d98$eu estava no lajedo
olhando as águas rolando
ede repente parou
olhaseus filhosnaumbanda
quando vem lá de aruanda
oh rêrê rêKaô
rêre rêKaô
rêrê rêKaô [2x]$ce47c0daa7d51a6537e90014fa2b96d98$, NULL, now()),
('eefce71b-7324-b36b-325d-c74659969925', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $teefce71b7324b36b325dc74659969925$Xangô -Pega no seu livro$teefce71b7324b36b325dc74659969925$, $ceefce71b7324b36b325dc74659969925$Pega no seu livroelevai lendo
pega na pena pra escrever
Xangô ,caô
saravá na umbanda seu Alafi,seu Agodô$ceefce71b7324b36b325dc74659969925$, NULL, now()),
('e5af093a-41ee-9d3f-d65b-e41a0c31b643', '654413a1-1c02-de9b-908d-abc47f2b8e6f', $te5af093a41ee9d3fd65be41a0c31b643$Xangô -Pedras em meu caminho$te5af093a41ee9d3fd65be41a0c31b643$, $ce5af093a41ee9d3fd65be41a0c31b643$Xangô colocou, pedra em meus caminhos
mas não era para eu pisar
Xangô colocou, pedra em meus caminhos
mas não era para eu pisar
Com as pedras que Xangô me dava
um lindo sonho se realizava
Com as pedras que Xangô me deu
fizuma gruta pra Aieieu
Com as pedras que Xangô me deu
fizuma gruta pra Aieieu
Pedra sobre pedra, consegui fazer
agruta para Oxum Marê
Pedra sobre pedra, consegui fazer
agruta para Oxum Marê$ce5af093a41ee9d3fd65be41a0c31b643$, NULL, now())
on conflict (id) do update set
  category_id = excluded.category_id,
  title = excluded.title,
  content = excluded.content,
  youtube_link = excluded.youtube_link,
  updated_at = now();

commit;
