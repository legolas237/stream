import 'package:flutter/material.dart';

import 'package:stream/widgets/auth_input/auth_input.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';

// ignore: must_be_immutable
class ControlledInputWidget extends StatefulWidget {
  ControlledInputWidget({
    Key? key,
    this.onChanged,
    this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.validateCallback,
  }) : super(key: key);

  late Palette palette;

  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool Function(String)? validateCallback;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _ControlledInputWidgetState();
}

class _ControlledInputWidgetState extends State<ControlledInputWidget> {
  late bool isValid;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
    isValid = widget.validateCallback != null ? widget.validateCallback!(controller.text,) : false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    return Row(
      children: [
        Expanded(
          child: AuthInputWidget(
            keyboardType: widget.keyboardType,
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.only(
              left: 20.0,
              top: 18.0,
              bottom: 18.0,
            ),
            onChanged: (value) {
              if(widget.onChanged != null) widget.onChanged!(value);

              if(widget.validateCallback != null) {
                setState(() {
                  isValid = widget.validateCallback!(value);
                });
              }
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 20.0,
          ),
          child: _buildSuffix(),
        ),
      ],
    );
  }

  // Render

  Widget _buildSuffix() {
    if(widget.validateCallback != null && isValid) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.palette.secondaryBrandColor(1.0),
      );
    }

    if(widget.validateCallback != null) {
      return Icon(
        Icons.check_circle,
        size: 15.0,
        color: widget.palette.captionColor(0.2),
      );
    }

    return const SizedBox();
  }
}