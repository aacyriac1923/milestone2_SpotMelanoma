import 'package:spotmelanoma/core/services/imageclassifier.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class ClassifierQuant extends ImageClassifier {
  ClassifierQuant({int numThreads: 1}) : super(numThreads: numThreads);

  @override
  //changed path
  String get modelName => 'model_melanoma.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}
