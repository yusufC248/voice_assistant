import 'package:url_launcher/url_launcher.dart';

class Command{
  static final all = [email, browser1, browser2];

  static const email = 'send email';
  static const browser1 = 'open';
  static const browser2 = 'search';
}

class Utils {
  static void scanText(String rawText) {
    String text = rawText.toLowerCase();

    if (text.contains(Command.email)) {
      final body = _getTextAfterCommand(text: text, command: Command.email);
      openEmail(body: body);
    }else if(text.contains(Command.browser1)){
      final url = _getTextAfterCommand(text: text, command: Command.browser1);
      openLink(url: url);
    }else if(text.contains(Command.browser2)){
      final url = _getTextAfterCommand(text: text, command: Command.browser2);
      searchLink(url: url);
    }
  }


  static String _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if(text =='open whatsapp'){
      text = 'open api.whatsapp.com/send?phone=6289687781238';
    }else if(text == 'open youtube'){
      text = 'open youtube.com';
    }else if(text == 'open instagram'){
      text = 'open instagram.com';
    }

    print(text);
    if (indexCommand == -1) {
      return "";
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future openLink({
    required String url,
  }) async {
    if (url
        .trim()
        .isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl('https://$url');
    }
  }

  static Future searchLink({
    required String url,
  }) async {
    if (url
        .trim()
        .isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl('https://www.google.com/search?q=$url');
    }
  }

  static Future openEmail({
    required String body,
  }) async {
    final url = 'mailto: ?body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }


}

