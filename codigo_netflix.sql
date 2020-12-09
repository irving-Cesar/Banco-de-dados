CREATE DATABASE netflix;

USE netflix;

CREATE TABLE filme (
	id_filme INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    duracao VARCHAR(45) NOT NULL,
    ano_lancamento DATE NOT NULL
);


CREATE TABLE direcao (
  id_direcao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome varchar(255) NOT NULL
);


CREATE TABLE genero (
  id_genero INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL
);	


CREATE TABLE papel (
  id_papel INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL
  );
  
  
  CREATE TABLE atores (
  id_atores INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL
);


CREATE TABLE avaliacao_filme (
  id_avaliacao_filme INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  filme INT NOT NULL,
  descricao varchar(255) NOT NULL,
  
  KEY fk_avaliacao_filme_idx (`filme`),
  CONSTRAINT fk_avaliacao_filme FOREIGN KEY (`filme`) REFERENCES `netflix`.`filme` (`id_filme`)
);


CREATE TABLE filme_direcao (
  direcao INT NOT NULL,
  filme INT NOT NULL,
  KEY fk_direcao_filme_idx (`direcao`),
  KEY fk_fimle_direcao_idx (`filme`),
  CONSTRAINT fk_direcao_filme FOREIGN KEY (`direcao`) REFERENCES `direcao` (`id_direcao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_fimle_direcao FOREIGN KEY (`filme`) REFERENCES `filme` (`id_filme`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE filme_atores (
  filme INT NOT NULL,
  atores INT NOT NULL,
  papel INT NOT NULL,
  
  KEY fk_atores_papel_idx (`papel`),
  KEY fk_atores_filme_idx (`atores`),
  KEY fk_filme_atores_idx (`filme`),
  CONSTRAINT fk_atores_papel FOREIGN KEY (`papel`) REFERENCES `papel` (`id_papel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_atores_filme FOREIGN KEY (`atores`) REFERENCES `atores` (`id_atores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_filme_atores FOREIGN KEY (`filme`) REFERENCES `filme` (`id_filme`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE filme_genero (
  genero INT NOT NULL,
  filme INT NOT NULL,
  KEY fk_genero_filme_idx (`genero`),
  KEY fk_filme_genero_idx (`filme`),
  CONSTRAINT fk_filme_genero FOREIGN KEY (`filme`) REFERENCES `filme` (`id_filme`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_genero_filme FOREIGN KEY (`genero`) REFERENCES `genero` (`id_genero`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- =================== COMEÇO DAS PROCEDURES =================== --

-- =================== INSERIR FILME ===================
DELIMITER $$
USE `netflix`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_FILME`(IN titulop VARCHAR(100),
								   IN descricaop TEXT,
                                   IN duracaop VARCHAR(45),
                                   IN ano_lancamentop DATE)
BEGIN
	INSERT INTO netflix.filme(titulo, descricao, duracao, ano_lancamento)
    VALUES (titulop, descricaop, duracaop, ano_lancamentop);
END$$

DELIMITER ;


-- =================== INSERIR ATORES =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_ATORES`(IN nomep VARCHAR(255))
BEGIN
	INSERT INTO netflix.atores(nome)
    VALUES(nomep);
END$$
DELIMITER ;


-- =================== INSERIR DIRECAO =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_DIRECAO`(IN nomep VARCHAR(255))
BEGIN
	INSERT INTO netflix.direcao(nome)
    VALUES(nomep);
END$$
DELIMITER ;


-- =================== INSERIR GENERO =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_GENERO`(IN nomep VARCHAR(255))
BEGIN
	INSERT INTO netflix.genero(nome)
    VALUES(nomep);
END$$
DELIMITER ;


-- =================== INSERIR PAPEL =================== --
DELIMITER $$
CREATE PROCEDURE `PROC_INS_PAPEL`(IN nomep VARCHAR(255))
BEGIN
	INSERT INTO netflix.papel(nome)
    VALUES(nomep);
END$$
DELIMITER ;


-- =================== INSERIR ATOR EM FILME =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_ATOR_FILME`(IN filmep INT,
									    IN atoresp INT,
                                        IN papelp INT)
BEGIN
	INSERT INTO netflix.filme_atores(filme, atores, papel)
    VALUES(filmep, atoresp, papelp);
END$$
DELIMITER ;

-- =================== INSERIR DIRETOR EM FILME =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_DIRETOR_FILME`(IN filmep INT,
									    IN direcaop INT)
BEGIN
	INSERT INTO netflix.filme_direcao(filme, direcao)
    VALUES(filmep, direcaop);
END$$ 
DELIMITER ;

-- =================== INSERIR GENERO EM FILME =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_GENERO_FILME`(IN filmep INT,
									    IN generop INT)
BEGIN
	INSERT INTO netflix.filme_genero(filme, genero)
    VALUES(filmep, generop);
END$$
DELIMITER ;


-- =================== INSERIR AVALIACAO EM FILME =================== --
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_INS_AVALIACAO_FILME`(IN filmep INT,
											 IN descricaop TEXT)
BEGIN
	INSERT INTO netflix.avaliacao_filme(filme, descricao)
	VALUES(filmep, descricaop);
END$$
DELIMITER ;

-- =================== FIM DAS PROCEDURES =================== --


-- =================== INSERIR FILME =================== --
CALL PROC_INS_FILME("Tenet", "Armado com apenas uma palavra – Tenet – e lutando pela sobrevivência do mundo inteiro, o Protagonista viaja através de um mundo crepuscular de espionagem internacional em uma missão que irá desenrolar em algo para além do tempo real.","2h 32m","2020-10-29");
CALL PROC_INS_FILME("Freaky: No Corpo de um Assassino", "Depois de trocar de corpo com um assassino em série, a adolescente de colegial Millie descobre que tem menos de um dia para reverter a situação antes que seja tarde demais.","1h 41m","2020-11-13");
CALL PROC_INS_FILME("Unfortunate Stories", "Four interconnected plots starring Ramón, a young heir; Bermejo, a tourist obsessed with order; Ayoub, an African immigrant pursuing his dream; and Alipio, a businessman addicted with gambling.","2h 9m","2020-11-19");
CALL PROC_INS_FILME("Mank", "A Hollywood da década de 1930 é vista pelo olhar crítico do roteirista Herman J. Mankiewicz, em meio aos seus esforços para terminar o roteiro de Cidadão Kane.","2h 11m","2020-12-04");
CALL PROC_INS_FILME("Fada Madrinha", "Uma fada madrinha jovem e inexperiente embarca numa aventura por conta própria para provar seu valor rastreando uma jovem cujo pedido de ajuda foi ignorado. O que ela descobre é que a garota agora se tornou uma mulher adulta que precisa de algo muito diferente de um príncipe encantado.","1h 50m","2020-12-04");
CALL PROC_INS_FILME("O Senhor dos Anéis: A Sociedade do Anel", "Em uma terra fantástica e única, um hobbit recebe de presente de seu tio um anel mágico e maligno que precisa ser destruído antes que caia nas mãos do mal. Para isso, o hobbit Frodo tem um caminho árduo pela frente, onde encontra perigo, medo e seres bizarros. Ao seu lado para o cumprimento desta jornada, ele aos poucos pode contar com outros hobbits, um elfo, um anão, dois humanos e um mago, totalizando nove pessoas que formam a Sociedade do Anel.","2h 59m","2002-01-01");
CALL PROC_INS_FILME("Tudo Bem no Natal Que Vem", "Depois de levar um tombo na véspera de Natal, o rabugento Jorge desmaia e acorda um ano depois sem lembrar do que se passou. Ele logo percebe que está condenado a continuar acordando na véspera de Natal, ano após ano, tendo que lidar com as consequências do que seu outro “eu” fez nos demais 364 dias.","1h 40m","2020-12-03");
CALL PROC_INS_FILME("O Presente de Natal de Angela", "Com o pai trabalhando na Austrália, a pequena Ângela bola um plano para realizar seu grande desejo: reunir a família no Natal.","47m","2020-12-01");
CALL PROC_INS_FILME("Selena: A Série", "Na adolescência, a cantora americana de origem mexicana Selena precisa fazer escolhas difíceis junto com sua família em nome do amor e da música.","1h","2020-12-04");
CALL PROC_INS_FILME("Wander", "After getting hired to probe a suspicious death in the small town of Wander, a mentally unstable private investigator becomes convinced the case is linked to the same 'conspiracy cover up' that caused the death of his daughter.","1h 34m","2020-12-04");
CALL PROC_INS_FILME("O Senhor dos Anéis: As Duas Torres", "Após a captura de Merry e Pippy pelos orcs, a Sociedade do Anel é dissolvida. Frodo e Sam seguem sua jornada rumo à Montanha da Perdição para destruir o anel e descobrem que estão sendo perseguidos pelo misterioso Gollum. Enquanto isso, Aragorn, o elfo e arqueiro Legolas e o anão Gimli partem para resgatar os hobbits sequestrados e chegam ao reino de Rohan, onde o rei Theoden foi vítima de uma maldição mortal de Saruman.","3h","2002-12-27");
CALL PROC_INS_FILME("Ava", "Atormentada por dúvidas, uma assassina de elite luta para proteger a si mesma e a sua família depois que uma missão dá errado.","1h 36m","2020-09-25");
CALL PROC_INS_FILME("Chick Fight", "Quando Anna Wyncomb é apresentada a um submundo de luta feminina para lidar com toda a bagunça que está a sua vida, ela percebe que está mais conectada à história do clube do que imaginava, redescobrindo a si mesma, sua força interior e seu verdadeiro propósito.","1h 37m","2020-11-13");
CALL PROC_INS_FILME("Crônicas de Natal: Parte Dois", "Revoltada com o novo relacionamento da mãe, Kate foge e vai parar no Polo Norte, onde um elfo faz planos de cancelar o Natal.","1h 52m","2020-11-18");
CALL PROC_INS_FILME("Mulan", "Hua Mulan é a espirituosa e determinada filha mais velha de um honrado guerreiro. Quando o Imperador da China emite um decreto que um homem de cada família deve servir no exército imperial, Mulan decide tomar o lugar de seu pai, que está doente. Assumindo a identidade de Hua Jun, ela se disfarça de homem para combater os invasores que estão atacando sua nação, provando-se uma grande guerreira.","1h 55m","2020-09-04");
CALL PROC_INS_FILME("O Som do Silêncio", "Um jovem baterista teme por seu futuro quando percebe que está gradualmente ficando surdo. Duas paixões estão em jogo: a música e sua namorada, que é integrante da mesma banda de heavy metal. Essa mudança drástica acarreta em muita tensão e angústia na vida do baterista, atormentado lentamente pelo silêncio.","2h 1m","2020-12-16");
CALL PROC_INS_FILME("The Flight Attendant", "Cassandra Bowen é uma comissária de bordo que acorda de ressaca em um hotel em Dubai ao lado de um cadáver. Ao invés de ligar para a polícia, ela foge e parte com seus colegas em um voo para Nova York. Mas a situação se complica quando ela é abordada por agentes do FBI, que têm algumas perguntas para ela em pleno voo.","48m","2020-11-26");
CALL PROC_INS_FILME("O Senhor dos Anéis: O Retorno do Rei", "O confronto final entre as forças do bem e do mal que lutam pelo controle do futuro da Terra Média se aproxima. Sauron planeja um grande ataque a Minas Tirith, capital de Gondor, o que faz com que Gandalf e Pippin partam para o local na intenção de ajudar a resistência. Um exército é reunido por Theoden em Rohan, em mais uma tentativa de deter as forças de Sauron. Enquanto isso, Frodo, Sam e Gollum seguem sua viagem rumo à Montanha da Perdição para destruir o anel.","3h 22m","2003-12-25");
CALL PROC_INS_FILME("Vozes", "Depois de uma tragédia ocorrer em sua nova casa, Daniel escuta um pedido de socorro sinistro e pede a ajuda de um famoso especialista em paranormalidade.","1h 38m","2020-07-24");
CALL PROC_INS_FILME("Os Bad Boys", "Os policiais Burnett (Martin Lawrence) e Lowrey (Will Smith) são encarregados de encontrar um carregamento de heroína que foi roubado. Uma testemunha liga para a delegacia dizendo ser capaz de identificar o ladrão. O pacato Burnett finge ser Lowrey para não perder o caso e acaba tendo que proteger a mulher, enquanto seu parceiro mulherengo cuida de sua família.","1h 58m","1995-07-07");
CALL PROC_INS_FILME("Guerra nas Estrelas", "A princesa Leia é mantida refém pelas forças imperiais comandadas por Darth Vader. Luke Skywalker e Han Solo precisam libertá-la e restaurar a liberdade e a justiça na galáxia.","2h 1m","1977-11-27");
CALL PROC_INS_FILME("Os Croods 2: Uma Nova Era", "Após finalmente deixarem a caverna onde viviam, a família Crood esbarra na maior ameaça que encontraram desde então: uma outra família pré-histórica, os Bettermans.","1h 35m","2020-12-24");
CALL PROC_INS_FILME("Enquanto Estivermos Juntos", "A história real de Jeremy Camp (K.J. Apa), famoso cantor de rock cristão e indicado ao Grammy. A obra deseja focar como a religião foi essencial para o artista superar dores de sua vida, principalmente quando sua esposa Melissa (Britt Robertson) é vítima de câncer.","1h 55m","2020-11-19");
CALL PROC_INS_FILME("Half Brothers", "A story about the complex connection with a brother who is based in Mexico, meant to be a metaphor of the relationship between neighboring countries America and Mexico.","1h 36m","2020-12-04");
CALL PROC_INS_FILME("Fate/stay night: Heaven's Feel III. Spring Song ", "As Sakura drowns in the murky darkness of the sins she has committed, Shirō's vow to protect her at all costs leads him into a raging battle to put an end to the Holy Grail War. Will Shirō's wish reach Sakura even as he challenges fate itself in a desperate battle against the rising tide?","2h","2020-11-18");
CALL PROC_INS_FILME("10 Horas Para o Natal", "Três irmãos já cansaram se passar o Natal com a família separada desde o divórcio de seus pais. No entanto, neste ano eles montaram um plano para reuni-los novamente em um feriado especial.","1h 5m","2020-12-03");
CALL PROC_INS_FILME("Complete Strangers", "A recovering alcoholic returns to his hometown after a hiatus, and falls in love with a man who will turn his world upside down.","1h 45m","2020-12-01");
CALL PROC_INS_FILME("Amizade Maldita", "Kevin e Beth notam que seu filho de oito anos, Josh, tem passado bastante tempo brincando com um novo amigo imaginário, chamado Z. O que a princípio parece uma relação inofensiva, rapidamente se transforma em algo destrutivo e perigoso. É quando Beth começa a desvendar o seu próprio passado, que ela descobre que Z pode não estar apenas na imaginação do filh","1h 23m","2020-12-03");
CALL PROC_INS_FILME("Fatman", "Enquanto um Papai Noel desordeiro e nada ortodoxo luta contra a falência de seus negócios, um inconformado garoto de doze anos contrata um assassino para matar o Bom Velhinho como forma de vingança após receber um pedaço de carvão de presente de Natal.","1h 40m","2020-11-26");
CALL PROC_INS_FILME("Magia Invertida", "Nory Horace, de dez anos, é uma Fluxer e, como a maioria das Fluxers, pode se transformar em animais. Mas toda vez que Nory tenta se transformar em um gatinho preto, ela acaba se transformando em uma louca combinação de animais, como um gatinho castor ou até um gatinho dragão. Ela é enviada para morar com sua tia, para poder frequentar uma escola com uma nova turma para crianças que, como Nory, têm uma magia invertida que não se encaixa perfeitamente em uma das cinco categorias estabelecidas de mágica. Desesperado para ser normal, Nory aprende o quão valioso ser diferente pode ser.","1h 36m","2020-10-10");
CALL PROC_INS_FILME("Coringa", "Arthur Fleck trabalha como palhaço para uma agência de talentos e, toda semana, precisa comparecer a uma agente social, devido aos seus conhecidos problemas mentais. Após ser demitido, Fleck reage mal à gozação de três homens em pleno metrô e os mata. Os assassinatos iniciam um movimento popular contra a elite de Gotham City, da qual Thomas Wayne é seu maior representan","2h 2m","2019-10-03");
CALL PROC_INS_FILME("Se Beber, Não Case!", "Dois dias antes de seu casamento, Doug e três amigos vão de carro até Las Vegas para uma louca e memorável despedida de solteiro. Quando os três padrinhos acordam na manhã seguinte, eles não conseguem se lembrar de nada e notam que Doug desapareceu. Com pouco tempo de sobra, os amigos tentam refazer a noite anterior e encontrar Doug para que possam levá-lo de volta a Los Angeles a tempo de chegar ao altar.","1h 40m","2009-08-11");
CALL PROC_INS_FILME("Lo sguardo della musica", "A documentary on the legendary film composer Ennio Morricone.","1h 30m","2020-08-28");
CALL PROC_INS_FILME("Forever Hollywood", "Noted Hollywood stars and directors talk about the history and evolution of the film industry in Los Angeles.","57m","1999-01-01");
CALL PROC_INS_FILME("Se Beber, Não Case! Parte II", "Depois de uma farra inesquecível em Las Vegas, Phil (Bradley Cooper), Stu (Ed Helms), Alan (Zach Galifianakis) e Doug (Justin Bartha) seguiram com suas vidas. Mas o bom e velho Stu está disposto a se casar novamente, desta vez com Lauren (Jamie Chung), e o local escolhido para a cerimônia foi a exótica Tailândia. Entretanto, o que era para ser uma simples despedida de solteiro acabou se transformando em outra aventura muito louca, só que agora num país diferente, com suas proprias regras e a promessa de ser marcante.","1h 42m","2011-05-27");
CALL PROC_INS_FILME("Se Beber, Não Case! Parte III", "Alan (Zach Galifianakis) está deprimido devido à morte de seu pai. Preocupado com o cunhado, Doug (Justin Bartha) sugere que ele vá até um lugar chamado New Horizons, que pode torná-lo um novo homem. Alan apenas aceita a sugestão após Phil (Bradley Cooper) e Stu (Ed Helms) concordarem em levá-lo, juntamente com Doug. É o início de uma nova viagem do quarteto, que acaba sendo interrompida bruscamente pelos capangas de Marshall (John Goodman). O malfeitor está atrás de Chow (Ken Jeong), que lhe aplicou um golpe milionário, e acredita que os amigos ainda possuam contato com ele. Após sequestrar Doug, Marshall dá a Alan, Stu e Phil um prazo para que encontrem Chow e devolvam as barras de ouro por ele roubadas, caso contrário todos morrerão. O que o trio não esperava era que, para reencontrar Chow, teria que ir até Tijuana, no México, e também em Las Vegas.","1h 40m","2013-05-31");
CALL PROC_INS_FILME("Cães de Aluguel", "Uma gangue de ladrões, fugindo de um assalto bem-sucedido, encontra-se em um armazém. O problema é que a polícia está atrás deles, e cada um começa então a desconfiar que possa haver um traidor no grupo. O filme tem uma montagem que mostra as cenas no armazém intercalando-se com flashbacks da preparação para o crime, até um final surpreendente. Roteiro inteligente, na ótima estréia de Quentin Tarantino na direção.","1h 39m","1993-06-04");


-- =================== INSERIR ATORES =================== --
CALL PROC_INS_ATORES("Izabela Rose");
CALL PROC_INS_ATORES("Siena Agudong");
CALL PROC_INS_ATORES("Kyle Howard");
CALL PROC_INS_ATORES("Joaquin Phoenix");
CALL PROC_INS_ATORES("Robert De Niro");
CALL PROC_INS_ATORES("Zazie Beetz");
CALL PROC_INS_ATORES("Malin Åkerman");
CALL PROC_INS_ATORES("Alec Baldwin");
CALL PROC_INS_ATORES("John David Washington");
CALL PROC_INS_ATORES("Robert Pattinson");
CALL PROC_INS_ATORES("Elizabeth Debicki");
CALL PROC_INS_ATORES("Vince Vaughn");
CALL PROC_INS_ATORES("Kathryn Newton");
CALL PROC_INS_ATORES("Alan Ruck");
CALL PROC_INS_ATORES("Chani Martín");
CALL PROC_INS_ATORES("Athenea Mata");
CALL PROC_INS_ATORES("Fernando Sansegundo");
CALL PROC_INS_ATORES("Gary Oldman");
CALL PROC_INS_ATORES("Amanda Seyfried");
CALL PROC_INS_ATORES("Charles Dance");
CALL PROC_INS_ATORES("Jillian Bell");
CALL PROC_INS_ATORES("Isla Fisher");
CALL PROC_INS_ATORES("Jane Curtin");
CALL PROC_INS_ATORES("Elijah Wood");
CALL PROC_INS_ATORES("Ian McKellen");
CALL PROC_INS_ATORES("Liv Tyler");
CALL PROC_INS_ATORES("Leandro Hassum");
CALL PROC_INS_ATORES("Danielle Winits");
CALL PROC_INS_ATORES("Louise Cardoso");
CALL PROC_INS_ATORES("Lucy O'Connell");
CALL PROC_INS_ATORES("Christian Serratos");
CALL PROC_INS_ATORES("Gabriel Chavarria");
CALL PROC_INS_ATORES("Ricardo Chavira");
CALL PROC_INS_ATORES("Aaron Eckhart");
CALL PROC_INS_ATORES("Tommy Lee Jones");
CALL PROC_INS_ATORES("Katheryn Winnick");
CALL PROC_INS_ATORES("Jessica Chastain");
CALL PROC_INS_ATORES("John Malkovich");
CALL PROC_INS_ATORES("Colin Farrell");
CALL PROC_INS_ATORES("Kurt Russell");
CALL PROC_INS_ATORES("Goldie Hawn");
CALL PROC_INS_ATORES("Darby Camp");
CALL PROC_INS_ATORES("Liu Yifei");
CALL PROC_INS_ATORES("Jet Li");
CALL PROC_INS_ATORES("Tzi Ma");
CALL PROC_INS_ATORES("Riz Ahmed");
CALL PROC_INS_ATORES("Olivia Cooke");
CALL PROC_INS_ATORES("Paul Raci");
CALL PROC_INS_ATORES("Kaley Cuoco");
CALL PROC_INS_ATORES("Michiel Huisman");
CALL PROC_INS_ATORES("Zosia Mamet");
CALL PROC_INS_ATORES("Viggo Mortensen");
CALL PROC_INS_ATORES("Rodolfo Sancho");
CALL PROC_INS_ATORES("Ramón Barea");
CALL PROC_INS_ATORES("Nerea Barros");
CALL PROC_INS_ATORES("Martin Lawrence");
CALL PROC_INS_ATORES("Will Smith");
CALL PROC_INS_ATORES("Téa Leoni");
CALL PROC_INS_ATORES("Mark Hamill");
CALL PROC_INS_ATORES("Harrison Ford");
CALL PROC_INS_ATORES("Carrie Fisher");
CALL PROC_INS_ATORES("Nicolas Cage");
CALL PROC_INS_ATORES("Emma Stone");
CALL PROC_INS_ATORES("Ryan Reynolds");
CALL PROC_INS_ATORES("Peter Dinklage");
CALL PROC_INS_ATORES("K.J. Apa");
CALL PROC_INS_ATORES("Britt Robertson");
CALL PROC_INS_ATORES("Nathan Parsons");
CALL PROC_INS_ATORES("Luis Gerardo Méndez");
CALL PROC_INS_ATORES("Connor Del Rio");
CALL PROC_INS_ATORES("Hayes Hargrove");
CALL PROC_INS_ATORES("Noriaki Sugiyama");
CALL PROC_INS_ATORES("Noriko Shitaya");
CALL PROC_INS_ATORES("Ayako Kawasumi");
CALL PROC_INS_ATORES("Luís Lobianco");
CALL PROC_INS_ATORES("Giulia Benite");
CALL PROC_INS_ATORES("Pedro Miranda");
CALL PROC_INS_ATORES("Pau Masó"); -- Diretor
CALL PROC_INS_ATORES("Matthew Crawley");
CALL PROC_INS_ATORES("Sian Abrahams");
CALL PROC_INS_ATORES("Keegan Connor Tracy");
CALL PROC_INS_ATORES("Jett Klyne");
CALL PROC_INS_ATORES("Sean Rogerson");
CALL PROC_INS_ATORES("Mel Gibson");
CALL PROC_INS_ATORES("Walton Goggins");
CALL PROC_INS_ATORES("Marianne Jean-Baptiste");
CALL PROC_INS_ATORES("Bradley Cooper");
CALL PROC_INS_ATORES("Ed Helms");
CALL PROC_INS_ATORES("Zach Galifianakis");
CALL PROC_INS_ATORES("Ennio Morricone");
CALL PROC_INS_ATORES("Wong Kar-wai");
CALL PROC_INS_ATORES("Quentin Tarantino");
CALL PROC_INS_ATORES("Sharon Stone");
CALL PROC_INS_ATORES("Warren Beatty");
CALL PROC_INS_ATORES("Annette Bening");
CALL PROC_INS_ATORES("Peter Jackson"); -- Diretor
CALL PROC_INS_ATORES("Bella Thorne");
CALL PROC_INS_ATORES("Harvey Keitel");
CALL PROC_INS_ATORES("Tim Roth");


-- =================== INSERIR DIRECAO =================== --
CALL PROC_INS_DIRECAO ("Joe Nussbaum");
CALL PROC_INS_DIRECAO ("Todd Phillips");
CALL PROC_INS_DIRECAO ("Paul Leyden");
CALL PROC_INS_DIRECAO ("Christopher Nolan");
CALL PROC_INS_DIRECAO ("Christopher Landon");
CALL PROC_INS_DIRECAO ("Javier Fesser");
CALL PROC_INS_DIRECAO ("David Fincher");
CALL PROC_INS_DIRECAO ("Sharon Maguire");
CALL PROC_INS_DIRECAO ("Peter Jackson"); 
CALL PROC_INS_DIRECAO ("Roberto Santucci");
CALL PROC_INS_DIRECAO ("Damien O'Connor");
CALL PROC_INS_DIRECAO ("Moisés Zamora");
CALL PROC_INS_DIRECAO ("April Mullen");
CALL PROC_INS_DIRECAO ("Tate Taylor");
CALL PROC_INS_DIRECAO ("Chris Columbus");
CALL PROC_INS_DIRECAO ("Niki Caro");
CALL PROC_INS_DIRECAO ("Darius Marder");
CALL PROC_INS_DIRECAO ("Steve Yockey");
CALL PROC_INS_DIRECAO ("Ángel Gómez Hernández");
CALL PROC_INS_DIRECAO ("Michael Bay");
CALL PROC_INS_DIRECAO ("George Lucas");
CALL PROC_INS_DIRECAO ("Joel Crawford");
CALL PROC_INS_DIRECAO ("Jon Erwin");
CALL PROC_INS_DIRECAO ("Luke Greenfield");
CALL PROC_INS_DIRECAO ("Junichi Minamino");
CALL PROC_INS_DIRECAO ("Cris D'amatos");
CALL PROC_INS_DIRECAO ("Pau Masó");
CALL PROC_INS_DIRECAO ("Brandon Christensen");
CALL PROC_INS_DIRECAO ("Ian Nelms");
CALL PROC_INS_DIRECAO ("Todd Phillips");
CALL PROC_INS_DIRECAO ("Giuseppe Tornatore");
CALL PROC_INS_DIRECAO ("Todd McCarthy");
CALL PROC_INS_DIRECAO ("Arnold Glassma");
CALL PROC_INS_DIRECAO("Chris Columbu"); 
CALL PROC_INS_DIRECAO("Andrew Erwin"); 
CALL PROC_INS_DIRECAO("Ken Takahashi"); 
CALL PROC_INS_DIRECAO("Tomonori Sudō"); 
CALL PROC_INS_DIRECAO("Kei Tsunematsu"); 
CALL PROC_INS_DIRECAO("Takuya Nonaka");
CALL PROC_INS_DIRECAO("Takahiro Miura"); 
CALL PROC_INS_DIRECAO("Eshom Nelms"); 
CALL PROC_INS_DIRECAO("Quentin Tarantino"); -- Diretor


-- =================== INSERIR GENERO =================== --
CALL PROC_INS_GENERO("Família");
CALL PROC_INS_GENERO("Fantasia");
CALL PROC_INS_GENERO("Cinema TV");
CALL PROC_INS_GENERO("Crime");
CALL PROC_INS_GENERO("Thriller");
CALL PROC_INS_GENERO("Drama");
CALL PROC_INS_GENERO("Ação");
CALL PROC_INS_GENERO("Comédia");
CALL PROC_INS_GENERO("Ficção científica");
CALL PROC_INS_GENERO("Terror");
CALL PROC_INS_GENERO("História");
CALL PROC_INS_GENERO("Aventura");
CALL PROC_INS_GENERO("Animação");
CALL PROC_INS_GENERO("Música");
CALL PROC_INS_GENERO("Romance");
CALL PROC_INS_GENERO("Mistério");
CALL PROC_INS_GENERO("Documentário");


-- =================== INSERIR PAPEL =================== --
CALL PROC_INS_PAPEL("Protagonista");
CALL PROC_INS_PAPEL("Um dos protagonista");
CALL PROC_INS_PAPEL("Uma pessoa próxima do protagonista");
CALL PROC_INS_PAPEL("Figurante");
CALL PROC_INS_PAPEL("Personagem de documentário");
CALL PROC_INS_PAPEL("Amigo do protagonista");
CALL PROC_INS_PAPEL("Vilão");
CALL PROC_INS_PAPEL("Heroi");
CALL PROC_INS_PAPEL("Amante do protagonista");
CALL PROC_INS_PAPEL("Galã");


-- =================== INSERIR AVALIACAO EM FILME =================== --
CALL PROC_INS_AVALIACAO_FILME(32, "Filme Muito engraçado, adoro a parte quando o Chow fala: É engraçado porque ele é gordo.");
CALL PROC_INS_AVALIACAO_FILME(35, "A obra de arte voltouu.");
CALL PROC_INS_AVALIACAO_FILME(36, "Eles não param de entrar em treta kkkkk");
CALL PROC_INS_AVALIACAO_FILME(37, "Belo filme, uma história que arrepia até os cabelo do nariz.");


-- =================== INSERIR ATOR/DIRETOR/GENERO FILME =================== --
-- FILME id = 1 --
-- ATORES
CALL PROC_INS_ATOR_FILME(1,9,1); -- FILME, ATOR, PAPEL
CALL PROC_INS_ATOR_FILME(1,10,3);
CALL PROC_INS_ATOR_FILME(1,11,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(1,4); -- FILME, DIRETOR
-- GENERO
CALL PROC_INS_GENERO_FILME(1,5); -- FILME, GENERO
CALL PROC_INS_GENERO_FILME(1,7);
CALL PROC_INS_GENERO_FILME(1,9);


-- FILME id = 2 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(2,12,3);
CALL PROC_INS_ATOR_FILME(2,13,1);
CALL PROC_INS_ATOR_FILME(2,14,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(2,5);
-- GENERO
CALL PROC_INS_GENERO_FILME(2,5);
CALL PROC_INS_GENERO_FILME(2,8);
CALL PROC_INS_GENERO_FILME(2,10);


-- FILME id = 3 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(3,15,3); 
CALL PROC_INS_ATOR_FILME(3,16,3);
CALL PROC_INS_ATOR_FILME(3,17,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(3,6);
-- GENERO
CALL PROC_INS_GENERO_FILME(3,8);


-- FILME id = 4 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(4,18,2); 
CALL PROC_INS_ATOR_FILME(4,19,2);
CALL PROC_INS_ATOR_FILME(4,20,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(4,7);
-- GENERO
CALL PROC_INS_GENERO_FILME(4,6);
CALL PROC_INS_GENERO_FILME(4,11);


-- FILME id = 5 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(5,21,1); 
CALL PROC_INS_ATOR_FILME(5,22,3);
CALL PROC_INS_ATOR_FILME(5,23,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(5,8);
-- GENERO
CALL PROC_INS_GENERO_FILME(5,1);
CALL PROC_INS_GENERO_FILME(5,2);
CALL PROC_INS_GENERO_FILME(5,8);


-- FILME id = 6 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(6,24,1); 
CALL PROC_INS_ATOR_FILME(6,25,2);
CALL PROC_INS_ATOR_FILME(6,26,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(6,9);
-- GENERO
CALL PROC_INS_GENERO_FILME(6,2);
CALL PROC_INS_GENERO_FILME(6,7);
CALL PROC_INS_GENERO_FILME(6,12);


-- FILME id = 7 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(7,27,1); 
CALL PROC_INS_ATOR_FILME(7,28,3);
CALL PROC_INS_ATOR_FILME(7,29,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(7,10);
-- GENERO
CALL PROC_INS_GENERO_FILME(7,1);
CALL PROC_INS_GENERO_FILME(7,8);


-- FILME id = 8 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(8,30,1); 
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(8,11);
-- GENERO
CALL PROC_INS_GENERO_FILME(8,13);


-- FILME id = 9 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(9,31,1); 
CALL PROC_INS_ATOR_FILME(9,32,3);
CALL PROC_INS_ATOR_FILME(9,33,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(9,12);
-- GENERO
CALL PROC_INS_GENERO_FILME(9,6);


-- FILME id = 10 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(10,34,2); 
CALL PROC_INS_ATOR_FILME(10,35,2);
CALL PROC_INS_ATOR_FILME(10,36,2);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(10,13);
-- GENERO
CALL PROC_INS_GENERO_FILME(10,4);
CALL PROC_INS_GENERO_FILME(10,5);
CALL PROC_INS_GENERO_FILME(10,16);


-- FILME id = 11 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(11,24,1); 
CALL PROC_INS_ATOR_FILME(11,25,3);
CALL PROC_INS_ATOR_FILME(11,26,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(11,9);
-- GENERO
CALL PROC_INS_GENERO_FILME(11,2);
CALL PROC_INS_GENERO_FILME(11,7);
CALL PROC_INS_GENERO_FILME(11,12);


-- FILME id = 12 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(12,37,1); 
CALL PROC_INS_ATOR_FILME(12,38,3);
CALL PROC_INS_ATOR_FILME(12,39,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(12,14);
-- GENERO
CALL PROC_INS_GENERO_FILME(12,4);
CALL PROC_INS_GENERO_FILME(12,5);
CALL PROC_INS_GENERO_FILME(12,6);
CALL PROC_INS_GENERO_FILME(12,7);


-- FILME id = 13 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(13,6,1); 
CALL PROC_INS_ATOR_FILME(13,7,3);
CALL PROC_INS_ATOR_FILME(13,8,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(13,3);
-- GENERO
CALL PROC_INS_GENERO_FILME(13,7);
CALL PROC_INS_GENERO_FILME(13,8);


-- FILME id = 14 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(14,40,2); 
CALL PROC_INS_ATOR_FILME(14,41,2);
CALL PROC_INS_ATOR_FILME(14,42,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(14,34);
-- GENERO
CALL PROC_INS_GENERO_FILME(14,1);
CALL PROC_INS_GENERO_FILME(14,2);
CALL PROC_INS_GENERO_FILME(14,12);


-- FILME id = 15 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(15,43,1); 
CALL PROC_INS_ATOR_FILME(15,44,3);
CALL PROC_INS_ATOR_FILME(15,45,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(15,16);
-- GENERO
CALL PROC_INS_GENERO_FILME(15,2);
CALL PROC_INS_GENERO_FILME(15,6);
CALL PROC_INS_GENERO_FILME(15,7);
CALL PROC_INS_GENERO_FILME(15,12);


-- FILME id = 16 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(16,46,1); 
CALL PROC_INS_ATOR_FILME(16,47,3);
CALL PROC_INS_ATOR_FILME(16,48,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(16,17);
-- GENERO
CALL PROC_INS_GENERO_FILME(16,6);


-- FILME id = 17 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(17,49,1); 
CALL PROC_INS_ATOR_FILME(18,50,3);
CALL PROC_INS_ATOR_FILME(19,51,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(17,18);
-- GENERO
CALL PROC_INS_GENERO_FILME(17,6);
CALL PROC_INS_GENERO_FILME(17,16);


-- FILME id = 18 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(18,24,1); 
CALL PROC_INS_ATOR_FILME(18,25,3);
CALL PROC_INS_ATOR_FILME(18,52,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(18,9);
-- GENERO
CALL PROC_INS_GENERO_FILME(18,2);
CALL PROC_INS_GENERO_FILME(18,7);
CALL PROC_INS_GENERO_FILME(18,12);


-- FILME id = 19 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(19,53,2); 
CALL PROC_INS_ATOR_FILME(19,54,3);
CALL PROC_INS_ATOR_FILME(19,55,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(19,19);
-- GENERO
CALL PROC_INS_GENERO_FILME(19,5);
CALL PROC_INS_GENERO_FILME(19,6);
CALL PROC_INS_GENERO_FILME(19,10);


-- FILME id = 20 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(20,56,2); 
CALL PROC_INS_ATOR_FILME(20,57,2);
CALL PROC_INS_ATOR_FILME(20,58,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(20,20);
-- GENERO
CALL PROC_INS_GENERO_FILME(20,4);
CALL PROC_INS_GENERO_FILME(20,5);
CALL PROC_INS_GENERO_FILME(20,7);
CALL PROC_INS_GENERO_FILME(20,8);


-- FILME id = 21 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(21,59,1); 
CALL PROC_INS_ATOR_FILME(21,60,3);
CALL PROC_INS_ATOR_FILME(21,61,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(21,21);
-- GENERO
CALL PROC_INS_GENERO_FILME(21,7);
CALL PROC_INS_GENERO_FILME(21,9);
CALL PROC_INS_GENERO_FILME(21,12);


-- FILME id = 22 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(22,62,2); 
CALL PROC_INS_ATOR_FILME(22,63,2);
CALL PROC_INS_ATOR_FILME(22,64,2);
CALL PROC_INS_ATOR_FILME(22,65,2);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(22,22);
-- GENERO
CALL PROC_INS_GENERO_FILME(22,1);
CALL PROC_INS_GENERO_FILME(22,2);
CALL PROC_INS_GENERO_FILME(22,12);
CALL PROC_INS_GENERO_FILME(22,13);


-- FILME id = 23 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(23,66,1); 
CALL PROC_INS_ATOR_FILME(23,67,9);
CALL PROC_INS_ATOR_FILME(23,68,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(23,22);
CALL PROC_INS_DIRETOR_FILME(23,35);
-- GENERO
CALL PROC_INS_GENERO_FILME(23,6);
CALL PROC_INS_GENERO_FILME(23,14);


-- FILME id = 24 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(24,69,2); 
CALL PROC_INS_ATOR_FILME(24,70,2);
CALL PROC_INS_ATOR_FILME(24,71,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(24,24);
-- GENERO
CALL PROC_INS_GENERO_FILME(24,6);
CALL PROC_INS_GENERO_FILME(24,8);


-- FILME id = 25 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(25,72,1); 
CALL PROC_INS_ATOR_FILME(25,73,9);
CALL PROC_INS_ATOR_FILME(25,74,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(25,25);
CALL PROC_INS_DIRETOR_FILME(25,36);
CALL PROC_INS_DIRETOR_FILME(25,37);
CALL PROC_INS_DIRETOR_FILME(25,38);
CALL PROC_INS_DIRETOR_FILME(25,39);
CALL PROC_INS_DIRETOR_FILME(25,40);
-- GENERO
CALL PROC_INS_GENERO_FILME(25,13);


-- FILME id = 26 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(26,75,1); 
CALL PROC_INS_ATOR_FILME(26,76,3);
CALL PROC_INS_ATOR_FILME(26,77,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(26,26);
-- GENERO
CALL PROC_INS_GENERO_FILME(26,1);
CALL PROC_INS_GENERO_FILME(26,8);


-- FILME id = 27 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(27,78,1); 
CALL PROC_INS_ATOR_FILME(27,79,9);
CALL PROC_INS_ATOR_FILME(27,80,6);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(27,27);
-- GENERO
CALL PROC_INS_GENERO_FILME(27,5);
CALL PROC_INS_GENERO_FILME(27,6);
CALL PROC_INS_GENERO_FILME(27,15);
CALL PROC_INS_GENERO_FILME(27,16);


-- FILME id = 28 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(28,81,3); 
CALL PROC_INS_ATOR_FILME(28,82,1);
CALL PROC_INS_ATOR_FILME(28,83,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(28,28);
-- GENERO
CALL PROC_INS_GENERO_FILME(28,5);
CALL PROC_INS_GENERO_FILME(28,10);


-- FILME id = 29 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(29,84,1); 
CALL PROC_INS_ATOR_FILME(29,85,7);
CALL PROC_INS_ATOR_FILME(29,86,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(29,28);
CALL PROC_INS_DIRETOR_FILME(29,41);
-- GENERO
CALL PROC_INS_GENERO_FILME(29,2);
CALL PROC_INS_GENERO_FILME(29,7);
CALL PROC_INS_GENERO_FILME(29,8);


-- FILME id = 30 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(30,1,1); 
CALL PROC_INS_ATOR_FILME(30,2,3);
CALL PROC_INS_ATOR_FILME(30,3,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(30,1);
-- GENERO
CALL PROC_INS_GENERO_FILME(30,1);
CALL PROC_INS_GENERO_FILME(30,2);
CALL PROC_INS_GENERO_FILME(30,3);


-- FILME id = 31 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(31,4,1); 
CALL PROC_INS_ATOR_FILME(31,5,3);
CALL PROC_INS_ATOR_FILME(31,6,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(31,2);
-- GENERO
CALL PROC_INS_GENERO_FILME(31,4);
CALL PROC_INS_GENERO_FILME(31,5);
CALL PROC_INS_GENERO_FILME(31,6);


-- FILME id = 32 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(32,87,2); 
CALL PROC_INS_ATOR_FILME(32,88,2);
CALL PROC_INS_ATOR_FILME(32,89,1);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(32,2);
-- GENERO
CALL PROC_INS_GENERO_FILME(32,8);


-- FILME id = 33 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(33,90,2); 
CALL PROC_INS_ATOR_FILME(33,91,2);
CALL PROC_INS_ATOR_FILME(33,92,2);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(33,31);
-- GENERO
CALL PROC_INS_GENERO_FILME(33,17);


-- FILME id = 34 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(34,93,2); 
CALL PROC_INS_ATOR_FILME(34,94,2);
CALL PROC_INS_ATOR_FILME(34,95,2);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(34,32);
CALL PROC_INS_DIRETOR_FILME(34,33);
-- GENERO
CALL PROC_INS_GENERO_FILME(34,17);

-- FILME id = 35 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(35,87,2); 
CALL PROC_INS_ATOR_FILME(35,88,1);
CALL PROC_INS_ATOR_FILME(35,89,2);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(35,2);
-- GENERO
CALL PROC_INS_GENERO_FILME(35,8);

-- FILME id = 36 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(36,87,1); 
CALL PROC_INS_ATOR_FILME(36,88,2);
CALL PROC_INS_ATOR_FILME(36,89,2);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(36,2);
-- GENERO
CALL PROC_INS_GENERO_FILME(36,8);


-- FILME id = 37 --
-- ATORES --
CALL PROC_INS_ATOR_FILME(37,92,2);
CALL PROC_INS_ATOR_FILME(37,92,4);
CALL PROC_INS_ATOR_FILME(37,92,6);  
CALL PROC_INS_ATOR_FILME(37,98,1);
CALL PROC_INS_ATOR_FILME(37,99,3);
-- DIRETOR 
CALL PROC_INS_DIRETOR_FILME(37,41);
-- GENERO
CALL PROC_INS_GENERO_FILME(37,4);
CALL PROC_INS_GENERO_FILME(37,5);


-- =================== COMEÇO DAS VIEWS =================== --

-- =================== QUESTÃO 1 =================== --
CREATE VIEW maiores_papeis AS
SELECT a.nome AS "Atores",
	   COUNT(fa.papel) AS "Quantidade de Papeis no filme"
FROM genero AS g
INNER JOIN filme_genero AS f
	ON f.genero = 4 -- Crime
INNER JOIN filme_atores as fa
	ON fa.filme = f.filme
INNER JOIN atores as a
	ON a.id_atores = fa.atores
WHERE g.id_genero = f.genero
GROUP BY a.nome
ORDER BY COUNT(fa.papel) DESC LIMIT 10;

-- SELECT * FROM maiores_papeis;
-- =================== QUESTÃO 2 =================== --

CREATE VIEW lista_qntd_genero AS
SELECT g.nome, COUNT(f.genero) AS "Quantidade de filmes"
FROM genero AS g
INNER JOIN filme_genero AS f
ON g.id_genero = f.genero
GROUP BY genero
ORDER BY (COUNT(f.genero)) ASC;

-- SELECT * FROM lista_qntd_genero;


-- =================== QUESTÃO 3 =================== --
CREATE VIEW quentin_tarantino_filmes AS
SELECT  f2.titulo  AS "Títuolo do filme", 
		an.nome AS "Nome do Ator",
        p.nome AS "Nome do Papel"
FROM filme_atores AS a
INNER JOIN filme AS f2
	ON a.filme = f2.id_filme
INNER JOIN papel AS p
	ON a.papel = p.id_papel
INNER JOIN atores AS an
	ON a.atores = an.id_atores
WHERE a.atores = 92; -- Quentin Tarantino

-- SELECT * FROM quentin_tarantino_filmes; -- foi inserido mais de um papel para ele, por isso 3 retornos do mesmo filme

-- =================== QUESTÃO 4 =================== --

CREATE VIEW se_beber_nao_case AS
SELECT f.titulo AS "Título",
	   a.nome AS "Atores",
       p.nome AS "Papel",
       f.ano_lancamento AS "Ano de Lançamento",
	   d.nome AS "Diretor"
FROM filme as f
INNER JOIN filme_atores as fa
	ON fa.filme = f.id_filme
INNER JOIN atores AS a
	ON a.id_atores = fa.atores
INNER JOIN papel AS p
	ON p.id_papel = fa.papel
INNER JOIN filme_direcao as fd
	ON fd.filme = f.id_filme
INNER JOIN direcao AS d
	ON d.id_direcao = fd.direcao	
WHERE f.titulo LIKE "%Se beber, não case_%"
ORDER BY f.ano_lancamento ASC;

-- SELECT * FROM se_beber_nao_case;

-- =================== QUESTÃO 5 =================== --
CREATE VIEW atores_que_mais_participaram AS

SELECT a.nome, COUNT(DISTINCTROW fg.genero)  AS "Quantidade de gêneros participados"
FROM atores AS a
INNER JOIN filme_genero AS fg
INNER JOIN filme_atores AS fa 
	ON fa.filme = fg.filme
WHERE a.id_atores = fa.atores
GROUP BY a.nome
ORDER BY COUNT(fg.genero) DESC LIMIT 10;

-- SELECT * FROM atores_que_mais_participaram;

-- =================== FIM DAS VIEWS =================== --


-- Verificando avaliação
-- SELECT * FROM avaliacao_filme;
