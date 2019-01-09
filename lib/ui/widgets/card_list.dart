import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../models/card_model.dart';
import '../../blocs/card_list_bloc.dart';
import '../widgets/card/front.dart';

class CardList extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final _screenSize = MediaQuery.of(context).size;

		return StreamBuilder<List<CardResults>>(
			stream: cardListBloc.cardList,
			builder: (context, snapshot) {
				return Column(
					children: <Widget>[
						!snapshot.hasData
							? Expanded(child: Center(child: CircularProgressIndicator()))
							: Column(
								children: <Widget>[
									Padding(
										padding: EdgeInsets.only(top: 25.0),
									),
									SizedBox(
										height: _screenSize.height*0.8,
										child: Swiper(
											itemBuilder: (BuildContext context, int index) {
												return CardFront(cardModel: snapshot.data[index]);
											},
											itemCount: snapshot.data.length,
											itemWidth: _screenSize.width*0.7,
											itemHeight: _screenSize.height*0.65,
											layout: SwiperLayout.STACK,
											scrollDirection: Axis.vertical,
										),
									)
								]
							)
					],
				);
			},
		);
	}
}