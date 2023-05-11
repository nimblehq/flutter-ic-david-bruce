import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/multiple_choice_option_ui_model.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class MultipleChoiceView extends StatefulWidget {
  final List<MultipleChoiceOptionUIModel> uiModels;
  final Function(List<String>) onSelect;

  const MultipleChoiceView({
    super.key,
    required this.uiModels,
    required this.onSelect,
  });

  @override
  State<MultipleChoiceView> createState() => _MultipleChoiceViewState();
}

class _MultipleChoiceViewState extends State<MultipleChoiceView> {
  List<int> selectedIndexes = [];

  Widget get _listView => ListView.separated(
        itemCount: widget.uiModels.length,
        itemBuilder: (_, index) => _itemBuilder(
          uiModels: widget.uiModels,
          index: index,
          selectedIndexes: selectedIndexes,
        ),
        separatorBuilder: (_, index) => _separatorBuilder(
          count: widget.uiModels.length,
          index: index,
        ),
      );

  Widget _itemBuilder({
    required List<MultipleChoiceOptionUIModel> uiModels,
    required int index,
    required List<int> selectedIndexes,
  }) {
    final uiModel = MultipleChoiceOptionUIModel(
      id: uiModels[index].id,
      title: uiModels[index].title,
      isSelected: selectedIndexes.contains(index),
    );
    return GestureDetector(
      onTap: () => _onTap(index),
      child: _listItem(uiModel),
    );
  }

  Widget _listItem(MultipleChoiceOptionUIModel uiModel) => SizedBox(
        width: context.screenSize.width - 160.0,
        height: Dimensions.multipleChoiceItemHeight,
        child: Row(
          children: [
            Expanded(
              child: Text(
                style: uiModel.isSelected
                    ? Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white70),
                maxLines: 1,
                uiModel.title,
              ),
            ),
            Container(
              width: Dimensions.multipleSelectionBoxHeight,
              height: Dimensions.multipleSelectionBoxHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: uiModel.isSelected
                  ? Container(
                      width: Dimensions.multipleSelectionBoxHeight,
                      height: Dimensions.multipleSelectionBoxHeight,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const FittedBox(
                        child: Icon(
                          Icons.check,
                          size: 25.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      );

  Widget _separatorBuilder({
    required int count,
    required int index,
  }) {
    if (index == count - 1) {
      return Container();
    }
    return _separator;
  }

  Widget get _separator => const Divider(
        color: Colors.white70,
        height: 0.5,
        thickness: 0.5,
        indent: Dimensions.separatorHeight,
        endIndent: Dimensions.separatorHeight,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: _listView,
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.removeWhere(((element) => element == index));
      } else {
        selectedIndexes.add(index);
        selectedIndexes.sort();
      }
    });
    var selectedIds =
        selectedIndexes.map((index) => widget.uiModels[index].id).toList();
    widget.onSelect(selectedIds);
  }
}
