import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_option_ui_model.dart';

import 'input_decoration.dart';

const _maxLines = 6;

class TextAreaFormView extends StatefulWidget {
  final SurveyAnswerOptionUIModel uiModel;
  final Function(Map<String, String>) onChange;

  const TextAreaFormView({
    super.key,
    required this.uiModel,
    required this.onChange,
  });

  @override
  State<TextAreaFormView> createState() => _TextAreaFormViewState();
}

class _TextAreaFormViewState extends State<TextAreaFormView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: _maxLines,
        decoration: inputDecoration(
          hintText: widget.uiModel.title.isEmpty
              ? widget.uiModel.shortText
              : widget.uiModel.title,
        ),
        controller: _controller,
      ),
    );
  }
}
