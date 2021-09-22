import 'dart:convert';

class CustomizeModel {
  const CustomizeModel({
    required this.correctErrors,
    required this.showTranslations,
  });

  final bool correctErrors;
  final bool showTranslations;

  String toJson() {
    Map data = {};

    data.addAll({'correctErrors': correctErrors});
    data.addAll({'showTranslations': showTranslations});

    return json.encode(data);
  }

  factory CustomizeModel.fromJson(Map<String, dynamic> json) {
    return CustomizeModel(
      correctErrors: json['correctErrors'],
      showTranslations: json['showTranslations'],
    );
  }
}
