import 'package:flutter/material.dart';

class CardModel {
	List<CardResults> results;
	CardModel({this.results});

	CardModel.fromJson(Map<String, dynamic> json) {
		if(json['cardResults'] != null) {
			results = new List<CardResults>();
			json['cardResults'].forEach((v) {
				results.add(CardResults.fromJson(v));
			});
		}
	}
}

class CardResults {
	String name;
	String number;
	String month;
	String year;
	String cvv;
	String type;
	Color color;

	CardResults({
		this.name,
		this.number,
		this.month,
		this.year,
		this.cvv,
		this.type,
		this.color,
	});

	CardResults.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		number = json['number'];
		month = json['month'];
		year = json['year'];
		cvv = json['cvv'];
		type = json['type'];
		color = json['color'];
	}
}