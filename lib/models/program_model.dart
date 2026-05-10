import 'package:flutter/material.dart';

class ProgramModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final double targetAmount;
  final double collectedAmount;
  final IconData icon;

  ProgramModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.targetAmount,
    required this.collectedAmount,
    required this.icon,
  });

  double get progress => collectedAmount / targetAmount;
}

final List<ProgramModel> dummyPrograms = [
  ProgramModel(
    id: '1',
    title: 'Beasiswa Santri Yatim',
    description: 'Bantuan biaya pendidikan untuk santri yatim dan dhuafa di pesantren.',
    category: 'Pendidikan',
    imageUrl: 'https://picsum.photos/seed/program1/600/400',
    targetAmount: 50000000,
    collectedAmount: 35000000,
    icon: Icons.school,
  ),
  ProgramModel(
    id: '2',
    title: 'Sembako untuk Lansia',
    description: 'Penyaluran paket sembako rutin untuk lansia prasejahtera.',
    category: 'Sosial',
    imageUrl: 'https://picsum.photos/seed/program2/600/400',
    targetAmount: 20000000,
    collectedAmount: 12500000,
    icon: Icons.favorite,
  ),
  ProgramModel(
    id: '3',
    title: 'Pembangunan Masjid Al-Hidayah',
    description: 'Renovasi dan pembangunan fasilitas masjid di daerah terpencil.',
    category: 'Dakwah',
    imageUrl: 'https://picsum.photos/seed/program3/600/400',
    targetAmount: 150000000,
    collectedAmount: 85000000,
    icon: Icons.mosque,
  ),
];
