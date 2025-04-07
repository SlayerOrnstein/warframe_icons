import 'package:xml/xml.dart';

Map<String, String> xmlToIcons(XmlDocument document) {
  final ttFont = document.firstElementChild;
  final cmap = ttFont?.firstElementChild;
  final relevantChild =
      cmap?.children.where((XmlNode e) {
        final correctPlatformID = e.getAttribute('platformID') == '0';
        final correctplatEncID = e.getAttribute('platEncID') == '3';
        final correctlanguage = e.getAttribute('language') == '0';

        return correctPlatformID && correctplatEncID && correctlanguage;
      }).first;

  if (relevantChild == null) {
    return <String, String>{};
  }

  final mapList = relevantChild.children.whereType<XmlElement>().toList();

  final icons = Map<String, String>.fromEntries(
    mapList.map((XmlElement e) {
      final code = e.attributes.first.value;
      final name = e.attributes.last.value;
      return MapEntry<String, String>(name, code);
      // ignore: require_trailing_commas formatter issues
    }),
  );

  return icons;
}
