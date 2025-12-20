import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

// Import project internal
import '../controllers/guru_controller.dart';

class UploadTugasScreen extends StatelessWidget {
  /// Constructor const meningkatkan performa rendering
  const UploadTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuruController>(
      builder: (context, controller, child) {
        final data = controller.uploadTugasData;

        return Scaffold(
          backgroundColor: const Color(
            0xFFF8F9FA,
          ), // Latar belakang abu-abu sangat muda
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
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
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: data.formKey, // Key dikelola oleh Controller/Model
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- SEKSI 1: INFORMASI DASAR ---
                      _buildSectionHeader(
                        Icons.info_outline,
                        "Informasi Tugas",
                      ),
                      const SizedBox(height: 12),
                      _buildLabel('Judul Tugas*'),
                      TextFormField(
                        controller: data.judulController,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        decoration: _inputDecoration(
                          'Contoh: Latihan Kalimat Pasif',
                        ),
                        validator: (val) => (val == null || val.isEmpty)
                            ? 'Judul tidak boleh kosong'
                            : null,
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
                                  isExpanded: true,
                                  decoration: _inputDecoration('Pilih'),
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
                                    controller.notifyListeners();
                                  },
                                  validator: (val) =>
                                      val == null ? 'Wajib' : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Kelas*'),
                                DropdownButtonFormField<String>(
                                  value: data.selectedKelas,
                                  isExpanded: true,
                                  decoration: _inputDecoration('Pilih'),
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

                      _buildLabel('Deskripsi Instruksi*'),
                      TextFormField(
                        controller: data.deskripsiController,
                        maxLines: 4,
                        decoration: _inputDecoration(
                          'Tuliskan langkah-langkah pengerjaan tugas...',
                        ),
                        validator: (val) => (val == null || val.isEmpty)
                            ? 'Deskripsi wajib diisi'
                            : null,
                      ),

                      const SizedBox(height: 30),

                      // --- SEKSI 2: LAMPIRAN & WAKTU ---
                      _buildSectionHeader(
                        Icons.attachment,
                        "Lampiran & Batas Waktu",
                      ),
                      const SizedBox(height: 12),
                      _buildLabel('File Lampiran Tugas*'),
                      _buildFilePickerUI(context, controller),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Dibuka Pada*'),
                                _buildDatePickerUI(
                                  context,
                                  controller,
                                  data.tanggalMulai,
                                  false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Batas Deadline*'),
                                _buildDatePickerUI(
                                  context,
                                  controller,
                                  data.tanggalDeadline,
                                  true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // --- BUTTON ACTION ---
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => _handlePublish(context, controller),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'PUBLISH TUGAS SEKARANG',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // --- LOADING OVERLAY ---
              if (controller.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // --- Widget Helpers (Private) ---

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.teal.shade800),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6.0, left: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  );

  Widget _buildFilePickerUI(BuildContext context, GuruController controller) {
    final data = controller.uploadTugasData;
    final hasFile = data.selectedFile != null;

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
            'zip',
          ],
        );
        if (result != null) {
          controller.updateTugasFile(
            File(result.files.single.path!),
            result.files.single.name,
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 100,
        decoration: BoxDecoration(
          color: hasFile ? Colors.teal.shade50 : const Color(0xFFF1F3F4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasFile ? Colors.teal : Colors.black12,
            width: hasFile ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                hasFile ? Icons.check_circle : Icons.cloud_upload_outlined,
                color: hasFile ? Colors.teal : Colors.grey,
                size: 28,
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  data.fileName ?? 'Pilih File (PDF, DOC, ZIP)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hasFile
                        ? Colors.teal.shade900
                        : Colors.grey.shade700,
                    fontSize: 12,
                    fontWeight: hasFile ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerUI(
    BuildContext context,
    GuruController controller,
    DateTime? dateValue,
    bool isDeadline,
  ) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: dateValue ?? DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          controller.updateTugasDate(picked, isDeadline);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateValue == null
                  ? 'Pilih'
                  : DateFormat('dd MMM yyyy').format(dateValue),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const Icon(
              Icons.calendar_month_outlined,
              size: 18,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  // --- Logic Handler ---

  void _handlePublish(BuildContext context, GuruController controller) async {
    final data = controller.uploadTugasData;

    if (!data.formKey.currentState!.validate()) return;

    if (data.selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda belum melampirkan file tugas'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (data.tanggalMulai == null || data.tanggalDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal mulai & deadline wajib diisi'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    bool success = await controller.submitPublishTugas();

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tugas berhasil dipublikasikan!'),
          backgroundColor: Colors.green,
        ),
      );
      controller.setSelectedIndex(0); // Kembali ke dashboard
    }
  }
}
