---
lang: it-IT
title: "Basi di Dati, Progetto di Laboratorio"
author:
- "Federico Serra, matricola 898925"
- "Alessandro Nocera, matricola 886732"
numbersections: true
urlcolor: blue
---

<!--
TODO
aggiustare le relazioni:
se 1:1 -> cardinalità della relazione
se 0:1 -> cardinalità al massimo della relazione

divisa non ha gli identificatori di serie nello schema relazionale + creazione tabelle
FIX
NOTE
in troupe -> sceneggiatura fotografia musiche
indirizzo -> via + città
geometry: "left=3cm,right=3cm,top=2cm,bottom=2cm"
for code styling check (anche no, bene il default):
https://learnbyexample.github.io/customizing-pandoc/

UTIL
//seleziona il voto medio
update film f1 set voto_medio =(
  select avg(v.numero_stelle) from film f2
  join riferisce_f r on f2.titolo = r.titolo_film 
  join voto  v on v.id = r.id_voto
  where f2.titolo=f1.titolo and f1.data_uscita=f2.data_uscita
)
where f1.titolo='Il gigante di ferro';

//film preferiti da un utente x
select * 
from film f join preferisce_f p on f.titolo=p.titolo_film
where p.email_utente='emailutente';

//voti delle serie
select * from serie s
join riferisce_s r on s.titolo = r.titolo_serie
join voto  v on v.id = r.id_voto
-->

\newpage

# Progettazione concettuale

## Requisiti iniziali

Si vuole realizzare una base di dati per la gestione di una piattaforma che fornisce
informazioni su film in uscita nei cinema e su serie e programmi TV in onda,
liberamente ispirato a piattaforme come ComingSoon.\
Un numero limitato di utenti della redazione si occupa di aggiornare le
informazioni sui contenuti disponibili inserendo i dati di film e serie,
comprese le date di uscita e programmazione in sala e in TV.
Degli utenti si memorizzano nome utente, password e indirizzo email.
Per i redattori si tiene traccia anche della data di inizio collaborazione.

I contenuti hanno una serie di caratteristiche ~~come evidenziato in Figura 1~~,
quali: data di uscita, genere, anno, regia, paese, durata, distribuzione,
sceneggiatura, fotografia, musiche e produzione.
In particolare, a ogni film e serie TV è associata una lista di attori, con
l’indicazione del personaggio interpretato.
Notare che alcune informazioni
tipiche dei film, ad esempio la regia, per le serie TV sono specifiche
dei singoli episodi.
Attori e registi hanno una propria scheda ~~(esempio in Figura 2)~~ dove vengono
visualizzati foto, nome, cognome, dati anagrafici e biografia.
Qui può essere anche mostrata una lista dei contenuti più
recenti a cui la persona ha partecipato.

I film vengono proiettati in svariati cinema in tutto il paese.
Per ogni cinema, si tiene traccia del suo nome, contatti, e localizzazione
(regione, provincia e indirizzo). La proiezione avviene a degli orari specifici
in diverse date, in una delle sale disponibili al cinema, e
comporta il pagamento di un biglietto il cui prezzo è indicato sul sito.

Programmi e serie TV vanno invece in onda su diverse piattaforme
(es. Netflix, Rai Gulp, …), che possono essere canali TV tradizionali o
piattaforme di streaming video. Le serie TV sono organizzate per genere,
come i film, es. commedia, drammatico, etc. In più, i serial
sono composti da episodi, racchiusi in una o più stagioni, dove ogni episodio ha
uno specifico titolo, durata, regista, e sceneggiatore. Anche per i programmi
sono memorizzate alcune informazioni, come l’anno di messa in onda, genere,
paese, durata e una descrizione testuale.

I visitatori del sito, previa registrazione tramite email e password, possono
lasciare un voto (da 1 a 5 stelline) su qualunque contenuto. La media dei voti
ricevuti da film e programmi viene mostrata nelle rispettive schede. Inoltre,
gli utenti possono cliccare su un link “inserisci tra i preferiti” presente
nelle schede dei contenuti, in modo da poter visualizzare in seguito i
contenuti salvati. Nel momento della cancellazione di un utente dal sito,
i suoi preferiti possono essere rimossi dal database, mentre i voti espressi
dal visitatore rimangono in memoria.

\newpage

## Glossario dei termini

\begin{table}[h!]
\begin{adjustwidth}{-.9in}{-.9in}
\centering
\begin{tabular}{llll}
\textit{Termine}                           & \textit{Descrizione}                                                                                                                               & \textit{Sinonimi}                                   & \textit{Collegamento}                                                                          \\ \hline
\multicolumn{1}{|l|}{\textbf{Piattaforme}} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Servizi informatici che rendono \\ disponibili agli utenti le stagioni\\ di una serie\end{tabular}} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Piattaforme di streaming\\ video\end{tabular}} & \multicolumn{1}{l|}{Serie}                                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuti}}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Insieme di produzioni\\ audiovisive (film, serie e programmi)\end{tabular}}                         & \multicolumn{1}{l|}{}                                                                         & \multicolumn{1}{l|}{Film, serie, programmi}                                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{Utente}}    & \multicolumn{1}{l|}{Persona registrata sul sito}                                                                                                   & \multicolumn{1}{l|}{Visitatori}                                                               & \multicolumn{1}{l|}{Voto}                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Redattore}}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Utente che aggiorna informazioni\\ riguardanti i contenuti presenti\\ sul sito\end{tabular}}       & \multicolumn{1}{l|}{Utenti della redazione}                                                   & \multicolumn{1}{l|}{Voto}                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Serie}}       & \multicolumn{1}{l|}{Serie TV disponibili sul sito}                                                                                                 & \multicolumn{1}{l|}{Serie TV, serial}                                                         & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Stagione, episodio,\\ piattaforma\end{tabular}} \\ \hline
\multicolumn{1}{|l|}{\textbf{Stagione}}    & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Raggruppamento in episodi di una\\ serie\end{tabular}}                                              & \multicolumn{1}{l|}{}                                                                         & \multicolumn{1}{l|}{Episodio, serie}                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Episodio}}    & \multicolumn{1}{l|}{Singola unità di una stagione}                                                                                                 & \multicolumn{1}{l|}{}                                                                         & \multicolumn{1}{l|}{Stagione, attore, regista}                                                 \\ \hline
\multicolumn{1}{|l|}{\textbf{Film}}        & \multicolumn{1}{l|}{Film presenti sul sito}                                                                                               & \multicolumn{1}{l|}{}                                                                         & \multicolumn{1}{l|}{Cinema, attore, regista}                                                   \\ \hline
\multicolumn{1}{|l|}{\textbf{Attore}}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Colui che recita in un contenuto\\ interpretando un ruolo\end{tabular}}                             & \multicolumn{1}{l|}{Persona}                                                                  & \multicolumn{1}{l|}{Contenuto}                                                                 \\ \hline
\multicolumn{1}{|l|}{\textbf{Regista}}     & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Colui che si occupa della regia\\ dei contenuti\end{tabular}}                                       & \multicolumn{1}{l|}{Regia, persona}                                                           & \multicolumn{1}{l|}{Contenuto}                                                                 \\ \hline
\multicolumn{1}{|l|}{\textbf{Cinema}}      & \multicolumn{1}{l|}{Luogo in cui è proiettato un film}                                                                                             & \multicolumn{1}{l|}{}                                                                         & \multicolumn{1}{l|}{Film}                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto}}        & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Voto numerico (da 1 a 5 stelle) \\ espresso da un utente del sito\end{tabular}}                   & \multicolumn{1}{l|}{}                                                                         & \multicolumn{1}{l|}{Contenuto, utente}                                                         \\ \hline
\end{tabular}%
\end{adjustwidth}
\end{table}

\newpage

## Requisiti rivisti e strutturati in gruppi di frasi omogenee

* **Frasi di carattere generale:** Si vuole realizzare una base di dati per la gestione di un sito che fornisce
informazioni su film in uscita nei cinema e su serie e programmi TV in onda,
liberamente ispirato a piattaforme come ComingSoon.

