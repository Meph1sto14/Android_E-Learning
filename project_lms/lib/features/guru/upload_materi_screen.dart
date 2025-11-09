import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UploadMateriScreen extends StatefulWidget {
  const UploadMateriScreen({super.key});

  @override
  State<UploadMateriScreen> createState() => _UploadMateriScreenState();
}

class _UploadMateriScreenState extends State<UploadMateriScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers untuk menyimpan data form
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _selectedMapel;
  String? _selectedKelas;
  String? _selectedKategori;
  String? _selectedStatus = 'Aktif'; // Default value
  DateTime? _tanggalPublikasi;

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
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'ppt', 'mp4'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  // --- FUNGSI UNTUK MENGAMBIL TANGGAL ---
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _tanggalPublikasi) {
      setState(() {
        _tanggalPublikasi = picked;
      });
    }
  }

  // --- FUNGSI SUBMIT FORM ---
  void _submitForm({bool isDraft = false}) {
    if (_formKey.currentState!.validate()) {
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap pilih file materi!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // --- TODO: LOGIKA UPLOAD KE BACKEND ---
      // status: isDraft ? 'Draft' : _selectedStatus
      //
      // Kirim ke server/database Anda...
      // ---
      
      final message = isDraft ? 'Materi disimpan sebagai draft' : 'Materi berhasil di-upload';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
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
        title: const Text('Upload Materi Pembelajaran'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Judul Materi*'),
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(hintText: 'Masukan Judul Materi'),
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
                        DropdownButtonFormField<String>(
                          hint: const Text('Pilih Kelas'),
                          value: _selectedKelas,
                          onChanged: (val) => setState(() => _selectedKelas = val),
                          items: ['Kelas 7A', 'Kelas 7B', 'Kelas 7C', 'Semua Kelas 7']
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
              
              _buildSectionTitle('Kategori Materi*'),
              DropdownButtonFormField<String>(
                hint: const Text('Pilih Kategori'),
                value: _selectedKategori,
                onChanged: (val) => setState(() => _selectedKategori = val),
                items: ['Modul Teks', 'Video Pembelajaran', 'Latihan Soal']
                    .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                    .toList(),
                validator: (value) => (value == null) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),

              _buildSectionTitle('Deskripsi Materi'),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan deskripsi singkat tentang materi...',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),

              _buildSectionTitle('Upload File Materi*'),
              _buildFilePicker(),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Tanggal Publikasi*'),
                        _buildDatePicker(
                          context,
                          date: _tanggalPublikasi,
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
                        _buildSectionTitle('Status*'),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          onChanged: (val) => setState(() => _selectedStatus = val),
                          items: ['Aktif', 'Arsip']
                              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
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
                  OutlinedButton(
                    onPressed: () => _submitForm(isDraft: true),
                    child: const Text('Simpan sebagai Draft'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => _submitForm(),
                    child: const Text('Upload Materi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER (Sama seperti sebelumnya) ---

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
                _fileName ?? 'Klik untuk upload file (PDF, JPG, PPT, dll.)',
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
        : DateFormat('dd/MM/yyyy').format(date);

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