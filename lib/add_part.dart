import 'package:flutter/material.dart';
import 'package:mechanics/database.dart';
import 'package:mechanics/models/part.dart';

class AddPartPage extends StatefulWidget {
  @override
  _AddPartPageState createState() => _AddPartPageState();
}

class _AddPartPageState extends State<AddPartPage> {
  final _formKey = GlobalKey<FormState>();

  String _partName = '';
  double _partCost = 0.0;

  void _addPart() async {
    if (_formKey.currentState!.validate()) {
      // Perform any desired actions with the entered part data
      PartChange newPart = PartChange(partName: _partName, cost: _partCost);
      await Database().addPart(newPart).then((value) {
        // Reset the form fields
        _formKey.currentState!.reset();

        // Show a success message or navigate back to the home page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Part added successfully!')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Part'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Part Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a part name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _partName = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Part Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the part cost';
                  }

                  // Validate that the value is a valid number
                  final cost = double.tryParse(value);
                  if (cost == null) {
                    return 'Invalid part cost';
                  }

                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _partCost = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _addPart,
                child: Text('Add Part'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
