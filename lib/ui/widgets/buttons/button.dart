import 'package:flutter/material.dart';
import '../../../blocs/bloc_provider.dart';
import '../../../blocs/card_bloc.dart';

class Button extends StatelessWidget {
	Button({this.color, this.text, this.textColor, this.redirect});

	final String text;
	final Color color;
	final Color textColor;
	final Widget redirect;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(bottom: 5.0),
			child: RaisedButton(
				elevation: 1.0,
				onPressed: () {
					var blocProviderCardCreate = BlocProvider(
						bloc: CardBloc(),
						child: redirect,
					);

					blocProviderCardCreate.bloc.selectCardType(text);
					Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => blocProviderCardCreate)
					);
				},
				color: color,
				textColor: textColor,
				child: Text(text),
			),
		);
	}
}