import 'package:flutter/material.dart';
import '../ui/widgets/navbar.dart';
import '../ui/widgets/flip_card.dart';
import '../ui/widgets/card_front.dart';
import '../ui/widgets/card_back.dart';
import '../helpers/card_colors.dart';
import '../helpers/formatters.dart';
import '../blocs/card_bloc.dart';
import '../blocs/bloc_provider.dart';
import '../models/card_color_model.dart';

class CardCreate extends StatefulWidget{
  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate>{
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final _creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(rotatedTurnsValue: 0),
          back: CardBack(),
        ),
      ),
    );

    final _name = StreamBuilder(
        stream: bloc.name,
        builder: (context, snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.changeName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Cardholder Name',
              errorText: snapshot.error,
            ),
          );
        });

    final _number = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: StreamBuilder(
          stream: bloc.number,
          builder: (context, snapshot) {
            return TextField(
              onChanged: bloc.changeNumber,
              keyboardType: TextInputType.number,
              maxLength: 19,
              maxLengthEnforced: true,
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: 'xxxx xxxx xxxx xxxx',
                  separator: ' ',
                ),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Card Number',
                counterText: '',
                errorText: snapshot.error,
              ),
            );
          }),
    );

    final _month = StreamBuilder(
      stream: bloc.month,
      builder: (context, snapshot) {
        return Container(
          width: 85.0,
          child: TextField(
            onChanged: bloc.changeMonth,
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'MM',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );

    final _year = StreamBuilder(
        stream: bloc.year,
        builder: (context, snapshot) {
          return Container(
            width: 120.0,
            child: TextField(
              onChanged: bloc.changeYear,
              keyboardType: TextInputType.number,
              maxLength: 4,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'YYYY',
                counterText: '',
                errorText: snapshot.error,
              ),
            ),
          );
        });

    final _cvv = StreamBuilder(
        stream: bloc.cvv,
        builder: (context, snapshot) {
          return Container(
            width: 85.0,
            child: TextField(
              focusNode: _focusNode,
              onChanged: bloc.changeCvv,
              keyboardType: TextInputType.number,
              maxLength: 3,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  counterText: '',
                  hintText: 'CVV',
                  errorText: snapshot.error),
            ),
          );
        });

    final _saveCard = StreamBuilder(
      stream: bloc.saveCardValid,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            child: Text(
              'Save Card',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            onPressed: snapshot.hasData
                ? () {
                    var blocProviderCardWallet = BlocProvider(
                      bloc: bloc,
                      child: Container(), // CardWallet()
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => blocProviderCardWallet));
                  }
                : null,
          ),
        );
      },
    );

    return new Scaffold(
        appBar: Navbar(
          appBarTitle: 'Create Card',
          leading: Icons.arrow_back,
          context: context,
        ),
        backgroundColor: Colors.grey[100],
        body: ListView(
          itemExtent: 750.0,
          padding: EdgeInsets.only(top:10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _creditCard,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        _name,
                        _number,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _month,
                            SizedBox(width: 12.0),
                            _year,
                            SizedBox(width: 12.0),
                            _cvv,
                          ],
                        ),
                        SizedBox(height: 20.0),
                        cardColors(bloc),
                        SizedBox(height: 50.0),
                        _saveCard,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget cardColors(CardBloc bloc) {
    final dotSize =
        (MediaQuery.of(context).size.width - 150) / CardColor.baseColors.length;

    List<Widget> dotList = new List<Widget>();

    for (var i = 0; i < CardColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorsList,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData
                      ? snapshot.data[i].isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12.0,
                            )
                          : Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: new BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
	}
}