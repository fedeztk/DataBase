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

create table CONTIENE(
  Numero_Stagione int not null,
  Titolo_Stagione varchar(64) not null,
  Data_uscita_Stagione date not null,
  Titolo_Episodio varchar(128) not null,
  constraint CONTIENE_P_KEY primary key(Numero_Stagione, Titolo_Stagione, Data_uscita_Stagione, Titolo_Episodio),
  constraint CONTIENE_F_KEY_STAGIONE foreign key (Numero_Stagione, Titolo_Stagione, Data_uscita_Stagione) references STAGIONE(Numero, Titolo_Serie, Data_uscita_Serie) on delete cascade on update cascade,
  constraint CONTIENE_F_KEY_EPISODIO foreign key(Titolo_Episodio) references EPISODIO(Titolo) on delete cascade on update cascade 
);

create table PROIEZIONE(
    Titolo_Film varchar(64) not null,
  Data_uscita_Film date not null,
  Nome_Cinema varchar(128) not null,
  Indirizzo_Cinema varchar(128) not null,
  Provincia_Cinema varchar(128) not null,
  Regione_Cinema varchar(128) not null,
  Prezzo int,
  Ora time,
  Data_C date,
  Sala int,
  constraint PROIEZIONE_P_K primary key(Titolo_Film, Data_uscita_Film, Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema,Regione_Cinema),
  constraint PROIEZIONE_F_K_FILM foreign key(Titolo_Film, Data_uscita_Film) references FILM(Titolo, Data_uscita) on delete cascade on update cascade,
  constraint PROIEZIONE_F_K_CINEMA foreign key(Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema, Regione_Cinema) references CINEMA(Nome, Indirizzo, Provincia, Regione) on delete cascade on update cascade
);

INSERT INTO UTENTE (Email,Nome_utente,PasswordU,isRedattore,Data_inizio_collaborazione)
VALUES 
('volutpat.Nulla.dignissim@inceptos.com','Galvin Valenzuela','DIcVn7997KIV',true,'2020-08-27'),
('nec.cursus@Phasellus.org','Remedios Ward','MIKKz9C55HIx',false,'2010-08-27'),
('ligula.consectetuer@Morbi.co.uk','Amery Parks','BIaGr8269ZIJ',false,'2011-06-21'),
('ut.aliquam.iaculis@Sed.com','Kelly Cox','TIeGp8A37FIM',false,'2020-01-29'),
('tempus@blandit.ca','Robin Hernandez','BIPKc1413FIa',false,'2011-10-08');

INSERT INTO VOTO (Id,Numero_stelle,Email_Utente)
VALUES 
(1,5,'volutpat.Nulla.dignissim@inceptos.com'),
(2,1,'nec.cursus@Phasellus.org'),
(3,4,'ligula.consectetuer@Morbi.co.uk'),
(4,2,'ut.aliquam.iaculis@Sed.com'),
(5,4,null);

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

