import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CardBloc {
	BehaviorSubject<String> _controller = BehaviorSubject<String>();

	// Add data stream
	Function(String) get selectCardType => _controller.sink.add;

	// Retrieve data from steam
	Stream<String> get type => _controller.stream;

	dispose() {
		_controller.close();
	}
}