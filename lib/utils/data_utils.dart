abstract class DataUtils {
  static String getUserImage(String username) {
    if (username == 'alumno') {
      return 'https://img.europapress.es/fotoweb/fotonoticia_20170618101437_420.jpg';
    }
    return _getImageUrl(username);
  }

  static String getChannelImage() => _getImageUrl('');

  static String _getImageUrl(String value) =>
      'https://ui-avatars.com/api/?name=$value';
}
