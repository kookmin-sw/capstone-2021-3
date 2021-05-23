/// API url
class ApiUrl {
  final url = "https://api.inobus.co.kr";
  final getOrganizations = "/api/v1/organizations";
  final getDevices = "/api/v1/devices";
  final getUser = "/api/v1/users/";
  final history = "/history";
  final tickets = "/tickets";

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
    return url + getUser + uid + history;
  }

  String getUserTicketsUrl(String uid) {
    return url + getUser + uid + tickets;
  }
}
