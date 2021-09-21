class AppointmentSearchRequest {
  String search;
  String category;
  String doctor;
  String dateFrom;
  String dateTo;
  String booked;
  String searchFrom;

  AppointmentSearchRequest(
      {this.search,
      this.category,
      this.doctor,
      this.dateFrom,
      this.dateTo,
      this.booked,
      this.searchFrom});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Search'] = this.search;
    data['Category'] = this.category;
    data['Doctor'] = this.doctor;
    data['DateFrom'] = this.dateFrom;
    data['DateTo'] = this.dateTo;
    data['Booked'] = this.booked;
    data['searchFrom'] = this.searchFrom;
    return data;
  }
}
