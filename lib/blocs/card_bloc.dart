import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/card_color_model.dart';
import '../models/card_model.dart';
import '../helpers/card_colors.dart';
import './validators.dart';
import './bloc_provider.dart';
import './card_list_bloc.dart';

class CardBloc with Validators implements BlocBase {
	BehaviorSubject<String> _name = BehaviorSubject<String>();
	BehaviorSubject<String> _number = BehaviorSubject<String>();
	BehaviorSubject<String> _month = BehaviorSubject<String>();
	BehaviorSubject<String> _year = BehaviorSubject<String>();
	BehaviorSubject<String> _cvv = BehaviorSubject<String>();
	BehaviorSubject<String> _type = BehaviorSubject<String>();
	BehaviorSubject<int> _colorIndexSelected = BehaviorSubject<int>(seedValue: 0);

	final _cardColors = BehaviorSubject<List<CardColorModel>>();

	// Add data to stream
	Function(String) get changeName => _name.sink.add;
	Function(String) get changeNumber => _number.sink.add;
	Function(String) get changeMonth => _month.sink.add;
	Function(String) get changeYear => _year.sink.add;
	Function(String) get changeCvv => _cvv.sink.add;
	Function(String) get selectCardType => _type.sink.add;

	// Retrieve data from stream
	Stream<String> get name => _name.stream.transform(validateName);
	Stream<String> get number => _number.stream.transform(validateNumber);
	Stream<String> get month => _month.stream.transform(validateMonth);
	Stream<String> get year => _year.stream.transform(validateYear);
	Stream<String> get cvv => _cvv.stream.transform(validateCvv);
	Stream<String> get type => _type.stream;
	Stream<int> get colorIndexSelected => _colorIndexSelected.stream;
	Stream<List<CardColorModel>> get cardColorsList => _cardColors.stream;
	Stream<bool> get saveCardValid => Observable.combineLatest5(name, number, month, year, cvv, (ow, n, m, y, c) => true);

	// Save
	void saveCard() {
    final newCard = CardResults(
        name: _name.value,
        number: _number.value.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
        month: _month.value,
        year: _year.value,
        cvv: _cvv.value,
        color: CardColor.baseColors[_colorIndexSelected.value],
        type: _type.value
        );
    cardListBloc.addCardToList(newCard);
  }

	// Select card color
	void selectCardColor(int colorIndex) {
		CardColor.cardColors.forEach((element) => element.isSelected = false);
		CardColor.cardColors[colorIndex].isSelected = true;
		_cardColors.sink.add(CardColor.cardColors);
		_colorIndexSelected.sink.add(colorIndex);
	}

	void dispose() {
		_type.close();
		_name.close();
		_number.close();
		_month.close();
		_year.close();
		_cvv.close();
		_colorIndexSelected.close();
		_cardColors.close();
	}
}