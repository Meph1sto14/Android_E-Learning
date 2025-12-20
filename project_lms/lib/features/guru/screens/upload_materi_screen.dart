import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../controllers/guru_controller.dart';

class UploadMateriScreen extends StatelessWidget {
  const UploadMateriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuruController>(
      builder: (context, controller, child) {
        final data = controller.uploadMateriData;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upload Materi'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => controller.setSelectedIndex(0),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: data.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: data.judulController, 
                        decoration: const InputDecoration(labelText: 'Judul Materi*', border: OutlineInputBorder()),
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: data.mapelController, 
                              decoration: const InputDecoration(labelText: 'Mata Pelajaran*', border: OutlineInputBorder()),
                              validator: (v) => v!.isEmpty ? 'Wajib' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: data.kelasController, 
                              decoration: const InputDecoration(labelText: 'Kelas*', border: OutlineInputBorder()),
                              validator: (v) => v!.isEmpty ? 'Wajib' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: data.selectedKategori,
                        decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                        items: ['Modul Teks', 'Video', 'Latihan'].map((k) => DropdownMenuItem(value: k, child: Text(k))).toList(),
                        onChanged: (v) { data.selectedKategori = v; controller.notifyListeners(); },
                        validator: (v) => v == null ? 'Pilih kategori' : null,
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: () async {
                          FilePickerResult? r = await FilePicker.platform.pickFiles();
                          if (r != null) controller.updateMateriFile(File(r.files.single.path!), r.files.single.name);
                        },
                        icon: const Icon(Icons.upload_file),
                        label: Text(data.fileName ?? 'Pilih File Materi'),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                          onPressed: () async {
                            if (data.formKey.currentState!.validate()) {
                              if (data.selectedFile == null) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih file materi dulu!')));
                                return;
                              }
                              bool ok = await controller.submitUploadMateri();
                              if (ok) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Materi Berhasil Diupload!'), backgroundColor: Colors.green));
                                controller.setSelectedIndex(0);
                              }
                            }
                          },
                          child: const Text('UPLOAD SEKARANG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading) Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
            ],
          ),
        );
      },
    );
  }
}