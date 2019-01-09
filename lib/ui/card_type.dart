import 'package:flutter/material.dart';
import './widgets//navbar.dart';
import './widgets/buttons/button.dart';

class CardType extends StatelessWidget {
	@override
	Widget build(BuildContext context) {

		final _buildTextInfo = Padding(
			padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
			child: Text.rich(
				TextSpan(
					text: 'You can now add gift cards with a specific balance into wallet. When the cards hits \$0.00 it will automatically disspaear. Want to know of your gift card will link? ',
					style: TextStyle(
						fontSize: 14.0,
						color: Colors.grey[700]
					),
					children: <TextSpan>[
						TextSpan(
							text: 'Learn More',
							style: TextStyle(
								color: Colors.lightBlue,
								fontWeight: FontWeight.bold
							)
						),
					]
				)
			),
		);

		return Scaffold(
			backgroundColor: Colors.white,
			appBar: Navbar(
				appBarTitle: 'Select type',
				leading: Icons.clear,
				context: context,
			),
			body: Container(
				padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>[
						Button(
							color: Colors.lightBlue,
							text: 'Credit Card',
							textColor: Colors.white,
						),
						Button(
							color: Colors.grey[100],
							text: 'Debit Card',
							textColor: Colors.grey[600],
						),
						Button(
							color: Colors.grey[100],
							text: 'Gift Card',
							textColor: Colors.grey[600],
						),
						_buildTextInfo,
					],
				),
			),
		);
	}
}