import 'dart:convert';

StaticModel staticModelFromJson(String str) => StaticModel.fromJson(json.decode(str));

class StaticModel {
  StaticModel({this.code, this.desc});

  final String? code;
  final String? desc;

  factory StaticModel.fromJson(Map<String, dynamic> json, {String? code, String? desc}) =>
      StaticModel(code: json[code ?? 'ItemValue'], desc: json[desc ?? 'ItemText']);
}
