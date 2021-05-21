/// API url
class ApiUrl {
  final url = "https://api.inobus.co.kr";
  final getOrganizations = "/api/v1/organizations";
  final getDevices = "/api/v1/devices";
  final getUser = "/api/v1/users/";
  final getUserHistory1 = "/api/v1/users/";
  final getUserHistory2 = "/history";

  String getOrganizationsUrl() {
    return url + getOrganizations;
  }

  String getDevicesUrl() {
    return url + getDevices;
  }

  String getUserUrl(String uid) {
    return url + getUser + uid;
  }

  String getUserHistoryUrl(String uid) {
    return url + getUserHistory1 + uid + getUserHistory2;
  }
}
