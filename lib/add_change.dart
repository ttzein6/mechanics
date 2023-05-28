import 'package:flutter/material.dart';
import 'package:mechanics/database.dart';
import 'package:mechanics/models/customer.dart';
import 'package:mechanics/models/part.dart';

class AddPartChangePage extends StatefulWidget {
  @override
  _AddPartChangePageState createState() => _AddPartChangePageState();
}

class _AddPartChangePageState extends State<AddPartChangePage> {
  final _formKey = GlobalKey<FormState>();

  Customer? _selectedCustomer;
  PartChange? _selectedPartChanges;

  void _addPartChange() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCustomer == null) {
        // No customer is selected, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a customer')),
        );
        return;
      }

      if (_selectedPartChanges == null) {
        // No part changes are selected, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a part change')),
        );
        return;
      }

      await Database()
          .addCustomerPartChange(_selectedCustomer!, _selectedPartChanges!)
          .then((value) {
        // Reset the form fields and selected values
        _formKey.currentState!.reset();
        _selectedCustomer = null;
        _selectedPartChanges = null;

        // Show a success message or navigate back to the previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Part changes added successfully!')),
        );
      });
    }
  }

  void _showCustomerSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<Customer>?>(
            future: Database().getCustomers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("error loading data ..."),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Customer> customerList = snapshot.data ?? [];
              return Container(
                height: 200,
                child: ListView.builder(
                  itemCount: customerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final customer = customerList[index];
                    return ListTile(
                      title: Text(customer.name),
                      onTap: () {
                        setState(() {
                          _selectedCustomer = customer;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            });
      },
    );
  }

  void _showPartChangeSelection() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<List<PartChange>?>(
            future: Database().getParts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("error loading data ..."),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<PartChange> partChangeList = snapshot.data ?? [];
              return Container(
                height: 200,
                child: ListView.builder(
                  itemCount: partChangeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final partChange = partChangeList[index];
                    return ListTile(
                      title: Text(partChange.partName),
                      onTap: () {
                        setState(() {
                          _selectedPartChanges = partChange;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Part Change'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Selected Customer:'),
                subtitle: _selectedCustomer != null
                    ? Text(_selectedCustomer!.name)
                    : null,
                onTap: _showCustomerSelection,
              ),
              ListTile(
                title: const Text('Selected Part Changes:'),
                subtitle: _selectedPartChanges != null
                    ? Text(_selectedPartChanges?.partName ?? "")
                    : null,
                onTap: _showPartChangeSelection,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _addPartChange,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
