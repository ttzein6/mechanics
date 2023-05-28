import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanics/database.dart';
import 'package:mechanics/models/customer.dart';
import 'package:mechanics/models/part.dart';

class AddCustomerPage extends StatefulWidget {
  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _plateNumber = '';
  String _carModel = '';
  DateTime _selectedDate = DateTime.now();
  List<PartChange> _partsChanges = [];

  void _addCustomer() async {
    if (_formKey.currentState!.validate()) {
      // Create a new customer object with the entered data
      Customer newCustomer = Customer(
        name: _name,
        plateNumber: _plateNumber,
        carModel: _carModel,
        lastVisitedDate: Timestamp.fromDate(_selectedDate),
        partChanges: [],
      );

      // Send the new customer data to the backend or perform any desired actions
      await Database().addCustomer(newCustomer).then((value) {
        // Reset the form fields
        _formKey.currentState!.reset();

        // Show a success message or navigate back to the home page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Customer added successfully!')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Plate Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a plate number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _plateNumber = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Car Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a car model';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _carModel = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text('Last Visited: '),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      });
                    },
                    child: Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _addCustomer,
                child: Text('Add Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
