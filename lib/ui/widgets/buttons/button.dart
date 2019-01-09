import 'package:flutter/material.dart';

class Button extends StatelessWidget {
	Button({this.color, this.text, this.textColor});

	final String text;
	final Color color;
	final Color textColor;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(bottom: 5.0),
			child: RaisedButton(
				elevation: 1.0,
				onPressed: () {},
				color: color,
				textColor: textColor,
				child: Text(text),
			),
		);
	}
}