create table UTENTE (
    Email varchar(64) NOT NULL CHECK (Email LIKE '%_@_%._%'),
    Nome_utente varchar(32) not null,
    PasswordU varchar(32) not null check(length(PasswordU)>=8),
    isRedattore boolean not null default false,
    Data_inizio_collaborazione date default null,
    constraint UTENTE_P_KEY primary key(Email)
);

create table FILM(
    Titolo varchar(64) not null,
    Data_uscita date not null,
    Durata int CHECK(Durata>0),
    Genere varchar(128),
    Produzione varchar(128),
    Paese varchar(128),
    Troupe varchar(1000),
    Distribuzione varchar(128),
    Descrizione_testuale varchar(1000),
    Voto_medio decimal(2,1),
    constraint FILM_P_KEY primary key (Titolo, Data_uscita)
);

create table SERIE(
    Titolo varchar(64) not null,
    Data_uscita date not null,
    Durata int check(Durata>0),
    Genere varchar(128),
    Produzione varchar(128),
    Paese varchar(128),
    Troupe varchar(1000),
    Distribuzione varchar(128),
    Descrizione_testuale varchar(1000),
    Voto_medio decimal(2,1),
    constraint SERIE_P_KEY primary key (Titolo, Data_uscita)
);

create table STAGIONE(
    Numero int not null,
    Titolo_Serie varchar(128) not null,
    Data_uscita_Serie  date not null,
   constraint STAGIONE_P_KEY primary key (Numero, Titolo_Serie, Data_uscita_Serie),
   constraint STAGIONE_F_KEY_SERIE foreign key (Titolo_Serie, Data_uscita_Serie) references SERIE(Titolo, Data_uscita)
);

create table PROGRAMMA(
    Titolo varchar(64) not null,
    Data_uscita date not null,
    Durata int check(Durata>0),
    Genere varchar(128),
    Produzione varchar(128),
    Paese varchar(128),
    Troupe varchar(1000),
    Distribuzione varchar(128),
    Descrizione_testuale varchar(1000),
    Voto_medio decimal(2,1),
    Canale varchar(128),
    constraint PROGRAMMA_P_KEY primary key (Titolo, Data_uscita)
);

create table VOTO (
    Id serial,
    Numero_stelle int check (Numero_stelle >=1 AND Numero_stelle <=5),
    Email_Utente varchar (64),
    constraint VOTO_F_KEY_UTENTE foreign key (Email_Utente)
	references UTENTE(Email),
    constraint VOTO_P_KEY primary key (Id)
);

create table PREFERISCE_F (
    Email_Utente varchar (64),
    Titolo_Film varchar (64),
    Data_uscita_Film date,
    constraint PREFERISCE_F_P_KEY primary key (Email_Utente, Titolo_Film, Data_uscita_Film),
    constraint PREFERISCE_F_KEY_UTENTE foreign key (Email_Utente) references UTENTE(Email),
    CONSTRAINT PREFERISCE_F_KEY_FILM foreign key (Data_uscita_Film, Titolo_Film)references FILM(Data_uscita,Titolo)
);

create table PREFERISCE_S ( 
    Email_Utente varchar (64), 
    Titolo_Serie varchar (64), 
    Data_uscita_Serie date, 
    constraint PREFERISCE_S_P_KEY primary key (Email_Utente, Titolo_Serie, Data_uscita_Serie),
    constraint PREFERISCE_S_KEY_UTENTE foreign key (Email_utente) references UTENTE(Email),
    constraint PREFERISCE_S_KEY_SERIE foreign key (Data_uscita_Serie, Titolo_Serie) references SERIE(Data_uscita,Titolo)
);
    
create table PREFERISCE_P ( 
    Email_Utente varchar (64), 
    Titolo_Programma varchar (64), 
    Data_uscita_Programma date, 
    constraint PREFERISCE_P_P_KEY primary key (Email_Utente, Titolo_Programma, Data_uscita_Programma),
    constraint PREFERISCE_P_KEY_UTENTE foreign key (Email_utente) references UTENTE(Email),
    constraint PREFERISCE_P_KEY_PROGRAMMA foreign key (Data_uscita_Programma, Titolo_Programma) references PROGRAMMA(Data_uscita,Titolo)
); 

create table RIFERISCE_F ( 
    Id_Voto serial, 
    Titolo_Film varchar (64), 
    Data_uscita_Film date, 
    constraint riferisce_F_P_KEY primary key (Id_Voto, Titolo_Film, Data_uscita_Film),
    constraint riferisce_F_KEY_VOTO foreign key (Id_Voto) references VOTO(Id),
    constraint riferisce_F_KEY_FILM foreign key (Data_uscita_Film, Titolo_Film) references FILM(Data_uscita,Titolo) 
);
create table RIFERISCE_P ( 
    Id_Voto serial, 
    Titolo_programma varchar (64), 
    Data_uscita_programma date, 
    constraint riferisce_P_P_KEY primary key (Id_Voto, Titolo_programma, Data_uscita_programma),
    constraint riferisce_P_KEY_VOTO foreign key (Id_Voto) references VOTO(Id),
    constraint riferisce_P_KEY_programma foreign key (Data_uscita_programma, Titolo_programma) references programma(Data_uscita,Titolo) 
);

create table RIFERISCE_S ( 
    Id_Voto serial,                      
    Titolo_serie varchar (64),
    Data_uscita_serie date, 
    constraint riferisce_S_P_KEY primary key (Id_Voto, Titolo_serie, Data_uscita_serie),
    constraint riferisce_S_KEY_VOTO foreign key (Id_Voto) references VOTO(Id),
    constraint riferisce_S_KEY_serie foreign key (Data_uscita_serie, Titolo_serie) references serie(Data_uscita,Titolo) 
); 



