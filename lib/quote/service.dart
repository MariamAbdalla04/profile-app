import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/quote/quote.dart';

Future<List<Quote>> fetchQuote() async {
  final response = await http.get(
    Uri.parse("https://api.api-ninjas.com/v1/quotes"),
    headers: {'X-Api-Key': 'WBs1BPH5QSu69SbNC27sjw==nQdxgYNOKt3ZkwPA'},
  );
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Quote.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
