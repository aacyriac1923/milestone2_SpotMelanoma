import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmelanoma/core/models/scanModel.dart';
import 'package:spotmelanoma/core/viewmodels/CRUDModel.dart';

class ImageCard extends StatelessWidget {
  final ScanModel scanDetails;

  ImageCard({@required this.scanDetails});

  @override
  Widget build(BuildContext context) {
    if (scanDetails != null) {
      return GestureDetector(
        onLongPress: () {
          showAlertDialog(context);
        },
        //---------------------Commented since development is pending
        // onTap: () {
        //   Navigator.push(context, MaterialPageRoute(
        //       builder: (_) => ScanDetails(scanObj: scanDetails)));
        // },
        //------------------------------------------------------------

        child: Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 5,
            child: Container(
              child: Column(
                children: <Widget>[
                  //-------------------Pending, since image view is expected here
                  Hero(
                    tag: scanDetails.id,
                    child: Text(
                      scanDetails.result,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.orangeAccent),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Chance of Melanoma: ${scanDetails.percentage}\%',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          scanDetails.scanDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
          child: Text(
        " No Scan history",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    var scanProvider = Provider.of<CRUDModel>(context);
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        Navigator.of(context).pop();
        await scanProvider.removeScanResult(scanDetails.id);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Do you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
