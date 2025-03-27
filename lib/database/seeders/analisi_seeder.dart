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
      ];
}
