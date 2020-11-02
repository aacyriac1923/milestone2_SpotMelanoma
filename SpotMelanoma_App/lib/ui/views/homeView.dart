import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spotmelanoma/core/models/scanModel.dart';
import 'package:spotmelanoma/core/viewmodels/CRUDModel.dart';
import 'package:spotmelanoma/ui/widgets/imageCard.dart';
import 'package:provider/provider.dart';
import 'package:spotmelanoma/core/models/user.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ScanModel> scanobj;

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<CRUDModel>(context);
    var userId = Provider.of<User>(context).id;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
        onPressed: () {
          Navigator.pushNamed(context, '/imgselection');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home')),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        child: StreamBuilder(
            stream: scanProvider.fetchScanResultAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                scanobj = snapshot.data.documents
                    .where((DocumentSnapshot ele) =>
                        ele['userId'] == userId.toString())
                    .map((doc) => ScanModel.fromMap(doc.data, doc.documentID))
                    .toList();
                if (scanobj.length > 0) {
                  return ListView.builder(
                    itemCount: scanobj.length,
                    itemBuilder: (buildContext, index) =>
                        ImageCard(scanDetails: scanobj[index]),
                  );
                } else {
                  return Center(
                      child: Text(
                    " No Scan history",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0),
                  ));
                }
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
  }
}
