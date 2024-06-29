import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionHelper {
  static final _storage = FlutterSecureStorage();

  // Generate a key and store it securely
  static Future<Encrypter> _getEncrypter() async {
    String? keyString = await _storage.read(key: 'encryption_key');
    if (keyString == null) {
      final key = Key.fromSecureRandom(32);
      await _storage.write(key: 'encryption_key', value: base64Url.encode(key.bytes));
      keyString = base64Url.encode(key.bytes);
    }
    final key = Key(base64Url.decode(keyString));
    final encrypter = Encrypter(AES(key));
    return encrypter;
  }

  // Encrypt a plain text
  static Future<String> encrypt(String plainText) async {
    final encrypter = await _getEncrypter();
    final iv = IV.fromLength(16); // Initialization vector
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64Url.encode(iv.bytes + encrypted.bytes);
  }

  // Decrypt an encrypted text
  static Future<String> decrypt(String encryptedText) async {
    final encrypter = await _getEncrypter();
    final bytes = base64Url.decode(encryptedText);
    final iv = IV(bytes.sublist(0, 16));
    final encrypted = Encrypted(bytes.sublist(16));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
