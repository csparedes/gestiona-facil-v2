class Utils {
  static bool validador(String scan) {
    if (scan.length >= 12) {
      return true;
    }
    return false;
  }

  static String transformarFecha(DateTime dateTime) {
    if (dateTime == null) {
      return 'Sin Fecha';
    }
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();
    return day + '/' + month + '/' + year;
  }
}
