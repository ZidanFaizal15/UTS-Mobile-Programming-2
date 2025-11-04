import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_uts/main.dart';

void main() {
  testWidgets('Menampilkan halaman utama restoran', (WidgetTester tester) async {
    // Jalankan aplikasi utama
    await tester.pumpWidget(RestaurantApp());

    // Pastikan teks judul utama muncul
    expect(find.text('Restoran Lezat'), findsOneWidget);

    // Pastikan ada tombol untuk melihat menu
    expect(find.text('Lihat Menu Makanan'), findsOneWidget);

    // Tekan tombol untuk berpindah halaman ke menu
    await tester.tap(find.text('Lihat Menu Makanan'));
    await tester.pumpAndSettle();

    // Verifikasi halaman menu muncul
    expect(find.text('Menu Makanan'), findsOneWidget);
  });
}
