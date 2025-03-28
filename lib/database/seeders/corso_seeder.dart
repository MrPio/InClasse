import '../../model/corso.dart';
import '../database_seeder.dart';

class CorsoSeeder extends Seeder<Corso> {
  @override
  List<Corso> get seeds => [
        Corso(
            nome: 'Ingegneria del Software',
            docente: 'Domenico URSINO',
            anno: '2024-2025',
            descrizione:
                "L'insegnamento ha la finalità di consentire agli studenti e alle studentesse di conoscere le nozioni di base dell'ingegneria del software, sia nel suo approccio tradizionale sia nell'approccio agile. Gli studenti e le studentesse impareranno, quindi, come si conduce un progetto software dallo studio di fattibilità fino alla validazione e al collaudo. Una seconda parte del corso è dedicata allo studio dei pattern sia a livello progettuale che a livello implementativo. In quest'ultimo caso si farà uso del linguaggio Python che rappresenta il linguaggio di programmazione di riferimento per il corso.",
            uid: "is",
            lezioni: [1, 2, 3, 4, 5, 6, 7, 8]),
        Corso(
            nome: 'Project Management',
            docente: 'Domenico URSINO',
            anno: '2024-2025',
            descrizione:
            "Il corso di Project Management fornisce le competenze fondamentali per pianificare, gestire e controllare progetti in contesti aziendali complessi. Vengono affrontati temi come la definizione degli obiettivi, la gestione dei tempi, dei costi, delle risorse e dei rischi. Il corso include l’utilizzo di strumenti e metodologie standard (come il metodo Gantt e il Critical Path). È previsto l’approccio sia teorico che pratico, con casi studio reali.",
            uid: "pm",
            lezioni: [1, 2, 3, 4, 5, 6]),
        Corso(
            nome: 'Data science',
            docente: 'Domenico URSINO',
            anno: '2024-2025',
            descrizione:
            "Il corso di Data Science introduce agli strumenti e alle tecniche per l’analisi e l’interpretazione dei dati. Copre argomenti come statistica, machine learning, data visualization e gestione dei dataset complessi. Gli studenti imparano a estrarre conoscenza dai dati utilizzando linguaggi come Python e librerie specializzate. Il corso unisce teoria e applicazioni pratiche in contesti reali.",
            uid: "ds",
            lezioni: [1, 2, 3, 4, 5]),
        Corso(
            nome: 'Manutenzione Preventiva per la Robotica e l\'Automazione Intelligente',
            docente: 'Alessandro FREDDI',
            anno: '2024-2025',
            descrizione:
                "L'insegnamento si pone l'obiettivo di fornire conoscenze e capacità di comprensione su sistemi di diagnosi e prognosi per la supervisione e la manutenzione di sistemi robotici e automatici.",
            uid: "mp",
            lezioni: [1, 2, 3, 4, 5, 6, 7, 8]),
        Corso(
            nome: 'Linguaggi di Programmazione',
            docente: 'Alessandro CUCCHIARELLI',
            anno: '2024-2025',
            descrizione:
                "Il corso ha l'obiettivo di fornire conoscenze avanzate sui diversi paradigmi di programmazione e sulle caratteristiche dei linguaggi e delle tecniche di programmazione ad essi associate. Il raggiungimento dell’obiettivo prefissato consentirà l’ampliamento le competenze già acquisite negli altri insegnamenti del corso di laurea relative ai linguaggi ed alle metodologie di programmazione.",
            uid: "ldp",
            lezioni: [1, 2, 3, 4, 5]),
        Corso(
            nome: 'Programmazione Avanzata',
            docente: 'Adriano MANCINI',
            anno: '2024-2025',
            descrizione:
                "Il corso svilupperà la capacità di svolgere analisi progettuali che richiedono un approccio multidisciplinare considerando l’elevata trasversalità del corso (full-stack approach). Grazie allo svolgimento di un lavoro di gruppo gli studenti potranno incrementare le loro abilità comunicative inserendosi in un team e presentando il risultato del lavoro in modo strutturato. Questo consente l’approfondimento di un tema specifico con conseguente sviluppo di capacità di analisi e sintesi di un problema anche complesso trattato nell’ambito del corso.",
            uid: "pa",
            lezioni: [1, 2, 3, 4]),
      ];
}