* **Frasi relative agli utenti:** Gli utenti possono essere di due tipologie: iscritti o redattori.
Entrambi si registrano tramite email e password. Possono votare e aggiungere ai preferiti qualunque contenuto.
Nel momento della cancellazione di un utente dal sito, i suoi preferiti possono essere rimossi dal database,
mentre i voti espressi rimangono in memoria.
Per gli utenti si memorizzano nome utente, password e indirizzo email.

* **Frasi relative ai redattori:** I redattori sono utenti che si occupano di aggiornare le
informazioni sui contenuti disponibili inserendo i dati dei contenuti,
comprese le date di uscita e programmazione nei cinema e nei canali televisivi.
Per i redattori si registra anche della data di inizio collaborazione.

* **Frasi relative ai contenuti:** I contenuti possono essere di tre tipi: serie, film e programmi.
Per i contenuti rappresentiamo: titolo, data di uscita,
genere, paese, durata, distribuzione, produzione e i membri della troupe
(attori con relativo personaggio interpretato, regista, sceneggiatori, i direttori
della fotografia, i responsabili delle musiche).\
Per i programmi memorizziamo anche il canale dove è disponibile il contenuto. \
Per i film memorizziamo invece anche i cinema dove saranno disponibili.

* **Frasi relative alle serie:** Le serie sono contenuti divisi in stagioni.
Le stagioni vanno in onda su siti di streaming online e sono divise in
episodi. Per ogni episodio si memorizza titolo, durata, regista, sceneggiatore e la lista di attori
che vi partecipano.

* **Frasi relative ai cinema:** Per i cinema rappresentiamo nome, contatti, e
localizzazione (regione, provincia e indirizzo). La proiezione dei film è caratterizzata
da: una sala del cinema, una data e un'ora, il prezzo del biglietto.

* **Frasi relative agli artisti:** Gli artisti possono essere
attori o registi. Per gli artisti è registrata una scheda personale contenente:
foto, nome, cognome, età, data e luogo di nascita, biografia e gli ultimi contenuti
a cui ha partecipato.

## Schema E-R + business rules

### Scherma E-R

![](./merge/25-11-2020.jpg)

### Business rules

* Quando un utente viene cancellato i voti espressi rimangono, dati personali e preferiti vengono rimossi.
* Il valore del voto è compreso tra 1 e 5 stelle.
* L'attributo voto medio di un contenuto indica la media dei voti assegnati dagli utenti.
* Per il singolo artista viene mantenuta una lista dei contenuti a cui ha partecipato.
* I redattori aggiornano le informazioni relative ai contenuti.
* L'attributo ruolo dell'associazione partecipazione può assumere i valori regista o attore. Nel primo caso l'attributo
personaggio interpretato avrà valore `NULL`, nel secondo invece avrà come valore il nome del personaggio interpretato dall'attore
all'interno del contenuto.

\newpage

# Progettazione logica

## Tavola dei volumi

\begin{table}[h!]
\begin{adjustwidth}{-.6in}{-.9in}
\begin{tabular}{llll}
\textit{Concetto}                             & \textit{Tipo}                  & \textit{Volume}              & \textit{Motivazione}                                                                                                                                                                                                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Utente}}         & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{50.000}  & \multicolumn{1}{l|}{Approssimazione della somma tra Iscritti e Redattori}                                                                                                                                                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Iscritto}}       & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{50.000}  & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Ci si basa sulla piattaforma italiana mymovies che \\ contava nel 2018 una media di 500.000 utenti unici\\ giornalieri, si suppone che il 10\% sia registrato.\end{tabular}}                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Redattore}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{10}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Mymovies conta 5 content manager, più altri collaboratori.\\ Si sceglie 10 come numero di profili abilitati alla modifica \\ calcolandone uno per ogni content manager più altri 5 \\ divisi tra i collaboratori.\end{tabular}} \\ \hline
\multicolumn{1}{|l|}{\textbf{Preferisce}}     & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{250.000} & \multicolumn{1}{l|}{Si considera una media di 5 film preferiti per utente}                                                                                                                                                                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Assegna}}        & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{5}       & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Media di 5 voti per utente ottenuta dividendo i voti totali per\\ gli utenti\end{tabular}}                                                                                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Voti}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{250.000} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Da mymovies si evince che ci sono circa \\ 200.00 recensioni totali, si considera un voto per recensione \\ più un voto per utente che non lascia il commento\end{tabular}}                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Riferisce}} & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{500}     & \multicolumn{1}{l|}{Si considera che il 1\% di utenti vota un film.}                                                                                                                                                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuto}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{40.000}  & \multicolumn{1}{l|}{Basandosi su dati di un articolo su mymovies}                                                                                                                                                                                                              \\ \hline
\multicolumn{1}{|l|}{\textbf{Partecipazione}} & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{20}      & \multicolumn{1}{l|}{Si stima un media di partecipazione a 20 contenuti per artista}                                                                                                                                                                                            \\ \hline
\multicolumn{1}{|l|}{\textbf{Programma}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{500}     & \multicolumn{1}{l|}{Approssimazione dati mymovies}                                                                                                                                                                                                                             \\ \hline
\multicolumn{1}{|l|}{\textbf{Film}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{10.000}  & \multicolumn{1}{l|}{Approssimazione dati mymovies}                                                                                                                                                                                                                             \\ \hline
\multicolumn{1}{|l|}{\textbf{Proiezione}}     & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{420.000} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si stima che in ogni cinema ci siano 4 spettacoli al giorno, \\ moltiplicati per i 30 giorni (un film rimane in programmazione\\ un mese), moltiplicati per i cinema in Italia\end{tabular}}                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{Cinema}}         & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{3.500}   & \multicolumn{1}{l|}{Numero di cinema presenti su mymovies}                                                                                                                                                                                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Serie}}          & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1.750}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Approssimazione basata sul fatto che sono 600 le serie\\ presenti su Netflix, considerando che non è presente 1 \\ serie su 3.\end{tabular}}                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Divisa}}         & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{3.500}   & \multicolumn{1}{l|}{Stesso valore di Stagione.}                                                                                                                                                                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Stagione}}       & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{3.500}   & \multicolumn{1}{l|}{Media di 2 stagioni a serie.}                                                                                                                                                                                                                              \\ \hline
\multicolumn{1}{|l|}{\textbf{Contiene}}       & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{29.500}  & \multicolumn{1}{l|}{Stesso valore di Episodio.}                                                                                                                                                                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Distribuzione}}  & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{600}     & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si stima che per ogni piattaforma è presente circa  il 30\% \\ delle serie.\end{tabular}}                                                                                                                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{Episodio}}       & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{29.500}  & \multicolumn{1}{l|}{Media di 8-9 episodi a stagione}                                                                                                                                                                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Piattaforma}}    & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{10}      & \multicolumn{1}{l|}{Si considerano le 10  principali piattaforme in Italia}                                                                                                                                                                                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{Attore}}         & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{3.000}   & \multicolumn{1}{l|}{Gli artisti rimanenti togliendo i registi}                                                                                                                                                                                                         \\ \hline
\multicolumn{1}{|l|}{\textbf{Regista}}        & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{2.000}   & \multicolumn{1}{l|}{Si considera una media di 20 contenuti girati per regista}                                                                                                                                                                                                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Artisti}}        & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{5.000}   & \multicolumn{1}{l|}{Dati approssimati ComingSoon}                                                                                                                                                                                                                              \\ \hline
\end{tabular}%
\end{adjustwidth}
\end{table}

\newpage

## Tavola delle operazioni


