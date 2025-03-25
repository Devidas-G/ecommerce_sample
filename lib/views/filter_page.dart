import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedCategory = "Price";
  Map<String, bool> filters = {
    "Below \$500": false,
    "Above \$500": false,
    "Above \$1000": false,
  };

  final List<String> categories = [
    "Price",
    "Category",
    "Brands",
    "Colors",
    "Size & Fit",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Filter"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Sidebar Menu
                Container(
                  width: 120,
                  color: Colors.grey.shade200,
                  child: ListView(
                    children:
                        categories.map((category) {
                          return GestureDetector(
                            onTap:
                                () =>
                                    setState(() => selectedCategory = category),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              color:
                                  selectedCategory == category
                                      ? Colors.red
                                      : Colors.transparent,
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      selectedCategory == category
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                // Filter Options
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        selectedCategory != "Price"
                            ? Center(child: Text("UX Not Provided"))
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  filters.keys.map((filter) {
                                    return CheckboxListTile(
                                      title: Text(filter),
                                      value: filters[filter],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          filters[filter] = value ?? false;
                                        });
                                      },
                                    );
                                  }).toList(),
                            ),
                  ),
                ),
              ],
            ),
          ),

          // Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        for (var key in filters.keys) {
                          filters[key] = false;
                        }
                      });
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      // Apply filter logic
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('FakeStoreApi does not support filter'),
                        ),
                      );
                    },
                    child: const Text(
                      "Apply Filter",
                      style: TextStyle(color: Colors.white),
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
