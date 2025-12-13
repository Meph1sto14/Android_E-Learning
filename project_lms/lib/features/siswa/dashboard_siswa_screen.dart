import 'package:flutter/material.dart';
import 'package:project_lms/features/shared/widgets/materi_card.dart';
import 'package:project_lms/features/shared/widgets/jadwal_card.dart';

class DashboardSiswaScreen extends StatefulWidget {
  const DashboardSiswaScreen({super.key});

  @override
  State<DashboardSiswaScreen> createState() => _DashboardSiswaScreenState();
}

class _DashboardSiswaScreenState extends State<DashboardSiswaScreen> {
  final ScrollController _scrollController = ScrollController();

  // Controller baru untuk list hari agar bisa scroll otomatis saat swipe
  final ScrollController _dayScrollController = ScrollController();

  String selectedDay = 'Senin';

  final List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  final List<MateriItem> mataPelajaran = const [
    MateriItem(
      title: 'Matematika',
      description:
          'Mengembangkan kemampuan berhitung, berpikir logis, dan memecahkan masalah sehari-hari.',
      icon: Icons.calculate_outlined,
      color: Colors.blueAccent,
    ),
    MateriItem(
      title: 'Bahasa Indonesia',
      description:
          'Mengasah keterampilan berbahasa melalui membaca, menulis, berbicara, dan mendengarkan dengan baik.',
      icon: Icons.book_outlined,
      color: Colors.green,
    ),
    MateriItem(
      title: 'Ilmu Pengetahuan Alam',
      description:
          'Mempelajari gejala alam, makhluk hidup, energi, dan lingkungan untuk memahami dunia sekitar.',
      icon: Icons.science_outlined,
      color: Colors.deepOrange,
    ),
    MateriItem(
      title: 'Pendidikan Pancasila',
      description:
          'Mengenal hak dan kewajiban sebagai warga negara serta pentingnya hidup rukun dan bertanggung jawab.',
      icon: Icons.gavel_outlined,
      color: Colors.purple,
    ),
  ];

  // Data untuk progress pelajaran horizontal
  final List<ProgressPelajaranItem> progressPelajaran = const [
    ProgressPelajaranItem(
      title: 'Ilmu Pengetahuan Alam',
      siswa: 'Lina',
      lesson: 3,
      totalLesson: 7,
      imageUrl: 'assets/images/science.jpg',
    ),
    ProgressPelajaranItem(
      title: 'Ilmu Pengetahuan Sosial',
      siswa: 'Lina',
      lesson: 6,
      totalLesson: 7,
      imageUrl: 'assets/images/social.jpg',
    ),
    ProgressPelajaranItem(
      title: 'Informatika / TIK',
      siswa: 'Lina',
      lesson: 1,
      totalLesson: 7,
      imageUrl: 'assets/images/informatika.jpg',
    ),
  ];

  // Data jadwal pelajaran
  final List<JadwalItem> allJadwal = const [
    // Senin
    JadwalItem(
      mapel: 'Matematika',
      hari: 'Senin',
      mulai: '07:00',
      selesai: '08:30',
    ),
    JadwalItem(
      mapel: 'Bahasa Indonesia',
      hari: 'Senin',
      mulai: '08:30',
      selesai: '10:00',
    ),
    JadwalItem(
      mapel: 'Ilmu Pengetahuan Alam',
      hari: 'Senin',
      mulai: '10:15',
      selesai: '11:45',
    ),

    // Selasa
    JadwalItem(
      mapel: 'Bahasa Inggris',
      hari: 'Selasa',
      mulai: '07:00',
      selesai: '08:30',
    ),
    JadwalItem(
      mapel: 'Ilmu Pengetahuan Sosial',
      hari: 'Selasa',
      mulai: '08:30',
      selesai: '10:00',
    ),
    JadwalItem(
      mapel: 'Matematika',
      hari: 'Selasa',
      mulai: '10:15',
      selesai: '11:45',
    ),

    // Rabu
    JadwalItem(
      mapel: 'Pendidikan Pancasila',
      hari: 'Rabu',
      mulai: '07:00',
      selesai: '08:30',
    ),
    JadwalItem(
      mapel: 'Bahasa Indonesia',
      hari: 'Rabu',
      mulai: '08:30',
      selesai: '10:00',
    ),
    JadwalItem(
      mapel: 'Pendidikan Jasmani',
      hari: 'Rabu',
      mulai: '10:15',
      selesai: '11:45',
    ),

    // Kamis
    JadwalItem(
      mapel: 'Ilmu Pengetahuan Alam',
      hari: 'Kamis',
      mulai: '07:00',
      selesai: '08:30',
    ),
    JadwalItem(
      mapel: 'Matematika',
      hari: 'Kamis',
      mulai: '08:30',
      selesai: '10:00',
    ),
    JadwalItem(
      mapel: 'Seni Budaya',
      hari: 'Kamis',
      mulai: '10:15',
      selesai: '11:45',
    ),

    // Jumat
    JadwalItem(
      mapel: 'Pendidikan Agama Islam',
      hari: 'Jumat',
      mulai: '08:00',
      selesai: '09:30',
    ),
    JadwalItem(
      mapel: 'Bahasa Inggris',
      hari: 'Jumat',
      mulai: '09:30',
      selesai: '11:00',
    ),
  ];

  List<JadwalItem> get filteredJadwal {
    return allJadwal.where((jadwal) => jadwal.hari == selectedDay).toList();
  }

  // Helper untuk mendapatkan index hari saat ini
  int get _currentIndex => days.indexOf(selectedDay);