\begin{table}[h!]
\begin{adjustwidth}{-.9in}{-.6in}
\begin{tabular}{llll}
\textit{Operazione}                                                                                                    & \textit{Tipo}                    & \textit{Frequenza}                  & \textit{Motivazione}                                                                                                                                                                                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Registrazione utente}}                                                                    & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{10/giorno}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considera il numero di utenti totali attuali \\ dopo 15 anni di attività\end{tabular}}                                                                                                                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Cancellazione utente}}                                                                    & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{1/giorno}       & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considera che l'eliminazione avvenga \\ meno raramente della registrazione, si \\ ottiene così una media di +9 utenti/giorno \\ coerente con i valori riportati nella tavola\\ dei volumi\end{tabular}} \\ \hline
\multicolumn{1}{|l|}{\textbf{Modifica dati utente}}                                                                    & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{5/mese}         & \multicolumn{1}{l|}{Operazione fatta raramente}                                                                                                                                                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{\begin{tabular}[c]{@{}l@{}}Assegnazione di un voto a \\ contenuto\end{tabular}}}          & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{45/giorno}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considera il numero di voti dopo 15 anni\\ di attività\end{tabular}}                                                                                                                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{\begin{tabular}[c]{@{}l@{}}Aggiornamento voto medio\\ di un contenuto\end{tabular}}}      & \multicolumn{1}{l|}{Batch}        & \multicolumn{1}{l|}{45/giorno}      & \multicolumn{1}{l|}{Uguale al numero di assegnazioni di voto}                                                                                                                                                                                             \\ \hline
\multicolumn{1}{|l|}{\textbf{\begin{tabular}[c]{@{}l@{}}Aggiunta di un contenuto \\ ai preferito\end{tabular}}}        & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{45/giorno}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Numero totale dei preferiti suddivisi in 15 \\ anni di attività\end{tabular}}                                                                                                                              \\ \hline
\multicolumn{1}{|l|}{\textbf{\begin{tabular}[c]{@{}l@{}}Eliminazione di un contenuto \\ tra i preferiti\end{tabular}}} & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{1/giorno}       & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Molto inferiore al numero di aggiunta dei \\ preferiti\end{tabular}}                                                                                                                                        \\ \hline
\multicolumn{1}{|l|}{\textbf{Aggiunta di un contenuto}}                                                                & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{3/giorno}       & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considerano film e serie presenti sulla \\ piattaforma dopo 15 anni di attività\end{tabular}}                                                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Modifica contenuto}}                                                                      & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{1/mese}         & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si suppone di dover modificare un contenuto \\ molto raramente\end{tabular}}                                                                                                                               \\ \hline
\multicolumn{1}{|l|}{\textbf{\begin{tabular}[c]{@{}l@{}}Aggiornamento cinema di \\ proiezione del film\end{tabular}}}  & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{90/mese}        & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}1/mese per i film attualmente al cinema, contando\\  una media di 1000 film prodotti all'anno\end{tabular}}                                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Aggiunta stagione alla serie}}                                                            & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{1/mese}         & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considera la media uscita di una nuova serie \\ di 1 al mese\end{tabular}}                                                                                                                              \\ \hline
\multicolumn{1}{|l|}{\textbf{Aggiunta artista}}                                                                        & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{1/mese}         & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considera che l'aggiunta della scheda di \\ un artista avvenga raramente, più raramente\\ della modifica\end{tabular}}                                                                                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Modifica/aggiornamento artista}}                                                          & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{3/giorno}       & \multicolumn{1}{l|}{Legato all'aggiunta di un contenuto}                                                                                                                                                                                                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Visualizzazione preferiti}}                                                               & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{800/giorno}     & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si considera che un utente guarda i propri \\ preferiti raramente, una volta ogni due mesi\end{tabular}}                                                                                                   \\ \hline
\multicolumn{1}{|l|}{\textbf{Visualizzazione contenuto}}                                                               & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{500.000/giorno} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Ci si basa sui dati di mymovies, è l'operazione \\ in assoluto più frequente\end{tabular}}                                                                                                                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Visualizzazione artista}}                                                                 & \multicolumn{1}{l|}{Interattivo} & \multicolumn{1}{l|}{1.000/giorno}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Minore della visualizzazione del contenuto, si \\ stima $\frac{1}{5}$ delle visualizzazioni del contenuto\end{tabular}}                                                                                               \\ \hline
\end{tabular}%
\end{adjustwidth}
\end{table}

\newpage

## Ristrutturazione dello schema E-R

### Analisi delle ridondanze

1. Attributo età di artista (attributo derivabile): l'attributo età è derivabile considerando l'anno di nascita e la data odierna. Il mantenimento di questo attributo comporta l'aggiornamento costante di un dato (età) secondo la data di nascita dell'artista. Per il precedente motivo si è scelto di eliminare la ridondanza, diminuendo gli aggiornamenti dei dati relativi all'artista.
2. Attributo Voto medio di contenuto (attributo derivabile da entità e conteggio): l'attributo voto medio è derivabile dal conteggio delle occorrenze dell'entità voto facente riferimento ad un dato contenuto. In questa somma, se si tiene anche conto del valore dei punteggi (il numero di stelle), si può facilmente derivare che $\frac{totale punteggi}{cardinalit\grave{a} voto} = voto medio$. 

Si è scelto di analizzare la seconda ridondanza in quanto ritenuta più significativa.

\begin{figure}
    \centering 
    \includegraphics[width=200pt]{./merge/snippetRidondanza.jpg}
\end{figure}

<!-- ![](./merge/snippetRidondanza.png){ width=50% } --> 

**Operazione 1 - assegnazione di un voto a un contenuto - **

*Accessi con ridondanza:*

\begin{table}[h]
\centering
\begin{tabular}{llll}
\textit{Concetto}                             & \textit{Costrutto}             & \textit{Accessi}       & \textit{Tipo}                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Scrittura} \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Lettura}   \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto contenuto}} & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Scrittura} \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuto}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Scrittura} \\ \hline
\end{tabular}%
\end{table}

\centerline{Il costo è di $(45\times2) + 45 + (45\times2) + (45\times2) = 315$ accessi al giorno, contando gli accessi in scrittura come doppi.}

*Accessi senza ridondanza:*

\begin{table}[h!]
\centering
\begin{tabular}{llll}
\textit{Concetto}                             & \textit{Costrutto}          & \textit{Accessi}       & \textit{Tipo}                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto}}           & \multicolumn{1}{l|}{Entità} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Scrittura} \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto contenuto}} & \multicolumn{1}{l|}{Entità} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Scrittura} \\ \hline
\end{tabular}%
\end{table}

\centerline{Il costo è di $(45\times2) + (45\times2) = 180$ accessi al giorno, contando gli accessi in scrittura come doppi.}

**Operazione 2 - visualizzazione contenuto (include il voto medio) - **

*Accessi con ridondanza:*

\begin{table}[h]
\centering
\begin{tabular}{llll}
\textit{Concetto}                        & \textit{Costrutto}          & \textit{Accessi}       & \textit{Tipo}                \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuto}} & \multicolumn{1}{l|}{Entità} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Lettura} \\ \hline
\end{tabular}%
\end{table}

\centerline{Il costo è di $500000$ accessi al giorno.}

*Accessi senza ridondanza:*

\begin{table}[h]
\centering
\begin{tabular}{llll}
\textit{Concetto}                             & \textit{Costrutto}             & \textit{Accessi}       & \textit{Tipo}                  \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Lettura} \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto contenuto}} & \multicolumn{1}{l|}{Associazione} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Lettura} \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuto}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Lettura} \\ \hline
\end{tabular}%
\end{table}

\centerline{Il costo è di $500000 + 500000 + 500000 = 1500000$ accessi al giorno.}

**Operazione 1 + operazione 2 - costi totali -**

*Con ridondanze (operazione 1 + operazione 2):* \newline
Costo totale in numero di accessi $315 + 500000 = 500315$.

*Senza ridondanze (operazione 1 + operazione 2):* \newline
Costo totale in numero di accessi $180 + 1500000 = 1500180$.

*Costi aggiuntivi in termini di spazio:* \
Ipotesi: si utilizzano $4 byte$ per memorizzare il valore del voto medio. \
Spazio totale necessario: $4 \times 40000 = 160000 = 160 Kbyte$ 

\begin{table}[h]
\centering
\begin{tabular}{lll}
                                       & \textit{Con ridondanza}        & \textit{Senza ridondanza}    \\ \cline{2-3} 
\multicolumn{1}{l|}{\textit{Numero accessi}}    & \multicolumn{1}{l|}{500315}    & \multicolumn{1}{l|}{1500180} \\ \cline{2-3} 
\multicolumn{1}{l|}{\textit{Spazio aggiuntivo}} & \multicolumn{1}{l|}{$160 Kbyte$} & \multicolumn{1}{l|}{$0 Kbyte$} \\ \cline{2-3} 
\end{tabular}
\end{table}