create table CINEMA(
    Nome varchar(128) not null,
    Indirizzo varchar(128) not null,
    Provincia varchar(128) not null,
    Regione varchar(128) not null,
    Contatti varchar(1000),
    constraint CINEMA_P_KEY primary key (Nome, Indirizzo, Provincia, Regione)
);

create table ARTISTA(
    Nome varchar(64) not null,
    Cognome varchar(64) not null,
    Data_di_nascita date not null,
    Luogo_di_nascita varchar(128),
    Biografia_testuale varchar(1000),
    Ultimi_contenuti varchar(1000),
    constraint ARTISTA_P_KEY primary key (Nome, Cognome, Data_di_nascita)
);

create table EPISODIO(
    Titolo varchar(128) not null,
    Durata int,
    Cast_episodio varchar(1000),
   constraint EPISODIO_P_KEY  primary key (Titolo)
);

create table PIATTAFORMA(
    Nome varchar(128) not null,
    constraint PIATTAFORMA_P_KEY primary key(Nome)
);

create table PARTECIPAZIONE_F(
    Nome_Artista varchar(128) not null,
    Cognome_Artista varchar(128) not null,
    Data_di_nascita_Artista date not null,
    Titolo_Film varchar(128) not null,
    Data_uscita_Film date not null,
    Ruolo varchar(64),
    Personaggio_interpretato varchar(64),
    constraint PARTECIPAZIONE_F_P_KEY primary key( Nome_Artista, Cognome_Artista,
 Data_di_nascita_Artista, Titolo_Film, Data_uscita_Film),
    constraint PARTECIPAZIONE_F_F_KEY_ARTISTA foreign key (Nome_Artista,
 Cognome_Artista,Data_di_nascita_Artista) references ARTISTA(Nome,Cognome,
 Data_di_nascita),
    constraint PARTECIPAZIONE_F_F_KEY_FILM foreign key (Titolo_Film,Data_uscita_Film) 
references FILM(Titolo, Data_uscita) 
);

create table PARTECIPAZIONE_S(
    Nome_Artista varchar(128) not null,
    Cognome_Artista varchar(128) not null,
    Data_di_nascita_Artista date not null,
    Titolo_Serie varchar(128) not null,
    Data_uscita_Serie date not null,
    Ruolo varchar(64),
    Personaggio_interpretato varchar(64),
    constraint PARTECIPAZIONE_S_P_KEY primary key( Nome_Artista, Cognome_Artista,
 Data_di_nascita_Artista, Titolo_Serie, Data_uscita_Serie),
    constraint PARTECIPAZIONE_F_F_KEY_ARTISTA foreign key (Nome_Artista,
 Cognome_Artista,Data_di_nascita_Artista) references ARTISTA(Nome,Cognome,
 Data_di_nascita),
    constraint PARTECIPAZIONE_S_KEY_FILM foreign key (Titolo_Serie, Data_uscita_Serie) 
references SERIE(Titolo, Data_uscita) 
);


create table PARTECIPAZIONE_P(
    Nome_Artista varchar(128) not null,
    Cognome_Artista varchar(128) not null,
    Data_di_nascita_Artista date not null,
    Titolo_Programma varchar(128) not null,
    Data_uscita_Programma date not null,
    Ruolo varchar(64),
    Personaggio_interpretato varchar(64),
    constraint PARTECIPAZIONE_P_P_KEY primary key( Nome_Artista, Cognome_Artista,
 Data_di_nascita_Artista, Titolo_Programma, Data_uscita_Programma),
    constraint PARTECIPAZIONE_P_F_KEY_ARTISTA foreign key (Nome_Artista,
 Cognome_Artista,Data_di_nascita_Artista) references ARTISTA(Nome,Cognome,
 Data_di_nascita),
    constraint PARTECIPAZIONE_F_F_KEY_PROGRAMMA foreign key (Titolo_Programma,
 Data_uscita_Programma) references PROGRAMMA(Titolo, Data_uscita) 
);

create table DISTRIBUZIONE(
    Nome_Piattaforma varchar(128) not null,
    Numero_Stagione int not null,
    Titolo_Serie varchar(128) not null,
    Data_uscita_Serie date not null,
    constraint DISTRIBUZIONE_P_KEY primary key(Nome_Piattaforma, Numero_Stagione, 
Titolo_Serie, Data_uscita_Serie),
    constraint DISTRIBUZIONE_F_KEY_PIATTAFORMA foreign key(Nome_Piattaforma) 
references PIATTAFORMA(Nome),
    constraint DISTRIBUZIONE_F_KEY_STAGIONE foreign key(Numero_Stagione, 
Titolo_Serie, Data_uscita_Serie) references STAGIONE(Numero, Titolo_Serie,
Data_uscita_Serie)
);

create table DIVISA(
    Titolo_Serie varchar(128) not null, 
    Data_uscita_Serie date not null,
    Numero_Stagione int not null,
    constraint DIVISA_P_KEY primary key (Titolo_Serie, Data_uscita_Serie, Numero_Stagione),
    constraint DIVISA_F_KEY_SERIE foreign key(Titolo_Serie, Data_uscita_Serie) references SERIE(Titolo, Data_uscita),
    constraint DIVISA_F_KEY_STAGIONE foreign key (Numero_Stagione, Titolo_Serie, Data_uscita_Serie) references STAGIONE(Numero, Titolo_Serie, Data_uscita_Serie)
);
