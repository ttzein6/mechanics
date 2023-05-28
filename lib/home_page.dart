import 'package:flutter/material.dart';
import 'package:mechanics/add_change.dart';
import 'package:mechanics/add_customer.dart';
import 'package:mechanics/add_part.dart';
import 'package:mechanics/customer_details.dart';
import 'package:mechanics/database.dart';
import 'package:mechanics/models/customer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Customer>?> _customerListFuture;
  List<Customer> displayedCustomerList = [];

  @override
  void initState() {
    super.initState();
    _customerListFuture = Database().getCustomers();
  }

  void filterCustomers(String keyword, list) {
    List<Customer> listToShow = list.where((customer) {
      final name = customer.name.toLowerCase();
      final carModel = customer.carModel.toLowerCase();
      return name.contains(keyword.toLowerCase()) ||
          carModel.contains(keyword.toLowerCase());
    }).toList();
    if (listToShow.isEmpty) {
      listToShow = list;
    }
    setState(() {
      displayedCustomerList = listToShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanics Store'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add Customer functionality
                      // Navigate to the Add Customer screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCustomerPage(),
                        ),
                      );
                    },
                    child: Text('Add Customer'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add Parts functionality
                      // Navigate to the Add Parts screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPartPage(),
                        ),
                      );
                    },
                    child: Text('Add Parts'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add Part Change functionality
                      // Navigate to the Add Part Change screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPartChangePage()),
                      );
                    },
                    child: Text('Add Part Change'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder<List<Customer>?>(
                future: _customerListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  var list = snapshot.data ?? [];
                  if (displayedCustomerList.isEmpty) {
                    displayedCustomerList = list;
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          onChanged: (value) {
                            filterCustomers(value, list);
                          },
                          decoration: InputDecoration(
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: displayedCustomerList.length,
                          itemBuilder: (context, index) {
                            final customer = displayedCustomerList[index];
                            return ListTile(
                              title: Text(customer.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Car Model: ${customer.carModel}'),
                                  Text(
                                      'Last Visited: ${customer.lastVisitedDate.toDate()}'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomerDetailsScreen(
                                        customer: customer),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
