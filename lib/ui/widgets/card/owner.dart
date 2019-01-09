import 'package:flutter/material.dart';

class CardOwner extends StatelessWidget {
	CardOwner({this.name});

	final String name;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(top: 15.0, left: 50.0),
			child: Text(
				name.toUpperCase(),
				style: TextStyle(
					color: Colors.white,
					fontSize: 18.0
				)
			),
		);
	}
}