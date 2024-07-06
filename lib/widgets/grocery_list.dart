import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shopapp/data/categories.dart';
import 'package:shopapp/models/category.dart';
import 'package:shopapp/models/grocery_item.dart';
import 'package:shopapp/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItemsLocal = [];
  bool _isLoading = true;
  void _loadData() async {
    final Uri url = Uri.https(
        'shopapp-9d15c-default-rtdb.firebaseio.com', 'shopping-list.json');
    final res = await http.get(url);

    if (res.body.isEmpty) {
      return;
    }

    final Map<String, dynamic> loadedData = json.decode(res.body);
    final List<GroceryItem> loadedItems = [];

    for (var item in loadedData.entries) {
      try {
        final Category category = categories.entries
            .firstWhere((e) => e.value.title == item.value['category'])
            .value;

        loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ));
      } catch (e) {
        log('Category not found for item: ${item.value['name']}');
      }
    }

    setState(() {
      _groceryItemsLocal = loadedItems;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No item added yet.'),
    );
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_groceryItemsLocal.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Your Grocery'),
            actions: [
              IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
            ],
          ),
          body: ListView.builder(
              itemCount: _groceryItemsLocal.length,
              itemBuilder: (ctx, index) => Dismissible(
                    key: ValueKey(_groceryItemsLocal[index].id),
                    onDismissed: (_) {
                      setState(() {
                        _groceryItemsLocal.remove(_groceryItemsLocal[index]);
                      });
                    },
                    child: ListTile(
                      title: Text(_groceryItemsLocal[index].name),
                      leading: Container(
                        height: 24,
                        width: 24,
                        color: _groceryItemsLocal[index].category.color,
                      ),
                      trailing:
                          Text(_groceryItemsLocal[index].quantity.toString()),
                    ),
                  )));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Grocery'),
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }

  _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItemsLocal.add(newItem);
      _isLoading = false;
    });
  }
}