**Decisione:**\
Considerata la differenza di circa 1000000 di accessi e lo spreco di memoria non ingente, si è scelto di lasciare la ridondanza,
essendo anche l'operazione 2 la più frequente sulla base di dati.

### Eliminazione delle generalizzazioni

**1. Utente - Iscritto, Redattore** (*generalizzazione totale ed esclusiva*)

![](./merge/gen1.jpg)

Motivazione: si è scelto di accorpare le entità figlie della generalizzazione nell'entità padre, semplificando così la base di dati.
Si è aggiunto a tale scopo un flag $isRedattore$ per indicare se l'utente è un iscritto o un redattore.

**2. Artista - Attore, Regista** (*generalizzazione totale ed esclusiva*)

![](./merge/gen2.jpg)

Motivazione: si è scelto di accorpare le entità figlie della generalizzazione nell'entità padre, in quanto gli accessi alla tabelle sono per la maggior parte contestuali. Se osserviamo la tavola delle operazioni infatti notiamo che la visualizzazione di un artista avviene 1000 volte
in un giorno, la visualizzazione di un contenuto (che richiede l'accesso ad entrambe le tabelle) invece occorre 500000 volte nello stesso tempo.
Per questo accorpamento non è stato necessaria l'aggiunta di attributi, in quanto la differenza tra attore e regista viene già espressa
dall'attributo ruolo dell'associazione partecipazione.

**3. Contenuto - Programma, Film, Serie** (*generalizzazione totale ed esclusiva*)

![](./merge/gen3.jpg)

Motivazione: si è scelto di accorpare la entità padre della generalizzazione nelle entità figlie, in quanto gli accessi alla tabelle figlie sono distinti.

### Partizionamento/accorpamento di entità e associazioni

Non si è valutato necessario il partizionamento e/o l'accorpamento di entità e associazioni a fronte delle operazioni previste sulla base di dati,
descritte nella tavola delle operazioni.

### Scelta degli identificatori principali

L'attributo ID di Voto ha lo scopo di mantenere i voti degli utenti eventualmente rimossi dalla base di dati (necessari per il calcolo
del voto medio di film, serie e programmi). Nonostante fosse già presente nello schema E-R iniziale si è pensato di spiegarlo per maggiore chiarezza. \
La descrizione degli altri identificatori principali non è stata trattata in quanto si ritiene sufficientemente auto-esplicativa a partire
dallo schema E-R + business-rules.

\newpage

### Schema E-R ristrutturato + business rules

<!-- ![](./merge/erRistr_2020-11-25_15-37-43.jpg) -->
\begin{figure}[h!]
\begin{adjustwidth}{-.9in}{-.9in}
\centering
\includegraphics[width=1.4\textwidth]{./merge/E-R_3.png}
\end{adjustwidth}
\end{figure}

**Business rules:**

* Se un utente ha il flag `isRedattore = TRUE` allora l'attributo `data inizio collaborazione IS NOT NULL`.
* Se viene modificato il flag `isRedattore` a `FALSE` l'attributo `data inizio collaborazione` assume valore `NULL`.
* Se viene modificato il flag `isRedattore` a `TRUE` l'attributo `data inizio collaborazione` assume come valore la
data del momento in cui viene modificato il flag (il giorno corrente).
* Il valore del voto è compreso tra 1 e 5 stelle.
* L'attributo voto medio di film indica la media dei voti assegnati dagli utenti.
* L'attributo voto medio di serie indica la media dei voti assegnati dagli utenti.
* L'attributo voto medio di programma indica la media dei voti assegnati dagli utenti.
* Per il singolo artista viene mantenuta una lista dei contenuti a cui ha partecipato.
* Gli utenti con flag `isRedattore = TRUE` aggiornano le informazioni relative a: film, serie, programmi.
* L'attributo ruolo dell'associazione partecipazione F può assumere i valori regista o attore. Nel primo caso l'attributo
personaggio interpretato avrà valore `NULL`, nel secondo invece avrà come valore il nome del personaggio interpretato dall'attore
all'interno del film.
* L'attributo ruolo dell'associazione partecipazione S può assumere i valori regista o attore. Nel primo caso l'attributo
personaggio interpretato avrà valore `NULL`, nel secondo invece avrà come valore il nome del personaggio interpretato dall'attore
all'interno della serie.
* L'attributo ruolo dell'associazione partecipazione P può assumere i valori regista o attore. Nel primo caso l'attributo
personaggio interpretato avrà valore `NULL`, nel secondo invece avrà come valore il nome del personaggio interpretato dall'attore
all'interno del programma.

### Schema relazionale

\
Utente (\underline{Email}, Nome utente, Password, isRedattore, Data inizio collaborazione)

\

Preferisce F (\underline{Email Utente, Titolo Film, Data uscita Film})

 > Preferisce F.Email Utente references Utente.Email

 > Preferisce F.Titolo Film references Film.Titolo

 > Preferisce F.Data uscita Film references Film.Data uscita

\

Preferisce S (\underline{Email Utente, Titolo Serie, Data uscita Serie})

 > Preferisce S.Email Utente references Utente.Email

 > Preferisce S.Titolo Serie references Serie.Titolo

 > Preferisce S.Data uscita Serie references Serie.Data uscita

\

Preferisce P (\underline{Email Utente, Titolo Programma, Data uscita Programma})

 > Preferisce P.Email utente references Utente.Email

 > Preferisce P.Titolo programma references Programma.Titolo

 > Preferisce P.Data uscita Programma references Programma.Data uscita

\

Voto (\underline{ID}, Numero stelle,  Email Utente)

 > Voto.Email Utente references Utente.Email

\

Riferisce F (\underline{ID voto, Titolo film, Data uscita Film})

 > Riferisce F.ID Voto references Voto.ID

 > Riferisce F.Titolo Film references Film.Titolo

 > Riferisce F.Data uscita Film references Film.Data uscita

\

Riferisce S (\underline{ID voto, Titolo serie, Data uscita serie})

 > Riferisce S.ID Voto references Voto.ID

 > Riferisce S.Titolo Serie references Serie.Titolo

 > Riferisce S.Data uscita Serie references Serie.Data uscita

\

Riferisce P (\underline{ID voto, Titolo programma, Data uscita programma})

 > Riferisce P.ID Voto references Voto.ID

 > Riferisce P.Titolo Programma references Programma.Titolo

 > Riferisce P.Data uscita Programma references Programma.Data uscita

\

Distribuzione (\underline{Nome Piattaforma, Numero Stagione, Titolo Serie, Data uscita Serie})

 > Distribuzione.Nome Piattaforma references Piattaforma.Nome

 > Distribuzione.Numero Stagione references Stagione.Numero

 > Distribuzione.Titolo Serie references Stagione.Titolo Serie

 > Distribuzione.Data uscita Stagione references Stagione.Data uscita Serie

\

Film (\underline{Titolo, Data uscita}, Durata, Genere, Produzione, Paese, Troupe, Distribuzione,

 > Descrizione testuale, Voto medio)

\

Serie (\underline{Titolo, Data uscita}, Durata, Genere, Produzione, Paese, Troupe, Distribuzione,

 > Descrizione testuale, Voto medio)

\

Programma (\underline{Titolo, Data uscita}, Durata, Genere, Produzione, Paese, Troupe, 

 > > > Distribuzione, Descrizione testuale, Voto medio, Canale)

\

Proiezione (\underline{Titolo Film, Data uscita Film, Nome Cinema, Indirizzo Cinema, Provincia Cinema,}

 > > \underline{Regione Cinema}, Prezzo, Ora, Data, Sala)

 > Proiezione.Titolo Film references Film.Titolo

 > Proiezione.Data uscita Film references Film.Data uscita

 > Proiezione.Nome Cinema references Cinema.Nome

 > Proiezione.Indirizzo Cinema references Cinema.Indirizzo

 > Proiezione.Provincia Cinema references Cinema.Provincia

 > Proiezione.Regione Cinema references Cinema.Regione

\

