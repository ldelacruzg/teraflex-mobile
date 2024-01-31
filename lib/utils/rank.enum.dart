enum Rank {
  fortaleza,
  superacion,
  renovacion,
  recuperacion,
  crecimiento,
  dominio,
}

Rank rankFromString(String rank) {
  switch (rank) {
    case 'Fortaleza':
      return Rank.fortaleza;
    case 'Superación':
      return Rank.superacion;
    case 'Renovación':
      return Rank.renovacion;
    case 'Recuperación':
      return Rank.recuperacion;
    case 'Crecimiento':
      return Rank.crecimiento;
    case 'Dominio':
      return Rank.dominio;
    default:
      return Rank.fortaleza;
  }
}

String rankToString(Rank rank) {
  switch (rank) {
    case Rank.fortaleza:
      return 'Fortaleza';
    case Rank.superacion:
      return 'Superación';
    case Rank.renovacion:
      return 'Renovación';
    case Rank.recuperacion:
      return 'Recuperación';
    case Rank.crecimiento:
      return 'Crecimiento';
    case Rank.dominio:
      return 'Dominio';
    default:
      return 'Fortaleza';
  }
}
