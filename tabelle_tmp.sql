INSERT INTO UTENTE (Email,Nome_utente,PasswordU,isRedattore,Data_inizio_collaborazione)
VALUES 
('volutpat.nulla.dignissim@inceptos.com','Galvin Valenzuela','DIcVn7997KIV',true,'2020-08-27'),
('nec.cursus@Phasellus.org','Remedios Ward','MIKKz9C55HIx',false,'2010-08-27'),
('ligula.consectetuer@Morbi.co.uk','Amery Parks','BIaGr8269ZIJ',false,'2011-06-21'),
('ut.aliquam.iaculis@Sed.com','Kelly Cox','TIeGp8A37FIM',false,'2020-01-29'),
('tempus@blandit.ca','Robin Hernandez','BIPKc1413FIa',false,'2011-10-08');

INSERT INTO VOTO (Id,Numero_stelle,Email_Utente)
VALUES 
(1,5,'volutpat.nulla.dignissim@inceptos.com'),
(2,1,'nec.cursus@Phasellus.org'),
(3,4,'ligula.consectetuer@Morbi.co.uk'),
(4,2,'ut.aliquam.iaculis@Sed.com'),
(5,4,NULL);

INSERT INTO PIATTAFORMA (Nome)
VALUES
('Netflix'),
('Disney+'),
('AmazonPrimeVideo'),
('Infinity'),
('Sky Go');

INSERT INTO CINEMA (Nome, Indirizzo, Provincia, Regione, Contatti)
VALUES 
('Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', '+390686391361'),
('Cinema Lumière', 'Via Azzo Gardino, 65, 40122 Bologna', 'BO', 'Emilia-Romagna','+390512195311'),
('La Casa del Cinema','Salizada San Stae, 1990, 30135 Venezia', 'VE', 'Veneto','+390412747140'),
('Cinema Massimo','Via Giuseppe Verdi, 18, 10124 Torino', 'TO', 'Piemonte', '+390118138574'),
('Arcadia', 'Via Martiri della Libertà, 5, 20066 Melzo', 'MI', 'Lombardia', '+390295416445');

INSERT INTO PROGRAMMA (Titolo, Data_uscita, Durata, Genere, Produzione, Paese, Troupe, Distribuzione, Descrizione_testuale, Voto_medio, Canale)
VALUES 
('Blob','1989-01-12' ,'20', 'Satirico', 'Rai', 'Italia', 'Enrico Ghezzi, Marco Giusti, Angelo Guglielmi', 'Rai', 'Ogni puntata - la cui durata può variare dai dieci ai trenta minuti - è un attento montaggio, un riutilizzo creativo di spezzoni video presi dai canali televisivi italiani ed esteri, filmati amatoriali e web, uniti in modo da mettere a nudo la tv e i suoi protagonisti', 0, 'Rai3'),
('Antonino Chef Academy', ' 2019-10-03', '90', 'Sky', ' Enogastronomico', 'Sky', 'Italia', 'Antonino Cannavacciuolo', 'Antonino Chef Academy è un programma culinario condotto dallo chef partenopeo Cannavacciuolo. Nella location del Castello Dal Pozzo di Oleggio, il cuoco pluripremiato deve vestire i panni di professore, per guidare dieci giovani aspiranti cuochi (tra i 18 e i 23 anni) che, a seguito di un percorso formativo, si sfidano in delle prove in cui devono mettere a frutto tutte le loro conoscenze ai fornelli.', 0, 'Sky Uno'),
('Fratelli Crozza', '2017-02-12', '70', 'Show', 'Andrea Zalone', 'Italia', '', 'Rai', 'Nel corso di ogni puntata viene analizzata l’attualità politica e sociale italiana attraverso la satira, i monologhi e i personaggi - reali o di fantasia - impersonati dall''imitatore.', 0, 'Nove'),
('Alessandro Borghese - 4 ristoranti', '2015-12-10', '60', 'Talent Show', 'Sky', 'Italia', 'Alessandro Borghese', 'Sky, Rai', 'In ogni puntata si sfidano quattro ristoratori di una stessa area geografica in Italia, per stabilire chi è il migliore in una categoria, scelta di volta in volta dal conduttore in base agli elementi tipici o le particolarità della ristorazione del territorio in cui si trova.', '0', 'TV8'),
('Forum', '1985-01-02', '120', 'Show', 'Mediaset', 'Italia', 'Catherine Spaak, Paola Perego, Rita dalla Chiesa, Barbara Palombelli', 'Mediaset', 'Due persone in contrasto su un argomento - problemi familiari, incidenti stradali, liti di condominio e via dicendo - si affidano alla sentenza di un giudice. Le questioni affrontate sono ricostruzioni di fatti, interpretate da due attori: il giudizio finale non è quindi da ritenersi ufficiale.', 0, 'Canale5');

