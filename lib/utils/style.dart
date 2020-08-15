import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  //Color
  static final Color backgroundPrimaryColor = Color(0xFF52307C);
  static final Color textColor = Colors.black;
  static final Color primaryColor = Color(0xFF663A82);
  static final Color backgroundLightColor = Color(0xFFbca0dc).withOpacity(0.3);
  static final Color lightPrimaryColor = Color(0xFFE8EBFF);

  //FontSize
  static final double fontSizeBody = 16;

  //Radius
  static final double buttonBorderRadius = 3;

  //Padding
  static final double lateralPaddingValue = 16.0;
  static final EdgeInsets lateralPadding =
      EdgeInsets.symmetric(horizontal: lateralPaddingValue);

  static Widget textFieldWithLabel(
    label,
    controller,
    context, {
    enabled = true,
    keyboardType,
    textCapitalization,
    obscure,
    textInputAction,
    focusNode,
    nextFocusNode,
    suffixIcon,
    isDeletable,
    prefixIcon,
    colorText,
    hintText,
    expands,
  }) {
    return TextField(
      autocorrect: false,
      keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
      textCapitalization: textCapitalization == null
          ? TextCapitalization.sentences
          : textCapitalization,
      autofocus: false,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled ? true : enabled,
      onSubmitted:
          textInputAction != null && textInputAction == TextInputAction.next
              ? (term) {
                  focusNode.unfocus();
                  FocusScope.of(context).requestFocus(nextFocusNode);
                }
              : null,
      obscureText: obscure == null ? false : obscure,
      style: TextStyle(
        fontSize: fontSizeBody,
        color: colorText != null
            ? colorText
            : enabled ? textColor : textColor.withOpacity(0.5),
      ),
      textInputAction:
          textInputAction == null ? TextInputAction.done : textInputAction,
      decoration: InputDecoration(
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 0, right: 0, bottom: 15),
                child: new SizedBox(
                  width: 24,
                  child: prefixIcon,
                )),
        suffixIcon: suffixIcon != null
            ? suffixIcon
            : isDeletable != null && isDeletable && controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: Style.primaryColor),
                    onPressed: () {
                      controller.clear();
                    })
                : null,
        filled: true,
        fillColor: Colors.grey.shade200,
        focusColor: Colors.black,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(color: Colors.black, width: 2)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
                color: controller.text.isNotEmpty
                    ? Colors.black
                    : Colors.transparent,
                width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
                color: controller.text.isNotEmpty
                    ? Colors.black
                    : Colors.transparent,
                width: 2)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
                color: controller.text.isNotEmpty
                    ? Colors.black
                    : Colors.transparent,
                width: 2)),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: hintText == null ? null : hintText,
      ),
      maxLines:
          expands != null && expands || keyboardType == TextInputType.multiline
              ? null
              : 1,
      expands: expands != null ? expands : false,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
    );
  }

  static Widget button(content, onPressed,
      {color,
      textColor = Colors.white,
      padding = const EdgeInsets.symmetric(vertical: 17)}) {
    if (color == null) {
      color = primaryColor;
    }
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(buttonBorderRadius)),
      highlightColor: color.withOpacity(0.5),
      padding: padding,
      color: color,
      disabledColor: color.withOpacity(0.5),
      child: content is String
          ? Text(
              content.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: fontSizeBody,
                fontWeight: FontWeight.bold,
              ),
            )
          : content,
    );
  }

  //Text

  static Widget body(
    text, {
    color,
    maxLines,
    textAlign,
    double fontSize,
    height,
    decoration,
    fontWeight,
  }) {
    return Text(text != null ? text : '',
        maxLines: maxLines,
        textAlign: textAlign != null ? textAlign : TextAlign.start,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
        style: GoogleFonts.openSans(
            color: color != null ? color : Colors.black,
            fontSize: fontSize != null ? fontSize : fontSizeBody, fontWeight: fontWeight != null ? fontWeight : FontWeight.normal));
  }
}
