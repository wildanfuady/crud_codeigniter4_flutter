import 'package:flutter/material.dart';

class RadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final Widget label;

  const RadioButton({
    Key key,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    @required this.label,
    this.activeColor,
    this.materialTapTargetSize,
  }) : assert(value != null),
        assert(groupValue != null),
        assert(onChanged != null),
        assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<T>(
          key: key,
          value: value,
          groupValue: groupValue,
          onChanged: (T newValue) {
            onChanged(newValue);
          },
          activeColor: activeColor,
          materialTapTargetSize: materialTapTargetSize,
        ),
        label,
      ],
    );
  }
}