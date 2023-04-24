import 'package:japx/japx.dart';

Map<String, dynamic> mapDataJson(Map<String, dynamic> json) =>
    json.containsKey('data') ? Japx.decode(json)['data'] : json;
