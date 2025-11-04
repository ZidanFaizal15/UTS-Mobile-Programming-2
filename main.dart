import 'package:flutter/material.dart';

void main() {
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pemesanan Makanan',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}

// ================= HALAMAN UTAMA =================
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restoran Lezat'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang di Restoran Lezat!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.restaurant_menu, color: Colors.orange),
                SizedBox(width: 10),
                Text('Pilih menu favoritmu di sini!'),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              child: const Text('Lihat Menu Makanan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HALAMAN MENU =================
class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // daftar menu
  final List<Map<String, dynamic>> menuItems = [
    {'nama': 'Nasi Goreng', 'harga': 25000},
    {'nama': 'Mie Ayam', 'harga': 20000},
    {'nama': 'Sate Ayam', 'harga': 30000},
    {'nama': 'Ayam Geprek', 'harga': 22000},
  ];

  // menyimpan pesanan user
  List<Map<String, dynamic>> pesanan = [];

  void tambahPesanan(Map<String, dynamic> item) {
    setState(() {
      pesanan.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Makanan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    title: Text(item['nama']),
                    subtitle: Text('Rp ${item['harga']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        tambahPesanan(item);
                      },
                      child: const Text('Pesan'),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart),
            label: Text('Lihat Pesanan (${pesanan.length})'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(pesanan: pesanan),
                ),
              );
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

// ================= HALAMAN PESANAN =================
class OrderPage extends StatelessWidget {
  final List<Map<String, dynamic>> pesanan;

  const OrderPage({super.key, required this.pesanan});

  @override
  Widget build(BuildContext context) {
    int totalHarga =
    pesanan.fold(0, (sum, item) => sum + (item['harga'] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Anda'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (pesanan.isEmpty)
              const Text(
                'Belum ada pesanan.',
                style: TextStyle(fontSize: 18),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: pesanan.length,
                  itemBuilder: (context, index) {
                    final item = pesanan[index];
                    return ListTile(
                      title: Text(item['nama']),
                      trailing: Text('Rp ${item['harga']}'),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            Text(
              'Total: Rp $totalHarga',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Kembali ke Halaman Utama'),
            ),
          ],
        ),
      ),
    );
  }
}
