import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/jadwal_controller.dart';
import '../model/jadwal_item_model.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<JadwalController>();

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
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          /// Bulan & Tahun
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

          /// Tab Hari
          _buildDayTabs(context, controller),

          const SizedBox(height: 20),

          /// Header Hari
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              controller.selectedDay,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// List Jadwal
          Expanded(
            child: _buildJadwalList(controller),
          ),
        ],
      ),
    );
  }

  // ================= TAB HARI =================
  Widget _buildDayTabs(BuildContext context, JadwalController controller) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: controller.days.length,
        itemBuilder: (context, index) {
          final day = controller.days[index];
          final isSelected = day == controller.selectedDay;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => controller.changeDay(day),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.shade400 : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color:
                        isSelected ? Colors.red.shade400 : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected ? Colors.white : Colors.grey.shade700,
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

  // ================= LIST JADWAL =================
  Widget _buildJadwalList(JadwalController controller) {
    final jadwalList = controller.jadwalHariIni;

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

  // ================= CARD JADWAL =================
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
              Icon(Icons.access_time,
                  size: 18, color: Colors.grey.shade700),
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
