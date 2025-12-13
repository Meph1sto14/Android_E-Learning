import 'package:flutter/material.dart';
import 'package:project_lms/features/shared/widgets/materi_card.dart';

class DashboardSiswaScreen extends StatefulWidget {
  const DashboardSiswaScreen({super.key});

  @override
  State<DashboardSiswaScreen> createState() => _DashboardSiswaScreenState();
}

class _DashboardSiswaScreenState extends State<DashboardSiswaScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<MateriItem> mataPelajaran = const [
    MateriItem(
      title: 'Matematika',
      progress: '75%',
      icon: Icons.calculate_outlined,
      color: Colors.blueAccent,
    ),
    MateriItem(
      title: 'Bahasa Indonesia',
      progress: '40%',
      icon: Icons.book_outlined,
      color: Colors.green,
    ),
    MateriItem(
      title: 'Ilmu Pengetahuan Alam',
      progress: '90%',
      icon: Icons.science_outlined,
      color: Colors.deepOrange,
    ),
    MateriItem(
      title: 'Pendidikan Pancasila',
      progress: '20%',
      icon: Icons.gavel_outlined,
      color: Colors.purple,
    ),
  ];

  // Data untuk progress pelajaran horizontal
  final List<ProgressPelajaranItem> progressPelajaran = const [
    ProgressPelajaranItem(
      title: 'Ilmu Pengetahuan Alam',
      teacher: 'Lina',
      lesson: 3,
      totalLesson: 7,
      imageUrl: 'assets/images/science.jpg',
    ),
    ProgressPelajaranItem(
      title: 'Ilmu Pengetahuan Sosial',
      teacher: 'Lina',
      lesson: 6,
      totalLesson: 7,
      imageUrl: 'assets/images/social.jpg',
    ),
    ProgressPelajaranItem(
      title: 'Informatika / TIK',
      teacher: 'Lina',
      lesson: 1,
      totalLesson: 7,
      imageUrl: 'assets/images/informatika.jpg',
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false);
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
                  : const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
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
                      backgroundImage:
                          AssetImage("assets/images/profile.jpeg"),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.teacher,
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
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
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
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
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
}

// ================= Model untuk Progress Pelajaran =================
class ProgressPelajaranItem {
  final String title;
  final String teacher;
  final int lesson;
  final int totalLesson;
  final String imageUrl;

  const ProgressPelajaranItem({
    required this.title,
    required this.teacher,
    required this.lesson,
    required this.totalLesson,
    required this.imageUrl,
  });
}