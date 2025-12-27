class DashboardData {
  String? status;
  Data? data;

  DashboardData({this.status, this.data});

  DashboardData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Issues? issues;
  WorkOrders? workOrders;
  Inspection? inspection;

  Data({this.issues, this.workOrders, this.inspection});

  Data.fromJson(Map<String, dynamic> json) {
    issues = json['issues'] != null ? Issues.fromJson(json['issues']) : null;
    workOrders = json['work_orders'] != null
        ? WorkOrders.fromJson(json['work_orders'])
        : null;
    inspection = json['inspection'] != null
        ? Inspection.fromJson(json['inspection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (issues != null) {
      data['issues'] = issues!.toJson();
    }
    if (workOrders != null) {
      data['work_orders'] = workOrders!.toJson();
    }
    if (inspection != null) {
      data['inspection'] = inspection!.toJson();
    }
    return data;
  }
}

class Issues {
  int? urgent;
  int? notUrgent;
  int? contractedPending;
  int? nonContractedPending;
  int? commonAreaPending;
  int? contractedWoIssued;
  int? nonContractedWoIssued;
  int? commonAreaWoIssued;

  Issues(
      {this.urgent,
      this.notUrgent,
      this.contractedPending,
      this.nonContractedPending,
      this.commonAreaPending,
      this.contractedWoIssued,
      this.nonContractedWoIssued,
      this.commonAreaWoIssued});

  Issues.fromJson(Map<String, dynamic> json) {
    urgent = json['urgent'];
    notUrgent = json['not_urgent'];
    contractedPending = json['contracted_pending'];
    nonContractedPending = json['non_contracted_pending'];
    commonAreaPending = json['common_area_pending'];
    contractedWoIssued = json['contracted_wo_issued'];
    nonContractedWoIssued = json['non_contracted_wo_issued'];
    commonAreaWoIssued = json['common_area_wo_issued'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['urgent'] = urgent;
    data['not_urgent'] = notUrgent;
    data['contracted_pending'] = contractedPending;
    data['non_contracted_pending'] = nonContractedPending;
    data['common_area_pending'] = commonAreaPending;
    data['contracted_wo_issued'] = contractedWoIssued;
    data['non_contracted_wo_issued'] = nonContractedWoIssued;
    data['common_area_wo_issued'] = commonAreaWoIssued;
    return data;
  }
}

class WorkOrders {
  int? urgent;
  int? notUrgent;
  int? contractedPending;
  int? nonContractedPending;
  int? commonAreaPending;

  WorkOrders(
      {this.urgent,
      this.notUrgent,
      this.contractedPending,
      this.nonContractedPending,
      this.commonAreaPending});

  WorkOrders.fromJson(Map<String, dynamic> json) {
    urgent = json['urgent'];
    notUrgent = json['not_urgent'];
    contractedPending = json['contracted_pending'];
    nonContractedPending = json['non_contracted_pending'];
    commonAreaPending = json['common_area_pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['urgent'] = urgent;
    data['not_urgent'] = notUrgent;
    data['contracted_pending'] = contractedPending;
    data['non_contracted_pending'] = nonContractedPending;
    data['common_area_pending'] = commonAreaPending;
    return data;
  }
}

class Inspection {
  int? units;
  int? commonArea;
  int? contractedPending;
  int? nonContractedPending;
  int? commonAreaPending;

  Inspection(
      {this.units,
      this.commonArea,
      this.contractedPending,
      this.nonContractedPending,
      this.commonAreaPending});

  Inspection.fromJson(Map<String, dynamic> json) {
    units = json['units'];
    commonArea = json['common_area'];
    contractedPending = json['contracted_pending'];
    nonContractedPending = json['non_contracted_pending'];
    commonAreaPending = json['common_area_pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['units'] = units;
    data['common_area'] = commonArea;
    data['contracted_pending'] = contractedPending;
    data['non_contracted_pending'] = nonContractedPending;
    data['common_area_pending'] = commonAreaPending;
    return data;
  }
}
