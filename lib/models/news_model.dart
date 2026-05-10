import 'package:flutter/material.dart';

class NewsModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final String date;
  final String imageUrl;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.imageUrl,
  });
}

final List<NewsModel> dummyNews = [
  NewsModel(
    id: '1',
    title: 'Pembangunan Gedung Madrasah Capai 70%',
    content: 'Alhamdulillah, pembangunan gedung Madrasah Zainul Ilah terus menunjukkan kemajuan positif. Saat ini pembangunan telah mencapai tahap penyelesaian atap dan mulai memasuki tahap finishing interior. Kami mengucapkan terima kasih kepada seluruh donatur yang telah berkontribusi.',
    author: 'Admin Yayasan',
    date: '08 Mei 2026',
    imageUrl: 'https://picsum.photos/seed/news1/600/400',
  ),
  NewsModel(
    id: '2',
    title: 'Penyaluran Sembako Ramadhan',
    content: 'Yayasan Zainul Ilah telah menyalurkan 500 paket sembako kepada warga lansia dan janda prasejahtera di sekitar lingkungan yayasan. Kegiatan ini merupakan bagian dari program sosial rutin di bulan suci Ramadhan.',
    author: 'Tim Sosial',
    date: '01 Mei 2026',
    imageUrl: 'https://picsum.photos/seed/news2/600/400',
  ),
];
