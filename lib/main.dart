import 'package:flutter/material.dart';

void main() {
  runApp(const FoodMenuApp());
}

// ─────────────────────────────────────────────
//  APP ROOT
// ─────────────────────────────────────────────
class FoodMenuApp extends StatelessWidget {
  const FoodMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makanan Nusantara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4611A),
          primary: const Color(0xFFD4611A),
          secondary: const Color(0xFF2D5016),
          surface: const Color(0xFFFFF8F0),
          background: const Color(0xFFFFF8F0),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────
class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int calories;
  final List<String> ingredients;
  bool isFavorite;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.calories,
    required this.ingredients,
    this.isFavorite = false,
  });
}

// ─────────────────────────────────────────────
//  STATIC DATA
// ─────────────────────────────────────────────
final List<MenuItem> allMenuItems = [
  MenuItem(
    id: '1',
    name: 'Nasi Goreng Spesial',
    description:
        'Nasi goreng wangi dengan bumbu rahasia turun-temurun, dilengkapi telur mata sapi, ayam suwir, udang, dan kerupuk renyah.',
    price: 25000,
    imageUrl:
        'assets/images/nasi_goreng.jpg',
    category: 'Makanan Utama',
    rating: 4.8,
    calories: 520,
    ingredients: ['Nasi', 'Telur', 'Ayam', 'Udang', 'Kecap', 'Bawang Merah', 'Cabai'],
  ),
  MenuItem(
    id: '2',
    name: 'Mie Ayam',
    description:
        'Mie kuning lembut dengan topping ayam cincang berbumbu, bakso kenyal, pangsit goreng, dan kuah kaldu ayam gurih.',
    price: 20000,
    imageUrl:
        'assets/images/mie_ayam.jpg',
    category: 'Makanan Utama',
    rating: 4.6,
    calories: 450,
    ingredients: ['Mie', 'Ayam', 'Bakso', 'Pangsit', 'Kecap', 'Bawang Goreng'],
  ),
  MenuItem(
    id: '3',
    name: 'Soto Ayam',
    description:
        'Kuah bening kunyit khas Jawa dengan suwiran ayam kampung, tauge, soun, telur rebus, dan taburan daun bawang segar.',
    price: 22000,
    imageUrl:
        'assets/images/soto_ayam.jpg',
    category: 'Makanan Utama',
    rating: 4.7,
    calories: 380,
    ingredients: ['Ayam', 'Kunyit', 'Jahe', 'Serai', 'Tauge', 'Soun', 'Telur'],
  ),
  MenuItem(
    id: '4',
    name: 'Gado-Gado',
    description:
        'Sayuran segar rebus dengan saus kacang legit berbumbu petis, dilengkapi tahu, tempe, telur, dan kerupuk udang.',
    price: 18000,
    imageUrl:
        'assets/images/gado_gado.jpg',
    category: 'Makanan Utama',
    rating: 4.5,
    calories: 340,
    ingredients: ['Kangkung', 'Kacang Panjang', 'Tahu', 'Tempe', 'Kacang Tanah', 'Petis'],
  ),
  MenuItem(
    id: '5',
    name: 'Es Teh Manis',
    description:
        'Teh melati segar diseduh panas lalu didinginkan dengan es batu, manis pas dan menyegarkan di cuaca panas.',
    price: 5000,
    imageUrl:
        'assets/images/es_teh.jpg',
    category: 'Minuman',
    rating: 4.4,
    calories: 80,
    ingredients: ['Teh Melati', 'Gula', 'Es Batu'],
  ),
  MenuItem(
    id: '6',
    name: 'Es Jeruk Segar',
    description:
        'Perasan jeruk nipis segar dicampur sirup gula, es batu melimpah, dan sedikit garam untuk rasa yang sempurna.',
    price: 7000,
    imageUrl:
        'assets/images/es_jeruk.jpg',
    category: 'Minuman',
    rating: 4.6,
    calories: 60,
    ingredients: ['Jeruk Nipis', 'Gula', 'Es Batu', 'Air Mineral'],
  ),
  MenuItem(
    id: '7',
    name: 'Pisang Goreng Keju',
    description:
        'Pisang raja matang digoreng crispy dengan adonan tepung renyah, ditaburi keju parut leleh dan susu kental manis.',
    price: 12000,
    imageUrl:
        'assets/images/pisang_keju.jpg',
    category: 'Camilan',
    rating: 4.7,
    calories: 290,
    ingredients: ['Pisang Raja', 'Tepung', 'Keju', 'Susu Kental Manis', 'Minyak'],
  ),
  MenuItem(
    id: '8',
    name: 'Martabak Telur Mini',
    description:
        'Kulit martabak renyah tipis berisi campuran telur bebek, daging cincang berbumbu, daun bawang, dan bihun.',
    price: 15000,
    imageUrl:
        'assets/images/martabak_telur.jpg',
    category: 'Camilan',
    rating: 4.5,
    calories: 320,
    ingredients: ['Telur Bebek', 'Daging Cincang', 'Bihun', 'Bawang Merah', 'Kulit Martabak'],
  ),
];

