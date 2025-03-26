enum RemoteImages {
  TENNA,
  SANTANDREA;

  String get url => "https://firebasestorage.googleapis.com/v0/b/tdq-37114.appspot.com/o/Teams%2F"
      "${name.toLowerCase() + ".jpg"}?alt=media";

  //final String? _url;

  const RemoteImages();
}
