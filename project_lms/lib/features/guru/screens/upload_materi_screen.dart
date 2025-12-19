import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../controllers/guru_controller.dart';

class UploadMateriScreen extends StatefulWidget {
  const UploadMateriScreen({super.key});

  @override
  State<UploadMateriScreen> createState() => _UploadMateriScreenState();
}

class _UploadMateriScreenState extends State<UploadMateriScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickFile(dynamic data) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'ppt', 'mp4'],
    );

    if (result != null) {
      setState(() {
        data.selectedFile = File(result.files.single.path!);
        data.fileName = result.files.single.name;
      });
    }
  }

  Future<void> _pickDate(BuildContext context, dynamic data) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        data.tanggalPublikasi = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GuruController>(context);
    final data = controller.uploadMateriData; 

    return Scaffold(
      backgroundColor: Colors.white,
      // PENAMBAHAN APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => controller.setSelectedIndex(0), // Kembali ke Dashboard
        ),
        title: const Text(
          'Upload Materi Pembelajaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabel('Judul Materi*'),
              TextFormField(
                controller: data.judulController,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(hintText: 'Masukan Judul Materi', border: OutlineInputBorder()),
                validator: (val) => (val == null || val.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Mata Pelajaran*'),
                        DropdownButtonFormField<String>(
                          value: data.selectedMapel,
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                          items: ['Bahasa Indonesia', 'Matematika', 'Bahasa Inggris']
                              .map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))
                              .toList(),
                          onChanged: (val) => setState(() => data.selectedMapel = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Kelas*'),
                        DropdownButtonFormField<String>(
                          value: data.selectedKelas,
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                          items: ['Kelas 7A', 'Kelas 7B', 'Kelas 7C']
                              .map((k) => DropdownMenuItem(value: k, child: Text(k, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))
                              .toList(),
                          onChanged: (val) => setState(() => data.selectedKelas = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel('Kategori Materi*'),
              DropdownButtonFormField<String>(
                value: data.selectedKategori,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Modul Teks', 'Video Pembelajaran', 'Latihan Soal']
                    .map((k) => DropdownMenuItem(value: k, child: Text(k, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))
                    .toList(),
                onChanged: (val) => setState(() => data.selectedKategori = val),
              ),
              const SizedBox(height: 20),
              _buildLabel('Deskripsi Materi'),
              TextFormField(
                controller: data.deskripsiController,
                maxLines: 4,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(hintText: 'Tuliskan deskripsi...', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              _buildLabel('Upload File Materi*'),
              _buildFilePickerUI(data),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Tanggal Publikasi*'),
                        _buildDatePickerUI(context, data),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Status*'),
                        DropdownButtonFormField<String>(
                          value: data.selectedStatus,
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                          items: ['Aktif', 'Arsip']
                              .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))
                              .toList(),
                          onChanged: (val) => setState(() => data.selectedStatus = val),
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
                  OutlinedButton(
                    onPressed: () {}, 
                    child: const Text('Simpan sebagai Draft', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && data.selectedFile != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Materi berhasil di-upload'), backgroundColor: Colors.green),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade800),
                    child: const Text('UPLOAD MATERI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
  );

  Widget _buildFilePickerUI(dynamic data) => GestureDetector(
    onTap: () => _pickFile(data),
    child: Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: Center(
        child: Text(data.fileName ?? 'Klik untuk upload file materi', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    ),
  );

  Widget _buildDatePickerUI(BuildContext context, dynamic data) => InkWell(
    onTap: () => _pickDate(context, data),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data.tanggalPublikasi == null ? 'Pilih' : DateFormat('dd/MM/yyyy').format(data.tanggalPublikasi!), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          const Icon(Icons.calendar_today, size: 18, color: Colors.black),
        ],
      ),
    ),
  );
}