import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static final _supabase = Supabase.instance.client;

  /// Fungsi untuk upload file dan mendapatkan URL-nya
  static Future<String?> uploadFile({
    required File file,
    required String bucketName,
    required String fileName,
  }) async {
    try {
      // 1. Upload file ke bucket
      final String path = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
      await _supabase.storage.from(bucketName).upload(path, file);

      // 2. Ambil Public URL setelah berhasil upload
      final String publicUrl = _supabase.storage.from(bucketName).getPublicUrl(path);
      
      return publicUrl;
    } catch (e) {
      print('Error Upload: $e');
      return null;
    }
  }
}