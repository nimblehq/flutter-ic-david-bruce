import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_option_ui_model.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

import 'input_decoration.dart';

class TextFieldFormView extends StatefulWidget {
  final List<SurveyAnswerOptionUIModel> uiModels;
  final Function(Map<String, String>) onChange;

  const TextFieldFormView({
    super.key,
    required this.uiModels,
    required this.onChange,
  });

  @override
  State<TextFieldFormView> createState() => _TextFieldFormViewState();
}

class _TextFieldFormViewState extends State<TextFieldFormView> {
  List<TextEditingController> _controllers = [];
  final Map<String, String> answers = <String, String>{};

  @override
  void initState() {
    super.initState();
    _buildControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  void _buildControllers() {
    _controllers = List<TextEditingController>.generate(
      widget.uiModels.length,
      (index) => TextEditingController(),
    );

    int index = 0;
    for (final uiModel in widget.uiModels) {
      final controller = _controllers[index];
      index++;
      controller.addListener(
        () {
          answers[uiModel.id] = controller.text;
          widget.onChange(answers);
        },
      );
    }
  }

  Widget _buildForm() {
    int index = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: ListView(
        children: widget.uiModels.map(
          (uiModel) {
            final controller = _controllers[index];
            index++;
            answers[uiModel.id] = '';
            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSmallest),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: inputDecoration(hintText: uiModel.title),
                controller: controller,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
