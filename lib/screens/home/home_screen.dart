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
import '../../providers/data_provider.dart';
import '../../core/app_theme.dart';
import 'package:provider/provider.dart';

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
            const SizedBox(height: 24),
            _buildIslamicFeatures(context),
            _buildLatestNews(context), // Kirim context
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B5E20), // Deep Emerald
            Color(0xFF2E7D32), // Light Emerald
          ],
        ),
        image: DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/arabesque.png'),
          repeat: ImageRepeat.repeat,
          opacity: 0.05,
        ),
        borderRadius: BorderRadius.only(
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



  Widget _buildLatestNews(BuildContext context) {
    final newsList = Provider.of<DataProvider>(context).newsList;

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
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: AppTheme.premiumShadowDecoration(),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        news.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
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
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.premiumShadowDecoration().copyWith(
        color: Colors.green[50], // Memberikan warna mint muda khusus kotak ini
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Layanan Islami & Program',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          // Grid Fitur & Program
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            childAspectRatio: 0.9,
            children: [
              _islamicItem(context, Icons.mosque, 'Jadwal Sholat', const PrayerTimesScreen()),
              _islamicItem(context, Icons.menu_book, 'Kumpulan Doa', const IslamicContentScreen()),
              _islamicItem(context, Icons.video_library, 'Kajian Video', const IslamicContentScreen()),
              _islamicItem(context, Icons.school, 'Pendidikan', const ProgramListScreen()),
              _islamicItem(context, Icons.favorite, 'Sosial', const ProgramListScreen()),
              _islamicItem(context, Icons.record_voice_over, 'Dakwah', const ProgramListScreen()),
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
              label: const Text('PENDAFTARAN SANTRI BARU'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.green[700], size: 26),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 70, // Batasi lebar teks agar tidak tumpang tindih
            child: Text(
              label, 
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
