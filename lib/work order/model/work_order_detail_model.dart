class WorkOrderDetails {
  bool? success;
  Data? data;

  WorkOrderDetails({this.success, this.data});

  WorkOrderDetails.fromJson(Map<String, dynamic> json) {
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
  String? woIdAuto;
  String? woType;
  int? facilityId;
  int? issueId;
  int? issueItemId;
  String? assignedTo;
  String? assigneeVocationType;
  int? assigneeUserId;
  String? description;
  String? expectedEndDate;
  String? expectedEndTime;
  dynamic actualEndDate;
  dynamic actualEndTime;
  String? locationTag;
  int? creamUnit;
  int? contracted;
  int? priority;
  int? unitSpecific;
  String? status;
  int? clientId;
  dynamic completionRemarks;
  dynamic completedBy;
  dynamic completedMode;
  CreatedBy? createdBy;
  CreatedBy? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;
  List<WorkorderPhotos>? workorderPhotos;
  List<WorkorderPhotos>? completionPhotos;
  Facility? facility;
  CreatedBy? assignee;
  Client? client;
  Issue? issue;
  IssueItem? issueItem;

  Data(
      {this.id,
      this.referenceUuid,
      this.woIdAuto,
      this.woType,
      this.facilityId,
      this.issueId,
      this.issueItemId,
      this.assignedTo,
      this.assigneeVocationType,
      this.assigneeUserId,
      this.description,
      this.expectedEndDate,
      this.expectedEndTime,
      this.actualEndDate,
      this.actualEndTime,
      this.locationTag,
      this.creamUnit,
      this.contracted,
      this.priority,
      this.unitSpecific,
      this.status,
      this.clientId,
      this.completionRemarks,
      this.completedBy,
      this.completedMode,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.items,
      this.workorderPhotos,
      this.completionPhotos,
      this.facility,
      this.assignee,
      this.client,
      this.issue,
      this.issueItem});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    woIdAuto = json['wo_id_auto'];
    woType = json['wo_type'];
    facilityId = json['facility_id'];
    issueId = json['issue_id'];
    issueItemId = json['issue_item_id'];
    assignedTo = json['assigned_to'];
    assigneeVocationType = json['assignee_vocation_type'];
    assigneeUserId = json['assignee_user_id'];
    description = json['description'];
    expectedEndDate = json['expected_end_date'];
    expectedEndTime = json['expected_end_time'];
    actualEndDate = json['actual_end_date'];
    actualEndTime = json['actual_end_time'];
    locationTag = json['location_tag'];
    creamUnit = json['cream_unit'];
    contracted = json['contracted'];
    priority = json['priority'];
    unitSpecific = json['unit_specific'];
    status = json['status'];
    clientId = json['client_id'];
    completionRemarks = json['completion_remarks'];
    completedBy = json['completed_by'];
    completedMode = json['completed_mode'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    updatedBy = json['updated_by'] != null
        ? new CreatedBy.fromJson(json['updated_by'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['workorder_photos'] != null) {
      workorderPhotos = <WorkorderPhotos>[];
      json['workorder_photos'].forEach((v) {
        workorderPhotos!.add(new WorkorderPhotos.fromJson(v));
      });
    }
    if (json['completion_photos'] != null) {
      completionPhotos = <WorkorderPhotos>[];
      json['completion_photos'].forEach((v) {
        completionPhotos!.add(new WorkorderPhotos.fromJson(v));
      });
    }
    facility = json['facility'] != null
        ? new Facility.fromJson(json['facility'])
        : null;
    assignee = json['assignee'] != null
        ? new CreatedBy.fromJson(json['assignee'])
        : null;
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    issue = json['issue'] != null ? new Issue.fromJson(json['issue']) : null;
    issueItem = json['issue_item'] != null
        ? new IssueItem.fromJson(json['issue_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['wo_id_auto'] = this.woIdAuto;
    data['wo_type'] = this.woType;
    data['facility_id'] = this.facilityId;
    data['issue_id'] = this.issueId;
    data['issue_item_id'] = this.issueItemId;
    data['assigned_to'] = this.assignedTo;
    data['assignee_vocation_type'] = this.assigneeVocationType;
    data['assignee_user_id'] = this.assigneeUserId;
    data['description'] = this.description;
    data['expected_end_date'] = this.expectedEndDate;
    data['expected_end_time'] = this.expectedEndTime;
    data['actual_end_date'] = this.actualEndDate;
    data['actual_end_time'] = this.actualEndTime;
    data['location_tag'] = this.locationTag;
    data['cream_unit'] = this.creamUnit;
    data['contracted'] = this.contracted;
    data['priority'] = this.priority;
    data['unit_specific'] = this.unitSpecific;
    data['status'] = this.status;
    data['client_id'] = this.clientId;
    data['completion_remarks'] = this.completionRemarks;
    data['completed_by'] = this.completedBy;
    data['completed_mode'] = this.completedMode;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    if (this.updatedBy != null) {
      data['updated_by'] = this.updatedBy!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.workorderPhotos != null) {
      data['workorder_photos'] =
          this.workorderPhotos!.map((v) => v.toJson()).toList();
    }
    if (this.completionPhotos != null) {
      data['completion_photos'] =
          this.completionPhotos!.map((v) => v.toJson()).toList();
    }
    if (this.facility != null) {
      data['facility'] = this.facility!.toJson();
    }
    if (this.assignee != null) {
      data['assignee'] = this.assignee!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.issue != null) {
      data['issue'] = this.issue!.toJson();
    }
    if (this.issueItem != null) {
      data['issue_item'] = this.issueItem!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  int? id;
  String? referenceUuid;
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
      this.referenceUuid,
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
    referenceUuid = json['reference_uuid'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['username'] = this.username;
    data['name'] = this.name;
    data['employee_no'] = this.employeeNo;
    data['joining_date'] = this.joiningDate;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['supervisor_id'] = this.supervisorId;
    data['role_id'] = this.roleId;
    data['vocation_type'] = this.vocationType;
    data['facility_ids'] = this.facilityIds;
    data['employment_type'] = this.employmentType;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Items {
  int? id;
  String? referenceUuid;
  int? workOrderId;
  int? assetId;
  String? sku;
  int? quantity;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
      this.referenceUuid,
      this.workOrderId,
      this.assetId,
      this.sku,
      this.quantity,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    workOrderId = json['work_order_id'];
    assetId = json['asset_id'];
    sku = json['sku'];
    quantity = json['quantity'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['work_order_id'] = this.workOrderId;
    data['asset_id'] = this.assetId;
    data['sku'] = this.sku;
    data['quantity'] = this.quantity;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class WorkorderPhotos {
  int? id;
  String? referenceUuid;
  int? workOrderId;
  String? photoPath;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? photoUrl;

  WorkorderPhotos(
      {this.id,
      this.referenceUuid,
      this.workOrderId,
      this.photoPath,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  WorkorderPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    workOrderId = json['work_order_id'];
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
    data['work_order_id'] = this.workOrderId;
    data['photo_path'] = this.photoPath;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

class Facility {
  int? id;
  String? referenceUuid;
  String? name;
  String? type;
  String? onefmFacilityInternalId;
  dynamic createdBy;
  dynamic updatedBy;
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

class Client {
  int? id;
  String? referenceUuid;
  String? name;
  String? onefmClientInternalId;
  String? companyName;
  String? email;
  String? netsuiteClientId;
  String? phone;
  String? mobile;
  String? address;
  String? mailingAddress;
  String? operationPersonName;
  String? operationPhone;
  String? operationMobile;
  String? operationEmail;
  String? accountPersonName;
  String? accountPhone;
  String? accountMobile;
  String? accountEmail;
  String? directorPersonName;
  String? directorPhone;
  String? directorMobile;
  String? directorEmail;
  int? status;
  int? createdBy;
  int? updatedBy;
  dynamic createdAt;
  dynamic updatedAt;

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

class Issue {
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
  String? externalResponse;
  int? externalAttempts;
  dynamic externalLastError;
  String? externalSentAt;

  Issue(
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
      this.externalSentAt});

  Issue.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class IssueItem {
  int? id;
  String? referenceUuid;
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

  IssueItem(
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
      this.updatedAt});

  IssueItem.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
