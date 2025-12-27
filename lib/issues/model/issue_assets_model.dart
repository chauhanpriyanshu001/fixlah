class ItemAssetsResponse {
  bool? success;
  List<IssueItemData>? data;

  ItemAssetsResponse({this.success, this.data});

  ItemAssetsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <IssueItemData>[];
      json['data'].forEach((v) {
        data!.add(IssueItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IssueItemData {
  int? id;
  int? facilityId;
  String? onefmAssetInternalId;
  String? name;
  String? sku;
  int? openStock;
  int? reorderLevel;
  String? sellingPrice;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Facility? facility;

  IssueItemData(
      {this.id,
      this.facilityId,
      this.onefmAssetInternalId,
      this.name,
      this.sku,
      this.openStock,
      this.reorderLevel,
      this.sellingPrice,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.facility});

  IssueItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    onefmAssetInternalId = json['onefm_asset_internal_id'];
    name = json['name'];
    sku = json['sku'];
    openStock = json['open_stock'];
    reorderLevel = json['reorder_level'];
    sellingPrice = json['selling_price'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    facility =
        json['facility'] != null ? Facility.fromJson(json['facility']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facility_id'] = facilityId;
    data['onefm_asset_internal_id'] = onefmAssetInternalId;
    data['name'] = name;
    data['sku'] = sku;
    data['open_stock'] = openStock;
    data['reorder_level'] = reorderLevel;
    data['selling_price'] = sellingPrice;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (facility != null) {
      data['facility'] = facility!.toJson();
    }
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
