import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../models/scanModel.dart';
import '../services/api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<ScanModel> scanmodel_list;

  Future<List<ScanModel>> fetchScanResults() async {
    var result = await _api.getDataCollection();
    scanmodel_list = result.documents
        .map((doc) => ScanModel.fromMap(doc.data, doc.documentID))
        .toList();
    return scanmodel_list;
  }

  Stream<QuerySnapshot> fetchScanResultAsStream() {
    return _api.streamDataCollection();
  }

  Future<ScanModel> getScanResultById(String id) async {
    var doc = await _api.getDocumentById(id);
    return ScanModel.fromMap(doc.data, doc.documentID);
  }

  Future removeScanResult(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future addScanResult(ScanModel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
