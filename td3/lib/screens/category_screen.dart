import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/top_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'product_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  int _currentIndex = 1; // Categorías

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  Future<void> _loadProducts() async {
    final products = await _productService.fetchProducts();
    setState(() {
      _allProducts = products;
      _filteredProducts = products;
    });
  }

  void _onSearchChanged(String query) {
    query = query.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) =>
        product.name.toLowerCase().contains(query) ||
        product.description.toLowerCase().contains(query)
      ).toList();
    });
  }


  void _filterByCategory(String keyword) {
    keyword = keyword.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) =>
        product.name.toLowerCase().contains(keyword) ||
        product.description.toLowerCase().contains(keyword)
      ).toList();
    });
  }

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/cart');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        searchController: _searchController,
        onSearchChanged: _onSearchChanged,
      ),
      body: Column(
        children: [
          // Filtros de categoría
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => _filterByCategory('ropa'),
                  child: Text('Ropa'),
                ),
                ElevatedButton(
                  onPressed: () => _filterByCategory('electrónica'),
                  child: Text('Electrónica'),
                ),
                ElevatedButton(
                  onPressed: () => _filterByCategory('videojuegos'),
                  child: Text('Videojuegos'),
                ),
              ],
            ),
          ),

          // Lista de productos
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(child: Text('No hay productos disponibles.'))
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported),
                          ),
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
