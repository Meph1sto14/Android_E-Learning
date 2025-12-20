import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../controllers/guru_controller.dart';

class UploadTugasScreen extends StatelessWidget {
  const UploadTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuruController>(
      builder: (context, controller, child) {
        final data = controller.uploadTugasData;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => controller.setSelectedIndex(0),
            ),
            title: const Text('Buat Tugas Baru', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: data.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Informasi Tugas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
                      const SizedBox(height: 12),
                      
                      const Text("Judul Tugas*", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: data.judulController,
                        decoration: const InputDecoration(hintText: 'Contoh: Latihan Kalimat Pasif', border: OutlineInputBorder()),
                        validator: (val) => (val == null || val.isEmpty) ? 'Judul wajib diisi' : null,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Mata Pelajaran*", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextFormField(
                                  controller: data.mapelController,
                                  decoration: const InputDecoration(hintText: 'Misal: IPA', border: OutlineInputBorder()),
                                  validator: (val) => (val == null || val.isEmpty) ? 'Wajib' : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Kelas*", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextFormField(
                                  controller: data.kelasController,
                                  decoration: const InputDecoration(hintText: 'Misal: 7B', border: OutlineInputBorder()),
                                  validator: (val) => (val == null || val.isEmpty) ? 'Wajib' : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      const Text("Deskripsi Instruksi*", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: data.deskripsiController,
                        maxLines: 4,
                        decoration: const InputDecoration(hintText: 'Langkah pengerjaan...', border: OutlineInputBorder()),
                        validator: (val) => (val == null || val.isEmpty) ? 'Wajib diisi' : null,
                      ),
                      
                      const SizedBox(height: 30),
                      const Text("Lampiran & Batas Waktu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
                      const SizedBox(height: 12),
                      
                      // UI FILE PICKER
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles();
                          if (result != null) {
                            controller.updateTugasFile(File(result.files.single.path!), result.files.single.name);
                          }
                        },
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text(data.fileName ?? 'Pilih File Lampiran')),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildDatePicker(context, controller, data.tanggalMulai, 'Dibuka Pada', false)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildDatePicker(context, controller, data.tanggalDeadline, 'Batas Deadline', true)),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity, height: 55,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (data.formKey.currentState!.validate()) {
                              bool ok = await controller.submitPublishTugas();
                              if (ok) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tugas Berhasil Terbit!'), backgroundColor: Colors.green));
                                controller.setSelectedIndex(0);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700),
                          child: const Text('PUBLISH TUGAS SEKARANG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading) Container(color: Colors.black45, child: const Center(child: CircularProgressIndicator())),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDatePicker(BuildContext context, GuruController controller, DateTime? date, String label, bool isDeadline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () async {
            DateTime? picked = await showDatePicker(context: context, initialDate: date ?? DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 30)), lastDate: DateTime(2030));
            if (picked != null) controller.updateTugasDate(picked, isDeadline);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Text(date == null ? 'Pilih' : DateFormat('dd/MM/yyyy').format(date)),
          ),
        ),
      ],
    );
  }
}