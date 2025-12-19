import 'package:flutter/material.dart';

class NilaiScreen extends StatelessWidget {
  const NilaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> daftarNilai = [
      {"mapel": "Matematika", "nilai": 92},
      {"mapel": "Bahasa Indonesia", "nilai": 78},
      {"mapel": "Ilmu Pengetahuan Alam", "nilai": 85},
      {"mapel": "Bahasa Inggris", "nilai": 88},
      {"mapel": "Pendidikan Pancasila", "nilai": 70},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Hasil Nilai",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarNilai.length,
        itemBuilder: (context, index) {
          final item = daftarNilai[index];
          final mapel = item["mapel"] as String;
          final nilai = item["nilai"] as int;

          // Tentukan warna berdasarkan nilai
          final Color warnaNilai = _getWarnaNilai(nilai);
          final String grade = _getGrade(nilai);

          return _buildNilaiCard(mapel, nilai, warnaNilai, grade);
        },
      ),
    );
  }

  // ======== Fungsi bantu ========

  Color _getWarnaNilai(int nilai) {
    if (nilai >= 85) return Colors.green.shade600;
    if (nilai >= 70) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  String _getGrade(int nilai) {
    if (nilai >= 85) return "A";
    if (nilai >= 70) return "B";
    return "C";
  }

  Widget _buildNilaiCard(
      String mapel, int nilai, Color warnaNilai, String grade) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar nilai
          CircleAvatar(
            backgroundColor: warnaNilai.withOpacity(0.2),
            child: Text(
              nilai.toString(),
              style: TextStyle(
                color: warnaNilai,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Nama mapel
          Expanded(
            child: Text(
              mapel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Grade huruf
          Text(
            grade,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: warnaNilai,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
