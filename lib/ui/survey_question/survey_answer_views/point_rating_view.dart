import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';

import '../../../utils/dimension.dart';

class PointRatingView extends StatefulWidget {
  final Function(int) onSelect;

  const PointRatingView({
    super.key,
    required this.onSelect,
  });

  @override
  State<PointRatingView> createState() => _PointRatingViewState();
}

class _PointRatingViewState extends State<PointRatingView> {
  int? selectedPoint;
  int maxLength = 10;

  Widget _pointRatingDividerWidget(int point) {
    return point <= maxLength - 1
        ? const VerticalDivider(color: Colors.white, width: 1)
        : const SizedBox.shrink();
  }

  Widget _pointRatingWidget(int point) => GestureDetector(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '$point',
                style: context.textTheme.displaySmall?.copyWith(
                  color: _pointColor(
                    selectedPoint: selectedPoint,
                    point: point,
                  ),
                ),
              ),
            ),
            _pointRatingDividerWidget(point),
          ],
        ),
        onTap: () => _onSelect(point),
      );

  List<Widget> get _pointRatingWidgets {
    List<Widget> widgets = List.empty(growable: true);
    for (var index = 1; index <= maxLength; ++index) {
      widgets.add(_pointRatingWidget(index));
    }
    return widgets;
  }

  Color _pointColor({
    required int? selectedPoint,
    required int point,
  }) {
    if (selectedPoint == null) {
      return Colors.white54;
    } else {
      return selectedPoint >= point ? Colors.white : Colors.white54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _pointRatingWidgets,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingNormal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localization.notAtAllLikely,
                style:
                    (selectedPoint != null && selectedPoint! <= maxLength / 2)
                        ? context.textTheme.displaySmall
                            ?.copyWith(color: Colors.white)
                        : context.textTheme.displaySmall
                            ?.copyWith(color: Colors.white54),
              ),
              Text(
                context.localization.extremelyLikely,
                style: (selectedPoint != null && selectedPoint! > maxLength / 2)
                    ? context.textTheme.displaySmall
                        ?.copyWith(color: Colors.white)
                    : context.textTheme.displaySmall
                        ?.copyWith(color: Colors.white54),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onSelect(int point) {
    setState(() {
      selectedPoint = point;
    });
    widget.onSelect(point);
  }
}