insert into PROGRAMMA (Titolo, Data_uscita, Durata, Genere, Produzione, Paese, Troupe, Distribuzione, Descrizione_testuale, Voto_medio, Canale)
values 
('Blob','1989-01-12' ,'20', 'Satirico', 'Rai', 'Italia', 'Enrico Ghezzi, Marco Giusti, Angelo Guglielmi', 'Rai', 'Ogni puntata - la cui durata può variare dai dieci ai trenta minuti - è un attento montaggio, un riutilizzo creativo di spezzoni video presi dai canali televisivi italiani ed esteri, filmati amatoriali e web, uniti in modo da mettere a nudo la tv e i suoi protagonisti', 0, 'Rai3'),
('Antonino Chef Academy', ' 2019-10-03', '90', 'Sky', ' Enogastronomico', 'Sky', 'Italia', 'Antonino Cannavacciuolo', 'Antonino Chef Academy è un programma culinario condotto dallo chef partenopeo Cannavacciuolo. Nella location del Castello Dal Pozzo di Oleggio, il cuoco pluripremiato deve vestire i panni di professore, per guidare dieci giovani aspiranti cuochi (tra i 18 e i 23 anni) che, a seguito di un percorso formativo, si sfidano in delle prove in cui devono mettere a frutto tutte le loro conoscenze ai fornelli.', 0, 'Sky Uno'),
('Fratelli Crozza', '2017-02-12', '70', 'Show', 'Andrea Zalone', 'Italia', '', 'Rai', 'Nel corso di ogni puntata viene analizzata l’attualità politica e sociale italiana attraverso la satira, i monologhi e i personaggi - reali o di fantasia - impersonati dall''imitatore.', 0, 'Nove'),
('Alessandro Borghese - 4 ristoranti', '2015-12-10', '60', 'Talent Show', 'Sky', 'Italia', 'Alessandro Borghese', 'Sky, Rai', 'In ogni puntata si sfidano quattro ristoratori di una stessa area geografica in Italia, per stabilire chi è il migliore in una categoria, scelta di volta in volta dal conduttore in base agli elementi tipici o le particolarità della ristorazione del territorio in cui si trova.', '0', 'TV8'),
('Forum', '1985-01-02', '120', 'Show', 'Mediaset', 'Italia', 'Catherine Spaak, Paola Perego, Rita dalla Chiesa, Barbara Palombelli', 'Mediaset', 'Due persone in contrasto su un argomento - problemi familiari, incidenti stradali, liti di condominio e via dicendo - si affidano alla sentenza di un giudice. Le questioni affrontate sono ricostruzioni di fatti, interpretate da due attori: il giudizio finale non è quindi da ritenersi ufficiale.', 0, 'Canale5');

insert into SERIE values('I Medici','2016-03-07',50, 'Drammatico', 'Big Light Productions, Lux Vide, Wild Bunch', 'Italia, Gran Bretagna', 'con Daniel Sharman e Alessandra Mastronardi.','Infinity', 'I Medici è una serie tv storica che racconta l''ascesa dell''illustre famiglia Medici, padrona di Firenze durante il Rinascimento e di come la stessa si sia dovuta difendere dagli attacchi delle altre famiglie fiorentine', 0 );
insert into SERIE values('The Queen''s Gambit', '2020-02-04',46, 'Drammatico', 'Marcus Loges, Mick Aniceto',  'USA', 'Steven Meizler, Michelle Tesoro ','Netflix','La serie esplora la vita di una bambina prodigio degli scacchi, orfana, di nome Beth Harmon, seguendo le sue vicissitudini dall''età di otto ai ventidue anni', 0 );
insert into SERIE values('The Mandalorian', '2019-07-05', 42, 'Fantascienza', 'Lucasfilm', 'USA',  'Ludwig Göransson Andrew L. Jones, Doug Chiang ', 'Dinsey+', 'Il protagonista è Din Djarin, un cacciatore di taglie mandaloriano che opera oltre i confini della Nuova Repubblica.', 0);
insert into SERIE values('Breaking Bad', '2008-02-28', 47, 'Thriller', 'High Bridge Entertainment', 'USA', 'Dave Porter ', 'Netflix', 'Walter White è un professore di chimica di Albuquerque che vive con la moglie Skyler, incinta della loro secondogenita, e il figlio Walter "Flynn" Junior',0);
insert into SERIE values('Il trono di spade', '2011-11-03', 60 , 'Fantasy', 'Television 360', 'USA', 'Michele Clapton, April Ferry ', 'HBO', 'La serie racconta le avventure di molti personaggi ed è ambientata in un grande mondo immaginario costituito principalmente dal continente Occidentale (Westeros) e da quello Orientale (Essos)',0);

insert into STAGIONE values(1,'The Queen''s Gambit', '2020-02-04');
insert into STAGIONE values(2,'Breaking Bad', '2008-02-28');
insert into STAGIONE values(1,'Breaking Bad', '2008-02-28');
insert into STAGIONE values(3,'Il trono di spade', '2011-11-03');
insert into STAGIONE values(1,'Il trono di spade', '2011-11-03');

