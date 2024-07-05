import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopapp/data/categories.dart';
import 'package:shopapp/models/category.dart';
import 'package:shopapp/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  int _enteredQantity = 0;
  Category _selectedCategory = categories[Categories.fruit]!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('f'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (String? value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 chracters.';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    initialValue: '1',
                    onSaved: (newValue) {
                      _enteredQantity = int.tryParse(newValue!)!;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0) {
                        return 'Must be a valid, positive number.';
                      }
                      return null;
                    },
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: DropdownButtonFormField(
                          value: _selectedCategory,
                          items: [
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(category.value.title),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (Category? value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          }))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Rest')),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.of(context).pop(GroceryItem(
                              id: DateTime.now().toString(),
                              name: _enteredName,
                              quantity: _enteredQantity,
                              category: _selectedCategory));
                        }
                      },
                      child: const Text('Add Item'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