Cinema (\underline{Nome, Indirizzo, Provincia, Regione}, Contatti)

\

Artista (\underline{Nome, Cognome, Data di nascita}, Luogo di nascita, Biografia testuale,

 > > Ultimi contenuti)

\

Partecipazione F (\underline{Nome Artista, Cognome Artista, Data di nascita Artista, Titolo Film,}

  > > > > \underline{Data uscita Film}, Ruolo, Personaggio interpretato)

 > Partecipazione F.Nome Artista references Artista.Nome

 > Partecipazione F.Cognome Artista references Artista.Cognome

 > Partecipazione F.Data di nascita Artista references Artista.Data di nascita

 > Partecipazione F.Titolo Film references Film.Titolo

 > Partecipazione F.Data uscita Film references Film.Data uscita

\

Partecipazione S (\underline{Nome Artista, Cognome Artista, Data di nascita Artista, Titolo Serie,}


 > > > > \underline{Data uscita Serie},Ruolo, Personaggio interpretato)

 > Partecipazione S.Nome Artista references Artista.Nome

 > Partecipazione S.Cognome Artista references Artista.Cognome

 > Partecipazione S.Data di nascita Artista references Artista.Data di nascita

 > Partecipazione S.Titolo Serie references Serie.Titolo

 > Partecipazione S.Data uscita Serie references Serie.Data uscita
 
\

Partecipazione P (\underline{Nome Artista, Cognome Artista, Data di nascita Artista, Titolo Programma,}

 > > > > \underline{Data uscita Programma}, Ruolo, Personaggio interpretato)

 > Partecipazione P.Nome Artista references Artista.Nome

 > Partecipazione P.Cognome Artista references Artista.Cognome

 > Partecipazione P.Data di nascita Artista references Artista.Data di nascita

 > Partecipazione P.Titolo Programma references Programma.Titolo

 > Partecipazione P.Data uscita Programma references Programma.Data uscita
 
\

Stagione (\underline{Numero,  Titolo Serie, Data uscita Serie})

 > Stagione.Titolo uscita Serie references Stagione.Titolo Serie

 > Stagione.Data uscita Serie references Stagione.Data uscita

\

Divisa (\underline{Titolo Serie, Data uscita Serie, Numero Stagione})

 > Divisa.Titolo Serie references Serie.Titolo

 > Divisa.Data uscita Serie references Serie.Data uscita

 > Divisa.Numero Serie references Stagione.Numero

\

Contiene (\underline{Numero Stagione,  Titolo Serie, Data uscita Serie, Titolo Episodio})

 > Contiene.Numero Stagione references Stagione.Numero

 > Contiene.Titolo Serie references Stagione.Titolo Serie

 > Contiene.Data uscita Serie references Stagione.Data uscita Serie

 > Contiene.Titolo Episodio references Stagione.Titolo

\

Episodio (\underline{Titolo}, Durata, Cast episodio)

\

Piattaforma (\underline{Nome})

\newpage

# Implementazione

## DDL di creazione del database

