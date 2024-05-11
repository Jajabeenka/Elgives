import 'package:flutter/material.dart';
import '../models/organization.dart';
import '../pages/donatePage.dart';
import '../models/donation.dart';
import '../slambook_widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../provider/orgs_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrgsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationsListStream = context.watch<OrganizationProvider>().organization;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Organizations',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 168, 202, 235)),
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 168, 202, 235)),
      ),
      drawer: DrawerWidget(),
      body: StreamBuilder(
        stream: donationsListStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.group, size: 80, color: Colors.blue),
                  SizedBox(height: 20),
                  Text(
                    'NO ORGANIZATIONS YET!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 12, 49),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('GO BACK TO SIGN IN'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              Organization org = Organization.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              var id = snapshot.data?.docs[index].id;
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text(
                    org.name,
                    style: TextStyle(color: Color.fromARGB(255, 8, 37, 66)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormSample(),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