insert into EPISODIO values('Valar Dohaeris', 55, 'Ciarán Hinds, Michael McElhatton, Ian McElhinney, Finn Jones');
insert into EPISODIO values('The Climb', 55, ' Gwendoline Christie, Ian McElhinney');
insert into EPISODIO values('Crazy Handful of Nothin', 55, ' Max Arciniega, John Koyama');
insert into EPISODIO values('Gray Matter', 45, 'Roberta Marquez, Allan Pacheco ');
insert into EPISODIO values('"Exchanges"', 30,'Anya Taylor-Joy');

insert into FILM values('Matrix','1999-04-02', 133, 'Fantascienza', 'Lana Wachowski, Lilly Wachowski', 'USA', 'Con Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving, Gloria Foster', 'Warner Bros','Un mondo che sembra reale ed è invece solo un paravento per nascondere la realtà vera. Seguendo un tatuaggio sulla spalla di una ragazza l''hacker Neo scopre che la cosiddetta realtà è solo un impulso elettrico fornito al cervello degli umani da un''intelligenza artificiale.', 0);
insert into FILM values ('Teenage Mutant Ninja Turtles', '2014-05-20', 101, 'Azione', 'Paramount Pictures', 'USA', 'Aleksandr Lokensgard, Frazer Newton, John A. Canavan', 'Universal Pictures', 'La pellicola è il remake del film Tartarughe Ninja alla riscossa del 1990 e segna il riavvio della serie cinematografica, proseguita nel 2016 con Tartarughe Ninja - Fuori dall''ombra.', 0);
insert into FILM values ('Il cosmo sul como', '2008-07-15', 94, 'Commedia', 'Medusa Film', 'Italia', 'Agostino Castiglioni Danilo Torchia Paolo Silvestri', 'Medusa Film', 'La storia si articola in quattro episodi, a cui fa da cornice la storia del Maestro Tsu''Nam.', 0);
insert into FILM values ('Ghost Rider - Spirito di vendetta', '2012-03-23', 95, 'Azione', 'Medusa Film',  'USA', ' Scott M. Gimple, David S. Goyer, Seth Hoffman', 'Johnny Driverha deciso di allontanarsi per imparare a controllare i suoi nuovi poteri.', 0);
insert into FILM values ('Il gigante di ferro', '1999-08-14', 86, 'Animazione', 'Warner Bros.', 'USA', 'Carl Canga, Ray Aragon  Michael Kamen', 'Warner Bros.', 'La storia è ambientata nel 1957, durante la guerra fredda, dopo il lancio dello Sputnik 1 avvenuto il 4 ottobre. Una strana e gigantesca figura precipita in mare nel corso di una tempesta.', 0);

INSERT INTO Preferisce_F (Email_Utente,Titolo_Film,Data_uscita_Film)
VALUES 
('volutpat.Nulla.dignissim@inceptos.com','Matrix','1999-04-02'),
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

insert into ARTISTA (Nome, Cognome, Data_di_nascita, Luogo_di_nascita, Biografia_testuale, Ultimi_contenuti)
values
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16', 'Miami','Anya Taylor-Joy nasce a Miami, in Florida, ed è la più piccola di sei fratelli, nati da madre anglo-spagnola e padre scozzese-argentino. Cresce fino ai 6 anni a Buenos Aires (Argentina) per poi trasferirsi nel Regno Unito, a Londra, dove è cresciuta studiando danza classica.È bilingue spagnolo-inglese. ', 'Playmobil: The Movie(2019),The New Mutants(2020),Emma(2020)');
insert into ARTISTA values
('Maurizio', 'Crozza', '1959-12-5', 'Genova', 'Nato a Genova nel quartiere di Borgoratti, primogenito di 4 figli, si diploma nel 1980 alla Scuola di recitazione del Teatro Stabile di Genova sotto la guida, tra gli altri, di Gian Maria Volonté. Il suo primo approccio è con il teatro classico dove lavora con i registi Egisto Marcucci,[1] William Gaskill e Marco Sciaccaluga.', 'Peggio di così si muore(1995),Consigli per gli acquisti (1997), Tutti gli uomini del deficiente(1999))');
insert into ARTISTA values
('Amethyst','Bentley','1989-09-07','Villafranca d''Asti', 'Famosa per la sua interpretazione di Marylin Monroe in "un medico in famiglia", è stata nominata ai Golden Globe per la parte di pianta scenica nel film "Garfild"', 'Garfild(2018), Provaci ancora prof "il Film"(2008)');
insert into ARTISTA values
('Mara','Herring','1940-05-13','Ajmer', 'Nata da madre polacca e padre turco si appassiona fin da tenera età allo spettacolo, icona di stile, ha recitato in molti film diretti da Checco Zalone', 'Tapinho(2014),La prima Repubblica(2015),Immigrato(2019),L''immunità di gregge(2020)');
insert into ARTISTA values
('Echo','Petty','1977-08-28','Lancaster', 'Famos* per il suo talento nel recitare la parte del gelataio in film per bambini. In passato ha avuto problemi poichè nessuno capisce quale sia il nome e quale il cognome', 'Pirati dei caraibi, La maledizione della prima luna(2003), Shrek 3(2007)');