INSERT INTO SERIE (Titolo, Data_uscita, Durata, Genere, Produzione, Paese, Troupe, Distribuzione, Descrizione_testuale, Voto_medio)
VALUES
('I Medici','2016-03-07',50, 'Drammatico', 'Big Light Productions, Lux Vide, Wild Bunch', 'Italia, Gran Bretagna', 'con Daniel Sharman e Alessandra Mastronardi.','Infinity', 'I Medici è una serie tv storica che racconta l''ascesa dell''illustre famiglia Medici, padrona di Firenze durante il Rinascimento e di come la stessa si sia dovuta difendere dagli attacchi delle altre famiglie fiorentine', 0 ),
('The Queen''s Gambit', '2020-02-04',46, 'Drammatico', 'Marcus Loges, Mick Aniceto',  'USA', 'Steven Meizler, Michelle Tesoro ','Netflix','La serie esplora la vita di una bambina prodigio degli scacchi, orfana, di nome Beth Harmon, seguendo le sue vicissitudini dall''età di otto ai ventidue anni', 0 ),
('The Mandalorian', '2019-07-05', 42, 'Fantascienza', 'Lucasfilm', 'USA',  'Ludwig Göransson Andrew L. Jones, Doug Chiang ', 'Dinsey+', 'Il protagonista è Din Djarin, un cacciatore di taglie mandaloriano che opera oltre i confini della Nuova Repubblica.', 0),
('Breaking Bad', '2008-02-28', 47, 'Thriller', 'High Bridge Entertainment', 'USA', 'Dave Porter ', 'Netflix', 'Walter White è un professore di chimica di Albuquerque che vive con la moglie Skyler, incinta della loro secondogenita, e il figlio Walter "Flynn" Junior',0),
('Il trono di spade', '2011-11-03', 60 , 'Fantasy', 'Television 360', 'USA', 'Michele Clapton, April Ferry ', 'HBO', 'La serie racconta le avventure di molti personaggi ed è ambientata in un grande mondo immaginario costituito principalmente dal continente Occidentale (Westeros) e da quello Orientale (Essos)',0);

INSERT INTO STAGIONE (Numero, Titolo_Serie, Data_uscita_Serie)
VALUES
(1,'The Queen''s Gambit', '2020-02-04'),
(2,'Breaking Bad', '2008-02-28'),
(1,'Breaking Bad', '2008-02-28'),
(3,'Il trono di spade', '2011-11-03'),
(1,'Il trono di spade', '2011-11-03');

INSERT INTO EPISODIO (Titolo, Durata, Cast_episodio)
VALUES 
('Valar Dohaeris', 55, 'Ciarán Hinds, Michael McElhatton, Ian McElhinney, Finn Jones'),
('The Climb', 55, ' Gwendoline Christie, Ian McElhinney'),
('Crazy Handful of Nothin', 55, ' Max Arciniega, John Koyama'),
('Gray Matter', 45, 'Roberta Marquez, Allan Pacheco '),
('"Exchanges"', 30,'Anya Taylor-Joy');

