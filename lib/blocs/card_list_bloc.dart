import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/card_model.dart';
import '../helpers/card_colors.dart';

class CardListBloc {
	BehaviorSubject<List<CardResults>> _cardsCollection = BehaviorSubject<List<CardResults>>();

	List<CardResults> _cardResults;

	// Constructor
	CardListBloc() {
		initialData();
	}

	// Retrieve data from Stream
	Stream<List<CardResults>> get cardList => _cardsCollection.stream;

	// Read JSON and set data
	void initialData() async {
		var data = await rootBundle.loadString('data/initial.json');
		var decodedJson = jsonDecode(data);
		_cardResults = CardModel.fromJson(decodedJson).results;

		for(var i=0; i<_cardResults.length; i++) {
			_cardResults[i].color = CardColor.baseColors[i];
		}

		_cardsCollection.sink.add(_cardResults);
	}

	// Add card to list
	void addCardToList(CardResults card) {
		_cardResults.add(card);
		_cardsCollection.sink.add(_cardResults);
	}

	void dispose() {
		_cardsCollection.close();
	}
}

final cardListBloc = CardListBloc();