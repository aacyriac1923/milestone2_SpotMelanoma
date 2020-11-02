class ScanModel {
  String id;
  String userId;
  String scanDate;
  String img;
  String result;
  String percentage;

  ScanModel(
      {this.id,
      this.result,
      this.scanDate,
      this.percentage,
      this.userId,
      this.img});

  ScanModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        result = snapshot['result'] ?? '',
        scanDate = snapshot['scanDate'] ?? '',
        percentage = snapshot['percentage'] ?? '',
        userId = snapshot['userId'] ?? '',
        img = snapshot['img'] ?? '';

  toJson() {
    return {
      "userId": userId,
      "percentage": percentage,
      "scanDate": scanDate,
      "result": result,
      "img": img,
    };
  }
}
