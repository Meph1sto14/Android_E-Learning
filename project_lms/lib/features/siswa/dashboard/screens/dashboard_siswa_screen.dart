import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/dashboard_siswa_controller.dart';
import 'package:project_lms/features/shared/widgets/materi_card.dart';
import 'package:project_lms/features/shared/widgets/jadwal_card.dart';
import 'package:project_lms/features/shared/widgets/progress_pelajaran_card.dart';

class DashboardSiswaScreen extends StatelessWidget {
  const DashboardSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<DashboardSiswaController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildTopHeader(context)),
          SliverToBoxAdapter(child: _buildHeader(c)),

          _buildSectionTitle("Mata Pelajaran Anda"),
          _buildMateriGrid(c, context), // 🔥 TAMBAHKAN context

          const SliverToBoxAdapter(child: SizedBox(height: 40)),

          _buildSectionTitle("Jadwal Pelajaran"),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildDayFilterWidget(c),
                const SizedBox(height: 16),
              ],
            ),
          ),
          _buildJadwalList(c),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ================= TOP HEADER =================
  Widget _buildTopHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: Colors.white,
          child: Row(
            children: [
              Row(
                children: const [
                  Icon(Icons.school, color: Colors.teal, size: 30),
                  SizedBox(width: 8),
                  Text(
                    "SMPN 3 Purwokerto",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: const [
                  Text(
                    "Lina Melinda",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          color: Colors.teal.shade700,
          child: Row(
            children: [
              _menuItem("Course"),
              const SizedBox(width: 25),
              _menuItemClickable(context, "Nilai", "/nilai"),
              const SizedBox(width: 25),
              _menuItemClickable(context, "Tugas", "/tugas"),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/",
                    (route) => false,
                  );
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuItem(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _menuItemClickable(
    BuildContext context,
    String title,
    String route,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // ================= HEADER PROGRESS =================
  Widget _buildHeader(DashboardSiswaController c) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade700, Colors.teal.shade400],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Progress Pelajaran Anda",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressCarousel(c),
        ],
      ),
    );
  }

  Widget _buildProgressCarousel(DashboardSiswaController c) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: c.progressScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: c.progressPelajaran.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ProgressPelajaranCard(
                  item: c.progressPelajaran[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _navButton(Icons.chevron_left, c.scrollProgressLeft),
            const SizedBox(width: 8),
            _navButton(Icons.chevron_right, c.scrollProgressRight),
          ],
        ),
      ],
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // ================= SECTION TITLE =================
  SliverToBoxAdapter _buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
      ),
    );
  }

  // ================= MATERI GRID ================= 
  // 🔥 DIPERBARUI: Tambah parameter context dan wrap dengan GestureDetector
  SliverPadding _buildMateriGrid(DashboardSiswaController c, BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = c.mataPelajaran[index];
            
            // 🔥 WRAP dengan GestureDetector untuk handle tap
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print('════════════════════════════════');
                print('CARD DIKLIK: ${item.title}');
                print('Index: $index');
                print('════════════════════════════════');
                
                // Tampilkan SnackBar untuk konfirmasi visual
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Membuka materi ${item.title}...'),
                    duration: const Duration(milliseconds: 800),
                    backgroundColor: Colors.teal,
                  ),
                );
                
                // Navigasi ke halaman detail materi
                Navigator.pushNamed(
                  context,
                  '/materi_detail',
                  arguments: item.title,
                );
              },
              child: MateriCard(item: item),
            );
          },
          childCount: c.mataPelajaran.length,
        ),
      ),
    );
  }

  // ================= DAY FILTER =================
  Widget _buildDayFilterWidget(DashboardSiswaController c) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        controller: c.dayScrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: c.days.length,
        itemBuilder: (context, index) {
          final day = c.days[index];
          final isSelected = day == c.selectedDay;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => c.changeDay(index),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        isSelected ? Colors.teal : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= JADWAL LIST =================
  SliverToBoxAdapter _buildJadwalList(DashboardSiswaController c) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            c.changeDay(c.currentDayIndex - 1);
          } else if (details.primaryVelocity! < 0) {
            c.changeDay(c.currentDayIndex + 1);
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Column(
            key: ValueKey(c.selectedDay),
            children: [
              if (c.filteredJadwal.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "Tidak ada jadwal hari ${c.selectedDay}",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: c.filteredJadwal.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: JadwalCard(
                        item: c.filteredJadwal[index],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}