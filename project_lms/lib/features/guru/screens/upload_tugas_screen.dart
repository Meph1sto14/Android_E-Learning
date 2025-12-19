import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../controllers/guru_controller.dart';

class UploadTugasScreen extends StatefulWidget {
  const UploadTugasScreen({super.key});

  @override
  State<UploadTugasScreen> createState() => _UploadTugasScreenState();
}

class _UploadTugasScreenState extends State<UploadTugasScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickFile(dynamic data) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'zip'],
    );

    if (result != null) {
      setState(() {
        data.selectedFile = File(result.files.single.path!);
        data.fileName = result.files.single.name;
      });
    }
  }

  Future<void> _pickDate(
    BuildContext context,
    dynamic data, {
    bool isDeadline = false,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isDeadline) {
          data.tanggalDeadline = picked;
        } else {
          data.tanggalMulai = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GuruController>(context);
    final data = controller.uploadTugasData;

    return Scaffold(
      backgroundColor: Colors.white,
      // PENAMBAHAN APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () =>
              controller.setSelectedIndex(0), // Kembali ke Dashboard
        ),
        title: const Text(
          'Buat Tugas Baru',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabel('Judul Tugas*'),
              TextFormField(
                controller: data.judulController,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Masukan Judul Tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Wajib diisi' : null,
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items:
                              [
                                    'Bahasa Indonesia',
                                    'Matematika',
                                    'Bahasa Inggris',
                                  ]
                                  .map(
                                    (m) => DropdownMenuItem(
                                      value: m,
                                      child: Text(
                                        m,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) =>
                              setState(() => data.selectedMapel = val),
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: ['Kelas 7A', 'Kelas 7B', 'Kelas 7C']
                              .map(
                                (k) => DropdownMenuItem(
                                  value: k,
                                  child: Text(
                                    k,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) =>
                              setState(() => data.selectedKelas = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel('Deskripsi Tugas*'),
              TextFormField(
                controller: data.deskripsiController,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Tuliskan deskripsi singkat tentang tugas...',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              _buildLabel('File Tugas*'),
              _buildFilePickerUI(data),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Tanggal Mulai*'),
                        _buildDatePickerUI(
                          context,
                          data,
                          data.tanggalMulai,
                          false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Tanggal Deadline*'),
                        _buildDatePickerUI(
                          context,
                          data,
                          data.tanggalDeadline,
                          true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        data.selectedFile != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tugas berhasil di-publish!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (data.selectedFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Harap pilih file tugas!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'PUBLISH TUGAS SEKARANG',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              data.fileName ?? 'Klik untuk upload file tugas',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildDatePickerUI(
    BuildContext context,
    dynamic data,
    DateTime? dateValue,
    bool isDeadline,
  ) => InkWell(
    onTap: () => _pickDate(context, data, isDeadline: isDeadline),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dateValue == null
                ? 'Pilih'
                : DateFormat('dd/MM/yyyy').format(dateValue),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.calendar_today, size: 18, color: Colors.black),
        ],
      ),
    ),
  );
}