INSERT INTO FILM (Titolo, Data_uscita, Durata, Genere, Produzione, Paese, Troupe, Distribuzione, Descrizione_testuale, Voto_medio)
VALUES 
('Matrix','1999-04-02', 133, 'Fantascienza', 'Lana Wachowski, Lilly Wachowski', 'USA', 'Con Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving, Gloria Foster', 'Warner Bros','Un mondo che sembra reale ed è invece solo un paravento per nascondere la realtà vera. Seguendo un tatuaggio sulla spalla di una ragazza l''hacker Neo scopre che la cosiddetta realtà è solo un impulso elettrico fornito al cervello degli umani da un''intelligenza artificiale.', 0),
('Teenage Mutant Ninja Turtles', '2014-05-20', 101, 'Azione', 'Paramount Pictures', 'USA', 'Aleksandr Lokensgard, Frazer Newton, John A. Canavan', 'Universal Pictures', 'La pellicola è il remake del film Tartarughe Ninja alla riscossa del 1990 e segna il riavvio della serie cinematografica, proseguita nel 2016 con Tartarughe Ninja - Fuori dall''ombra.', 0), 
('Il cosmo sul como', '2008-07-15', 94, 'Commedia', 'Medusa Film', 'Italia', 'Agostino Castiglioni Danilo Torchia Paolo Silvestri', 'Medusa Film', 'La storia si articola in quattro episodi, a cui fa da cornice la storia del Maestro Tsu''Nam.', 0),
('Ghost Rider - Spirito di vendetta', '2012-03-23', 95, 'Azione', 'Medusa Film',  'USA', ' Scott M. Gimple, David S. Goyer, Seth Hoffman', 'Medusa Film','Johnny Driverha deciso di allontanarsi per imparare a controllare i suoi nuovi poteri.', 0),
('Il gigante di ferro', '1999-08-14', 86, 'Animazione', 'Warner Bros.', 'USA', 'Carl Canga, Ray Aragon  Michael Kamen', 'Warner Bros.', 'La storia è ambientata nel 1957, durante la guerra fredda, dopo il lancio dello Sputnik 1 avvenuto il 4 ottobre. Una strana e gigantesca figura precipita in mare nel corso di una tempesta.', 0);

INSERT INTO Preferisce_F (Email_Utente,Titolo_Film,Data_uscita_Film)
VALUES 
('volutpat.nulla.dignissim@inceptos.com','Matrix','1999-04-02'),
('nec.cursus@Phasellus.org','Teenage Mutant Ninja Turtles', '2014-05-20');

INSERT INTO Preferisce_S (Email_Utente,Titolo_Serie,Data_uscita_Serie)
VALUES 
('ligula.consectetuer@Morbi.co.uk','The Mandalorian', '2019-07-05'),
('ut.aliquam.iaculis@Sed.com','Breaking Bad', '2008-02-28');

INSERT INTO Preferisce_P (Email_Utente,Titolo_Programma,Data_uscita_Programma)
VALUES 
('tempus@blandit.ca','Blob','1989-01-12');

INSERT INTO Riferisce_F (Id_Voto,Titolo_Film,Data_uscita_Film)
VALUES
(1,'Il gigante di ferro', '1999-08-14');

INSERT INTO Riferisce_S (Id_Voto,Titolo_Serie,Data_uscita_Serie)
VALUES
(2,'Il trono di spade', '2011-11-03'),
(3,'I Medici','2016-03-07');

INSERT INTO Riferisce_P (Id_Voto,Titolo_Programma,Data_uscita_Programma)
VALUES
(4,'Alessandro Borghese - 4 ristoranti', '2015-12-10');

INSERT INTO Distribuzione (Nome_Piattaforma, Numero_Stagione, Titolo_Serie, Data_uscita_Serie)
VALUES
('Netflix', 1, 'The Queen''s Gambit', '2020-02-04'),
('AmazonPrimeVideo', 2, 'Breaking Bad', '2008-02-28'),
('Infinity', 1, 'Breaking Bad', '2008-02-28'),
('Infinity', 3, 'Il trono di spade', '2011-11-03');

INSERT INTO Divisa (Titolo_Serie, Data_uscita_Serie, Numero_Stagione)
VALUES
('The Queen''s Gambit', '2020-02-04', 1),
('Breaking Bad', '2008-02-28', 2),
('Breaking Bad', '2008-02-28', 1),
('Il trono di spade', '2011-11-03', 3);

