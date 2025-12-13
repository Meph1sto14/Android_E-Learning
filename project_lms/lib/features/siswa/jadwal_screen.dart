import 'package:flutter/material.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  String selectedDay = 'Senin';
  final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  // Data jadwal per hari
  final Map<String, List<JadwalItem>> jadwalPerHari = {
    'Senin': [
      JadwalItem(
        mataPelajaran: 'Matematika',
        kodeKelas: 'MTK-101',
        ruangan: 'SE-07-01',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.blue.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Bahasa Indonesia',
        kodeKelas: 'BIN-201',
        ruangan: 'SE-07-02',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.red.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Ilmu Pengetahuan Alam',
        kodeKelas: 'IPA-301',
        ruangan: 'SE-08-01',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.orange.shade100,
      ),
    ],
    'Selasa': [
      JadwalItem(
        mataPelajaran: 'Bahasa Inggris',
        kodeKelas: 'ENG-101',
        ruangan: 'SE-07-03',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.pink.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Ilmu Pengetahuan Sosial',
        kodeKelas: 'IPS-201',
        ruangan: 'SE-07-04',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.amber.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Pendidikan Pancasila',
        kodeKelas: 'PKN-101',
        ruangan: 'SE-08-02',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.purple.shade100,
      ),
    ],
    'Rabu': [
      JadwalItem(
        mataPelajaran: 'Pendidikan Jasmani',
        kodeKelas: 'PJK-101',
        ruangan: 'Lapangan',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.green.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Informatika / TIK',
        kodeKelas: 'TIK-202',
        ruangan: 'LAB-01',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.indigo.shade100,
      ),
    ],
    'Kamis': [
      JadwalItem(
        mataPelajaran: 'Pendidikan Agama',
        kodeKelas: 'PAI-101',
        ruangan: 'SE-07-05',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.teal.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Seni Budaya',
        kodeKelas: 'SBD-101',
        ruangan: 'SE-09-01',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.red.shade200,
      ),
      JadwalItem(
        mataPelajaran: 'Bahasa Jawa',
        kodeKelas: 'BJW-101',
        ruangan: 'SE-07-06',
        waktuMulai: '10:00',
        waktuSelesai: '11:30',
        color: Colors.brown.shade100,
      ),
    ],
    'Jumat': [
      JadwalItem(
        mataPelajaran: 'Prakarya dan Kewirausahaan',
        kodeKelas: 'PKW-101',
        ruangan: 'SE-10-01',
        waktuMulai: '07:00',
        waktuSelesai: '08:30',
        color: Colors.deepPurple.shade100,
      ),
      JadwalItem(
        mataPelajaran: 'Matematika',
        kodeKelas: 'MTK-102',
        ruangan: 'SE-07-01',
        waktuMulai: '08:30',
        waktuSelesai: '09:45',
        color: Colors.blue.shade100,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Jadwal & Presensi',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.access_time, color: Colors.black87),
            onPressed: () {
              // Action untuk history/riwayat
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Bulan dan Tahun
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Desember 2025',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Tab Hari
          _buildDayTabs(),
          const SizedBox(height: 20),
          // Header Hari
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              selectedDay,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List Jadwal
          Expanded(
            child: _buildJadwalList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayTabs() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = day == selectedDay;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedDay = day;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.shade400 : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? Colors.red.shade400 : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildJadwalList() {
    final jadwalList = jadwalPerHari[selectedDay] ?? [];

    if (jadwalList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada jadwal hari ini',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: jadwalList.length,
      itemBuilder: (context, index) {
        return _buildJadwalCard(jadwalList[index]);
      },
    );
  }

  Widget _buildJadwalCard(JadwalItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: _getDarkerColor(item.color),
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.mataPelajaran,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                item.kodeKelas,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                item.ruangan,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                '${item.waktuMulai} - ${item.waktuSelesai}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDarkerColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      1,
    );
  }
}

// Model untuk Jadwal Item
class JadwalItem {
  final String mataPelajaran;
  final String kodeKelas;
  final String ruangan;
  final String waktuMulai;
  final String waktuSelesai;
  final Color color;

  JadwalItem({
    required this.mataPelajaran,
    required this.kodeKelas,
    required this.ruangan,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.color,
  });
}