```SQL
CREATE TABLE UTENTE (
    Email varchar(64) NOT NULL CHECK (Email LIKE '%_@_%._%'),
    Nome_utente varchar(32) NOT NULL,
    PasswordU varchar(32) NOT NULL CHECK(length(PasswordU)>=8),
    isRedattore boolean NOT NULL default false,
    Data_inizio_collaborazione date default null,
    CONSTRAINT UTENTE_P_KEY primary key(Email)
);

CREATE TABLE FILM(
    Titolo varchar(64) NOT NULL,
    Data_uscita date NOT NULL,
    Durata int CHECK(Durata>0),
    Genere varchar(128),
    Produzione varchar(128),
    Paese varchar(128),
    Troupe varchar(1000),
    Distribuzione varchar(128),
    Descrizione_testuale varchar(1000),
    Voto_medio decimal(2,1),
    CONSTRAINT FILM_P_KEY primary key (Titolo, Data_uscita)
);

CREATE TABLE SERIE(
    Titolo varchar(64) NOT NULL,
    Data_uscita date NOT NULL,
    Durata int CHECK(Durata>0),
    Genere varchar(128),
    Produzione varchar(128),
    Paese varchar(128),
    Troupe varchar(1000),
    Distribuzione varchar(128),
    Descrizione_testuale varchar(1000),
    Voto_medio decimal(2,1),
    CONSTRAINT SERIE_P_KEY primary key (Titolo, Data_uscita)
);

CREATE TABLE STAGIONE(
    Numero int NOT NULL,
    Titolo_Serie varchar(128) NOT NULL,
    Data_uscita_Serie  date NOT NULL,
    CONSTRAINT STAGIONE_P_KEY primary key (Numero, Titolo_Serie, Data_uscita_Serie),
    CONSTRAINT STAGIONE_F_KEY_SERIE foreign key (Titolo_Serie, Data_uscita_Serie) references SERIE(Titolo, Data_uscita)on delete cascade on update cascade
);

CREATE TABLE PROGRAMMA(
    Titolo varchar(64) NOT NULL,
    Data_uscita date NOT NULL,
    Durata int CHECK(Durata>0),
    Genere varchar(128),
    Produzione varchar(128),
    Paese varchar(128),
    Troupe varchar(1000),
    Distribuzione varchar(128),
    Descrizione_testuale varchar(1000),
    Voto_medio decimal(2,1),
    Canale varchar(128),
    CONSTRAINT PROGRAMMA_P_KEY primary key (Titolo, Data_uscita)
);

CREATE TABLE VOTO (
    Id serial,
    Numero_stelle int CHECK (Numero_stelle >=1 AND Numero_stelle <=5),
    Email_Utente varchar (64),
    CONSTRAINT VOTO_F_KEY_UTENTE foreign key (Email_Utente) references UTENTE(Email) on delete set null on update cascade,
    CONSTRAINT VOTO_P_KEY primary key (Id)
);

CREATE TABLE PREFERISCE_F (
    Email_Utente varchar (64),
    Titolo_Film varchar (64),
    Data_uscita_Film date,
    CONSTRAINT PREFERISCE_F_P_KEY primary key (Email_Utente, Titolo_Film, Data_uscita_Film),
    CONSTRAINT PREFERISCE_F_KEY_UTENTE foreign key (Email_Utente) references UTENTE(Email)on delete cascade on update cascade,
    CONSTRAINT PREFERISCE_F_KEY_FILM foreign key (Data_uscita_Film, Titolo_Film)references FILM(Data_uscita,Titolo)on delete cascade on update cascade
);

CREATE TABLE PREFERISCE_S ( 
    Email_Utente varchar (64), 
    Titolo_Serie varchar (64), 
    Data_uscita_Serie date, 
    CONSTRAINT PREFERISCE_S_P_KEY primary key (Email_Utente, Titolo_Serie, Data_uscita_Serie),
    CONSTRAINT PREFERISCE_S_KEY_UTENTE foreign key (Email_utente) references UTENTE(Email)on delete cascade on update cascade,
    CONSTRAINT PREFERISCE_S_KEY_SERIE foreign key (Data_uscita_Serie, Titolo_Serie) references SERIE(Data_uscita,Titolo)on delete cascade on update cascade
);
    
CREATE TABLE PREFERISCE_P ( 
    Email_Utente varchar (64), 
    Titolo_Programma varchar (64), 
    Data_uscita_Programma date, 
    CONSTRAINT PREFERISCE_P_P_KEY primary key (Email_Utente, Titolo_Programma, Data_uscita_Programma),
    CONSTRAINT PREFERISCE_P_KEY_UTENTE foreign key (Email_utente) references UTENTE(Email)on delete cascade on update cascade,
    CONSTRAINT PREFERISCE_P_KEY_PROGRAMMA foreign key (Data_uscita_Programma, Titolo_Programma) references PROGRAMMA(Data_uscita,Titolo)on delete cascade on update cascade
); 

CREATE TABLE RIFERISCE_F ( 
    Id_Voto serial, 
    Titolo_Film varchar (64), 
    Data_uscita_Film date, 
    CONSTRAINT riferisce_F_P_KEY primary key (Id_Voto, Titolo_Film, Data_uscita_Film),
    CONSTRAINT riferisce_F_KEY_VOTO foreign key (Id_Voto) references VOTO(Id)on delete cascade on update cascade,
    CONSTRAINT riferisce_F_KEY_FILM foreign key (Data_uscita_Film, Titolo_Film) references FILM(Data_uscita,Titolo) on delete cascade on update cascade
);
CREATE TABLE RIFERISCE_P ( 
    Id_Voto serial, 
    Titolo_programma varchar (64), 
    Data_uscita_programma date, 
    CONSTRAINT riferisce_P_P_KEY primary key (Id_Voto, Titolo_programma, Data_uscita_programma),
    CONSTRAINT riferisce_P_KEY_VOTO foreign key (Id_Voto) references VOTO(Id)on delete cascade on update cascade,
    CONSTRAINT riferisce_P_KEY_programma foreign key (Data_uscita_programma, Titolo_programma) references programma(Data_uscita,Titolo) on delete cascade on update cascade
);

CREATE TABLE RIFERISCE_S ( 
    Id_Voto serial,                      
    Titolo_serie varchar (64),
    Data_uscita_serie date, 
    CONSTRAINT riferisce_S_P_KEY primary key (Id_Voto, Titolo_serie, Data_uscita_serie),
    CONSTRAINT riferisce_S_KEY_VOTO foreign key (Id_Voto) references VOTO(Id)on delete cascade on update cascade,
    CONSTRAINT riferisce_S_KEY_serie foreign key (Data_uscita_serie, Titolo_serie) references serie(Data_uscita,Titolo) on delete cascade on update cascade
); 

CREATE TABLE CINEMA(
    Nome varchar(128) NOT NULL,
    Indirizzo varchar(128) NOT NULL,
    Provincia varchar(128) NOT NULL,
    Regione varchar(128) NOT NULL,
    Contatti varchar(1000),
    CONSTRAINT CINEMA_P_KEY primary key (Nome, Indirizzo, Provincia, Regione)
);

CREATE TABLE ARTISTA(
    Nome varchar(64) NOT NULL,
    Cognome varchar(64) NOT NULL,
    Data_di_nascita date NOT NULL,
    Luogo_di_nascita varchar(128),
    Biografia_testuale varchar(1000),
    Ultimi_contenuti varchar(1000),
    CONSTRAINT ARTISTA_P_KEY primary key (Nome, Cognome, Data_di_nascita)
);

CREATE TABLE EPISODIO(
    Titolo varchar(128) NOT NULL,
    Durata int,
    Cast_episodio varchar(1000),
    CONSTRAINT EPISODIO_P_KEY  primary key (Titolo)
);

CREATE TABLE PIATTAFORMA(
    Nome varchar(128) NOT NULL,
    CONSTRAINT PIATTAFORMA_P_KEY primary key(Nome)
);

CREATE TABLE PARTECIPAZIONE_F(
    Nome_Artista varchar(128) NOT NULL,
    Cognome_Artista varchar(128) NOT NULL,
    Data_di_nascita_Artista date NOT NULL,
    Titolo_Film varchar(128) NOT NULL,
    Data_uscita_Film date NOT NULL,
    Ruolo varchar(64),
    Personaggio_interpretato varchar(64),
    CONSTRAINT PARTECIPAZIONE_F_P_KEY primary key( Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Film, Data_uscita_Film),
    CONSTRAINT PARTECIPAZIONE_F_F_KEY_ARTISTA foreign key (Nome_Artista, Cognome_Artista,Data_di_nascita_Artista) references ARTISTA(Nome,Cognome, Data_di_nascita)on delete cascade on update cascade,
    CONSTRAINT PARTECIPAZIONE_F_F_KEY_FILM foreign key (Titolo_Film,Data_uscita_Film) references FILM(Titolo, Data_uscita) on delete cascade on update cascade
);

CREATE TABLE PARTECIPAZIONE_S(
    Nome_Artista varchar(128) NOT NULL,
    Cognome_Artista varchar(128) NOT NULL,
    Data_di_nascita_Artista date NOT NULL,
    Titolo_Serie varchar(128) NOT NULL,
    Data_uscita_Serie date NOT NULL,
    Ruolo varchar(64),
    Personaggio_interpretato varchar(64),
    CONSTRAINT PARTECIPAZIONE_S_P_KEY primary key( Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Serie, Data_uscita_Serie),
    CONSTRAINT PARTECIPAZIONE_F_F_KEY_ARTISTA foreign key (Nome_Artista, Cognome_Artista,Data_di_nascita_Artista) references ARTISTA(Nome,Cognome, Data_di_nascita)on delete cascade on update cascade,
    CONSTRAINT PARTECIPAZIONE_S_KEY_FILM foreign key (Titolo_Serie, Data_uscita_Serie) references SERIE(Titolo, Data_uscita) on delete cascade on update cascade
);

CREATE TABLE PARTECIPAZIONE_P(
    Nome_Artista varchar(128) NOT NULL,
    Cognome_Artista varchar(128) NOT NULL,
    Data_di_nascita_Artista date NOT NULL,
    Titolo_Programma varchar(128) NOT NULL,
    Data_uscita_Programma date NOT NULL,
    Ruolo varchar(64),
    Personaggio_interpretato varchar(64),
    CONSTRAINT PARTECIPAZIONE_P_P_KEY primary key( Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Programma, Data_uscita_Programma),
    CONSTRAINT PARTECIPAZIONE_P_F_KEY_ARTISTA foreign key (Nome_Artista, Cognome_Artista,Data_di_nascita_Artista) references ARTISTA(Nome,Cognome, Data_di_nascita)on delete cascade on update cascade,
    CONSTRAINT PARTECIPAZIONE_F_F_KEY_PROGRAMMA foreign key (Titolo_Programma, Data_uscita_Programma) references PROGRAMMA(Titolo, Data_uscita) on delete cascade on update cascade
);

CREATE TABLE DISTRIBUZIONE(
    Nome_Piattaforma varchar(128) NOT NULL,
    Numero_Stagione int NOT NULL,
    Titolo_Serie varchar(128) NOT NULL,
    Data_uscita_Serie date NOT NULL,
    CONSTRAINT DISTRIBUZIONE_P_KEY primary key(Nome_Piattaforma, Numero_Stagione, Titolo_Serie, Data_uscita_Serie),
    CONSTRAINT DISTRIBUZIONE_F_KEY_PIATTAFORMA foreign key(Nome_Piattaforma) references PIATTAFORMA(Nome)on delete cascade on update cascade,
    CONSTRAINT DISTRIBUZIONE_F_KEY_STAGIONE foreign key(Numero_Stagione, Titolo_Serie, Data_uscita_Serie) references STAGIONE(Numero, Titolo_Serie, Data_uscita_Serie)on delete cascade on update cascade
);

CREATE TABLE DIVISA(
    Titolo_Serie varchar(128) NOT NULL, 
    Data_uscita_Serie date NOT NULL,
    Numero_Stagione int NOT NULL,
    CONSTRAINT DIVISA_P_KEY primary key (Titolo_Serie, Data_uscita_Serie, Numero_Stagione),
    CONSTRAINT DIVISA_F_KEY_SERIE foreign key(Titolo_Serie, Data_uscita_Serie) references SERIE(Titolo, Data_uscita)on delete cascade on update cascade,
    CONSTRAINT DIVISA_F_KEY_STAGIONE foreign key (Numero_Stagione, Titolo_Serie, Data_uscita_Serie) references STAGIONE(Numero, Titolo_Serie, Data_uscita_Serie)on delete cascade on update cascade
);

CREATE TABLE CONTIENE(
   Numero_Stagione int NOT NULL,
   Titolo_Stagione varchar(64) NOT NULL,
   Data_uscita_Stagione date NOT NULL,
   Titolo_Episodio varchar(128) NOT NULL,
   CONSTRAINT CONTIENE_P_KEY primary key(Numero_Stagione, Titolo_Stagione, Data_uscita_Stagione, Titolo_Episodio),
   CONSTRAINT CONTIENE_F_KEY_STAGIONE foreign key (Numero_Stagione, Titolo_Stagione, Data_uscita_Stagione) references STAGIONE(Numero, Titolo_Serie, Data_uscita_Serie) on delete cascade on update cascade,
   CONSTRAINT CONTIENE_F_KEY_EPISODIO foreign key(Titolo_Episodio) references EPISODIO(Titolo) on delete cascade on update cascade 
);

CREATE TABLE PROIEZIONE(
   Titolo_Film varchar(64) NOT NULL,
   Data_uscita_Film date NOT NULL,
   Nome_Cinema varchar(128) NOT NULL,
   Indirizzo_Cinema varchar(128) NOT NULL,
   Provincia_Cinema varchar(128) NOT NULL,
   Regione_Cinema varchar(128) NOT NULL,
   Prezzo int,
   Ora time,
   Data_C date,
   Sala int,
   CONSTRAINT PROIEZIONE_P_K primary key(Titolo_Film, Data_uscita_Film, Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema,Regione_Cinema),
   CONSTRAINT PROIEZIONE_F_K_FILM foreign key(Titolo_Film, Data_uscita_Film) references FILM(Titolo, Data_uscita) on delete cascade on update cascade,
   CONSTRAINT PROIEZIONE_F_K_CINEMA foreign key(Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema, Regione_Cinema) references CINEMA(Nome, Indirizzo, Provincia, Regione) on delete cascade on update cascade
);
```

