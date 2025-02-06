import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Furniture Store', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;
  final List<String> categories = ['Semua', 'Ruang Tamu', 'Kamar Tidur', 'Ruang Makan'];
  List<String> displayItems = ['kamar_tidur', 'meja_makan', 'meja_tamu', 'ruang_tamu'];

  final Map<String, double> productRatings = {
    'kamar_tidur': 4.5,
    'meja_makan': 4.2,
    'meja_tamu': 4.0,
    'ruang_tamu': 4.3,
  };

  final Map<String, String> productDescriptions = {
    'kamar_tidur': 'Desain modern dan nyaman untuk tidur yang nyenyak.',
    'meja_makan': 'Meja makan yang elegan, cocok untuk berbagai acara.',
    'meja_tamu': 'Minimalis dan fungsional, cocok untuk ruang tamu Anda.',
    'ruang_tamu': 'Sofa empuk dengan desain kontemporer.',
  };

  void updateCategory(int index) {
    setState(() {
      selectedCategory = index;
      if (index == 0) {
        displayItems = ['kamar_tidur', 'meja_makan', 'meja_tamu', 'ruang_tamu'];
      } else if (index == 1) {
        displayItems = ['ruang_tamu'];
      } else if (index == 2) {
        displayItems = ['kamar_tidur'];
      } else if (index == 3) {
        displayItems = ['meja_makan'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Temukan Furnitur Modern Terbaik',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: selectedCategory == index,
                    onSelected: (selected) {
                      updateCategory(index);
                    },
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Furnitur Rekomendasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                return FurnitureCard(
                  imageType: displayItems[index],
                  rating: productRatings[displayItems[index]] ?? 0.0,
                  description: productDescriptions[displayItems[index]] ?? '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          imageType: displayItems[index],
                          title: displayItems[index],
                          price: _getPrice(displayItems[index]),
                          rating: productRatings[displayItems[index]] ?? 0.0,
                          description: productDescriptions[displayItems[index]] ?? '',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getPrice(String product) {
    final Map<String, String> prices = {
      'kamar_tidur': 'Rp 5.000.000',
      'meja_makan': 'Rp 3.500.000',
      'meja_tamu': 'Rp 2.000.000',
      'ruang_tamu': 'Rp 4.500.000',
    };
    return prices[product] ?? 'Rp 1.000.000';
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Halaman Keranjang'));
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Halaman Favorit'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Halaman Profil'));
  }
}

class FurnitureCard extends StatelessWidget {
  final String imageType;
  final double rating;
  final String description;
  final VoidCallback onTap;

  const FurnitureCard({super.key, required this.imageType, required this.rating, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> imagePaths = {
      'kamar_tidur': 'assets/images/kamar_tidur.jpg',
      'meja_makan': 'assets/images/meja_makan.jpg',
      'meja_tamu': 'assets/images/meja_tamu.jpg',
      'ruang_tamu': 'assets/images/ruang_tamu.jpg',
    };

    final Map<String, String> titles = {
      'kamar_tidur': 'Kamar Tidur Modern',
      'meja_makan': 'Meja Makan Elegan',
      'meja_tamu': 'Meja Tamu Minimalis',
      'ruang_tamu': 'Sofa Ruang Tamu',
    };

    final Map<String, String> prices = {
      'kamar_tidur': 'Rp 5.000.000',
      'meja_makan': 'Rp 3.500.000',
      'meja_tamu': 'Rp 2.000.000',
      'ruang_tamu': 'Rp 4.500.000',
    };

    String imagePath = imagePaths[imageType] ?? 'assets/images/default.jpg';
    String title = titles[imageType] ?? 'Furniture Modern';
    String price = prices[imageType] ?? 'Rp 1.000.000';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const Spacer(),
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(rating.toString(), style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final String imageType;
  final String title;
  final String price;
  final double rating;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.imageType,
    required this.title,
    required this.price,
    required this.rating,
    required this.description,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  Color selectedColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    String productImage = 'assets/images/${widget.imageType}.jpg';
    String productTitle = widget.title;
    String productPrice = widget.price;
    String productDescription = widget.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(productImage, width: double.infinity, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productTitle,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < widget.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 18,
                            );
                          }),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.rating.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          productPrice,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                        ),
                        const SizedBox(height: 10),
                        const Text('Choose a color:'),
                        Row(
                          children: [
                            _colorOption(Colors.grey),
                            _colorOption(Colors.yellow),
                            _colorOption(Colors.brown),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text('Select Quantity:'),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                            IconButton(
                              onPressed: () => setState(() => quantity++),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          productDescription,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {},
                child: const Text('ADD TO CART', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.deepPurple : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}