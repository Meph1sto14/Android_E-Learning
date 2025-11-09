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
  String? _selectedFile;
  bool _isSubmitted = false;
  final TextEditingController _catatanController = TextEditingController();

  // ===================== File Picker =====================
  Future<void> _pilihFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() => _selectedFile = result.files.single.name);
    }
  }

  // ===================== Kirim Tugas =====================
  void _kirimTugas() {
    if (_selectedFile == null) {
      _showSnackBar('Pilih file terlebih dahulu sebelum mengirim!', Colors.redAccent);
      return;
    }

    setState(() => _isSubmitted = true);
    _showSnackBar('Tugas berhasil dikumpulkan!', Colors.teal);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // ===================== UI =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Kirimkan Tugas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildCatatanField(),
          const SizedBox(height: 20),
          _buildFilePickerButton(),
          const SizedBox(height: 20),
          _buildSubmitButton(),
          if (_isSubmitted) _buildSuccessMessage(),
        ],
      ),
    );
  }

  // ===================== Komponen UI =====================
  BoxDecoration _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      );

  Widget _buildHeader() {
    return Column(
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
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildCatatanField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Keterangan:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _catatanController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Tambahkan catatan untuk guru (opsional)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePickerButton() {
    return OutlinedButton.icon(
      onPressed: _pilihFile,
      icon: const Icon(Icons.attach_file),
      label: Text(_selectedFile ?? 'Pilih File Tugas'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: Colors.teal.shade600),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton.icon(
      onPressed: _kirimTugas,
      icon: const Icon(Icons.send),
      label: const Text('Kirim Sekarang'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.teal.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.teal, size: 60),
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
    );
  }
}