insert into PARTECIPAZIONE_F (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Film, Data_uscita_Film, Ruolo, Personaggio_interpretato)
values
('Anya Josephine Marie', 'Taylor-Joy','1996-04-16', 'Matrix','1999-04-02', 'Regista', null),
('Mara','Herring','1940-05-13', 'Ghost Rider - Spirito di vendetta', '2012-03-23', 'Attore', 'Sedia');
insert into PARTECIPAZIONE_S (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Serie, Data_uscita_Serie, Ruolo, Personaggio_interpretato)
values
('Amethyst','Bentley','1989-09-07', 'Breaking Bad', '2008-02-28', 'Attore', 'Walter Jr');
insert into PARTECIPAZIONE_P (Nome_Artista, Cognome_Artista, Data_di_nascita_Artista, Titolo_Programma, Data_uscita_Programma, Ruolo, Personaggio_interpretato)
values
('Maurizio', 'Crozza', '1959-12-5', 'Fratelli Crozza', '2017-02-12', 'Attore', 'Crozza'),
('Amethyst','Bentley','1989-09-07', 'Alessandro Borghese - 4 ristoranti', '2015-12-10', 'Regista', null),
('Echo','Petty','1977-08-28' , 'Antonino Chef Academy', ' 2019-10-03', 'Attore', 'Mestolo');

insert into CONTIENE values (1,'The Queen''s Gambit','2020-02-04','"Exchanges"');
insert into CONTIENE values (1,  'Breaking Bad',  '2008-02-28', 'Crazy Handful of Nothin');
insert into CONTIENE values (2,  'Breaking Bad',  '2008-02-28', 'Gray Matter');
insert into CONTIENE values (3, 'Il trono di spade', '2011-11-03', 'Valar Dohaeris');
insert into CONTIENE values (1,  'Il trono di spade', '2011-11-03', 'The Climb');

insert into Proiezione (Titolo_Film,Data_uscita_Film, Nome_Cinema, Indirizzo_Cinema, Provincia_Cinema, Regione_Cinema, Prezzo, Ora, Data_C, Sala)
values
('Matrix','1999-04-02','Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 5, '16:30', '2020-11-10', 1),
('Teenage Mutant Ninja Turtles','2014-05-20','Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 5, '16:45', '2020-09-10', 2),
('Il cosmo sul como', '2008-07-15', 'Cinema Multisala Lux','Via Massaciuccoli, 33, 00199 Roma' ,'RM', 'Lazio', 7, '12:30', '2020-12-06', 1),
('Il cosmo sul como', '2008-07-15', 'Cinema Lumière', 'Via Azzo Gardino, 65, 40122 Bologna', 'BO', 'Emilia-Romagna', 8, '20:00', '2021-11-10', 6),
('Il gigante di ferro', '1999-08-14', 'La Casa del Cinema','Salizada San Stae, 1990, 30135 Venezia', 'VE', 'Veneto', 4.50, '18:30', '2020-04-03', 3);
```