const List<String> categories = ['Semua', 'Makanan Utama', 'Minuman', 'Camilan'];

// ─────────────────────────────────────────────
//  CART STATE (simple global state)
// ─────────────────────────────────────────────
class CartState extends ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get items => _items;

  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  double get totalPrice {
    double total = 0;
    _items.forEach((id, qty) {
      final item = allMenuItems.firstWhere((m) => m.id == id);
      total += item.price * qty;
    });
    return total;
  }

  void add(String id) {
    _items[id] = (_items[id] ?? 0) + 1;
    notifyListeners();
  }

  void remove(String id) {
    if (_items.containsKey(id)) {
      _items[id] = _items[id]! - 1;
      if (_items[id] == 0) _items.remove(id);
    }
    notifyListeners();
  }

  int quantity(String id) => _items[id] ?? 0;

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

final CartState cart = CartState();

// ─────────────────────────────────────────────
//  HOME PAGE
// ─────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String _selectedCategory = 'Semua';
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    cart.addListener(_onCartChange);
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    cart.removeListener(_onCartChange);
    _animController.dispose();
    super.dispose();
  }

  void _onCartChange() => setState(() {});

  List<MenuItem> get _filteredItems {
    if (_selectedCategory == 'Semua') return allMenuItems;
    return allMenuItems.where((m) => m.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFFD4611A),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFD4611A)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          const Color(0xFFD4611A).withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🍜 Warung Nusantara',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Cita rasa asli Indonesia',
                          style: TextStyle(color: Colors.white.withOpacity(0.88), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_rounded, color: Colors.white),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    ),
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // ── Student Identity Card ─────────────────
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: const StudentIdentityCard(),
            ),
          ),

          // ── Section Title ─────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Text(
                'Menu Kami',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),

          // ── Category Tabs ─────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final selected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedCategory = cat;
                      _animController.reset();
                      _animController.forward();
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFFD4611A) : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected ? const Color(0xFFD4611A) : Colors.grey.shade300,
                        ),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFD4611A).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.grey.shade700,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ── Menu Grid ────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _filteredItems[index];
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: MenuCard(
                      item: item,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailPage(item: item)),
                      ),
                      onAddToCart: () {
                        cart.add(item.id);
                        debugPrint('${item.name} ditambahkan ke keranjang');
                        debugPrint('Total item sekarang: ${cart.totalItems}');
                        debugPrint('Total harga: Rp ${cart.totalPrice}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} ditambahkan ke keranjang!'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: const Color(0xFF2D5016),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: _filteredItems.length,
              ),
            ),
          ),
        ],
      ),
      // ── Bottom Cart Bar ──────────────────────────
      bottomNavigationBar: cart.totalItems > 0
          ? BottomCartBar(
              onCheckout: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              ),
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────
//  STUDENT IDENTITY CARD
// ─────────────────────────────────────────────
class StudentIdentityCard extends StatelessWidget {
  const StudentIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D5016), Color(0xFF4A7A28)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D5016).withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Text(
                    '🎓 IDENTITAS MAHASISWA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: const Color.fromARGB(255, 53, 41, 41),
                  backgroundImage: const AssetImage(
                    'assets/images/me.jpg',
                  ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ahdatun Fatimah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'NIM: 240131002',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.25), height: 1),
            const SizedBox(height: 14),
            _InfoRow(icon: Icons.school_rounded, label: 'Program Studi', value: 'Teknologi Informasi'),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.business_rounded, label: 'Fakultas', value: 'Fakultas Teknik dan Sains'),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.calendar_today_rounded, label: 'Semester', value: '4 (genap)'),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.location_on_rounded, label: 'Universitas', value: 'Universitas Sapta Mandiri'),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  MENU CARD
// ─────────────────────────────────────────────
class MenuCard extends StatefulWidget {
  final MenuItem item;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const MenuCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        widget.item.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFFFE0C4),
                          child: const Icon(Icons.restaurant, size: 40, color: Color(0xFFD4611A)),
                        ),
                      ),
                    ),
                    // Category badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.item.category,
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // Favorite button
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () => setState(() => widget.item.isFavorite = !widget.item.isFavorite),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                            ],
                          ),
                          child: Icon(
                            widget.item.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 14,
                            color: widget.item.isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Info
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF1A1A1A),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 13, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 3),
                          Text(
                            widget.item.rating.toString(),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF777777)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp ${_formatPrice(widget.item.price.toInt())}',
                            style: const TextStyle(
                              color: Color(0xFFD4611A),
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onAddToCart,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4611A),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.add, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DETAIL PAGE
// ─────────────────────────────────────────────
class DetailPage extends StatefulWidget {
  final MenuItem item;
  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _qty = 1;

  @override
  void initState() {
    super.initState();
    cart.addListener(_onCartChange);
    _qty = cart.quantity(widget.item.id) > 0 ? cart.quantity(widget.item.id) : 1;
  }