## DML di popolamento di tutte le tabelle del database

```SQL
INSERT INTO UTENTE (Email,Nome_utente,PasswordU,isRedattore, Data_inizio_collaborazione)
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
('Blob','1989-01-12' ,'20', 'Satirico', 'Rai', 'Italia', 'Fotografia: Enrico Ghezzi, Sceneggiuatura: Marco Giusti, Muscia: Angelo Guglielmi', 'Rai', 'Ogni puntata - la cui durata può variare dai dieci ai trenta minuti - è un attento montaggio, un riutilizzo creativo di spezzoni video presi dai canali televisivi italiani ed esteri, filmati amatoriali e web, uniti in modo da mettere a nudo la tv e i suoi protagonisti', 0, 'Rai3'),
('Antonino Chef Academy', ' 2019-10-03', '90', 'Sky', ' Enogastronomico', 'Sky', 'Italia', 'Sceneggiuatura: Antonino Cannavacciuolo', 'Antonino Chef Academy è un programma culinario condotto dallo chef partenopeo Cannavacciuolo. Nella location del Castello Dal Pozzo di Oleggio, il cuoco pluripremiato deve vestire i panni di professore, per guidare dieci giovani aspiranti cuochi (tra i 18 e i 23 anni) che, a seguito di un percorso formativo, si sfidano in delle prove in cui devono mettere a frutto tutte le loro conoscenze ai fornelli.', 0, 'Sky Uno'),
('Fratelli Crozza', '2017-02-12', '70', 'Show', 'Sceneggiatura: Andrea Zalone', 'Italia', '', 'Rai', 'Nel corso di ogni puntata viene analizzata l’attualità politica e sociale italiana attraverso la satira, i monologhi e i personaggi - reali o di fantasia - impersonati dall''imitatore.', 0, 'Nove'),
('Alessandro Borghese - 4 ristoranti', '2015-12-10', '60', 'Talent Show', 'Sky', 'Italia', 'Sceneggiatura: Alessandro Borghese', 'Sky, Rai', 'In ogni puntata si sfidano quattro ristoratori di una stessa area geografica in Italia, per stabilire chi è il migliore in una categoria, scelta di volta in volta dal conduttore in base agli elementi tipici o le particolarità della ristorazione del territorio in cui si trova.', '0', 'TV8'),
('Forum', '1985-01-02', '120', 'Show', 'Mediaset', 'Italia', 'Sceneggiatura: Catherine Spaak, Musica: Paola Perego, Fotografia: Rita dalla Chiesa, Barbara Palombelli', 'Mediaset', 'Due persone in contrasto su un argomento - problemi familiari, incidenti stradali, liti di condominio e via dicendo - si affidano alla sentenza di un giudice. Le questioni affrontate sono ricostruzioni di fatti, interpretate da due attori: il giudizio finale non è quindi da ritenersi ufficiale.', 0, 'Canale5');

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
('Crazy Handful of Nothin', 55, 'Attore: Amethyst Bentley, Michael McElhatton, Ian McElhinney, Finn Jones'),
('Exchanges', 23, 'Regista: Anya Josephine Marie Taylor-Joy');

INSERT INTO FILM (Titolo, Data_uscita, Durata, Genere, Produzione, Paese, Troupe, Distribuzione, Descrizione_testuale, Voto_medio)
VALUES 
('Matrix','1999-04-02', 133, 'Fantascienza', 'Lana Wachowski, Lilly Wachowski', 'USA', 'Con Keanu Reeves, Laurence Fishburne, Fotografia: Carrie-Anne Moss,Sceneggiatura: Hugo Weaving, Musica: Gloria Foster', 'Warner Bros','Un mondo che sembra reale ed è invece solo un paravento per nascondere la realtà vera. Seguendo un tatuaggio sulla spalla di una ragazza l''hacker Neo scopre che la cosiddetta realtà è solo un impulso elettrico fornito al cervello degli umani da un''intelligenza artificiale.', 0),
('Teenage Mutant Ninja Turtles', '2014-05-20', 101, 'Azione', 'Paramount Pictures', 'USA', 'Musica: Aleksandr Lokensgard,Sceneggiatura: Frazer Newton, Fotografia: John A. Canavan', 'Universal Pictures', 'La pellicola è il remake del film Tartarughe Ninja alla riscossa del 1990 e segna il riavvio della serie cinematografica, proseguita nel 2016 con Tartarughe Ninja - Fuori dall''ombra.', 0), 
('Il cosmo sul como', '2008-07-15', 94, 'Commedia', 'Medusa Film', 'Italia', 'Fotografia: Agostino Castiglioni, Sceneggiatura: Danilo Torchia, Musica: Paolo Silvestri', 'Medusa Film', 'La storia si articola in quattro episodi, a cui fa da cornice la storia del Maestro Tsu''Nam.', 0),
('Ghost Rider - Spirito di vendetta', '2012-03-23', 95, 'Azione', 'Medusa Film',  'USA', 'Sceneggiatura: Scott M. Gimple, David S. Goyer, Musica: Seth Hoffman', 'Medusa Film','Johnny Driverha deciso di allontanarsi per imparare a controllare i suoi nuovi poteri.', 0),
('Il gigante di ferro', '1999-08-14', 86, 'Animazione', 'Warner Bros.', 'USA', 'Fotografia:Carl Canga, Sceneggiatura: Ray Aragon, Musica: Michael Kamen', 'Warner Bros.', 'La storia è ambientata nel 1957, durante la guerra fredda, dopo il lancio dello Sputnik 1 avvenuto il 4 ottobre. Una strana e gigantesca figura precipita in mare nel corso di una tempesta.', 0);

INSERT INTO PREFERISCE_F (Email_Utente,Titolo_Film,Data_uscita_Film)
VALUES 
('volutpat.nulla.dignissim@inceptos.com','Matrix','1999-04-02'),
('nec.cursus@Phasellus.org','Teenage Mutant Ninja Turtles', '2014-05-20');

INSERT INTO PREFERISCE_S (Email_Utente,Titolo_Serie,Data_uscita_Serie)
VALUES 
('ligula.consectetuer@Morbi.co.uk','The Mandalorian', '2019-07-05'),
('ut.aliquam.iaculis@Sed.com','Breaking Bad', '2008-02-28');

INSERT INTO PREFERISCE_P (Email_Utente,Titolo_Programma,Data_uscita_Programma)
VALUES 
('tempus@blandit.ca','Blob','1989-01-12');

INSERT INTO RIFERISCE_F (Id_Voto,Titolo_Film,Data_uscita_Film)
VALUES
(1,'Il gigante di ferro', '1999-08-14');

INSERT INTO RIFERISCE_S (Id_Voto,Titolo_Serie,Data_uscita_Serie)
VALUES
(2,'Il trono di spade', '2011-11-03'),
(3,'I Medici','2016-03-07');

INSERT INTO RIFERISCE_P (Id_Voto,Titolo_Programma,Data_uscita_Programma)
VALUES
(4,'Alessandro Borghese - 4 ristoranti', '2015-12-10');

INSERT INTO DISTRIBUZIONE (Nome_Piattaforma, Numero_Stagione, Titolo_Serie, Data_uscita_Serie)
VALUES
('Netflix', 1, 'The Queen''s Gambit', '2020-02-04'),
('AmazonPrimeVideo', 2, 'Breaking Bad', '2008-02-28'),
('Infinity', 1, 'Breaking Bad', '2008-02-28'),
('Infinity', 3, 'Il trono di spade', '2011-11-03');

INSERT INTO DIVISA (Titolo_Serie, Data_uscita_Serie, Numero_Stagione)
VALUES
('The Queen''s Gambit', '2020-02-04', 1),
('Breaking Bad', '2008-02-28', 2),
('Breaking Bad', '2008-02-28', 1),
('Il trono di spade', '2011-11-03', 3);

INSERT INTO ARTISTA (Nome, Cognome, Data_di_nascita, Luogo_di_nascita, Biografia_testuale, Ultimi_contenuti)
VALUES
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16', 'Miami','Anya Taylor-Joy nasce a Miami, in Florida, ed è la più piccola di sei fratelli, nati da madre anglo-spagnola e padre scozzese-argentino. Cresce fino ai 6 anni a Buenos Aires (Argentina) per poi trasferirsi nel Regno Unito, a Londra, dove è cresciuta studiando danza classica.È bilingue spagnolo-inglese. ', 'Playmobil: The Movie(2019),The New Mutants(2020), The Queen''s Gambit(2020)'),
('Maurizio', 'Crozza', '1959-12-5', 'Genova', 'Nato a Genova nel quartiere di Borgoratti, primogenito di 4 figli, si diploma nel 1980 alla Scuola di recitazione del Teatro Stabile di Genova sotto la guida, tra gli altri, di Gian Maria Volonté. Il suo primo approccio è con il teatro classico dove lavora con i registi Egisto Marcucci,[1] William Gaskill e Marco Sciaccaluga.', 'Peggio di così si muore(1995),Consigli per gli acquisti (1997), Tutti gli uomini del deficiente(1999))'),
('Amethyst','Bentley','1989-09-07','Villafranca d''Asti', 'Famosa per la sua interpretazione di Marylin Monroe in "un medico in famiglia", è stata nominata ai Golden Globe per la parte di pianta scenica nel film "Garfild"', 'Garfild(2018), Provaci ancora prof "il Film"(2008), Breaking Bad (2008)'),
('Mara','Herring','1940-05-13','Ajmer', 'Nata da madre polacca e padre turco si appassiona fin da tenera età allo spettacolo, icona di stile, ha recitato in molti film diretti da Checco Zalone', 'Tapinho(2014),La prima Repubblica(2015),Immigrato(2019),L''immunità di gregge(2020)'),
('Echo','Petty','1977-08-28','Lancaster', 'Famos* per il suo talento nel recitare la parte del gelataio in film per bambini. In passato ha avuto problemi poichè nessuno capisce quale sia il nome e quale il cognome', 'Pirati dei caraibi, La maledizione della prima luna(2003), Shrek 3(2007)');

INSERT INTO PARTECIPAZIONE_F (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Film, Data_uscita_Film, Ruolo, Personaggio_interpretato)
VALUES
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16', 'Matrix','1999-04-02', 'Regista', NULL),
('Mara','Herring','1940-05-13', 'Ghost Rider - Spirito di vendetta', '2012-03-23', 'Attore', 'Sedia');

INSERT INTO PARTECIPAZIONE_S (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Serie, Data_uscita_Serie, Ruolo, Personaggio_interpretato)
VALUES
('Amethyst','Bentley','1989-09-07', 'Breaking Bad', '2008-02-28', 'Attore', 'Walter Jr'),
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16','The Queen''s Gambit','2020-02-04', 'Regista', NULL);

INSERT INTO PARTECIPAZIONE_P (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Programma, Data_uscita_Programma, Ruolo, Personaggio_interpretato)
VALUES
('Maurizio', 'Crozza', '1959-12-5', 'Fratelli Crozza', '2017-02-12', 'Attore', 'Crozza'),
('Amethyst','Bentley','1989-09-07', 'Alessandro Borghese - 4 ristoranti', '2015-12-10', 'Regista', NULL),
('Echo','Petty','1977-08-28' , 'Antonino Chef Academy', ' 2019-10-03', 'Attore', 'Mestolo');

INSERT INTO CONTIENE (Numero_Stagione, Titolo_Stagione, Data_uscita_Stagione, Titolo_Episodio)
VALUES
(1,'The Queen''s Gambit','2020-02-04','Exchanges'),
(1,  'Breaking Bad',  '2008-02-28', 'Crazy Handful of Nothin');

INSERT INTO PROIEZIONE (Titolo_Film,Data_uscita_Film, Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema, Regione_Cinema, Prezzo, Ora, Data_C, Sala)
VALUES
('Matrix','1999-04-02','Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 5, '16:30', '2020-11-10', 1),
('Teenage Mutant Ninja Turtles','2014-05-20','Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 5, '16:45', '2020-09-10', 2),
('Il cosmo sul como', '2008-07-15', 'Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 7, '12:30', '2020-12-06', 1),
('Il cosmo sul como', '2008-07-15', 'Cinema Lumière', 'Via Azzo Gardino, 65, 40122 Bologna', 'BO', 'Emilia-Romagna', 8, '20:00', '2021-11-10', 6),
('Il gigante di ferro', '1999-08-14', 'La Casa del Cinema','Salizada San Stae, 1990, 30135 Venezia', 'VE', 'Veneto', 4.50, '18:30', '2020-04-03', 3);

```

