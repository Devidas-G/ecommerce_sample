import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_kdigitalcurry/features/homepage/presentation/category_page.dart';
import 'package:ecommerce_kdigitalcurry/views/cart_page.dart';
import 'package:ecommerce_kdigitalcurry/views/product_details.dart';
import 'package:ecommerce_kdigitalcurry/views/profile_page.dart';
import 'package:ecommerce_kdigitalcurry/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/product_provider.dart';
import 'widgets/widgets.dart';
import '../../../utils/image_provider.dart' as im;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const Map<String, String> categories = {
    'Men': 'assets/images/men.png',
    'Women': 'assets/images/women.png',
    'Kids': 'assets/images/kids.png',
  };

  static const Map<String, String> category = {
    'Watches': 'assets/images/watch.png',
    'Shoes': 'assets/images/shoes.png',
    'Heels': 'assets/images/heels.png',
    'Beauty & Make Up': 'assets/images/makeup.png',
    'Bags & Bag Packs': 'assets/images/bag.png',
    'Jewellery': 'assets/images/jewellery.png',
    'Sunglasses': 'assets/images/sunglasses.png',
    'perfume': 'assets/images/perfume.png',
  };

  static const List<String> brandNames = [
    'MONT BLANC',
    'ULYSSE NARDIN',
    'BOGGI MILANO',
    'LONGCHAMP',
    'RAYMOND WEIL',
    'LANCEL',
  ];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final imageProvider = Provider.of<im.ImageProvider>(context);
    // Filter products for men's and women's clothing
    final mensClothing =
        productProvider.products
            .where((product) => product.category == "men's clothing")
            .toList();
    final womensClothing =
        productProvider.products
            .where((product) => product.category == "women's clothing")
            .toList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),

      drawer: Drawer(
        width: double.infinity,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Remove rounded corners
        ),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              title: const Text('Category'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => CartPage()));
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Men'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => CategoryPage(
                                CategoryName: "Men",
                                Categories: {
                                  'Clothing': [
                                    'T-Shirt',
                                    'Shirt',
                                    'Jeans',
                                    'Jacket',
                                  ],
                                  'Footwear': [
                                    'Sneakers',
                                    'Formal Shoes',
                                    'Sandals',
                                  ],
                                  'Accessories': [
                                    'Watches',
                                    'Bags',
                                    'Belts',
                                    'Luxury Watches',
                                  ],
                                },
                              ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Women'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to Women's category page
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Electronics'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to Electronics category page
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Jewelry'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to Jewelry category page
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body:
          productProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : productProvider.error != null
              ? Center(child: Text('Error: ${productProvider.error}'))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    imageProvider.images.isEmpty
                        ? Container(
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[300],
                          ),
                          child: const Center(
                            child: Text('No images available'),
                          ),
                        )
                        : CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            height: 200.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            autoPlayCurve: Curves.fastOutSlowIn,
                          ),
                          items:
                              imageProvider.images.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      // margin: const EdgeInsets.symmetric(
                                      //   horizontal: 5.0,
                                      // ),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(
                                        //   8.0,
                                        // ),
                                        image: DecorationImage(
                                          image: NetworkImage(image.url),
                                          fit: BoxFit.cover,
                                          onError:
                                              (exception, stackTrace) =>
                                                  const Icon(Icons.error),
                                        ),
                                      ),
                                      child:
                                          image.description != null
                                              ? Container(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(
                                                        0.7,
                                                      ),
                                                      Colors.transparent,
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    image.description!,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                              : null,
                                    );
                                  },
                                );
                              }).toList(),
                        ),

                    // Brands Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shop by Brands',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  brandNames.map((e) {
                                    return BuildBrandCard(e);
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Categories Section
                    const Text(
                      'Browse Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            categories.entries.map((e) {
                              return Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: AssetImage(e.value),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          e.key,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                      ),
                    ),

                    // Sale Banner (Placeholder)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/banner.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    // Shop by Category Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shop by Category',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children:
                                category.entries.map((e) {
                                  return BuildCategoryCard(
                                    e.key,
                                    e.value,
                                    context,
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Men's Cloth Collection
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Men\'s Cloth Collection',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  mensClothing
                                      .map(
                                        (product) => Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 320,
                                              child: ProductCard(
                                                imageUrl: product.image,
                                                name: product.title,
                                                description:
                                                    product.description,
                                                price: product.price,
                                                originalPrice:
                                                    product.price * 1.3,
                                                discountPercentage: 30,
                                                onFavoriteToggle: () {},
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              ProductDetails(
                                                                product:
                                                                    product,
                                                              ),
                                                    ),
                                                  );
                                                },
                                                isFavorited: false,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Women's Cloth Collection
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Women\'s Cloth Collection',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  womensClothing
                                      .map(
                                        (product) => Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 320,
                                              child: ProductCard(
                                                imageUrl: product.image,
                                                name: product.title,
                                                description:
                                                    product.description,
                                                price: product.price,
                                                originalPrice:
                                                    product.price * 1.3,
                                                discountPercentage: 30,
                                                onFavoriteToggle: () {},
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              ProductDetails(
                                                                product:
                                                                    product,
                                                              ),
                                                    ),
                                                  );
                                                },
                                                isFavorited: false,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // FAQs Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Frequently Asked Questions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          BuildFAQItem(
                            'How can I place an order?',
                            'Yes, you can try us for free for 30 days. If you want, we’ll provide you with a free, personalized 30-minute onboarding call to get you up and running as soon as possible.',
                          ),
                          BuildFAQItem(
                            'COD/Cash on Delivery available?',
                            'Yes, we offer COD on most products.',
                          ),
                          BuildFAQItem(
                            'What is your cancellation policy?',
                            'You can cancel your order within 24 hours of placing it.',
                          ),
                          BuildFAQItem(
                            'Do you offer international shipping?',
                            'Yes, we ship to many countries worldwide.',
                          ),
                        ],
                      ),
                    ),

                    // Footer
                    Footer(),
                  ],
                ),
              ),
    );
  }
}
