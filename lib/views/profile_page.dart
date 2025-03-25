import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../features/auth/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'K&D DigitalCurry',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Image
            const CircleAvatar(radius: 50, child: Icon(Icons.person)),
            const SizedBox(height: 10),
            // User Name
            Text(
              user != null ? user.fullName : 'Loading...',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Edit Profile Button
            TextButton.icon(
              onPressed: () {
                // Navigate to Edit Profile page
              },
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Edit Profile'),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
            ),
            ListTile(title: Text("My Orders"), leading: Icon(Icons.receipt)),
            Divider(height: 0),
            ListTile(title: Text("My Wishlist"), leading: Icon(Icons.list)),
            Divider(height: 0),
            ListTile(title: Text("My Address"), leading: Icon(Icons.pin_drop)),
            Divider(height: 0),
            ListTile(
              title: Text("Contact us"),
              leading: Icon(Icons.headphones),
            ),
            Divider(height: 0),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () async {
                await authProvider.logout().then(Navigator.of(context).pop);
              },
            ),
            Divider(height: 0),
            SizedBox(height: 50),
            Footer(),
          ],
        ),
      ),
    );
  }
}
