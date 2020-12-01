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
Coerenza formattazione `` vs "" vs niente
( Coerenza generale con nomi e schemi )
FIX
NOTE
in troupe -> sceneggiatura fotografia musiche
indirizzo -> via + città
geometry: "left=3cm,right=3cm,top=2cm,bottom=2cm"
for code styling check (anche no, bene il default):
https://learnbyexample.github.io/customizing-pandoc/
-->

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
\multicolumn{1}{|l|}{\textbf{Preferisce}}     & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{250.000} & \multicolumn{1}{l|}{Si considera una media di 5 film preferiti per utente}                                                                                                                                                                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Assegna}}        & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{5}       & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Media di 5 voti per utente ottenuta dividendo i voti totali per\\ gli utenti\end{tabular}}                                                                                                                                      \\ \hline
\multicolumn{1}{|l|}{\textbf{Voti}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{250.000} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Da mymovies si evince che ci sono circa \\ 200.00 recensioni totali, si considera un voto per recensione \\ più un voto per utente che non lascia il commento\end{tabular}}                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto contenuto}} & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{500}     & \multicolumn{1}{l|}{Si considera che il 1\% di utenti vota un film.}                                                                                                                                                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuti}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{40.000}  & \multicolumn{1}{l|}{Basandosi su dati di un articolo su mymovies}                                                                                                                                                                                                              \\ \hline
\multicolumn{1}{|l|}{\textbf{Partecipazione}} & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{20}      & \multicolumn{1}{l|}{Si stima un media di partecipazione a 20 contenuti per artista}                                                                                                                                                                                            \\ \hline
\multicolumn{1}{|l|}{\textbf{Programma}}      & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{500}     & \multicolumn{1}{l|}{Approssimazione dati mymovies}                                                                                                                                                                                                                             \\ \hline
\multicolumn{1}{|l|}{\textbf{Film}}           & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{10.000}  & \multicolumn{1}{l|}{Approssimazione dati mymovies}                                                                                                                                                                                                                             \\ \hline
\multicolumn{1}{|l|}{\textbf{Proiezione}}     & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{420.000} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si stima che in ogni cinema ci siano 4 spettacoli al giorno, \\ moltiplicati per i 30 giorni (un film rimane in programmazione\\ un mese), moltiplicati per i cinema in Italia\end{tabular}}                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{Cinema}}         & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{3.500}   & \multicolumn{1}{l|}{Numero di cinema presenti su mymovies}                                                                                                                                                                                                                     \\ \hline
\multicolumn{1}{|l|}{\textbf{Serie}}          & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{1.750}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Approssimazione basata sul fatto che sono 600 le serie\\ presenti su Netflix, considerando che non è presente 1 \\ serie su 3.\end{tabular}}                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Divisa}}         & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{3.500}   & \multicolumn{1}{l|}{Stesso valore di Stagione.}                                                                                                                                                                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Stagione}}       & \multicolumn{1}{l|}{Entità}    & \multicolumn{1}{l|}{3.500}   & \multicolumn{1}{l|}{Media di 2 stagioni a serie.}                                                                                                                                                                                                                              \\ \hline
\multicolumn{1}{|l|}{\textbf{Contiene}}       & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{29.500}  & \multicolumn{1}{l|}{Stesso valore di Episodio.}                                                                                                                                                                                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Distribuzione}}  & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{600}     & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Si stima che per ogni piattaforma è presente il circa  il 30\% \\ delle serie.\end{tabular}}                                                                                                                                    \\ \hline
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

1. Attributo "età" di "artista" (attributo derivabile): l'attributo "età" è derivabile considerando l'anno di nascita e la data odierna. Il mantenimento di questo attributo comporta l'aggiornamento costante di un dato ("età") secondo la data di nascita dell'artista. Per il precedente motivo si è scelto di eliminare la ridondanza, diminuendo gli aggiornamenti dei dati relativi all'artista.
2. Attributo "Voto medio" di "contenuto" (attributo derivabile da entità e conteggio): l'attributo "voto medio" è derivabile dal conteggio delle occorrenze dell'entità "voto" facente riferimento ad un dato "contenuto". In questa somma, se si tiene anche conto del valore dei punteggi (il numero di stelle), si può facilmente derivare che $\frac{totale punteggi}{cardinalit\grave{a} voto} = voto medio$. 

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
\multicolumn{1}{|l|}{\textbf{Voto contenuto}} & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Scrittura} \\ \hline
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
\multicolumn{1}{|l|}{\textbf{Voto contenuto}} & \multicolumn{1}{l|}{associazione} & \multicolumn{1}{l|}{1} & \multicolumn{1}{l|}{Lettura} \\ \hline
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
dall'attributo ruolo della associazione partecipazione.

**3. Contenuto - Programma, Film, Serie** (*generalizzazione totale ed esclusiva*)

![](./merge/gen3.jpg)

Motivazione: si è scelto di accorpare la entità padre della generalizzazione nelle entità figlie, in quanto gli accessi alla tabelle figlie sono distinti.

### Partizionamento/accorpamento di entità e associazioni

Non si è valutato necessario il partizionamento e/o l'accorpamento di entità e associazioni a fronte delle operazioni previste sulla base di dati,
descritte nella tavola delle operazioni.

### Scelta degli identificatori principali

L'attributo `ID` di Voto ha lo scopo di mantenere i voti degli utenti eventualmente rimossi dalla base di dati (necessari per il calcolo
del voto medio di film, serie e programmi). Nonostante fosse già presente nello [schema E-R iniziale](### Schema E-R) si è pensato di spiegarlo per maggiore chiarezza. \
La descrizione degli altri identificatori principali non è stata trattata in quanto si ritiene sufficientemente auto-esplicativa a partire
dallo schema E-R + business-rules.

### Schema E-R ristrutturato + business rules

![](./merge/erRistr_2020-11-25_15-37-43.jpg)

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

 > Riferisce.ID Voto references Voto.ID

 > Riferisce F.Titolo Film references Film.Titolo

 > Riferisce F.Data uscita Film references Film.Data uscita

\

Riferisce S (\underline{ID voto, Titolo serie, Data uscita serie})

 > Riferisce.ID Voto references Voto.ID

 > Riferisce F.Titolo Serie references Serie.Titolo

 > Riferisce F.Data uscita Serie references Serie.Data uscita

\

Riferisce P (\underline{ID voto, Titolo programma, Data uscita programma})

 > Riferisce.ID Voto references Voto.ID

 > Riferisce F.Titolo Programma references Programma.Titolo

 > Riferisce F.Data uscita Programma references Programma.Data uscita

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

 > > \underline{Regione Cinema}, Prezzo, Ora, Data, Sala})

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
```
