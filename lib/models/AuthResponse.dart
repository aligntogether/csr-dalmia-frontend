
class AuthResponse {
  final String referenceId;
  final String userType;
  final String appName;
  final String accessToken;
  final String refreshToken;
  final String platform;
  final String employeeName;

  AuthResponse(this.referenceId, this.userType, this.appName, this.accessToken,
      this.refreshToken, this.platform,this.employeeName);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      json['referenceId'].toString(),
      json['userType'].toString(),
      json['appName'].toString(),
      json['accessToken'].toString(),
      json['refreshToken'].toString(),
      json['platform'].toString(),
      json['employeeName'].toString(),
    );
  }
}
