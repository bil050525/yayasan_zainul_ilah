import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../programs/program_list_screen.dart';
import '../news/news_detail_screen.dart';
import '../donation/donation_screen.dart';
import '../auth/login_screen.dart';
import '../profile/profile_screen.dart';
import '../dashboard/transparency_dashboard.dart';
import '../islamic/prayer_times_screen.dart';
import '../islamic/islamic_content_screen.dart';
import 'ppdb_form_screen.dart';
import '../../models/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _HomeContent(onTabChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      }),
      const ProgramListScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'Donasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final Function(int) onTabChanged;
  const _HomeContent({required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yayasan Zainul Ilah'),
        // Tombol logout dihapus dari sini agar beranda bersih untuk publik
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildQuickActions(context),
            _buildIslamicFeatures(context), // Fitur baru
            _buildLatestNews(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang di',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            'Yayasan Zainul Ilah',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Membangun umat melalui pendidikan dan pemberdayaan sosial.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => onTabChanged(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Donasi Sekarang'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _quickActionItem(Icons.school, 'Pendidikan'),
              _quickActionItem(Icons.favorite, 'Sosial'),
              _quickActionItem(Icons.mosque, 'Dakwah'),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TransparencyDashboard()),
                  );
                },
                child: _quickActionItem(Icons.analytics, 'Laporan'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Tombol PPDB
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PpdbFormScreen()),
                );
              },
              icon: const Icon(Icons.app_registration),
              label: const Text('PENDAFTARAN SANTRI BARU (PPDB)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActionItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF1B5E20)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildLatestNews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Berita Terbaru',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyNews.length,
            itemBuilder: (context, index) {
              final news = dummyNews[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                  leading: SizedBox(
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        news.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, size: 20),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    news.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    news.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildIslamicFeatures(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Layanan Islami',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _islamicItem(
                context, 
                Icons.access_time_filled, 
                'Jadwal Sholat', 
                const PrayerTimesScreen()
              ),
              _islamicItem(
                context, 
                Icons.menu_book, 
                'Kumpulan Doa', 
                const IslamicContentScreen()
              ),
              _islamicItem(
                context, 
                Icons.video_library, 
                'Kajian Video', 
                const IslamicContentScreen()
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _islamicItem(BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.green[700]),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