## Operazioni di cancellazione e modifica

### Operazioni consentite dalla base di dati

```SQL
-- utente
UPDATE UTENTE SET nome_utente='Galvin Venezuela' WHERE nome_utente='Galvin Valenzuela';
DELETE from UTENTE WHERE nome_utente = 'Galvin Venezuela';

-- film
UPDATE FILM SET titolo='Il Giggante de fero' WHERE titolo = 'Il gigante di ferro';
DELETE from FILM WHERE titolo = 'Il Giggante de fero';

-- piattaforma
UPDATE PIATTAFORMA SET nome='La tv di casa mia' WHERE nome='Disney+';
DELETE from PIATTAFORMA WHERE nome='La tv di casa mia';

-- serie
DELETE from SERIE WHERE titolo = 'Breaking Bad';
UPDATE SERIE SET titolo='La serie con le spade' WHERE titolo = 'Il trono di spade';

-- cinema/proiezione
DELETE from CINEMA WHERE nome='Cinema Lumière';
UPDATE PROIEZIONE SET nome_cinema='La Casa del Cinema',indirizzo_cinema='Salizada San Stae, 1990, 30135 Venezia', provincia_cinema='VE', regione_cinema='Veneto' WHERE titolo_film='Matrix';

-- artista
UPDATE ARTISTA SET Nome='Piero' WHERE Luogo_di_nascita='Miami';
```

### Operazioni non consentite dalla base di dati (violazione vincolo di chiave esterna)

```SQL
UPDATE DISTRIBUZIONE SET nome_piattaforma='La tv' WHERE nome_piattaforma='Netflix'
-- ERROR:  insert or update on table "distribuzione" violates foreign key constraint "distribuzione_f_key_piattaforma"
-- DETAIL:  Key (nome_piattaforma)=(La tv) is not present in table "piattaforma".

UPDATE PROIEZIONE SET nome_cinema='The Space',indirizzo_cinema='Corso Torino 90, 30145 Beinasco', provincia_cinema='TO', regione_cinema='Piemonte' WHERE titolo_film='Matrix'
-- ERROR:  insert or update on table "proiezione" violates foreign key constraint "proiezione_f_k_cinema"
-- DETAIL:  Key (nome_cinema, indirizzo_cinema, provincia_cinema, regione_cinema)=(The Space, Corso Torino 90, 30145 Beinasco, TO, Piemonte) is not present in table "cinema".
```
