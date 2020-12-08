import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final String prefixText, defText, defHintText, type;
  final bool hasRemoveBtn, isPass;
  final IconData leftIcon;
  TextEditingController controller;

  InputFieldWidget({
    Key key,
    this.prefixText,
    this.defText,
    this.hasRemoveBtn = false,
    this.type,
    this.controller,
    this.defHintText,
    this.isPass = false,
    this.leftIcon,
  }) : super(key: key);

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();

  TextEditingController get textController {
    return controller;
  }
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _hidePass = true;

  TextInputType getInputType() {
    if (widget.type == 'phoneNum') {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.leftIcon != null) ...[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              widget.leftIcon,
              size: 22,
              color: Color(0xFFAF42AE),
            ),
          )
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  TextField(
                    controller: widget.controller,
                    keyboardType: getInputType(),
                    decoration: InputDecoration(
                      prefixText: widget.prefixText ?? "",
                      labelText: widget.defText,
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(),
                      hintText: widget.defHintText,
                      contentPadding: EdgeInsets.only(
                          left: widget.prefixText != null ? 5 : 20, right: 20),
                      hintStyle: TextStyle(fontSize: 16, height: 2.25),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFAF42AE))),
                    ),
                    obscureText: widget.isPass && _hidePass,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                    ),
                  ),
                  widget.hasRemoveBtn || widget.isPass
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              widget.hasRemoveBtn
                                  ? Icons.remove
                                  : _hidePass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                              size: 22,
                            ),
                            color: widget.hasRemoveBtn
                                ? Colors.black
                                : Colors.black.withOpacity(0.4),
                            onPressed: () {
                              setState(() {
                                if (widget.isPass) {
                                  _hidePass = !_hidePass;
                                }
                              });
                            },
                          ))
                      : new Container(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
