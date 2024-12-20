class HtmlModel {
  final String detail;
  
  factory HtmlModel.fromJson(Map<String, dynamic> json) {
    return HtmlModel(
      detail: json['bodyTemplate'],
    );
  }
  
  HtmlModel({
    required this.detail,
  });
}
