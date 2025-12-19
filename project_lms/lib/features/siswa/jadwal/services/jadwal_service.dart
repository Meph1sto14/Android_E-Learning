import 'package:flutter/material.dart';
import '../model/jadwal_item_model.dart';

class JadwalService {
  final Map<String, List<JadwalItem>> _jadwalPerHari = {
    'Senin': [
      JadwalItem(
        mataPelajaran: 'Matematika',
        kodeKelas: 'MTK-101',
        ruangan: 'SE-07-01',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.blueAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Bahasa Indonesia',
        kodeKelas: 'BIN-201',
        ruangan: 'SE-07-02',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.redAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Ilmu Pengetahuan Alam',
        kodeKelas: 'IPA-301',
        ruangan: 'SE-08-01',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.orangeAccent.shade100,
      ),
    ],
    'Selasa': [
      JadwalItem(
        mataPelajaran: 'Bahasa Inggris',
        kodeKelas: 'ENG-101',
        ruangan: 'SE-07-03',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.pinkAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Ilmu Pengetahuan Sosial',
        kodeKelas: 'IPS-201',
        ruangan: 'SE-07-04',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.amberAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Pendidikan Pancasila',
        kodeKelas: 'PKN-101',
        ruangan: 'SE-08-02',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.purpleAccent.shade100,
      ),
    ],
    'Rabu': [
      JadwalItem(
        mataPelajaran: 'Pendidikan Jasmani',
        kodeKelas: 'PJK-101',
        ruangan: 'Lapangan',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.greenAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Informatika / TIK',
        kodeKelas: 'TIK-202',
        ruangan: 'LAB-01',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.indigoAccent.shade100,
      ),
    ],
    'Kamis': [
      JadwalItem(
        mataPelajaran: 'Pendidikan Agama',
        kodeKelas: 'PAI-101',
        ruangan: 'SE-07-05',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.tealAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Seni Budaya',
        kodeKelas: 'SBD-101',
        ruangan: 'SE-09-01',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.redAccent.shade200,
      ),
      JadwalItem(
        mataPelajaran: 'Bahasa Jawa',
        kodeKelas: 'BJW-101',
        ruangan: 'SE-07-06',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.brown.shade200,
      ),
    ],
    'Jumat': [
      JadwalItem(
        mataPelajaran: 'Prakarya dan Kewirausahaan',
        kodeKelas: 'PKW-101',
        ruangan: 'SE-10-01',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.deepPurpleAccent.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Matematika',
        kodeKelas: 'MTK-102',
        ruangan: 'SE-07-01',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.blueAccent.shade100,
      ),
    ],
  };

  Map<String, List<JadwalItem>> get jadwalPerHari => _jadwalPerHari;
}
