import 'package:flutter/material.dart';
import '../models/organization.dart';
import '../pages/donatePage.dart';
import '../models/donation.dart';
import '../slambook_widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../provider/orgs_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrgsPage extends StatelessWidget {
  // final List<String> organization;
  // final Function(Friend) addFriend;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationsListStream = context.watch<OrganizationProvider>().organization;
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 168, 202, 235))),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Icon(Icons.group),
                  Text(
                  'NO FRIENDS YET!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 12, 49),
                  ),
                ),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/'); 
                  },
                  child: Text('Go to Slambook'),
                ),
                ],
              )
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                Organization org = Organization.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);
                //gets the unique id
                var id = snapshot.data?.docs[index].id;
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(org.name, style: TextStyle(color: Color.fromARGB(255, 8, 37, 66)),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormSample(),
                      ),
                    );
                  },
                );
              },
            );
        }
      )    
    );
  }
}