  @override
  void dispose() {
    cart.removeListener(_onCartChange);
    super.dispose();
  }

  void _onCartChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFFD4611A),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'menu-${widget.item.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: const Color(0xFFFFE0C4)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black45],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + fav
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => widget.item.isFavorite = !widget.item.isFavorite),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: widget.item.isFavorite
                                ? Colors.red.shade50
                                : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.item.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: widget.item.isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Stats row
                  Row(
                    children: [
                      _StatChip(icon: Icons.star_rounded, color: const Color(0xFFF59E0B), label: '${widget.item.rating}'),
                      const SizedBox(width: 10),
                      _StatChip(icon: Icons.local_fire_department_rounded, color: Colors.orange, label: '${widget.item.calories} kal'),
                      const SizedBox(width: 10),
                      _StatChip(
                        icon: Icons.category_rounded,
                        color: const Color(0xFF2D5016),
                        label: widget.item.category,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Price
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4611A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Text('Harga', style: TextStyle(color: Color(0xFF666666), fontSize: 14)),
                        const Spacer(),
                        Text(
                          'Rp ${_formatPrice(widget.item.price.toInt())}',
                          style: const TextStyle(
                            color: Color(0xFFD4611A),
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text('Deskripsi',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.description,
                    style: const TextStyle(color: Color(0xFF555555), fontSize: 14, height: 1.7),
                  ),

                  const SizedBox(height: 24),

                  // Ingredients
                  const Text('Bahan Utama',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.item.ingredients
                        .map((ing) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D5016).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFF2D5016).withOpacity(0.2)),
                              ),
                              child: Text(
                                '🌿 $ing',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2D5016),
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: Row(
          children: [
            // Qty control
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _QtyButton(icon: Icons.remove, onTap: () => setState(() { if (_qty > 1) _qty--; })),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$_qty', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  _QtyButton(icon: Icons.add, onTap: () => setState(() => _qty++)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < _qty; i++) cart.add(widget.item.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$_qty x ${widget.item.name} ditambahkan!'),
                      backgroundColor: const Color(0xFF2D5016),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4611A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('Tambah ke Keranjang', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _StatChip({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Icon(icon, size: 20, color: const Color(0xFFD4611A)),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CART PAGE
// ─────────────────────────────────────────────
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    cart.addListener(_onChange);
  }

  @override
  void dispose() {
    cart.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final cartItems = cart.items.entries.map((e) {
      final item = allMenuItems.firstWhere((m) => m.id == e.key);
      return MapEntry(item, e.value);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('Keranjang', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: const Color(0xFFD4611A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                cart.clear();
                setState(() {});
              },
              child: const Text('Hapus Semua', style: TextStyle(color: Colors.white70)),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🛒', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  const Text('Keranjang masih kosong', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF555555))),
                  const SizedBox(height: 8),
                  const Text('Yuk tambahkan menu favoritmu!', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4611A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Lihat Menu'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index].key;
                      final qty = cartItems[index].value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(width: 70, height: 70, color: const Color(0xFFFFE0C4)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                  const SizedBox(height: 4),
                                  Text('Rp ${_formatPrice(item.price.toInt())}',
                                      style: const TextStyle(color: Color(0xFFD4611A), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () { cart.remove(item.id); setState(() {}); },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.remove, size: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.w800)),
                                ),
                                GestureDetector(
                                  onTap: () { cart.add(item.id); setState(() {}); },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD4611A),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.add, size: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Summary
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pesanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Text(
                            'Rp ${_formatPrice(cart.totalPrice.toInt())}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFD4611A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('=== PESANAN BERHASIL ===');
                            cart.items.forEach((id, qty) {
                              final item = allMenuItems.firstWhere((m) => m.id == id);

                              debugPrint('${item.name} x$qty');
                            });

                            debugPrint('Total Bayar: Rp ${cart.totalPrice}');
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                title: const Text('🎉 Pesanan Berhasil!', style: TextStyle(fontWeight: FontWeight.w800)),
                                content: Text(
                                  'Total: Rp ${_formatPrice(cart.totalPrice.toInt())}\n\nTerima kasih telah memesan di Warung Nusantara!',
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      cart.clear();
                                      Navigator.popUntil(context, (r) => r.isFirst);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFD4611A),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    child: const Text('OK', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4611A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: Text(
                            'Pesan Sekarang (${cart.totalItems} item)',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// ─────────────────────────────────────────────
//  BOTTOM CART BAR
// ─────────────────────────────────────────────
class BottomCartBar extends StatelessWidget {
  final VoidCallback onCheckout;
  const BottomCartBar({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: ElevatedButton(
        onPressed: onCheckout,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A1A),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4611A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${cart.totalItems}',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Lihat Keranjang', style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Text(
              'Rp ${_formatPrice(cart.totalPrice.toInt())}',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────────
String _formatPrice(int price) {
  final str = price.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
    buffer.write(str[i]);
  }
  return buffer.toString();
}