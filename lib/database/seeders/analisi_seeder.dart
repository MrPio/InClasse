import 'package:in_classe/model/analisi.dart';
import 'package:tuple/tuple.dart';

import '../database_seeder.dart';

class AnalisiSeeder extends Seeder<Analisi> {
  @override
  List<Analisi> get seeds => [
    Analisi(
      corso: 'is',
      lezione: 1,
      summary:
      "Nella lezione di oggi abbiamo concluso l’analisi della terza categoria di design pattern, quelli comportamentali, dopo aver già trattato quelli creazionali e strutturali. È stato evidenziato come in molte situazioni software complesse, se non si ricorre a una progettazione ordinata, il sistema può diventare ingestibile, ad esempio nel caso in cui ogni componente debba comunicare direttamente con tutti gli altri. Per evitare questo tipo di caos si introduce il pattern Mediator, che funge da intermediario centralizzato tra i componenti, analogamente al modello MVC. Lo stesso principio è stato applicato nei sistemi informativi sanitari regionali durante la pandemia o nei bonifici bancari internazionali, dove il sistema SWIFT funziona come mediatore tra le banche. È stato poi introdotto il concetto di undo, mostrando quanto sia complesso da implementare in sistemi avanzati come un sistema operativo. Per gestire efficacemente l’annullamento di un’azione si ricorre al pattern Memento, che permette di memorizzare lo stato precedente dell’oggetto senza violare l’incapsulamento. Il sistema conserva uno snapshot dello stato, così in caso di necessità può essere ripristinato, mentre nella maggior parte dei casi non si spreca tempo. Un altro pattern discusso è l’Observer, che permette a un oggetto di notificare automaticamente gli altri quando cambia stato. È il meccanismo alla base di sistemi come le mailing list, gli RSS feed o le notifiche push, e si basa sull’idea che solo gli utenti interessati ricevano aggiornamenti, evitando comunicazioni inutili. Questo pattern viene spesso contrapposto a soluzioni naive in cui tutti sono notificati indiscriminatamente, con conseguente disturbo o inefficienza. È stato poi approfondito il pattern State, che consente a un oggetto di cambiare comportamento a seconda del suo stato interno, mantenendo lo stesso comando. È stato fatto l’esempio dei computer zombie e dei botnet per spiegare come un’entità apparentemente secondaria possa modificare completamente il comportamento di un sistema. Allo stesso tempo, è stato ribadito come l’interfaccia giochi un ruolo centrale, permettendo la sostituzione e la modularità dei componenti. Si è parlato anche del pattern Strategy, che consente di scegliere a tempo di esecuzione l’algoritmo migliore tra più opzioni, ad esempio tra quick sort, heap sort o merge sort, a seconda del caso d’uso. Questo pattern riflette la flessibilità necessaria per selezionare la strategia più adatta a un determinato contesto operativo, garantendo migliori prestazioni e adattabilità. Un’altra parte della lezione si è concentrata sul pattern Template Method, utile quando un processo è composto da più passi, alcuni opzionali o variabili. Ogni passaggio viene implementato attraverso un’interfaccia, rendendo più semplice la sostituzione o la personalizzazione di ciascun passo. È stato utilizzato l’esempio della produzione automobilistica per illustrare come una stessa sequenza di operazioni possa produrre auto diverse in base ai componenti o optional selezionati. Infine, è stato introdotto il pattern Visitor, che permette di separare algoritmi da oggetti su cui operano, utile ad esempio nei sistemi client-server. Il visitor permette di adattare il comportamento del sistema in base al tipo di cliente, migliorando l’efficienza e la personalizzazione dell’interazione. Anche qui torna il concetto di interfaccia come elemento di disaccoppiamento e snodabilità tra componenti diversi del sistema. La lezione si è chiusa con un invito a non reinventare soluzioni già esistenti: i pattern sono strumenti consolidati pensati da esperti per affrontare problemi comuni nella progettazione software. Conoscerli significa essere in grado di affrontare problemi reali in modo professionale. Nella prossima lezione ci sarà una panoramica sulle problematiche più attuali dell’ingegneria del software moderna.",
      test: [
        Tuple2(
          "Qual è il ruolo del pattern Memento nella gestione dell'operazione di undo nei sistemi complessi?",
          "Il pattern Memento consente di memorizzare lo stato interno di un oggetto senza violare l’incapsulamento, facilitando l’operazione di undo. È utile nei sistemi complessi dove serve ripristinare configurazioni precedenti, come nei sistemi operativi o negli editor. Memorizza solo quando necessario, riducendo il carico di elaborazione. In questo modo, l’undo diventa efficace senza rallentare le prestazioni.",
        ),
        Tuple2(
          "In che modo il pattern State permette di modificare il comportamento di un oggetto durante l’esecuzione?",
          "Il pattern State consente a un oggetto di cambiare comportamento in base al suo stato interno, mantenendo lo stesso input. Questo approccio rende il codice più flessibile e leggibile, evitando numerosi controlli condizionali. È utile per modellare sistemi con comportamenti dinamici. L’esempio dei robot e della SIM evidenzia il potere di uno stato controllante.",
        ),
        Tuple2(
          "Perché il pattern Strategy è importante nella scelta dell’algoritmo più adatto a tempo di esecuzione?",
          "Il pattern Strategy separa l’algoritmo dalla logica che lo utilizza, permettendo di scegliere la strategia migliore in base al contesto. È utile quando le condizioni variano, come nella scelta tra quick sort, heap sort o merge sort. Migliora le prestazioni e l’adattabilità del sistema. È centrale in contesti dinamici come la data science.",
        ),
        Tuple2(
          "Come il pattern Visitor aiuta a disaccoppiare i comportamenti dai dati e migliorare la modularità?",
          "Il Visitor consente di definire nuove operazioni su oggetti senza modificarne la struttura. Rende possibile adattare il comportamento del sistema al tipo di cliente o contesto. È utile nei sistemi client-server per separare logica e dati. Favorisce modularità, estensibilità e riuso del codice, semplificando l’evoluzione del software.",
        ),
      ],
      topics: [
        "Pattern Mediator",
        "Undo e pattern Memento",
        "Pattern Observer e notifiche",
        "Pattern Strategy",
      ],
    ),
    Analisi(
      corso: 'is',
      lezione: 2,
      summary:
      "Durante la lezione di Ingegneria del Software si sono affrontate tre tematiche fondamentali: la configurazione, la qualità e, seppur brevemente, il riuso del software. È stato introdotto il concetto di configuration management, ovvero l'insieme di strumenti e pratiche che permettono di gestire le versioni del software, i metadati associati come autore e data di modifica, e la possibilità di eseguire rollback in caso di errore. Questo approccio diventa indispensabile soprattutto in contesti collaborativi o con metodologie agili come Scrum, dove lo sviluppo è continuo e ogni iterazione può generare una nuova versione del software. Il sistema di versionamento garantisce controllo, tracciabilità e coerenza tra le varie componenti del progetto, soprattutto quando si affrontano architetture complesse come i microservizi. È stata quindi approfondita la nozione di qualità del software, evidenziando che essa non è un valore assoluto ma relativo al contesto d’uso e alla percezione dell’utente. Un software, per quanto tecnicamente avanzato, può risultare inadeguato se non risponde ai bisogni reali dell’utente o risulta difficile da usare. Sono state analizzate le sei caratteristiche principali che determinano la qualità: funzionalità, usabilità, affidabilità, efficienza, manutenibilità e portabilità, ognuna delle quali include ulteriori sotto-caratteristiche. La qualità non riguarda soltanto il codice, ma anche l’esperienza utente, l’adeguatezza al compito, la compatibilità con altri sistemi, la sicurezza e la conformità agli standard normativi. L’usabilità, ad esempio, si evolve nel concetto più ampio di user experience, che tiene conto di come l’utente percepisce e interagisce col sistema, spingendo verso lo sviluppo partecipato in cui si raccolgono dati reali da test con gli utenti. L’affidabilità riguarda la capacità del software di comportarsi in maniera corretta e prevedibile anche in condizioni avverse, mentre l’efficienza valuta il consumo di risorse in rapporto alle prestazioni. La manutenibilità è centrale, considerando che la manutenzione costituisce la parte predominante nel ciclo di vita di un software: un codice ben progettato, modulare, suddiviso in classi e metodi semplici, facilita interventi futuri. La portabilità è la capacità del software di funzionare su diversi ambienti, come accade con Java grazie alla JVM. Si è poi introdotto il concetto di adattabilità, ossia la capacità di un software di essere modificato o adattato a scenari diversi da quello originale. Si è proseguito con il tema del riuso, fondamentale per ridurre tempi, costi e rischi nello sviluppo. Riutilizzare software già esistente, specie se collaudato e usato da molte persone, garantisce maggiore affidabilità e rispetto degli standard. Tuttavia, il riuso richiede un’attenta valutazione per capire se un software è compatibile con le esigenze del nuovo contesto, e non è sempre semplice trovare o accedere a ciò che serve. È stato fatto l’esempio della pubblica amministrazione, dove diversi enti riadattano lo stesso sistema per scopi diversi, come avvenuto nel caso del software per la gestione delle vaccinazioni. È stato anche sottolineato che oggi un programmatore deve conoscere e saper usare le librerie esistenti, come scikit-learn in Python, piuttosto che reinventare soluzioni già ottimizzate. Infine, si è accennato alla prossima tematica che sarà trattata, quella dei pattern, elementi fondamentali per una progettazione software strutturata e riutilizzabile. L'incontro si è concluso con l'invito a riprendere il discorso sul riuso e ad approfondire i pattern nella lezione successiva.",
      test: [
        Tuple2(
          "Che cos’è il configuration management e perché è importante nello sviluppo software?",
          "Il configuration management è l’insieme di strumenti e pratiche per gestire versioni del software, metadati (come autore e data) e rollback in caso di errore. È fondamentale nello sviluppo collaborativo e nelle metodologie agili perché garantisce tracciabilità, coerenza e controllo nelle modifiche, specialmente in architetture complesse come i microservizi.",
        ),
        Tuple2(
          "Quali sono le sei caratteristiche principali che definiscono la qualità di un software?",
          "Le sei caratteristiche principali sono: funzionalità, usabilità, affidabilità, efficienza, manutenibilità e portabilità. Ciascuna di esse ha ulteriori sotto-caratteristiche e contribuisce a determinare quanto un software sia adatto, stabile, performante, facile da mantenere e compatibile con diversi ambienti.",
        ),
        Tuple2(
            "Perché il riuso del software è vantaggioso e quali criticità può presentare?",
            "Il riuso riduce tempi, costi e rischi nello sviluppo, permettendo di sfruttare soluzioni già collaudate e conformi agli standard. Tuttavia, richiede una valutazione attenta della compatibilità con il nuovo contesto d’uso e può essere complicato trovare software già esistenti adatti alle proprie esigenze, specialmente in contesti pubblici."
        ),
        Tuple2(
            "Qual è la differenza tra usabilità e user experience in un software?",
            "L’usabilità si riferisce alla facilità d’uso del software, mentre la user experience è un concetto più ampio che include la percezione complessiva dell’utente, dalla facilità di navigazione alla soddisfazione nell’uso. La UX si ottiene spesso attraverso test con utenti reali e progettazione partecipata."
        ),
      ],
      topics: [
        "Configuration Management",
        "Qualità del Software",
        "Riuso del Software",
        "User Experience e Usabilità"
      ],
    ),
    Analisi(
      corso: 'ldp',
      lezione: 1,
      summary:
      "La lezione tratta l'uso della struttura dati lista nel contesto della programmazione orientata agli oggetti, in particolare per la gestione di figure composite. La lista adottata è di tipo LIFO (Last In, First Out), simile a uno stack, dove gli elementi vengono inseriti in testa e rimossi dalla stessa posizione. La superclasse LinkedList funge da base per la rappresentazione delle componenti grafiche delle figure composite, con il metodo init che accetta due parametri: il valore del primo elemento e il puntatore alla coda della lista. Il metodo add, inizialmente ereditato da LinkedList, viene successivamente incorporato direttamente in CompositeFigure, che gestisce autonomamente l'aggiunta di elementi alla propria lista interna. Si discute poi dell'uso dell'ereditarietà multipla e delle sue criticità, in particolare nei linguaggi che la supportano, mentre nei linguaggi a ereditarietà singola questi problemi non si presentano. Viene anche affrontata la programmazione relazionale, sottolineando come essa consenta di definire relazioni tra input e output in modo flessibile, a differenza della programmazione imperativa e interattiva. Viene infine introdotto il problema delle N regine, un classico problema combinatorio, per illustrare come generare e verificare soluzioni utilizzando tecniche di backtracking e strutture dati adatte alla ricerca dello spazio delle soluzioni. L'approccio si basa sulla generazione di tutte le possibili configurazioni e sulla selezione di quelle che soddisfano i vincoli del problema, evidenziando la differenza tra approcci deterministici e non deterministici.",
      test: [
        Tuple2(
          "Che tipo di struttura dati viene utilizzata per rappresentare le figure composite e in che modo viene gestito l’inserimento degli elementi?",
          "Per rappresentare le figure composite viene utilizzata una lista di tipo LIFO (Last In, First Out), simile a uno stack, in cui gli elementi vengono inseriti in testa e successivamente estratti sempre dalla testa della lista.",
        ),
        Tuple2(
          "In che modo la classe CompositeFigure interagisce con la struttura dati LinkedList nelle due modalità viste nella lezione?",
          "Nella prima modalità, CompositeFigure eredita da LinkedList e quindi utilizza direttamente i suoi metodi, mentre nella seconda modalità CompositeFigure include al proprio interno un attributo di tipo LinkedList e definisce autonomamente il metodo add che delega comunque l’inserimento alla lista interna.",
        ),
        Tuple2(
            "Qual è il vantaggio della programmazione relazionale nella risoluzione di problemi combinatori, come quello delle quattro regine?",
            "La programmazione relazionale permette di esprimere i vincoli e generare tutte le soluzioni possibili in modo dichiarativo e non deterministico, consentendo al motore inferenziale di esplorare autonomamente lo spazio delle configurazioni ammissibili."
        ),
        Tuple2(
            "Che ruolo ha il costrutto choice nei linguaggi relazionali e perché è importante nella generazione delle soluzioni?",
            "Il costrutto choice consente di gestire la generazione di alternative e il backtracking, permettendo al programma di esplorare vie diverse quando una combinazione fallisce, senza causare errori ma facendo fallire solo il ramo corrente dell’esecuzione."
        ),
      ],
      topics: [
        "LIFO / LinkedList",
        "Ereditarietà multipla",
        "Programmazione relazionale",
        "Problemi combinatori"
      ],
    ),
    Analisi(
      corso: 'mp',
      lezione: 1,
      summary:
      "La curva di taratura dei sensori è non lineare e il valore del misurando non è noto a priori. Per questo il produttore utilizza strumenti di riferimento più precisi. La taratura è valida per un range operativo standard, ma in laboratorio è possibile rifare la curva su un intervallo ristretto per migliorare l'accuratezza. Il comportamento del sensore dipende anche dalla risposta dinamica: quando il tempo di risposta del sensore è paragonabile a quello del sistema misurato, è necessario caratterizzarlo dinamicamente. Sensori piezoelettrici, ad esempio, non misurano in continua a causa della ricombinazione delle cariche e hanno una risposta in frequenza limitata dal circuito di condizionamento. La linearità è sempre un'approssimazione: esistono fenomeni come isteresi e zona morta che influenzano la misura. Per ridurre incertezze e rumore, in simulazioni si introduce una deviazione standard coerente con l’errore reale del sensore. I fattori ambientali influenzano le prestazioni nel tempo, quindi la scelta del sensore deve tenere conto delle condizioni operative. L'acquisizione dati richiede condizionamento del segnale per amplificazione, filtraggio e adattamento d’impedenza, garantendo la corretta trasmissione al convertitore analogico-digitale. Il circuito di condizionamento, basato su amplificatori operazionali e impedenze, massimizza il trasferimento del segnale senza perdita d’informazione. In ambito industriale, si utilizzano segnali standard come 4-20 mA per distinguere tra valori reali e guasti del sensore.",
      test: [
        Tuple2(
            "Cos’è la “curva di taratura” e perché non è perfettamente lineare?",
            "La curva di taratura rappresenta la relazione tra l’uscita del sensore e il valore del misurando. Non è perfettamente lineare perché i principi fisici utilizzati nei sensori sono intrinsecamente non lineari. Inoltre, il valore esatto del misurando non è noto a priori, quindi il produttore utilizza strumenti di riferimento più accurati per costruire la curva. In genere, si lavora in un range ristretto in cui la curva può essere approssimata come lineare."
        ),
        Tuple2(
            "Perché è importante la risposta dinamica del sensore nei sistemi a variazione rapida?",
            "La risposta dinamica diventa fondamentale quando la costante di tempo del sensore è comparabile a quella del sistema da misurare. In questi casi, la risposta statica (curva di taratura) non è più sufficiente: bisogna considerare l’intera risposta in frequenza del sensore per garantire che esso segua correttamente le variazioni del segnale. Se il segnale da misurare varia a 100 Hz, ad esempio, il sensore deve avere una banda piatta almeno fino a quella frequenza."
        ),
        Tuple2(
            "Che ruolo ha il circuito di condizionamento in un sistema di misura analogico-digitale?",
            "Il circuito di condizionamento ha tre funzioni principali:\n\n    Impedance matching – garantisce il corretto trasferimento del segnale tra sensore e convertitore.\n\n    Amplificazione – aumenta il livello del segnale analogico (spesso dell’ordine dei microvolt) per renderlo trattabile.\n\n    Filtraggio – elimina rumori e componenti indesiderate in frequenza.\n    Questo circuito è fondamentale per adattare correttamente il segnale del sensore alla catena di acquisizione dati."
        ),
        Tuple2(
            "Cos’è uno Smart Sensor e quali vantaggi offre?",
            "Uno Smart Sensor è un sensore che integra al suo interno l’amplificazione, il condizionamento del segnale, la conversione analogico-digitale e un microprocessore. I vantaggi sono:\n\n    maggiore intercambiabilità\n\n    configurazione semplificata via software\n\n    possibilità di eseguire elaborazioni locali (es. calcolo di indicatori di condizione)\n\n    riduzione del cablaggio e trasmissione diretta su protocolli industriali."
        ),
      ],
      topics: [
        "Sensori: statica vs dinamica",
        "Condizionamento segnale",
        "DAC e sensori smart",
        "Errori e incertezza"
      ],
    ),
    Analisi(
      corso: 'pa',
      lezione: 1,
      summary:
      "Durante la lezione si è discusso inizialmente della disponibilità online delle registrazioni delle prime lezioni, poi si è introdotto il tema della programmazione avanzata partendo da una riflessione sulla crescente attenzione verso linguaggi memory-safe e sul warning legato all’uso di C e C++, in particolare per la gestione della memoria, spiegando che persino la comunità del kernel Linux sta valutando alternative più sicure. Si è passati poi alla programmazione funzionale, sottolineando come essa eviti effetti collaterali e privilegi un paradigma basato su espressioni e funzioni prive di variabili globali o puntatori, con valutazioni locali e predicibili. È stato introdotto il concetto di lambda calcolo e la trasparenza referenziale, spiegando che in assenza di effetti collaterali l’ordine di valutazione delle espressioni non influenza il risultato. Si è osservato che nella programmazione funzionale si predilige la ricorsione all’iterazione, si usano funzioni di ordine superiore e l’esecuzione di codice è assimilabile a un sistema di deduzione logico-matematica. Si è riflettuto sull’impatto dell’accesso non controllato alla memoria in linguaggi come C, e su come altri linguaggi come Python o Java gestiscano invece questi errori in modo più sicuro. È stato inoltre toccato il concetto di astrazione e riutilizzo del codice con ereditarietà e gestione delle eccezioni, con un’analisi di codice semplice eseguito in ambiente cloud. Infine si è parlato di come costruire i numeri e le operazioni aritmetiche in modo ricorsivo a partire da zero tramite il successore, mostrando che anche funzioni come somma e moltiplicazione possono essere implementate come applicazioni successive e che a-b possono essere a loro volta funzioni, preparando il terreno per esperimenti futuri in JavaScript con funzioni come seno di x e trasformazioni tramite funzioni di ordine superiore.",
      test: [
        Tuple2(
            "Perché si sta parlando di abbandonare C e C++ a favore di altri linguaggi secondo il report discusso in lezione?",
            "Perché C e C++ non sono memory-safe, cioè non garantiscono una gestione sicura della memoria, mentre nuovi linguaggi promuovono maggiore sicurezza, specialmente in ambiti critici come il kernel Linux."
        ),
        Tuple2(
            "Qual è la caratteristica principale della programmazione funzionale che la distingue da quella imperativa?",
            "La programmazione funzionale evita effetti collaterali e modifica dello stato globale, concentrandosi su funzioni pure che operano solo su dati locali e producono lo stesso output per gli stessi input."
        ),
        Tuple2(
            "Che vantaggio offre la trasparenza referenziale nella programmazione funzionale?",
            "Permette di sostituire le funzioni con i loro risultati senza cambiare il comportamento del programma, rendendo il codice più predicibile, testabile e facile da ottimizzare."
        ),
        Tuple2(
            "Perché l’uso di variabili globali e passaggi per indirizzo è considerato problematico?",
            "Perché rendono il comportamento del programma meno prevedibile, introducono dipendenze nascoste e aumentano il rischio di errori difficili da tracciare, compromettendo l'affidabilità del software."
        ),
      ],
      topics: [
        "Programmazione funzionale",
        "Lambda calcolo",
        "Trasparenza referenziale",
        "Ereditarietà"
      ],
    ),
    Analisi(
      corso: 'pa',
      lezione: 2,
      summary:
      "Durante la lezione di Programmazione Avanzata, si è discusso del passaggio dai concetti base a quelli più evoluti come le closure e il currying, che verranno approfonditi successivamente. È stato evidenziato l’uso di Python anche in ambito avanzato per la sua versatilità, affiancato da JavaScript tramite Node.js, motore di esecuzione lato server che permette di superare i limiti imposti dai browser, come l’accesso al file system. A differenza dell’HTML e CSS, che producono contenuti statici, il JavaScript consente la dinamicità e l'interazione con dati e contenuti. Tuttavia, l’obiettivo non è creare pagine web ma back-end che restituiscano contenuti, spesso sotto forma di JSON, formato più leggero rispetto all’XML e ampiamente usato nelle applicazioni web per la trasmissione di dati. Il server, a cui il browser invia richieste (fetch), risponde con dati strutturati che poi vengono elaborati e formattati dal client. Tutti i linguaggi usati lato client (HTML, CSS, JavaScript) sono visibili all’utente finale, mentre le operazioni più sensibili vengono gestite lato server, dove la sicurezza è maggiore. Si è visto come Node.js, insieme ad Express, consente di creare applicativi web complessi con autenticazioni e interazioni con servizi esterni. È stato mostrato l’uso di strumenti come Visual Studio Code per strutturare progetti contenenti sia file Python che JavaScript, introducendo anche la configurazione tramite file come .jshintrc. Si è passati poi alla sintassi comparata tra i linguaggi: in JavaScript si usa console.log, in Python print, e si è parlato di come il motore JavaScript esegua codice in modalità just-in-time (JIT). A livello di dichiarazione delle variabili, sono state introdotte le differenze tra var, let e const, spiegando la loro visibilità e comportamento, con attenzione particolare alla gestione della memoria e ai concetti di blocco e ambito. Si è discusso anche della tipizzazione: sia Python che JavaScript consentono una certa flessibilità, ma mentre Python è dinamico, si può estendere JavaScript con TypeScript per una maggiore sicurezza tramite tipizzazione esplicita. Sono state confrontate anche operazioni comuni su array e stringhe nei due linguaggi, mostrando somiglianze e differenze, come l’uso delle f-string in Python e dei template literal con backtick in JavaScript. L’accento è stato posto sulla gestione delle stringhe, sulla concatenazione, sul tipo di ritorno delle funzioni, sul casting implicito e sul comportamento degli operatori logici e di confronto, spiegando l’importanza del triplo uguale in JavaScript per confronti che tengano conto anche del tipo. Infine, si è osservato il comportamento del linguaggio in caso di errori di inizializzazione o di accesso a variabili non definite, mettendo in evidenza la differenza tra comportamento previsto e imprevedibile, sottolineando l’importanza di una buona gestione delle variabili e della memoria nel codice.",
      test: [
        Tuple2(
            "Qual è il ruolo di Node.js nello sviluppo web e perché è utile lato server?",
            "Node.js è un motore JavaScript eseguito lato server che permette di superare i limiti imposti dal browser, come l'accesso al file system. È utile per sviluppare back-end di applicazioni web che gestiscono dati dinamici, autenticazioni e interazioni con servizi esterni, rendendo possibile l'esecuzione di codice JavaScript anche fuori dal contesto del browser"
        ),
        Tuple2(
            "Perché JSON è preferito all’XML nelle moderne applicazioni web?",
            "JSON è preferito perché è più leggero, leggibile e facile da elaborare rispetto all’XML. È nativamente supportato da JavaScript, il che lo rende particolarmente adatto per lo scambio di dati tra client e server nelle applicazioni web moderne."
        ),
        Tuple2(
            "Qual è la differenza tra var, let e const in JavaScript?",
            "var ha una visibilità a livello di funzione ed è soggetto a hoisting, let ha visibilità a livello di blocco e consente riassegnazioni, mentre const è anch’esso visibile nel blocco ma non permette riassegnazioni (pur permettendo modifiche agli oggetti referenziati). La distinzione è importante per una corretta gestione della memoria e dello scope."
        ),
        Tuple2(
            "In cosa differiscono Python e JavaScript riguardo alla tipizzazione e alla gestione delle stringhe?",
            "Python è un linguaggio dinamico che consente di assegnare variabili senza dichiararne esplicitamente il tipo, ma può essere esteso con annotazioni di tipo. JavaScript, pur essendo anch’esso dinamico, può essere esteso con TypeScript per introdurre la tipizzazione statica. Per quanto riguarda le stringhe, Python utilizza le f-string per l’interpolazione, mentre JavaScript usa i template literal delimitati da backtick."
        ),
      ],
      topics: [
        "Node.js",
        "JSON vs XML",
        "Scope variabili",
        "Tipizzazione in Python e JavaScript"
      ],
    ),
  ];
}
