import 'package:flutter/material.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class MusicGenreTileWidget extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onSelected;
  final List<String> initialSelected;

  const MusicGenreTileWidget({
    super.key,
    required this.options,
    required this.onSelected,
    required this.initialSelected,
  });

  @override
  _MusicGenreTileWidgetState createState() => _MusicGenreTileWidgetState();
}

class _MusicGenreTileWidgetState extends State<MusicGenreTileWidget> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5.0,
      runSpacing: 2.0,
      children: widget.options.map((option) {
        bool isSelected = selectedOptions.contains(option);
        return ElevatedButton(
          onPressed: () {
            setState(() {
              isSelected
                  ? selectedOptions.remove(option)
                  : selectedOptions.add(option);
            });
            widget.onSelected(option);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? VoidColors.whiteColor : VoidColors.secondary,
            backgroundColor: isSelected ? VoidColors.secondary : Colors.white,
            side: BorderSide(color: VoidColors.secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(option),
        );
      }).toList(),
    );
  }
}
