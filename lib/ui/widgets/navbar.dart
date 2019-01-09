import 'package:flutter/material.dart';

class Navbar extends AppBar {
	Navbar({
		String appBarTitle,
		IconData leading,
		BuildContext context
	}) : super(
		elevation: 0.0,
		backgroundColor: Colors.white,
		centerTitle: true,
		title: Text(
			appBarTitle,
			style: TextStyle(
				color: Colors.black,
				fontSize: 14.0,
				fontWeight: FontWeight.w600
			),
		),
		leading: IconButton(
			icon: Icon(
				leading,
				color: Colors.black,
			),
			onPressed: () {
				Navigator.pop(context);
			},
		)
	);
}