import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmelanoma/core/models/scanModel.dart';
import 'package:spotmelanoma/core/viewmodels/CRUDModel.dart';

class ScanDetails extends StatelessWidget {
  final ScanModel scanObj;

  ScanDetails({@required this.scanObj});

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Result Details'),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await scanProvider.removeScanResult(scanObj.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: scanObj.id,
            child: Image.asset(
              'assets/${scanObj.img}.jpg',
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            scanObj.result,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '${scanObj.percentage} \%',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}
