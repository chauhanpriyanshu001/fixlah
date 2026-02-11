class InspectionCategoryitemData {
  bool? success;
  String? message;
  List<CategoryNewData>? data;

  InspectionCategoryitemData({this.success, this.message, this.data});

  InspectionCategoryitemData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryNewData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryNewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryNewData {
  int? id;
  String? referenceUuid;
  int? inspectionTemplateId;
  String? name;
  int? sortOrder;
  bool? isDeleted;
  dynamic deletedAt;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  CategoryNewData(
      {this.id,
      this.referenceUuid,
      this.inspectionTemplateId,
      this.name,
      this.sortOrder,
      this.isDeleted,
      this.deletedAt,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.items});

  CategoryNewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    inspectionTemplateId = json['inspection_template_id'];
    name = json['name'];
    sortOrder = json['sort_order'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['inspection_template_id'] = this.inspectionTemplateId;
    data['name'] = this.name;
    data['sort_order'] = this.sortOrder;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? referenceUuid;
  int? inspectionTemplateId;
  int? inspectionCategoryId;
  String? name;
  dynamic referenceImage;
  int? overallGrade;
  int? overallCompliance;
  int? sortOrder;
  bool? isDeleted;
  dynamic deletedAt;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  dynamic referenceImageUrl;
  List<ReferencePhotos>? referencePhotos;
  List<RunItems>? runItems;

  Items(
      {this.id,
      this.referenceUuid,
      this.inspectionTemplateId,
      this.inspectionCategoryId,
      this.name,
      this.referenceImage,
      this.overallGrade,
      this.overallCompliance,
      this.sortOrder,
      this.isDeleted,
      this.deletedAt,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.referenceImageUrl,
      this.referencePhotos,
      this.runItems});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    inspectionTemplateId = json['inspection_template_id'];
    inspectionCategoryId = json['inspection_category_id'];
    name = json['name'];
    referenceImage = json['reference_image'];
    overallGrade = json['overall_grade'];
    overallCompliance = json['overall_compliance'];
    sortOrder = json['sort_order'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referenceImageUrl = json['reference_image_url'];
    if (json['reference_photos'] != null) {
      referencePhotos = <ReferencePhotos>[];
      json['reference_photos'].forEach((v) {
        referencePhotos!.add(new ReferencePhotos.fromJson(v));
      });
    }
    if (json['run_items'] != null) {
      runItems = <RunItems>[];
      json['run_items'].forEach((v) {
        runItems!.add(new RunItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['inspection_template_id'] = this.inspectionTemplateId;
    data['inspection_category_id'] = this.inspectionCategoryId;
    data['name'] = this.name;
    data['reference_image'] = this.referenceImage;
    data['overall_grade'] = this.overallGrade;
    data['overall_compliance'] = this.overallCompliance;
    data['sort_order'] = this.sortOrder;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reference_image_url'] = this.referenceImageUrl;
    if (this.referencePhotos != null) {
      data['reference_photos'] =
          this.referencePhotos!.map((v) => v.toJson()).toList();
    }
    if (this.runItems != null) {
      data['run_items'] = this.runItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferencePhotos {
  int? id;
  String? referenceUuid;
  int? inspectionCategoryItemId;
  String? photoPath;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? photoUrl;

  ReferencePhotos(
      {this.id,
      this.referenceUuid,
      this.inspectionCategoryItemId,
      this.photoPath,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  ReferencePhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    inspectionCategoryItemId = json['inspection_category_item_id'];
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
    data['inspection_category_item_id'] = this.inspectionCategoryItemId;
    data['photo_path'] = this.photoPath;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

class RunItems {
  int? id;
  String? referenceUuid;
  int? inspectionId;
  int? inspectionCategoryId;
  int? inspectionCategoryItemId;
  dynamic condition;
  dynamic overallGrade;
  dynamic overallCompliance;
  dynamic remarks;
  dynamic conditionDescription;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<Null>? goodPhotos;
  List<Null>? beforePhotos;
  List<Null>? afterPhotos;

  RunItems(
      {this.id,
      this.referenceUuid,
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
      this.goodPhotos,
      this.beforePhotos,
      this.afterPhotos});

  RunItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
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
    if (json['good_photos'] != null) {
      goodPhotos = <Null>[];
      json['good_photos'].forEach((v) {
        goodPhotos!.add((v));
      });
    }
    if (json['before_photos'] != null) {
      beforePhotos = <Null>[];
      json['before_photos'].forEach((v) {
        beforePhotos!.add((v));
      });
    }
    if (json['after_photos'] != null) {
      afterPhotos = <Null>[];
      json['after_photos'].forEach((v) {
        afterPhotos!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['inspection_id'] = this.inspectionId;
    data['inspection_category_id'] = this.inspectionCategoryId;
    data['inspection_category_item_id'] = this.inspectionCategoryItemId;
    data['condition'] = this.condition;
    data['overall_grade'] = this.overallGrade;
    data['overall_compliance'] = this.overallCompliance;
    data['remarks'] = this.remarks;
    data['condition_description'] = this.conditionDescription;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.goodPhotos != null) {
      data['good_photos'] = this.goodPhotos!.map((v) => v).toList();
    }
    if (this.beforePhotos != null) {
      data['before_photos'] = this.beforePhotos!.map((v) => v).toList();
    }
    if (this.afterPhotos != null) {
      data['after_photos'] = this.afterPhotos!.map((v) => v).toList();
    }
    return data;
  }
}
