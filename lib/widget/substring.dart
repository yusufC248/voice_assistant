import 'package:flutter/material.dart';

class SubstringHighlight extends StatelessWidget {
  final String text;
  final List<String> terms;
  final TextStyle? textStyle;
  final TextStyle? textStyleHighlight;

  const SubstringHighlight({Key? key, required this.text, required this.terms, this.textStyle, this.textStyleHighlight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(terms.isEmpty){
      return Text(text, style: textStyle,);
    }else{
      final matchingTerms = terms.where((term) => text.toLowerCase().contains(term)).toList();
      if(matchingTerms.isEmpty){
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(text, style: textStyle,),
                SizedBox(height: 16.0,),
                ClipRRect(
                    child: Image.network(
                        "https://i.ibb.co/prRm9wD/1634859690362.png", fit: BoxFit.cover,height: 400, width: 300)),
              ],
            ));
      }
      final termMatch = matchingTerms.first;
      final termLC = termMatch.toLowerCase();

      final List<InlineSpan> children = [];

      final List<String> spanList = text.toLowerCase().split(termLC);
      int i = 0;
      spanList.forEach((v) {
        if (v.isNotEmpty) {
          children.add(TextSpan(
              text: text.substring(i, i + v.length), style: textStyle));
          i += v.length;
        }
        if (i < text.length) {
          children.add(TextSpan(
              text: text.substring(i, i + termMatch.length),
              style: textStyleHighlight));
          i += termMatch.length;
        }
      });
      return RichText(text: TextSpan(children: children));
    }
  }
}
