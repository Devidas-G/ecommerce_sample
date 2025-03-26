import 'package:ecommerce_kdigitalcurry/utils/cart_provider.dart';
import 'package:ecommerce_kdigitalcurry/utils/product_provider.dart';
import 'package:ecommerce_kdigitalcurry/widgets/cart_items.dart';
import 'package:ecommerce_kdigitalcurry/widgets/similar_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/auth_provider.dart';
import '../utils/models/cart.dart';
import '../utils/models/product.dart';
import '../widgets/widgets.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Back")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "YOUR CART",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  CartItems(user: authProvider.user!),
                  SizedBox(height: 16),
                  _buildPromoCodeSection(),
                  SizedBox(height: 16),
                  _buildOrderSummary(),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "PROCEED TO SHIPPING",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            SimilarProducts(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Have a promocode"),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: "Enter Coupon Code",
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text("APPLY", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Applicable Coupons",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildCouponOption(
              "SHIRT20",
              "Get 20% off on your favorite shirt!",
            ),
            _buildCouponOption("BUYSHIRTS10", "Save \$10 on shirt purchase"),
            _buildCouponOption("CLASSYSHIRTS25", "25% off on premium shirts"),
            _buildCouponOption("SHIRTFEST15", "Enjoy 15% off this season"),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponOption(String code, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(code, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description),
            ],
          ),
          Radio(value: code, groupValue: null, onChanged: (value) {}),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Total Summary",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildSummaryRow("Total", "MRP \$1100"),
            _buildSummaryRow("Discount", "-\$213"),
            _buildSummaryRow("Coupon Code", "-\$220"),
            _buildSummaryRow("Delivery Fee", "\$0"),
            Divider(),
            _buildSummaryRow("Order Total", "\$667", isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
