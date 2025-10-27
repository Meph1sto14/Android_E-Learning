import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class KirimTugasScreen extends StatefulWidget {
  final String mapel;
  final String judul;

  const KirimTugasScreen({
    super.key,
    required this.mapel,
    required this.judul,
  });

  @override
  State<KirimTugasScreen> createState() => _KirimTugasScreenState();
}

class _KirimTugasScreenState extends State<KirimTugasScreen> {
  String? selectedFile;
  bool isSubmitted = false;
  final TextEditingController _catatanController = TextEditingController();

  Future<void> pilihFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name;
      });
    }
  }

  void kirimTugas() {
    if (selectedFile != null) {
      setState(() {
        isSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tugas berhasil dikumpulkan!'),
          backgroundColor: Colors.teal,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih file terlebih dahulu sebelum mengirim!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: const Text(
          'Kirimkan Tugas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.mapel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.judul,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Keterangan:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _catatanController,
                decoration: InputDecoration(
                  hintText: 'Tambahkan catatan untuk guru (opsional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              OutlinedButton.icon(
                onPressed: pilihFile,
                icon: const Icon(Icons.attach_file),
                label: Text(
                  selectedFile ?? 'Pilih File Tugas',
                  style: const TextStyle(fontSize: 14),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Colors.teal.shade600),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: kirimTugas,
                icon: const Icon(Icons.send),
                label: const Text('Kirim Sekarang'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.teal.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              if (isSubmitted) ...[
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.teal, size: 60),
                      const SizedBox(height: 10),
                      Text(
                        'Tugas telah dikumpulkan!',
                        style: TextStyle(
                          color: Colors.teal.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
