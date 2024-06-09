import 'package:flutter/material.dart';
import 'package:pkamus/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DictionaryPage(),
    );
  }
}

class DictionaryPage extends StatefulWidget {
  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final List<Map<String, String>> words = [
    {"indonesia": "Anak", "english": "Child", "description": "Seorang manusia muda di bawah usia pubertas."},
    {"indonesia": "Kucing", "english": "Cat", "description": "Mamalia karnivora berbulu lembut yang jinak."},
    {"indonesia": "Sekolah", "english": "School", "description": "Institusi untuk mendidik anak-anak."},
    {"indonesia": "Rumah", "english": "House", "description": "Bangunan tempat tinggal manusia."},
    {"indonesia": "Mobil", "english": "car", "description": "Kendaraan bermotor untuk transportasi darat."},
    {"indonesia": "Kopi", "english": "Coffee", "description": "Minuman panas yang dibuat dari biji kopi yang disangrai."},
    {"indonesia": "Matahari", "english": "Sun", "description": "Bintang di pusat tata surya yang memberikan cahaya dan panas."},
    {"indonesia": "Buku", "english": "Book", "description": " Kumpulan halaman terikat yang berisi teks atau gambar."},
    {"indonesia": "Pisang", "english": "Banana", "description": "Buah tropis yang panjang dan kuning, biasanya dimakan."},
    {"indonesia": "Komputer", "english": "Computer", "description": "Perangkat elektronik untuk memproses dan menyimpan data."},
    {"indonesia": "Meja", "english": "Table", "description": "Permukaan datar dengan kaki untuk menopang objek."},
    {"indonesia": "Tangan", "english": "Hand", "description": "Bagian tubuh yang terletak di ujung lengan."},
    {"indonesia": "Kaki", "english": "Foot", "description": "Bagian tubuh yang terletak di bawah pergelangan kaki."},
    {"indonesia": "Burung", "english": "Bird", "description": "Hewan vertebrata berbulu yang bisa terbang."},
    {"indonesia": "Pintu", "english": "Door", "description": "Pembuka atau penutup masuk ke dalam atau keluar dari ruangan."},
    {"indonesia": "Jalan", "english": "Road", "description": "Jalur untuk transportasi darat."},
    {"indonesia": "Air", "english": "Water", "description": "Senyawa kimia yang terdiri dari dua atom hidrogen dan satu atom oksigen."},
    {"indonesia": "Makan", "english": "Eat", "description": "Proses mengonsumsi makanan untuk memperoleh energi."},
    {"indonesia": "Minum", "english": "drink", "description": "Proses mengonsumsi cairan untuk menghilangkan rasa haus."},
    {"indonesia": "Buah", "english": "Fruit", "description": "Bagian tumbuhan yang mengandung biji dan biasanya dimakan."},
    {"indonesia": "Sayur", "english": "Vegetable", "description": "Bagian tumbuhan yang dimakan sebagai makanan."},
    {"indonesia": "Uang", "english": "Money", "description": "Medium pertukaran yang diterima dalam perdagangan."},
    {"indonesia": "Pakaian", "english": "Clothes", "description": " Bahan yang dikenakan untuk menutup tubuh."},
    {"indonesia": "Tulisan", "english": "Writing", "description": "Proses membuat simbol atau huruf untuk menyampaikan pesan."},
    {"indonesia": "Rambut", "english": "Hair", "description": "Filamen yang tumbuh di kulit kepala manusia dan hewan."},
    {"indonesia": "Susu", "english": "Milk", "description": "Cairan putih yang dihasilkan oleh kelenjar susu mamalia."},
    {"indonesia": "Jam", "english": "Clock", "description": "Alat yang digunakan untuk mengukur waktu."},
    {"indonesia": "Bola", "english": "Ball", "description": "Objek bulat yang biasanya digunakan dalam berbagai jenis permainan."},
    {"indonesia": "Pohon", "english": "Tree", "description": "Tanaman besar dengan batang dan cabang yang berdaun."},
    {"indonesia": "Sapi", "english": "Cow", "description": " Sapi adalah hewan herbivora yang makanannya adalah rumput dan hijauan lainnya."},
  ];

  late TextEditingController _searchController;
  List<Map<String, String>> filteredWords = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredWords = words;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterWords(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredWords = words;
      } else {
        filteredWords = words.where((word) =>
            word['indonesia']!.toLowerCase().contains(query.toLowerCase()) ||
            word['english']!.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  void _showDescription(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('deskripsi'),
          backgroundColor: const Color.fromARGB(255, 143, 220, 255),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('KamusKu',),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterWords,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredWords.length,
              itemBuilder: (context, index) {
                final word = filteredWords[index];
                return ListTile(
                  title: Text(word['indonesia']!),
                  subtitle: Text(word['english']!),
                  onTap: () {
                    _showDescription(context, word['description'] ?? '');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
