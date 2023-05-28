import 'package:flutter/material.dart';
import 'package:mechanics/models/customer.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final Customer customer;

  CustomerDetailsScreen({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${customer.name}'),
            Text('Car Model: ${customer.carModel}'),
            Text('Plate Number: ${customer.plateNumber}'),
            Text('Last Visited: ${customer.lastVisitedDate.toDate()}'),
            const SizedBox(height: 20.0),
            const Text(
              'Part Changes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: customer.partChanges.length,
              itemBuilder: (context, index) {
                final partChange = customer.partChanges[index];
                return ListTile(
                  title: Text(partChange.partName),
                  subtitle: Text('Cost: ${partChange.cost.toStringAsFixed(2)}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
