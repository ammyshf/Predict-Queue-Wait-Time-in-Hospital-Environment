import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class MedicalModel {
  loadModel(position) async {
    var model = await Tflite.loadModel(
      model: 'assets/tflite/medical.tflite',
      isAsset: true,
    );
    final interpreter =
        await tfl.Interpreter.fromAsset('tflite/medical.tflite');
    var input = await [
      [position]
    ];
    var output = List(1 * 1).reshape([1, 1]);
    interpreter.run(input, output);
    print(output);
    var testBoxBraces = output.asMap();
    print(testBoxBraces[0][0].round());
    int finalOutput = testBoxBraces[0][0].round();
    return finalOutput;
  }
}
