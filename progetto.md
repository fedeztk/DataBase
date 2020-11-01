---
lang: it-IT
title: "Basi di Dati, Progetto di Laboratorio"
author: "Federico Serra, matricola 898925"
numbersections: true
urlcolor: blue
---

<!--
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
quali: data di uscita, genere, anno, regia, attori, paese, durata, distribuzione,
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

\

\begin{table}[h!]
\begin{adjustwidth}{-.9in}{-.9in}  
\centering
\begin{tabular}{llll}
\textit{Termine}                           & \textit{Descrizione}                                                                                                                                              & \textit{Sinonimi}                                                                                                     & \textit{Collegamento}                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Piattaforme}} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Servizi che rendono disponibili\\ agli utenti i contenuti. Possono\\ essere televisivi o informatici\end{tabular}} & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}canali TV tradizionali,\\ piattaforme di streaming video\end{tabular}} & \multicolumn{1}{l|}{Utenti, contenuti}                                                          \\ \hline
\multicolumn{1}{|l|}{\textbf{Contenuti}}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Insieme di produzioni\\ audiovisive (film e serie)\end{tabular}}                                                   & \multicolumn{1}{l|}{programmi TV, serie, film}                                                                        & \multicolumn{1}{l|}{Film, serie}                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Utenti}}      & \multicolumn{1}{l|}{Persona che usufruisce del sito}                                                                                                              & \multicolumn{1}{l|}{visitatore, visitatori}                                                                           & \multicolumn{1}{l|}{}                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Iscritti}}    & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Persona registrata sulla piattaforma.\\ Può votare\end{tabular}}                                                   & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{Voto}                                                                       \\ \hline
\multicolumn{1}{|l|}{\textbf{Redattori}}   & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Persona che aggiorna informazioni\\ riguardanti i contenuti e la relativa\\ distribuzione\end{tabular}}            & \multicolumn{1}{l|}{utenti della redazione}                                                                           & \multicolumn{1}{l|}{}                                                                           \\ \hline
\multicolumn{1}{|l|}{\textbf{Serie}}       & \multicolumn{1}{l|}{Serie TV disponibili sulla piattaforma}                                                                                                       & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}serie TV, programmi TV, \\ programmi, serial\end{tabular}}             & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Stagione, episodio,\\ piattaforma\end{tabular}}  \\ \hline
\multicolumn{1}{|l|}{\textbf{Stagione}}    & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Raggruppamento di episodi di una\\ serie\end{tabular}}                                                             & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{Episodio, serie}                                                            \\ \hline
\multicolumn{1}{|l|}{\textbf{Episodi}}     & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Singola unità di una stagione, \\ e quindi di una serie\end{tabular}}                                              & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Stagione, serie, attore,\\ regista\end{tabular}} \\ \hline
\multicolumn{1}{|l|}{\textbf{Film}}        & \multicolumn{1}{l|}{Film presenti sulla piattaforma}                                                                                                              & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{Cinema, attore, regista}                                                    \\ \hline
\multicolumn{1}{|l|}{\textbf{Troupe}}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Insieme di collaboratori che \\ partecipano alla realizzazione\\  di contenuti\end{tabular}}                       & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{Attori, registi}                                                            \\ \hline
\multicolumn{1}{|l|}{\textbf{Attori}}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Colui che appare, recita, in un\\ contenuto\end{tabular}}                                                          & \multicolumn{1}{l|}{persona}                                                                                          & \multicolumn{1}{l|}{Film, serie}                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Registi}}     & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Colui che si occupa della regia\\ dei contenuti\end{tabular}}                                                      & \multicolumn{1}{l|}{regia, persona}                                                                                   & \multicolumn{1}{l|}{Film, serie}                                                                \\ \hline
\multicolumn{1}{|l|}{\textbf{Cinema}}      & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Luogo in cui vengono riprodotti\\ i film\end{tabular}}                                                             & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{Film}                                                                       \\ \hline
\multicolumn{1}{|l|}{\textbf{Voto}}        & \multicolumn{1}{l|}{\begin{tabular}[c]{@{}l@{}}Voto numerico (da 1 a 5) espresso\\ da un utente della piattaforma\end{tabular}}                                   & \multicolumn{1}{l|}{}                                                                                                 & \multicolumn{1}{l|}{Contenuto, utente}                                                          \\ \hline
\end{tabular}
\end{adjustwidth}
\end{table}

\newpage

## Requisiti rivisti e strutturati in gruppi di frasi omogenee

* **Frasi di carattere generale:** Si vuole realizzare una base di dati per la gestione di una piattaforma che fornisce
informazioni su film in uscita nei cinema e su serie e programmi TV in onda,
liberamente ispirato a piattaforme come ComingSoon.

* **Frasi relative agli utenti:** Gli utenti possono essere di due tipologie: iscritti o redattori.
Gli utenti si memorizzano tramite nome utente, password e indirizzo email.

* **Frasi relative ai redattori:** I redattori sono utenti che si occupano di aggiornare le
informazioni sui contenuti disponibili inserendo i dati di film e serie,
comprese le date di uscita e programmazione in sala e in TV.
Per i redattori si tiene traccia anche della data di inizio collaborazione.

* **Frasi relative agli iscritti:** Gli iscritti si registrano tramite email e password. 
Possono votare e aggiungere ai preferiti qualunque contenuto. Nel momento della cancellazione
di un utente dal sito, i suoi preferiti possono essere rimossi dal database, mentre i voti espressi
dal visitatore rimangono in memoria.

* **Frasi relative ai contenuti:** 
