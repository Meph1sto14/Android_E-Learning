import 'package:flutter/material.dart';

class DashboardGuruScreen extends StatefulWidget {
  const DashboardGuruScreen({super.key});

  @override
  State<DashboardGuruScreen> createState() => _DashboardGuruScreenState();
}

class _DashboardGuruScreenState extends State<DashboardGuruScreen> {
  String _selectedMenu = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double padding = constraints.maxWidth > 600 ? 24.0 : 16.0;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildMenuNavigasi(),
                    const SizedBox(height: 24),
                    _buildPengumuman(),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, cardConstraints) {
                        if (cardConstraints.maxWidth > 800) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildKelasCard('Bahasa Inggris', 'Kelas 7-A', 3, 10)),
                              const SizedBox(width: 20),
                              Expanded(child: _buildKelasCard('Bahasa Inggris', 'Kelas 7-B', 5, 8)),
                              const SizedBox(width: 20),
                              Expanded(child: _buildKelasCard('Bahasa Inggris', 'Kelas 7-C', 1, 12)),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              _buildKelasCard('Bahasa Inggris', 'Kelas 7-A', 3, 10),
                              const SizedBox(height: 20),
                              _buildKelasCard('Bahasa Inggris', 'Kelas 7-B', 5, 8),
                              const SizedBox(height: 20),
                              _buildKelasCard('Bahasa Inggris', 'Kelas 7-C', 1, 12),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 16.0,
      spacing: 16.0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'E-Learning SMPN 3 Purwokerto',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            const Text(
              'Portal Guru',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.teal,
              child: Text(
                'SI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat Datang,',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const Text(
                  'Bu Sari Indah, S.Pd',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuNavigasi() {
    final List<String> menuItems = [
      'Dashboard',
      'Upload Tugas',
      'Upload Materi',
      'Monitor Siswa',
      'Penilaian'
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.start,
        children: menuItems.map((item) {
          bool isActive = _selectedMenu == item;
          return ChoiceChip(
            label: Text(item),
                selected: isActive,
                onSelected: (selected) {
              if (selected) {
                    setState(() {
                      _selectedMenu = item;
                });
              }
            },
            selectedColor: Colors.teal.shade400,
                backgroundColor: Colors.grey.shade200,
                labelStyle: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color:
                      isActive ? Colors.teal.shade400 : Colors.grey.shade300,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPengumuman() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade100.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Row(
        children: const [
          Icon(Icons.campaign_rounded, color: Colors.teal, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Pengumuman: 5 Tugas baru telah dikumpulkan oleh siswa dan menunggu penilaian Anda!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKelasCard(
      String mapel, String kelas, int tugasPerluDinilai, int siswaTerkumpul) {
    const int totalSiswa = 32;
    double progress = siswaTerkumpul / totalSiswa;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.book_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mapel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    kelas,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: Colors.orange.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                '$tugasPerluDinilai Tugas Perlu Dinilai',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Progress Pengumpulan (Tugas 7): $siswaTerkumpul/$totalSiswa Siswa',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade400),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

