import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/model/enum/emoticon_type.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/survey_answer_component_id.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class EmoticonView extends StatefulWidget {
  final EmoticonType type;
  final Function(int) onSelect;

  const EmoticonView({
    super.key,
    required this.type,
    required this.onSelect,
  });

  @override
  State<EmoticonView> createState() => _EmoticonViewState();
}

class _EmoticonViewState extends State<EmoticonView> {
  int? selectedIndex;

  List<Widget> get _likertButtons {
    List<Widget> widgets = [];
    widget.type.icons.asMap().forEach((index, icon) {
      widgets.add(
        InkWell(
          key: AnswerComponentId.answer('$index'),
          child: Container(
            margin: const EdgeInsets.all(Dimensions.paddingSmallest),
            child: SizedBox(
              width: Dimensions.emoticonSize,
              height: Dimensions.emoticonSize,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  icon,
                  style: TextStyle(
                    color: _textColor(
                      selectedIndex: selectedIndex,
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ),
          onTap: () => _onSelect(index),
        ),
      );
    });
    return widgets;
  }

  Color _textColor({
    required int? selectedIndex,
    required int index,
  }) {
    if (selectedIndex == null) {
      return Colors.white54;
    } else if (widget.type.isSingleHighlight) {
      return selectedIndex == index ? Colors.white : Colors.white54;
    } else {
      return selectedIndex >= index ? Colors.white : Colors.white54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _likertButtons,
      ),
    );
  }

  void _onSelect(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onSelect(index);
  }
}
