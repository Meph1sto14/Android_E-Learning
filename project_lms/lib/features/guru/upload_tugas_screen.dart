import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class UploadTugasScreen extends StatefulWidget {
  const UploadTugasScreen({super.key});

  @override
  State<UploadTugasScreen> createState() => _UploadTugasScreenState();
}

class _UploadTugasScreenState extends State<UploadTugasScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers untuk menyimpan data form
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _selectedMapel;
  String? _selectedKelas;
  DateTime? _tanggalMulai;
  DateTime? _tanggalDeadline;

  // Variabel untuk file
  File? _selectedFile;
  String? _fileName;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  // --- FUNGSI UNTUK MENGAMBIL FILE ---
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      // Batasi jenis file yang bisa diupload
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'zip'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  // --- FUNGSI UNTUK MENGAMBIL TANGGAL ---
  Future<void> _pickDate(BuildContext context, {bool isDeadline = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isDeadline) {
          _tanggalDeadline = picked;
        } else {
          _tanggalMulai = picked;
        }
      });
    }
  }

  // --- FUNGSI SUBMIT FORM ---
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap pilih file tugas!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // --- TODO: LOGIKA UPLOAD KE BACKEND ---
      // Ambil semua data:
      // _judulController.text
      // _selectedMapel
      // _selectedKelas
      // _deskripsiController.text
      // _selectedFile
      // _tanggalMulai
      // _tanggalDeadline
      //
      // Kirim ke server/database Anda...
      // ---
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tugas berhasil di-publish!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Tugas Baru'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Judul Tugas*'),
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(hintText: 'Masukan Judul Tugas'),
                validator: (value) => (value == null || value.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Mata Pelajaran*'),
                        // Ganti dengan data asli Anda
                        DropdownButtonFormField<String>(
                          hint: const Text('Pilih Mata Pelajaran'),
                          value: _selectedMapel,
                          onChanged: (val) => setState(() => _selectedMapel = val),
                          items: ['Bahasa Indonesia', 'Matematika', 'Bahasa Inggris']
                              .map((mapel) => DropdownMenuItem(value: mapel, child: Text(mapel)))
                              .toList(),
                          validator: (value) => (value == null) ? 'Wajib diisi' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Kelas*'),
                        // Ganti dengan data asli Anda
                        DropdownButtonFormField<String>(
                          hint: const Text('Pilih Kelas'),
                          value: _selectedKelas,
                          onChanged: (val) => setState(() => _selectedKelas = val),
                          items: ['Kelas 7A', 'Kelas 7B', 'Kelas 7C']
                              .map((kelas) => DropdownMenuItem(value: kelas, child: Text(kelas)))
                              .toList(),
                          validator: (value) => (value == null) ? 'Wajib diisi' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildSectionTitle('Deskripsi Tugas*'),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan deskripsi singkat tentang tugas...',
                ),
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),

              _buildSectionTitle('File Tugas*'),
              _buildFilePicker(), // Widget custom untuk file picker
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Tanggal Mulai*'),
                        _buildDatePicker(
                          context,
                          date: _tanggalMulai,
                          onTap: () => _pickDate(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Tanggal Deadline*'),
                        _buildDatePicker(
                          context,
                          date: _tanggalDeadline,
                          onTap: () => _pickDate(context, isDeadline: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Publish Tugas'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFilePicker() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade50,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload_outlined, color: Colors.grey, size: 40),
              const SizedBox(height: 8),
              Text(
                _fileName ?? 'Klik untuk upload file (PDF, JPG, DOCX, dll.)',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, {DateTime? date, required VoidCallback onTap}) {
    String text = date == null
        ? 'Pilih tanggal'
        : DateFormat('dd/MM/yyyy').format(date); // Format tanggal

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            const Icon(Icons.calendar_today_outlined, size: 20),
          ],
        ),
      ),
    );
  }
}

// Tambahkan ini di file `main.dart` atau file `routes.dart` Anda
// '/upload-tugas': (context) => const UploadTugasScreen(),