INSERT INTO ARTISTA (Nome, Cognome, Data_di_nascita, Luogo_di_nascita, Biografia_testuale, Ultimi_contenuti)
VALUES
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16', 'Miami','Anya Taylor-Joy nasce a Miami, in Florida, ed è la più piccola di sei fratelli, nati da madre anglo-spagnola e padre scozzese-argentino. Cresce fino ai 6 anni a Buenos Aires (Argentina) per poi trasferirsi nel Regno Unito, a Londra, dove è cresciuta studiando danza classica.È bilingue spagnolo-inglese. ', 'Playmobil: The Movie(2019),The New Mutants(2020),Emma(2020)'),
('Maurizio', 'Crozza', '1959-12-5', 'Genova', 'Nato a Genova nel quartiere di Borgoratti, primogenito di 4 figli, si diploma nel 1980 alla Scuola di recitazione del Teatro Stabile di Genova sotto la guida, tra gli altri, di Gian Maria Volonté. Il suo primo approccio è con il teatro classico dove lavora con i registi Egisto Marcucci,[1] William Gaskill e Marco Sciaccaluga.', 'Peggio di così si muore(1995),Consigli per gli acquisti (1997), Tutti gli uomini del deficiente(1999))'),
('Amethyst','Bentley','1989-09-07','Villafranca d''Asti', 'Famosa per la sua interpretazione di Marylin Monroe in "un medico in famiglia", è stata nominata ai Golden Globe per la parte di pianta scenica nel film "Garfild"', 'Garfild(2018), Provaci ancora prof "il Film"(2008)'),
('Mara','Herring','1940-05-13','Ajmer', 'Nata da madre polacca e padre turco si appassiona fin da tenera età allo spettacolo, icona di stile, ha recitato in molti film diretti da Checco Zalone', 'Tapinho(2014),La prima Repubblica(2015),Immigrato(2019),L''immunità di gregge(2020)'),
('Echo','Petty','1977-08-28','Lancaster', 'Famos* per il suo talento nel recitare la parte del gelataio in film per bambini. In passato ha avuto problemi poichè nessuno capisce quale sia il nome e quale il cognome', 'Pirati dei caraibi, La maledizione della prima luna(2003), Shrek 3(2007)');

INSERT INTO PARTECIPAZIONE_F (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Film, Data_uscita_Film, Ruolo, Personaggio_interpretato)
VALUES
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16', 'Matrix','1999-04-02', 'Regista', NULL),
('Mara','Herring','1940-05-13', 'Ghost Rider - Spirito di vendetta', '2012-03-23', 'Attore', 'Sedia');
INSERT INTO PARTECIPAZIONE_S (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Serie, Data_uscita_Serie, Ruolo, Personaggio_interpretato)
VALUES
('Amethyst','Bentley','1989-09-07', 'Breaking Bad', '2008-02-28', 'Attore', 'Walter Jr');
INSERT INTO PARTECIPAZIONE_P (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Programma, Data_uscita_Programma, Ruolo, Personaggio_interpretato)
VALUES
('Maurizio', 'Crozza', '1959-12-5', 'Fratelli Crozza', '2017-02-12', 'Attore', 'Crozza'),
('Amethyst','Bentley','1989-09-07', 'Alessandro Borghese - 4 ristoranti', '2015-12-10', 'Regista', NULL),
('Echo','Petty','1977-08-28' , 'Antonino Chef Academy', ' 2019-10-03', 'Attore', 'Mestolo');

INSERT INTO CONTIENE (Numero_Stagione, Titolo_Stagione, Data_uscita_Stagione, Titolo_Episodio)
VALUES
(1,'The Queen''s Gambit','2020-02-04','"Exchanges"'),
(1,  'Breaking Bad',  '2008-02-28', 'Crazy Handful of Nothin'),
(2,  'Breaking Bad',  '2008-02-28', 'Gray Matter'),
(3, 'Il trono di spade', '2011-11-03', 'Valar Dohaeris'),
(1,  'Il trono di spade', '2011-11-03', 'The Climb');

INSERT INTO Proiezione (Titolo_Film,Data_uscita_Film, Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema, Regione_Cinema, Prezzo, Ora, Data_C, Sala)
VALUES
('Matrix','1999-04-02','Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 5, '16:30', '2020-11-10', 1),
('Teenage Mutant Ninja Turtles','2014-05-20','Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 5, '16:45', '2020-09-10', 2),
('Il cosmo sul como', '2008-07-15', 'Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 7, '12:30', '2020-12-06', 1),
('Il cosmo sul como', '2008-07-15', 'Cinema Lumière', 'Via Azzo Gardino, 65, 40122 Bologna', 'BO', 'Emilia-Romagna', 8, '20:00', '2021-11-10', 6),
('Il gigante di ferro', '1999-08-14', 'La Casa del Cinema','Salizada San Stae, 1990, 30135 Venezia', 'VE', 'Veneto', 4.50, '18:30', '2020-04-03', 3);
