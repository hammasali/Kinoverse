class Utils {
  static String getUserName(String email) => '${email.split('@')[0]}';
  static dynamic hourlyRate(String rate)=> '${rate.split('-')}';
}
