import 'package:spotmelanoma/core/services/imageclassifier.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class ClassifierMeta extends ImageClassifier {
  ClassifierMeta({int numThreads}) : super(numThreads: numThreads);

  @override
  String get modelName => 'model_melanoma.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}
