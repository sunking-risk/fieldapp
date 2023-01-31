import 'dart:convert';
import 'dart:core';
import 'package:FieldApp/customer_profile.dart';
import 'package:FieldApp/pending_calls.dart';
import 'package:FieldApp/utils/themes/theme.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:http/http.dart' as http;

import 'complete_calls.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);
  @override
  CustomerState createState() => CustomerState();
}

class CustomerState extends State<Customer> {

  bool isDescending = false;
  void _statusFilter(String _status) {
    List<Map<String, dynamic>> results = [];
    switch (_status) {
      case "Complete":
        {
          results = _allUsers
              .where((user) =>
                  user["status"].toLowerCase().contains(_status.toLowerCase()))
              .toList();
        }
        break;

      case "Pending":
        {
          results = _allUsers
              .where((user) =>
                  user["status"].toLowerCase().contains(_status.toLowerCase()))
              .toList();
        }
        break;

      case "Over due":
        {
          results = _allUsers
              .where((user) =>
                  user["status"].toLowerCase().contains(_status.toLowerCase()))
              .toList();
        }
        break;
      case "All":
        {
          results = _allUsers;
        }
        break;
      default: {
        results = _allUsers;
      }
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  final List<Map<String, dynamic>> _allUsers = [
    {
      "id": 1,
      "name": "Collection Score",
      "request": "New Request",
      "status": "Complete"
    },
    {
      "id": 2,
      "name": "Team Management",
      "request": "pending Approval",
      "status": "Complete"
    },
    {
      "id": 3,
      "name": "Customer Management",
      "request": "New Request",
      "status": "Over due"
    },
    {
      "id": 4,
      "name": "Pilot Management",
      "request": "Rejected",
      "status": "Complete"
    },
    {
      "id": 5,
      "name": "Process Management",
      "request": "New Request",
      "status": "Pending"
    },
    {
      "id": 6,
      "name": "Customer Management",
      "request": "Pending",
      "status": "Pending"
    },
    {
      "id": 7,
      "name": "Process Management",
      "request": "Rejected",
      "status": "Pending"
    },
    {
      "id": 8,
      "name": "Collection Score",
      "request": "Rejected",
      "status": "Over due"
    },
    {
      "id": 9,
      "name": "Team Management",
      "request": "Pending Approval",
      "status": "Over due"
    },
    {
      "id": 10,
      "name": "Pilot Management",
      "request": "Rejected ",
      "status": "New Request"
    },
  ];
  List<Map<String, dynamic>> _foundUsers = [];
  void _searchFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }


  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          KpiTittle(
            kpicolor: AppColor.mycolor,
            label: 'Calls Summary',
            txtcolor: Colors.black87,
          ),
          Row(
            children: [
              RowData(
                value: '70',
                label: 'Call Made',
              ),
              RowData(
                value: '30',
                label: 'Calls Pending',
              ),
              RowData(
                value: '70%',
                label: 'Complete rate',
              ),
              RowData(
                value: '40%',
                label: 'Success Calls',
              )
            ],
          ),
          KpiTittle(
            kpicolor: AppColor.mycolor,
            label: 'Visit Summary',
            txtcolor: Colors.black87,
          ),
          Row(
            children: [
              RowData(
                value: '20',
                label: 'Visit Made',
              ),
              RowData(
                value: '40',
                label: 'Visit Pending',
              ),
              RowData(
                value: '35%',
                label: 'Complete rate',
              ),
              RowData(
                value: '20%',
                label: 'Success Visit',
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            constraints: BoxConstraints.expand(height: 40),
            child: TabBar(tabs: [
              Tab(text: "Pending",),
              Tab(text: "Completed"),
            ]),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15),
              child: TabBarView(
                children: [
                  PendingCalls(),
                  CompleteCalls()
                ],
              ),

            ),
          )
        ],
      ),
    );
  }
}

class KpiTittle extends StatelessWidget {
  final Color kpicolor;
  final String label;
  final Color txtcolor;
  const KpiTittle(
      {Key? key,
      required this.kpicolor,
      required this.txtcolor,
      required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.amber,
      color: kpicolor,
      child: ListTile(
        title: Center(
            child:
                Text(label, style: TextStyle(fontSize: 20, color: txtcolor))),
        dense: true,
      ),
    );
  }
}

class RowData extends StatelessWidget {
  final value;
  final String label;

  const RowData({Key? key, required this.value, required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 3,
          child: Container(
            height: 50,
            width: 50,
            child: Column(
              children: [
                Text(value,
                    style: TextStyle(
                      fontSize: 30,
                    )),
                Text(label, style: TextStyle(fontSize: 9))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
