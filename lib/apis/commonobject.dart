class CommonObject {
  final String respCode;
  final String respMsg;
  final dynamic respBody;

  CommonObject(this.respCode, this.respMsg, this.respBody);

  factory CommonObject.fromJson(Map<String, dynamic> json) {
    return CommonObject(
      json['resp_code'].toString(),
      json['resp_msg'].toString(),
      json['resp_body'],
    );
  }
}