  // Fungsi untuk mengganti hari (digunakan saat swipe atau klik)
  void _changeDay(int newIndex) {
    if (newIndex >= 0 && newIndex < days.length) {
      setState(() {
        selectedDay = days[newIndex];
      });
      // Scroll list tombol hari agar tombol aktif terlihat
      _scrollToDay(newIndex);
    }
  }

  // Fungsi scroll otomatis untuk tombol hari
  void _scrollToDay(int index) {
    if (_dayScrollController.hasClients) {
      // Estimasi lebar item sekitar 85px (padding + text)
      double offset = index * 85.0;
      // Batasi agar tidak scroll berlebih (simple clamp)
      double maxScroll = _dayScrollController.position.maxScrollExtent;
      if (offset > maxScroll) offset = maxScroll;

      _dayScrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dayScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: null,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildTopHeader(context)),
          SliverToBoxAdapter(child: _buildHeader(context)),
          _buildSectionTitle("Mata Pelajaran Anda"),
          _buildMateriGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          _buildSectionTitle("Jadwal Pelajaran"),
          SliverToBoxAdapter(
            child: Column(
              children: [_buildDayFilterWidget(), const SizedBox(height: 16)],
            ),
          ),
          _buildJadwalList(), // List jadwal dengan fitur swipe
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ================= Top Header (White Navigation Bar) =================
  Widget _buildTopHeader(BuildContext context) {
    return Column(
      children: [
        // ==================== BARIS ATAS PUTIH ====================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: Colors.white,
          child: Row(
            children: [
              const Row(
                children: [
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
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/profile.jpeg"),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ==================== BARIS MENU WARNA HIJAU ====================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          color: Colors.teal.shade700,
          child: Row(
            children: [
              Row(
                children: [
                  _menuItemClickable(context, "Course", null),
                  const SizedBox(width: 25),
                  _menuItemClickable(context, "Nilai", '/nilai'),
                  const SizedBox(width: 25),
                  _menuItemClickable(context, "Tugas", '/tugas'),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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

  Widget _menuItemClickable(BuildContext context, String title, String? route) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ================= Header Gradient (Progress Section) =================
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade700, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
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
            'Progress Pelajaran anda',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressCarousel(),
        ],
      ),
    );
  }

  // ================= Progress Carousel dengan Panah =================
  Widget _buildProgressCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: progressPelajaran.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 8,
                  right: index == progressPelajaran.length - 1 ? 0 : 8,
                ),
                child: _buildProgressCard(progressPelajaran[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Panah navigasi di bawah card
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildNavButton(Icons.chevron_left, Colors.teal.shade400, () {
              _scrollController.animateTo(
                _scrollController.offset - 268,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }),
            const SizedBox(width: 8),
            _buildNavButton(Icons.chevron_right, Colors.teal.shade600, () {
              _scrollController.animateTo(
                _scrollController.offset + 268,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }),
          ],
        ),
      ],
    );
  }

  // ================= Progress Card Item =================
  Widget _buildProgressCard(ProgressPelajaranItem item) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gambar header
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 85,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: item.imageUrl.isNotEmpty
                  ? Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
          // Info section
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage("assets/images/profile.jpeg"),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.siswa,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: item.lesson / item.totalLesson,
                    color: Colors.teal,
                    backgroundColor: Colors.grey.shade300,
                    minHeight: 5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Lesson ${item.lesson} of ${item.totalLesson}',
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= Tombol Navigasi =================
  Widget _buildNavButton(IconData icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // ================= Title section =================
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

  // ================= Grid Pelajaran =================
  SliverPadding _buildMateriGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.95,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => MateriCard(item: mataPelajaran[index]),
          childCount: mataPelajaran.length,
        ),
      ),
    );
  }

  // ================= Day Filter Widget =================
  Widget _buildDayFilterWidget() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        controller: _dayScrollController, // Tambahkan controller
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const ClampingScrollPhysics(),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = day == selectedDay;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _changeDay(index); // Gunakan fungsi changeDay
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.teal.shade600 : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Colors.teal.shade600
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.teal.shade200.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.teal.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
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

  // ================= Jadwal List dengan Swipe =================
  SliverToBoxAdapter _buildJadwalList() {
    return SliverToBoxAdapter(
      // GestureDetector mendeteksi usapan layar
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe ke Kanan (Hari Sebelumnya)
            _changeDay(_currentIndex - 1);
          } else if (details.primaryVelocity! < 0) {
            // Swipe ke Kiri (Hari Berikutnya)
            _changeDay(_currentIndex + 1);
          }
        },
        child: Container(
          // Min height agar area swipe tetap ada meskipun list kosong
          constraints: const BoxConstraints(minHeight: 200),
          color: Colors.transparent, // Transparan agar gesture terdeteksi
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            // Key berubah berdasarkan selectedDay agar animasi berjalan
            child: Column(
              key: ValueKey<String>(selectedDay),
              children: [
                if (filteredJadwal.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 50,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Tidak ada jadwal untuk hari $selectedDay',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Geser untuk melihat hari lain',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredJadwal.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: JadwalCard(item: filteredJadwal[index]),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= Model untuk Progress Pelajaran =================
class ProgressPelajaranItem {
  final String title;
  final String siswa;
  final int lesson;
  final int totalLesson;
  final String imageUrl;

  const ProgressPelajaranItem({
    required this.title,
    required this.siswa,
    required this.lesson,
    required this.totalLesson,
    required this.imageUrl,
  });
}
