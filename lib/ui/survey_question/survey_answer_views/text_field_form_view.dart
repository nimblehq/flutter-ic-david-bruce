import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

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
    return ListView(
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
              decoration: _inputDecoration(
                hintText: uiModel.title,
              ),
              controller: controller,
            ),
          );
        },
      ).toList(),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
  }) {
    return InputDecoration(
      labelText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0),
      ),
      fillColor: Colors.white24,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSemi,
        horizontal: Dimensions.paddingSmall,
      ),
    );
  }
}
