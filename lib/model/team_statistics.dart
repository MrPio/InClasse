/// Composizione con Edition
/// COMPLETAMENTE RIDONDANTE, RICAVATA E CACHATA IN LOCALE. Si presuppone che l'app scarichi tutto dell'edizione corrente.
class TeamStatistics {
  int punteggio, partiteGiocate, partiteVinte, pareggi, sconfitte, goalFatti, goalSubiti, differenzaReti;

  TeamStatistics(
      {this.punteggio = 0,
      this.partiteGiocate = 0,
      this.partiteVinte = 0,
      this.pareggi = 0,
      this.sconfitte = 0,
      this.goalFatti = 0,
      this.goalSubiti = 0,
      this.differenzaReti = 0});
}
