import 'package:flutter/material.dart';
import 'package:shopapp/models/grocery_item.dart';
import 'package:shopapp/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItemsLocal = [];

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No item added yet.'),
    );
    if (_groceryItemsLocal.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Your Grocery'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push<GroceryItem>(MaterialPageRoute(
                            builder: (ctx) => const NewItem()))
                        .then((GroceryItem? val) {
                      if (val == null) {
                        return;
                      }
                      setState(() {
                        _groceryItemsLocal.add(val);
                      });
                      ;
                    });
                  },
                  icon: const Icon(Icons.add))
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
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push<GroceryItem>(
                          MaterialPageRoute(builder: (ctx) => const NewItem()))
                      .then((GroceryItem? val) {
                    if (val == null) {
                      return;
                    }
                    setState(() {
                      _groceryItemsLocal.add(val);
                    });
                    ;
                  });
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
