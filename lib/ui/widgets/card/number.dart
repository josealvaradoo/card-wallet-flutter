import 'package:flutter/material.dart';

class CardNumber extends StatelessWidget {
	CardNumber({this.number});

	final String number;
	
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(top: 15.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					_buildDots(),
				],
			),
		);
	}

	Widget _buildDots() {
		List<Widget> dotList = List<Widget>();
		var counter = 0;

		for(var i=0; i<12; i++) {
			counter += 1;
			dotList.add(
				Padding(
					padding: EdgeInsets.symmetric(horizontal: 3.0),
					child: Container(
						width: 8.0,
						height: 8.0,
						decoration: BoxDecoration(
							color: Colors.white,
							shape: BoxShape.circle
						),
					),
				)
			);
			if(counter == 4) {
				counter = 0;
				dotList.add(SizedBox(width: 30.0));
			}
		}

		dotList.add(_buildNumbers());

		return Row(
			children: dotList,
		);
	}

	Widget _buildNumbers() {
		return Text(
			number.substring(12),
			style: TextStyle(
				color: Colors.white,
				fontSize: 16.0
			)
		);
	}
}