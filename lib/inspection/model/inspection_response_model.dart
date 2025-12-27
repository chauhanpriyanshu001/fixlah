class InspectionResponse {
  bool? success;
  Data? data;

  InspectionResponse({this.success, this.data});

  InspectionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<InspectionData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <InspectionData>[];
      json['data'].forEach((v) {
        data!.add(InspectionData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class InspectionData {
  int? id;
  String? inspectionCode;
  int? inspectionTemplateId;
  int? facilityId;
  int? facilityBlockId;
  int? facilityUnitId;
  String? inspectionDate;
  int? clientId;
  int? contracted;
  int? cream;
  String? unitSpecific;
  String? status;
  String? startedAt;
  String? completedAt;
  String? completedVia;
  String? completedUserAgent;
  String? completedIp;
  dynamic completedMode;
  String? reportPath;
  String? reportStatus;
  String? reportGeneratedAt;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? notGoodItemsCount;
  int? totalItemsCount;
  bool? hasNotGood;
  String? icon;
  InspectionTemplate? inspectionTemplate;
  Facility? facility;
  Block? block;
  Unit? unit;
  Creator? creator;

  InspectionData(
      {this.id,
      this.inspectionCode,
      this.inspectionTemplateId,
      this.facilityId,
      this.facilityBlockId,
      this.facilityUnitId,
      this.inspectionDate,
      this.clientId,
      this.contracted,
      this.cream,
      this.unitSpecific,
      this.status,
      this.startedAt,
      this.completedAt,
      this.completedVia,
      this.completedUserAgent,
      this.completedIp,
      this.completedMode,
      this.reportPath,
      this.reportStatus,
      this.reportGeneratedAt,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.notGoodItemsCount,
      this.totalItemsCount,
      this.hasNotGood,
      this.icon,
      this.inspectionTemplate,
      this.facility,
      this.block,
      this.unit,
      this.creator});

  InspectionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionCode = json['inspection_code'];
    inspectionTemplateId = json['inspection_template_id'];
    facilityId = json['facility_id'];
    facilityBlockId = json['facility_block_id'];
    facilityUnitId = json['facility_unit_id'];
    inspectionDate = json['inspection_date'];
    clientId = json['client_id'];
    contracted = json['contracted'];
    cream = json['cream'];
    unitSpecific = json['unit_specific'];
    status = json['status'];
    startedAt = json['started_at'];
    completedAt = json['completed_at'];
    completedVia = json['completed_via'];
    completedUserAgent = json['completed_user_agent'];
    completedIp = json['completed_ip'];
    completedMode = json['completed_mode'];
    reportPath = json['report_path'];
    reportStatus = json['report_status'];
    reportGeneratedAt = json['report_generated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notGoodItemsCount = json['not_good_items_count'];
    totalItemsCount = json['total_items_count'];
    hasNotGood = json['has_not_good'];
    icon = json['icon'];
    inspectionTemplate = json['inspection_template'] != null
        ? InspectionTemplate.fromJson(json['inspection_template'])
        : null;
    facility =
        json['facility'] != null ? Facility.fromJson(json['facility']) : null;
    block = json['block'] != null ? Block.fromJson(json['block']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_code'] = inspectionCode;
    data['inspection_template_id'] = inspectionTemplateId;
    data['facility_id'] = facilityId;
    data['facility_block_id'] = facilityBlockId;
    data['facility_unit_id'] = facilityUnitId;
    data['inspection_date'] = inspectionDate;
    data['client_id'] = clientId;
    data['contracted'] = contracted;
    data['cream'] = cream;
    data['unit_specific'] = unitSpecific;
    data['status'] = status;
    data['started_at'] = startedAt;
    data['completed_at'] = completedAt;
    data['completed_via'] = completedVia;
    data['completed_user_agent'] = completedUserAgent;
    data['completed_ip'] = completedIp;
    data['completed_mode'] = completedMode;
    data['report_path'] = reportPath;
    data['report_status'] = reportStatus;
    data['report_generated_at'] = reportGeneratedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['not_good_items_count'] = notGoodItemsCount;
    data['total_items_count'] = totalItemsCount;
    data['has_not_good'] = hasNotGood;
    data['icon'] = icon;
    if (inspectionTemplate != null) {
      data['inspection_template'] = inspectionTemplate!.toJson();
    }
    if (facility != null) {
      data['facility'] = facility!.toJson();
    }
    if (block != null) {
      data['block'] = block!.toJson();
    }
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    return data;
  }
}

class InspectionTemplate {
  int? id;
  String? name;
  String? description;
  String? unitSpecific;
  String? periodicity;
  int? facilityId;
  bool? viewToClient;
  bool? companySignReq;
  bool? agentSignReq;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  InspectionTemplate(
      {this.id,
      this.name,
      this.description,
      this.unitSpecific,
      this.periodicity,
      this.facilityId,
      this.viewToClient,
      this.companySignReq,
      this.agentSignReq,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  InspectionTemplate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    unitSpecific = json['unit_specific'];
    periodicity = json['periodicity'];
    facilityId = json['facility_id'];
    viewToClient = json['view_to_client'];
    companySignReq = json['company_sign_req'];
    agentSignReq = json['agent_sign_req'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['unit_specific'] = unitSpecific;
    data['periodicity'] = periodicity;
    data['facility_id'] = facilityId;
    data['view_to_client'] = viewToClient;
    data['company_sign_req'] = companySignReq;
    data['agent_sign_req'] = agentSignReq;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Facility {
  int? id;
  String? name;
  String? type;
  String? onefmFacilityInternalId;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? updatedAt;

  Facility(
      {this.id,
      this.name,
      this.type,
      this.onefmFacilityInternalId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Facility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    onefmFacilityInternalId = json['onefm_facility_internal_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['onefm_facility_internal_id'] = onefmFacilityInternalId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Block {
  int? id;
  int? facilityId;
  String? name;
  String? onefmBlockInternalId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Block(
      {this.id,
      this.facilityId,
      this.name,
      this.onefmBlockInternalId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Block.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    name = json['name'];
    onefmBlockInternalId = json['onefm_block_internal_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facility_id'] = facilityId;
    data['name'] = name;
    data['onefm_block_internal_id'] = onefmBlockInternalId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Unit {
  int? id;
  int? facilityId;
  int? facilityBlockId;
  int? facilityFloorId;
  String? unitNo;
  String? onefmUnitInternalId;
  String? creamUnit;
  dynamic contractUnit;
  dynamic occupied;
  String? qrcode;
  int? createdBy;
  int? updatedBy;
  dynamic createdAt;
  dynamic updatedAt;

  Unit(
      {this.id,
      this.facilityId,
      this.facilityBlockId,
      this.facilityFloorId,
      this.unitNo,
      this.onefmUnitInternalId,
      this.creamUnit,
      this.contractUnit,
      this.occupied,
      this.qrcode,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    facilityBlockId = json['facility_block_id'];
    facilityFloorId = json['facility_floor_id'];
    unitNo = json['unit_no'];
    onefmUnitInternalId = json['onefm_unit_internal_id'];
    creamUnit = json['cream_unit'];
    contractUnit = json['contract_unit'];
    occupied = json['occupied'];
    qrcode = json['qrcode'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facility_id'] = facilityId;
    data['facility_block_id'] = facilityBlockId;
    data['facility_floor_id'] = facilityFloorId;
    data['unit_no'] = unitNo;
    data['onefm_unit_internal_id'] = onefmUnitInternalId;
    data['cream_unit'] = creamUnit;
    data['contract_unit'] = contractUnit;
    data['occupied'] = occupied;
    data['qrcode'] = qrcode;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Creator {
  int? id;
  String? username;
  String? name;
  String? employeeNo;
  String? joiningDate;
  String? mobile;
  String? email;
  String? designation;
  int? supervisorId;
  int? roleId;
  String? vocationType;
  String? facilityIds;
  String? employmentType;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Creator(
      {this.id,
      this.username,
      this.name,
      this.employeeNo,
      this.joiningDate,
      this.mobile,
      this.email,
      this.designation,
      this.supervisorId,
      this.roleId,
      this.vocationType,
      this.facilityIds,
      this.employmentType,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    employeeNo = json['employee_no'];
    joiningDate = json['joining_date'];
    mobile = json['mobile'];
    email = json['email'];
    designation = json['designation'];
    supervisorId = json['supervisor_id'];
    roleId = json['role_id'];
    vocationType = json['vocation_type'];
    facilityIds = json['facility_ids'];
    employmentType = json['employment_type'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['employee_no'] = employeeNo;
    data['joining_date'] = joiningDate;
    data['mobile'] = mobile;
    data['email'] = email;
    data['designation'] = designation;
    data['supervisor_id'] = supervisorId;
    data['role_id'] = roleId;
    data['vocation_type'] = vocationType;
    data['facility_ids'] = facilityIds;
    data['employment_type'] = employmentType;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  int? page;
  bool? active;

  Links({this.url, this.label, this.page, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    page = json['page'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['page'] = page;
    data['active'] = active;
    return data;
  }
}
