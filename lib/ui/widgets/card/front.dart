import 'package:flutter/material.dart';
import '../../../models/card_model.dart';
import './chip.dart';
import './last_number.dart';
import './logo.dart';
import './number.dart';
import './owner.dart';
import './valid_thru.dart';

class CardFront extends StatelessWidget {
	final CardResults cardModel;
	CardFront({this.cardModel});

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(15.0),
				color: cardModel.color,
			),
			child: RotatedBox(
				quarterTurns: 3,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>[
						CardLogo(type: cardModel.type),
						CardChip(),
						CardNumber(number: cardModel.number),
						CardLastNumber(number: cardModel.number),
						CardValidThru(month: cardModel.month, year: cardModel.year),
						CardOwner(name: cardModel.name)
					],
				),
			),
		);
	}
}