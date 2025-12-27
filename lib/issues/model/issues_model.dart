import 'package:fixlah/work%20order/model/work_order_model.dart';

class IssuesList {
  bool? success;
  PageData? data;

  IssuesList({this.success, this.data});

  IssuesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? PageData.fromJson(json['data']) : null;
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

class PageData {
  int? currentPage;
  List<IssueData>? data;
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

  PageData(
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

  PageData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <IssueData>[];
      json['data'].forEach((v) {
        data!.add(IssueData.fromJson(v));
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

class IssueData {
  int? id;
  int? facilityId;
  int? facilityBlockId;
  int? facilityUnitId;
  String? issueIdAuto;
  String? issueType;
  int? locationTagId;
  int? clientId;
  String? priority;
  int? creamUnit;
  int? unitSpecific;
  int? contracted;
  String? status;
  int? clientAcknowledgeRequire;
  int? clientAcknowledgeSent;
  String? clientAcknowledgeSentDate;
  int? proceedWo;
  int? clientAcknowledged;
  String? clientAcknowledgedDate;
  dynamic issueCreatedFrom;
  dynamic issueCreatedBy;
  dynamic issueCreatedById;
  String? issueRaisedBy;
  dynamic tenantName;
  dynamic tenantFinNo;
  CreatedBy? createdBy;
  CreatedBy? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? workOrdersCount;
  Facility? facility;
  Block? block;
  Unit? unit;
  List<IssueItem>? items;
  List<Photos>? photos;
  Client? client;
  LocationTag? locationTag;

  IssueData(
      {this.id,
      this.facilityId,
      this.facilityBlockId,
      this.facilityUnitId,
      this.issueIdAuto,
      this.issueType,
      this.locationTagId,
      this.clientId,
      this.priority,
      this.creamUnit,
      this.unitSpecific,
      this.contracted,
      this.status,
      this.clientAcknowledgeRequire,
      this.clientAcknowledgeSent,
      this.clientAcknowledgeSentDate,
      this.proceedWo,
      this.clientAcknowledged,
      this.clientAcknowledgedDate,
      this.issueCreatedFrom,
      this.issueCreatedBy,
      this.issueCreatedById,
      this.issueRaisedBy,
      this.tenantName,
      this.tenantFinNo,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.workOrdersCount,
      this.facility,
      this.block,
      this.unit,
      this.items,
      this.photos,
      this.client,
      this.locationTag});

  IssueData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    facilityBlockId = json['facility_block_id'];
    facilityUnitId = json['facility_unit_id'];
    issueIdAuto = json['issue_id_auto'];
    issueType = json['issue_type'];
    locationTagId = json['location_tag_id'];
    clientId = json['client_id'];
    priority = json['priority'];
    creamUnit = json['cream_unit'];
    unitSpecific = json['unit_specific'];
    contracted = json['contracted'];
    status = json['status'];
    clientAcknowledgeRequire = json['client_acknowledge_require'];
    clientAcknowledgeSent = json['client_acknowledge_sent'];
    clientAcknowledgeSentDate = json['client_acknowledge_sent_date'];
    proceedWo = json['proceed_wo'];
    clientAcknowledged = json['client_acknowledged'];
    clientAcknowledgedDate = json['client_acknowledged_date'];
    issueCreatedFrom = json['issue_created_from'];
    issueCreatedBy = json['issue_created_by'];
    issueCreatedById = json['issue_created_by_id'];
    issueRaisedBy = json['issue_raised_by'];
    tenantName = json['tenant_name'];
    tenantFinNo = json['tenant_fin_no'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    updatedBy = json['updated_by'] != null
        ? CreatedBy.fromJson(json['updated_by'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    workOrdersCount = json['work_orders_count'];
    facility =
        json['facility'] != null ? Facility.fromJson(json['facility']) : null;
    block = json['block'] != null ? Block.fromJson(json['block']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['items'] != null) {
      items = <IssueItem>[];
      json['items'].forEach((v) {
        items!.add(IssueItem.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    locationTag = json['location_tag'] != null
        ? LocationTag.fromJson(json['location_tag'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facility_id'] = facilityId;
    data['facility_block_id'] = facilityBlockId;
    data['facility_unit_id'] = facilityUnitId;
    data['issue_id_auto'] = issueIdAuto;
    data['issue_type'] = issueType;
    data['location_tag_id'] = locationTagId;
    data['client_id'] = clientId;
    data['priority'] = priority;
    data['cream_unit'] = creamUnit;
    data['unit_specific'] = unitSpecific;
    data['contracted'] = contracted;
    data['status'] = status;
    data['client_acknowledge_require'] = clientAcknowledgeRequire;
    data['client_acknowledge_sent'] = clientAcknowledgeSent;
    data['client_acknowledge_sent_date'] = clientAcknowledgeSentDate;
    data['proceed_wo'] = proceedWo;
    data['client_acknowledged'] = clientAcknowledged;
    data['client_acknowledged_date'] = clientAcknowledgedDate;
    data['issue_created_from'] = issueCreatedFrom;
    data['issue_created_by'] = issueCreatedBy;
    data['issue_created_by_id'] = issueCreatedById;
    data['issue_raised_by'] = issueRaisedBy;
    data['tenant_name'] = tenantName;
    data['tenant_fin_no'] = tenantFinNo;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['work_orders_count'] = workOrdersCount;
    if (facility != null) {
      data['facility'] = facility!.toJson();
    }
    if (block != null) {
      data['block'] = block!.toJson();
    }
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (locationTag != null) {
      data['location_tag'] = locationTag!.toJson();
    }
    return data;
  }
}

class CreatedBy {
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

  CreatedBy(
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

  CreatedBy.fromJson(Map<String, dynamic> json) {
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

class Facility {
  int? id;
  String? name;
  String? type;
  String? onefmFacilityInternalId;
  int? createdBy;
  int? updatedBy;
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

class IssueItems {
  int? id;
  int? issueId;
  String? item;
  int? areaId;
  String? issueType;
  int? assetId;
  int? quantity;
  String? charge;
  String? remarks;
  int? clientAcknowledged;
  dynamic clientAcknowledgedDate;
  String? status;
  String? doneBy;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  IssueItems(
      {this.id,
      this.issueId,
      this.item,
      this.areaId,
      this.issueType,
      this.assetId,
      this.quantity,
      this.charge,
      this.remarks,
      this.clientAcknowledged,
      this.clientAcknowledgedDate,
      this.status,
      this.doneBy,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  IssueItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    issueId = json['issue_id'];
    item = json['item'];
    areaId = json['area_id'];
    issueType = json['issue_type'];
    assetId = json['asset_id'];
    quantity = json['quantity'];
    charge = json['charge'];
    remarks = json['remarks'];
    clientAcknowledged = json['client_acknowledged'];
    clientAcknowledgedDate = json['client_acknowledged_date'];
    status = json['status'];
    doneBy = json['done_by'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['issue_id'] = issueId;
    data['item'] = item;
    data['area_id'] = areaId;
    data['issue_type'] = issueType;
    data['asset_id'] = assetId;
    data['quantity'] = quantity;
    data['charge'] = charge;
    data['remarks'] = remarks;
    data['client_acknowledged'] = clientAcknowledged;
    data['client_acknowledged_date'] = clientAcknowledgedDate;
    data['status'] = status;
    data['done_by'] = doneBy;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Photos {
  int? id;
  int? issueId;
  int? issueItemId;
  String? photoPath;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Photos(
      {this.id,
      this.issueId,
      this.issueItemId,
      this.photoPath,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    issueId = json['issue_id'];
    issueItemId = json['issue_item_id'];
    photoPath = json['photo_path'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['issue_id'] = issueId;
    data['issue_item_id'] = issueItemId;
    data['photo_path'] = photoPath;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? companyName;
  String? email;
  String? netsuiteClientId;
  String? phone;
  dynamic mobile;
  String? address;
  dynamic mailingAddress;
  dynamic operationPersonName;
  dynamic operationPhone;
  dynamic operationMobile;
  String? operationEmail;
  dynamic accountPersonName;
  dynamic accountPhone;
  dynamic accountMobile;
  String? accountEmail;
  dynamic directorPersonName;
  dynamic directorPhone;
  dynamic directorMobile;
  String? directorEmail;
  int? status;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? updatedAt;

  Client(
      {this.id,
      this.name,
      this.companyName,
      this.email,
      this.netsuiteClientId,
      this.phone,
      this.mobile,
      this.address,
      this.mailingAddress,
      this.operationPersonName,
      this.operationPhone,
      this.operationMobile,
      this.operationEmail,
      this.accountPersonName,
      this.accountPhone,
      this.accountMobile,
      this.accountEmail,
      this.directorPersonName,
      this.directorPhone,
      this.directorMobile,
      this.directorEmail,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    netsuiteClientId = json['netsuite_client_id'];
    phone = json['phone'];
    mobile = json['mobile'];
    address = json['address'];
    mailingAddress = json['mailing_address'];
    operationPersonName = json['operation_person_name'];
    operationPhone = json['operation_phone'];
    operationMobile = json['operation_mobile'];
    operationEmail = json['operation_email'];
    accountPersonName = json['account_person_name'];
    accountPhone = json['account_phone'];
    accountMobile = json['account_mobile'];
    accountEmail = json['account_email'];
    directorPersonName = json['director_person_name'];
    directorPhone = json['director_phone'];
    directorMobile = json['director_mobile'];
    directorEmail = json['director_email'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['netsuite_client_id'] = netsuiteClientId;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['address'] = address;
    data['mailing_address'] = mailingAddress;
    data['operation_person_name'] = operationPersonName;
    data['operation_phone'] = operationPhone;
    data['operation_mobile'] = operationMobile;
    data['operation_email'] = operationEmail;
    data['account_person_name'] = accountPersonName;
    data['account_phone'] = accountPhone;
    data['account_mobile'] = accountMobile;
    data['account_email'] = accountEmail;
    data['director_person_name'] = directorPersonName;
    data['director_phone'] = directorPhone;
    data['director_mobile'] = directorMobile;
    data['director_email'] = directorEmail;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class LocationTag {
  int? id;
  String? name;
  int? facilityId;
  int? facilityBlockId;
  int? facilityFloorId;
  int? facilityUnitId;
  String? qrcode;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  LocationTag(
      {this.id,
      this.name,
      this.facilityId,
      this.facilityBlockId,
      this.facilityFloorId,
      this.facilityUnitId,
      this.qrcode,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  LocationTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    facilityId = json['facility_id'];
    facilityBlockId = json['facility_block_id'];
    facilityFloorId = json['facility_floor_id'];
    facilityUnitId = json['facility_unit_id'];
    qrcode = json['qrcode'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['facility_id'] = facilityId;
    data['facility_block_id'] = facilityBlockId;
    data['facility_floor_id'] = facilityFloorId;
    data['facility_unit_id'] = facilityUnitId;
    data['qrcode'] = qrcode;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
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
