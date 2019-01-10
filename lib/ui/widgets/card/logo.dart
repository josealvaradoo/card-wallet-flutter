import 'package:flutter/material.dart';

class CardLogo extends StatelessWidget {
	CardLogo({this.type});

	final String type;

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.end,
			children: <Widget>[
				Padding(
					padding: EdgeInsets.only(top: 25.0, right: 52.0),
					child: Image(
						image: AssetImage('assets/images/visa_logo.png'),
						width: 65.0,
						height: 32.0,
					),
				),
				Padding(
					padding: EdgeInsets.only(right: 52.0),
					child: Text(
						type.toUpperCase(),
						style: TextStyle(
							color: Colors.white,
							fontSize: 14.0,
							fontWeight: FontWeight.w400
						),
					),
				),
			],
		);
	}
}