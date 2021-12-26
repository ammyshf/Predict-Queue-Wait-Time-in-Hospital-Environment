import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class PhysicianModel {
  loadModel(issue) async {
    var model = await Tflite.loadModel(
      model: 'assets/tflite/physician.tflite',
      isAsset: true,
    );
    final interpreter =
        await tfl.Interpreter.fromAsset('tflite/physician.tflite');
    var input = await issue;
    var output = List(1 * 1).reshape([1, 1]);
    interpreter.run(input, output);
    print(output);
    var testBoxBraces = output.asMap();
    print(testBoxBraces[0][0].round());
    int finalOutput = testBoxBraces[0][0].round();
    return finalOutput;
  }
}
