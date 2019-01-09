import 'package:flutter/material.dart';

class CardLastNumber extends StatelessWidget {
	CardLastNumber({this.number});

	final String number;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(top: 1.0, left: 55.0),
			child: Text(
				number.substring(12),
				style: TextStyle(
					color: Colors.white,
					fontSize: 8.0
				),
			),
		);
	}
}