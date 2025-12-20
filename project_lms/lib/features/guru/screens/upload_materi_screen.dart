import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

// Sesuaikan path import dengan struktur project Anda
import '../controllers/guru_controller.dart';

class UploadMateriScreen extends StatelessWidget {
  /// Sekarang widget ini bisa menggunakan const karena GlobalKey
  /// sudah dipindahkan ke dalam controller/model.
  const UploadMateriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuruController>(
      builder: (context, controller, child) {
        // Mengambil data form dari controller
        final data = controller.uploadMateriData;

        return Scaffold(
          backgroundColor: Colors.white,
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
              'Upload Materi Pembelajaran',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  /// MENGGUNAKAN KEY DARI CONTROLLER (Model)
                  key: data.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- Judul Materi ---
                      _buildLabel('Judul Materi*'),
                      TextFormField(
                        controller: data.judulController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Masukan Judul Materi',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) =>
                            (val == null || val.isEmpty) ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 20),

                      // --- Row: Mata Pelajaran & Kelas ---
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Mata Pelajaran*'),
                                DropdownButtonFormField<String>(
                                  value: data.selectedMapel,
                                  isExpanded: true,
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
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    data.selectedMapel = val;
                                    controller.notifyListeners(); // Refresh UI
                                  },
                                  validator: (val) =>
                                      val == null ? 'Wajib' : null,
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
                                  isExpanded: true,
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
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    data.selectedKelas = val;
                                    controller.notifyListeners();
                                  },
                                  validator: (val) =>
                                      val == null ? 'Wajib' : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // --- Kategori Materi ---
                      _buildLabel('Kategori Materi*'),
                      DropdownButtonFormField<String>(
                        value: data.selectedKategori,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items:
                            ['Modul Teks', 'Video Pembelajaran', 'Latihan Soal']
                                .map(
                                  (k) => DropdownMenuItem(
                                    value: k,
                                    child: Text(
                                      k,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {
                          data.selectedKategori = val;
                          controller.notifyListeners();
                        },
                        validator: (val) => val == null ? 'Wajib' : null,
                      ),
                      const SizedBox(height: 20),

                      // --- Deskripsi Materi ---
                      _buildLabel('Deskripsi Materi'),
                      TextFormField(
                        controller: data.deskripsiController,
                        maxLines: 4,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Tuliskan deskripsi singkat...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // --- File Picker ---
                      _buildLabel('Upload File Materi*'),
                      _buildFilePickerUI(context, controller),
                      const SizedBox(height: 20),

                      // --- Row: Tanggal & Status ---
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Tanggal Publikasi*'),
                                _buildDatePickerUI(context, controller),
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
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  items: ['Aktif', 'Arsip']
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(
                                            s,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    data.selectedStatus = val;
                                    controller.notifyListeners();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // --- Action Buttons ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // Logika draft bisa ditambahkan di controller
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                            ),
                            child: const Text(
                              'Simpan sebagai Draft',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () => _handleUpload(context, controller),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade800,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 15,
                              ),
                            ),
                            child: const Text(
                              'UPLOAD MATERI',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // --- Loading Overlay ---
              if (controller.isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.teal),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Widget Helper: Label Input
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

  // Widget Helper: UI File Picker
  Widget _buildFilePickerUI(BuildContext context, GuruController controller) {
    final data = controller.uploadMateriData;
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'pdf',
            'jpg',
            'jpeg',
            'png',
            'doc',
            'docx',
            'ppt',
            'mp4',
          ],
        );

        if (result != null) {
          // Mengupdate file melalui method controller agar UI refresh
          controller.updateMateriFile(
            File(result.files.single.path!),
            result.files.single.name,
          );
        }
      },
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
                color: Colors.teal,
                size: 32,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  data.fileName ??
                      'Klik untuk upload file materi\n(PDF, JPG, PPT, MP4)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper: UI Date Picker
  Widget _buildDatePickerUI(BuildContext context, GuruController controller) {
    final data = controller.uploadMateriData;
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          controller.updateMateriDate(picked);
        }
      },
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
              data.tanggalPublikasi == null
                  ? 'Pilih Tanggal'
                  : DateFormat('dd/MM/yyyy').format(data.tanggalPublikasi!),
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

  // Logika Eksekusi Upload
  void _handleUpload(BuildContext context, GuruController controller) async {
    final data = controller.uploadMateriData;

    // 1. Validasi Input Form menggunakan Key dari Controller
    if (!data.formKey.currentState!.validate()) return;

    // 2. Validasi File Materi (Harus diisi)
    if (data.selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih file materi terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 3. Eksekusi Submit melalui Controller
    bool success = await controller.submitUploadMateri();

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Materi berhasil di-upload ke sistem!'),
          backgroundColor: Colors.green,
        ),
      );
      // Kembali ke Dashboard (Index 0)
      controller.setSelectedIndex(0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengunggah materi. Periksa koneksi Anda.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
