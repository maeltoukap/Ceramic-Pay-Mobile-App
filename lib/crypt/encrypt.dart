import 'package:encrypt/encrypt.dart';

// final key = Key.fromUtf8("bonjourtoutlemondejesuisonprogra");

final iv = IV.fromUtf8("hellotoutlemonde");
final key = Key.fromUtf8('82a645babc5cd41c9a2cb4d0d3ba17ad');
// final iv = IV.fromLength(16);

String encrypt(String text) {
  // final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypter = Encrypter(AES(key));
  final finalCrypt = encrypter.encrypt(text, iv: iv);

  return finalCrypt.base64;
}

String decrypt(String text) {
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final decrypt = encrypter.decrypt(Encrypted.from64(text), iv: iv);

  return decrypt;
}
