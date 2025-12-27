class IssueDetails {
  bool? success;
  Data? data;

  IssueDetails({this.success, this.data});

  IssueDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? referenceUuid;
  int? facilityId;
  int? facilityBlockId;
  int? facilityUnitId;
  String? issueIdAuto;
  dynamic fixlahIssueId;
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
  dynamic clientAcknowledgeSentDate;
  int? proceedWo;
  int? clientAcknowledged;
  dynamic clientAcknowledgedDate;
  dynamic issueCreatedFrom;
  dynamic issueCreatedBy;
  dynamic issueCreatedById;
  String? issueRaisedBy;
  dynamic tenantName;
  dynamic tenantFinNo;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  bool? externalSent;
  dynamic externalResponse;
  int? externalAttempts;
  String? externalLastError;
  dynamic externalSentAt;
  double? daysSinceCreated;
  Facility? facility;
  Block? block;
  Unit? unit;
  Client? client;
  LocationTag? locationTag;
  List<Items>? items;

  Data(
      {this.id,
      this.referenceUuid,
      this.facilityId,
      this.facilityBlockId,
      this.facilityUnitId,
      this.issueIdAuto,
      this.fixlahIssueId,
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
      this.externalSent,
      this.externalResponse,
      this.externalAttempts,
      this.externalLastError,
      this.externalSentAt,
      this.daysSinceCreated,
      this.facility,
      this.block,
      this.unit,
      this.client,
      this.locationTag,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    facilityId = json['facility_id'];
    facilityBlockId = json['facility_block_id'];
    facilityUnitId = json['facility_unit_id'];
    issueIdAuto = json['issue_id_auto'];
    fixlahIssueId = json['fixlah_issue_id'];
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
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    externalSent = json['external_sent'];
    externalResponse = json['external_response'];
    externalAttempts = json['external_attempts'];
    externalLastError = json['external_last_error'];
    externalSentAt = json['external_sent_at'];
    daysSinceCreated = json['days_since_created'];
    facility = json['facility'] != null
        ? new Facility.fromJson(json['facility'])
        : null;
    block = json['block'] != null ? new Block.fromJson(json['block']) : null;
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    locationTag = json['location_tag'] != null
        ? new LocationTag.fromJson(json['location_tag'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['facility_id'] = this.facilityId;
    data['facility_block_id'] = this.facilityBlockId;
    data['facility_unit_id'] = this.facilityUnitId;
    data['issue_id_auto'] = this.issueIdAuto;
    data['fixlah_issue_id'] = this.fixlahIssueId;
    data['issue_type'] = this.issueType;
    data['location_tag_id'] = this.locationTagId;
    data['client_id'] = this.clientId;
    data['priority'] = this.priority;
    data['cream_unit'] = this.creamUnit;
    data['unit_specific'] = this.unitSpecific;
    data['contracted'] = this.contracted;
    data['status'] = this.status;
    data['client_acknowledge_require'] = this.clientAcknowledgeRequire;
    data['client_acknowledge_sent'] = this.clientAcknowledgeSent;
    data['client_acknowledge_sent_date'] = this.clientAcknowledgeSentDate;
    data['proceed_wo'] = this.proceedWo;
    data['client_acknowledged'] = this.clientAcknowledged;
    data['client_acknowledged_date'] = this.clientAcknowledgedDate;
    data['issue_created_from'] = this.issueCreatedFrom;
    data['issue_created_by'] = this.issueCreatedBy;
    data['issue_created_by_id'] = this.issueCreatedById;
    data['issue_raised_by'] = this.issueRaisedBy;
    data['tenant_name'] = this.tenantName;
    data['tenant_fin_no'] = this.tenantFinNo;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['external_sent'] = this.externalSent;
    data['external_response'] = this.externalResponse;
    data['external_attempts'] = this.externalAttempts;
    data['external_last_error'] = this.externalLastError;
    data['external_sent_at'] = this.externalSentAt;
    data['days_since_created'] = this.daysSinceCreated;
    if (this.facility != null) {
      data['facility'] = this.facility!.toJson();
    }
    if (this.block != null) {
      data['block'] = this.block!.toJson();
    }
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.locationTag != null) {
      data['location_tag'] = this.locationTag!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Facility {
  int? id;
  String? referenceUuid;
  String? name;
  String? type;
  String? onefmFacilityInternalId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Facility(
      {this.id,
      this.referenceUuid,
      this.name,
      this.type,
      this.onefmFacilityInternalId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Facility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    name = json['name'];
    type = json['type'];
    onefmFacilityInternalId = json['onefm_facility_internal_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['name'] = this.name;
    data['type'] = this.type;
    data['onefm_facility_internal_id'] = this.onefmFacilityInternalId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Block {
  int? id;
  String? referenceUuid;
  int? facilityId;
  String? name;
  String? onefmBlockInternalId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Block(
      {this.id,
      this.referenceUuid,
      this.facilityId,
      this.name,
      this.onefmBlockInternalId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Block.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    facilityId = json['facility_id'];
    name = json['name'];
    onefmBlockInternalId = json['onefm_block_internal_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['facility_id'] = this.facilityId;
    data['name'] = this.name;
    data['onefm_block_internal_id'] = this.onefmBlockInternalId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Unit {
  int? id;
  String? referenceUuid;
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
      this.referenceUuid,
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
    referenceUuid = json['reference_uuid'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['facility_id'] = this.facilityId;
    data['facility_block_id'] = this.facilityBlockId;
    data['facility_floor_id'] = this.facilityFloorId;
    data['unit_no'] = this.unitNo;
    data['onefm_unit_internal_id'] = this.onefmUnitInternalId;
    data['cream_unit'] = this.creamUnit;
    data['contract_unit'] = this.contractUnit;
    data['occupied'] = this.occupied;
    data['qrcode'] = this.qrcode;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Client {
  int? id;
  String? referenceUuid;
  String? name;
  dynamic onefmClientInternalId;
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
      this.referenceUuid,
      this.name,
      this.onefmClientInternalId,
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
    referenceUuid = json['reference_uuid'];
    name = json['name'];
    onefmClientInternalId = json['onefm_client_internal_id'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['name'] = this.name;
    data['onefm_client_internal_id'] = this.onefmClientInternalId;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['netsuite_client_id'] = this.netsuiteClientId;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['mailing_address'] = this.mailingAddress;
    data['operation_person_name'] = this.operationPersonName;
    data['operation_phone'] = this.operationPhone;
    data['operation_mobile'] = this.operationMobile;
    data['operation_email'] = this.operationEmail;
    data['account_person_name'] = this.accountPersonName;
    data['account_phone'] = this.accountPhone;
    data['account_mobile'] = this.accountMobile;
    data['account_email'] = this.accountEmail;
    data['director_person_name'] = this.directorPersonName;
    data['director_phone'] = this.directorPhone;
    data['director_mobile'] = this.directorMobile;
    data['director_email'] = this.directorEmail;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LocationTag {
  int? id;
  String? referenceUuid;
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
      this.referenceUuid,
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
    referenceUuid = json['reference_uuid'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['name'] = this.name;
    data['facility_id'] = this.facilityId;
    data['facility_block_id'] = this.facilityBlockId;
    data['facility_floor_id'] = this.facilityFloorId;
    data['facility_unit_id'] = this.facilityUnitId;
    data['qrcode'] = this.qrcode;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Items {
  int? id;
  String? referenceUuid;
  int? issueId;
  String? item;
  int? areaId;
  String? issueType;
  dynamic assetId;
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
  List<Photos>? photos;
  dynamic workOrder;

  Items(
      {this.id,
      this.referenceUuid,
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
      this.updatedAt,
      this.photos,
      this.workOrder});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
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
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    workOrder = json['work_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['issue_id'] = this.issueId;
    data['item'] = this.item;
    data['area_id'] = this.areaId;
    data['issue_type'] = this.issueType;
    data['asset_id'] = this.assetId;
    data['quantity'] = this.quantity;
    data['charge'] = this.charge;
    data['remarks'] = this.remarks;
    data['client_acknowledged'] = this.clientAcknowledged;
    data['client_acknowledged_date'] = this.clientAcknowledgedDate;
    data['status'] = this.status;
    data['done_by'] = this.doneBy;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['work_order'] = this.workOrder;
    return data;
  }
}

class Photos {
  int? id;
  String? referenceUuid;
  int? issueId;
  int? issueItemId;
  String? photoPath;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? photoUrl;

  Photos(
      {this.id,
      this.referenceUuid,
      this.issueId,
      this.issueItemId,
      this.photoPath,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    issueId = json['issue_id'];
    issueItemId = json['issue_item_id'];
    photoPath = json['photo_path'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['issue_id'] = this.issueId;
    data['issue_item_id'] = this.issueItemId;
    data['photo_path'] = this.photoPath;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}
