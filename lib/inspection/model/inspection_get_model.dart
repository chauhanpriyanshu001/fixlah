class InspectionGetData {
  bool? success;
  Data? data;

  InspectionGetData({this.success, this.data});

  InspectionGetData.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? inspectionCode;
  int? inspectionTemplateId;
  int? facilityId;
  int? facilityBlockId;
  int? facilityUnitId;
  String? inspectionDate;
  dynamic clientId;
  int? contracted;
  int? cream;
  String? unitSpecific;
  String? status;
  String? startedAt;
  dynamic completedAt;
  dynamic completedVia;
  dynamic completedUserAgent;
  dynamic completedIp;
  dynamic completedMode;
  dynamic reportPath;
  String? reportStatus;
  dynamic reportGeneratedAt;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  InspectionTemplate? inspectionTemplate;
  List<Items>? items;
  List<Signatures>? signatures;
  Facility? facility;
  Block? block;
  Unit? unit;
  dynamic client;

  Data(
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
      this.inspectionTemplate,
      this.items,
      this.signatures,
      this.facility,
      this.block,
      this.unit,
      this.client});

  Data.fromJson(Map<String, dynamic> json) {
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
    inspectionTemplate = json['inspection_template'] != null
        ? InspectionTemplate.fromJson(json['inspection_template'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['signatures'] != null) {
      signatures = <Signatures>[];
      json['signatures'].forEach((v) {
        signatures!.add(Signatures.fromJson(v));
      });
    }
    facility =
        json['facility'] != null ? Facility.fromJson(json['facility']) : null;
    block = json['block'] != null ? Block.fromJson(json['block']) : null;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    client = json['client'];
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
    if (inspectionTemplate != null) {
      data['inspection_template'] = inspectionTemplate!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (signatures != null) {
      data['signatures'] = signatures!.map((v) => v.toJson()).toList();
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
    data['client'] = client;
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
  List<Categories>? categories;

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
      this.updatedAt,
      this.categories});

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
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
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
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  int? inspectionTemplateId;
  String? name;
  int? sortOrder;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
      this.inspectionTemplateId,
      this.name,
      this.sortOrder,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionTemplateId = json['inspection_template_id'];
    name = json['name'];
    sortOrder = json['sort_order'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_template_id'] = inspectionTemplateId;
    data['name'] = name;
    data['sort_order'] = sortOrder;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Items {
  int? id;
  int? inspectionId;
  int? inspectionCategoryId;
  int? inspectionCategoryItemId;
  String? condition;
  String? overallGrade;
  int? overallCompliance;
  String? remarks;
  String? conditionDescription;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Categories? category;
  CategoryItem? categoryItem;
  List<InspectionPhoto>? goodPhotos;
  List<InspectionPhoto>? beforePhotos;
  List<InspectionPhoto>? afterPhotos;

  Items(
      {this.id,
      this.inspectionId,
      this.inspectionCategoryId,
      this.inspectionCategoryItemId,
      this.condition,
      this.overallGrade,
      this.overallCompliance,
      this.remarks,
      this.conditionDescription,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.categoryItem,
      this.goodPhotos,
      this.beforePhotos,
      this.afterPhotos});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionId = json['inspection_id'];
    inspectionCategoryId = json['inspection_category_id'];
    inspectionCategoryItemId = json['inspection_category_item_id'];
    condition = json['condition'];
    overallGrade = json['overall_grade'];
    overallCompliance = json['overall_compliance'];
    remarks = json['remarks'];
    conditionDescription = json['condition_description'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category =
        json['category'] != null ? Categories.fromJson(json['category']) : null;
    categoryItem = json['category_item'] != null
        ? CategoryItem.fromJson(json['category_item'])
        : null;
    if (json['good_photos'] != null) {
      goodPhotos = <InspectionPhoto>[];
      json['good_photos'].forEach((v) {
        goodPhotos!.add(InspectionPhoto.fromJson(v));
      });
    }
    if (json['before_photos'] != null) {
      beforePhotos = <InspectionPhoto>[];
      json['before_photos'].forEach((v) {
        beforePhotos!.add(InspectionPhoto.fromJson(v));
      });
    }
    if (json['after_photos'] != null) {
      afterPhotos = <InspectionPhoto>[];
      json['after_photos'].forEach((v) {
        afterPhotos!.add(InspectionPhoto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_id'] = inspectionId;
    data['inspection_category_id'] = inspectionCategoryId;
    data['inspection_category_item_id'] = inspectionCategoryItemId;
    data['condition'] = condition;
    data['overall_grade'] = overallGrade;
    data['overall_compliance'] = overallCompliance;
    data['remarks'] = remarks;
    data['condition_description'] = conditionDescription;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (categoryItem != null) {
      data['category_item'] = categoryItem!.toJson();
    }
    if (goodPhotos != null) {
      data['good_photos'] = goodPhotos!.map((v) => v.toJson()).toList();
    }
    if (beforePhotos != null) {
      data['before_photos'] = beforePhotos!.map((v) => v.toJson()).toList();
    }
    if (afterPhotos != null) {
      data['after_photos'] = afterPhotos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItem {
  int? id;
  int? inspectionTemplateId;
  int? inspectionCategoryId;
  String? name;
  dynamic referenceImage;
  int? overallGrade;
  int? overallCompliance;

  int? sortOrder;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  dynamic referenceImageUrl;
  List<ReferencePhotos>? referencePhotos;

  CategoryItem(
      {this.id,
      this.inspectionTemplateId,
      this.inspectionCategoryId,
      this.name,
      this.referenceImage,
      this.overallGrade,
      this.overallCompliance,
      this.sortOrder,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.referenceImageUrl,
      this.referencePhotos});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionTemplateId = json['inspection_template_id'];
    inspectionCategoryId = json['inspection_category_id'];
    name = json['name'];
    referenceImage = json['reference_image'];
    overallGrade = json['overall_grade'];
    overallCompliance = json['overall_compliance'];
    sortOrder = json['sort_order'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referenceImageUrl = json['reference_image_url'];
    if (json['reference_photos'] != null) {
      referencePhotos = <ReferencePhotos>[];
      json['reference_photos'].forEach((v) {
        referencePhotos!.add(ReferencePhotos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_template_id'] = inspectionTemplateId;
    data['inspection_category_id'] = inspectionCategoryId;
    data['name'] = name;
    data['reference_image'] = referenceImage;
    data['overall_grade'] = overallGrade;
    data['overall_compliance'] = overallCompliance;
    data['sort_order'] = sortOrder;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reference_image_url'] = referenceImageUrl;
    if (referencePhotos != null) {
      data['reference_photos'] =
          referencePhotos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferencePhotos {
  int? id;
  int? inspectionCategoryItemId;
  String? photoPath;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? photoUrl;

  ReferencePhotos(
      {this.id,
      this.inspectionCategoryItemId,
      this.photoPath,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  ReferencePhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionCategoryItemId = json['inspection_category_item_id'];
    photoPath = json['photo_path'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_category_item_id'] = inspectionCategoryItemId;
    data['photo_path'] = photoPath;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['photo_url'] = photoUrl;
    return data;
  }
}

class InspectionPhoto {
  int? id;
  int? inspectionId;
  String? inspectionItemId;
  String? photoPath;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? photoUrl;

  InspectionPhoto(
      {this.id,
      this.inspectionId,
      this.inspectionItemId,
      this.photoPath,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  InspectionPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionId = json['inspection_id'];
    inspectionItemId = json['inspection_item_id'].toString();
    photoPath = json['photo_path'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_id'] = inspectionId;
    data['inspection_item_id'] = inspectionItemId;
    data['photo_path'] = photoPath;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['photo_url'] = photoUrl;
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

class Signatures {
  int? id;
  int? inspectionId;
  int? userId;
  String? companyRepName;
  String? companyRepDesignation;
  String? companyRepDate;
  dynamic companyRepSignature;
  int? companyUpdatedBy;
  String? companyUpdatedAt;
  dynamic agentRepName;
  dynamic agentRepDesignation;
  dynamic agentRepDate;
  dynamic agentRepSignature;
  dynamic agentUpdatedBy;
  dynamic agentUpdatedAt;
  String? createdAt;
  String? updatedAt;
  dynamic companySignatureUrl;
  dynamic agentSignatureUrl;
  SignedBy? companySignedBy;
  SignedBy? agentSignedBy;

  Signatures(
      {this.id,
      this.inspectionId,
      this.userId,
      this.companyRepName,
      this.companyRepDesignation,
      this.companyRepDate,
      this.companyRepSignature,
      this.companyUpdatedBy,
      this.companyUpdatedAt,
      this.agentRepName,
      this.agentRepDesignation,
      this.agentRepDate,
      this.agentRepSignature,
      this.agentUpdatedBy,
      this.agentUpdatedAt,
      this.createdAt,
      this.updatedAt,
      this.companySignatureUrl,
      this.agentSignatureUrl,
      this.companySignedBy,
      this.agentSignedBy});

  Signatures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionId = json['inspection_id'];
    userId = json['user_id'];
    companyRepName = json['company_rep_name'];
    companyRepDesignation = json['company_rep_designation'];
    companyRepDate = json['company_rep_date'];
    companyRepSignature = json['company_rep_signature'];
    companyUpdatedBy = json['company_updated_by'];
    companyUpdatedAt = json['company_updated_at'];
    agentRepName = json['agent_rep_name'];
    agentRepDesignation = json['agent_rep_designation'];
    agentRepDate = json['agent_rep_date'];
    agentRepSignature = json['agent_rep_signature'];
    agentUpdatedBy = json['agent_updated_by'];
    agentUpdatedAt = json['agent_updated_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companySignatureUrl = json['company_signature_url'];
    agentSignatureUrl = json['agent_signature_url'];
    companySignedBy = json['company_signed_by'] != null
        ? SignedBy.fromJson(json['company_signed_by'])
        : null;
    agentSignedBy = json['agent_signed_by'] != null
        ? SignedBy.fromJson(json['agent_signed_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_id'] = inspectionId;
    data['user_id'] = userId;
    data['company_rep_name'] = companyRepName;
    data['company_rep_designation'] = companyRepDesignation;
    data['company_rep_date'] = companyRepDate;
    data['company_rep_signature'] = companyRepSignature;
    data['company_updated_by'] = companyUpdatedBy;
    data['company_updated_at'] = companyUpdatedAt;
    data['agent_rep_name'] = agentRepName;
    data['agent_rep_designation'] = agentRepDesignation;
    data['agent_rep_date'] = agentRepDate;
    data['agent_rep_signature'] = agentRepSignature;
    data['agent_updated_by'] = agentUpdatedBy;
    data['agent_updated_at'] = agentUpdatedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['company_signature_url'] = companySignatureUrl;
    data['agent_signature_url'] = agentSignatureUrl;
    if (companySignedBy != null) {
      data['company_signed_by'] = companySignedBy!.toJson();
    }
    if (agentSignedBy != null) {
      data['agent_signed_by'] = agentSignedBy!.toJson();
    }

    return data;
  }
}

class SignedBy {
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

  SignedBy(
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

  SignedBy.fromJson(Map<String, dynamic> json) {
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
