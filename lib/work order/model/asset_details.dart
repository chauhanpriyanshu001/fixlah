class AssetDetails {
  bool? success;
  Data? data;

  AssetDetails({this.success, this.data});

  AssetDetails.fromJson(Map<String, dynamic> json) {
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
  String? supplierId;
  dynamic locationIdData;
  dynamic businessTypeIdData;
  dynamic clientAssetNameId;
  String? imsInternalAssetId;
  String? name;
  String? sku;
  String? clientShownName;
  dynamic unit;
  dynamic purchasePrice;
  int? openStock;
  dynamic openStockValue;
  int? stockUsed;
  int? reorderLevel;
  dynamic vendorId;
  dynamic manufacturerId;
  dynamic brand;
  String? sellingPrice;
  dynamic purchaseDate;
  dynamic expiryDate;
  dynamic warrantyPeriod;
  dynamic image;
  dynamic description;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Facility? facility;

  Data(
      {this.id,
      this.referenceUuid,
      this.facilityId,
      this.supplierId,
      this.locationIdData,
      this.businessTypeIdData,
      this.clientAssetNameId,
      this.imsInternalAssetId,
      this.name,
      this.sku,
      this.clientShownName,
      this.unit,
      this.purchasePrice,
      this.openStock,
      this.openStockValue,
      this.stockUsed,
      this.reorderLevel,
      this.vendorId,
      this.manufacturerId,
      this.brand,
      this.sellingPrice,
      this.purchaseDate,
      this.expiryDate,
      this.warrantyPeriod,
      this.image,
      this.description,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.facility});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    facilityId = json['facility_id'];
    supplierId = json['supplier_id'];
    locationIdData = json['location_id_data'];
    businessTypeIdData = json['business_type_id_data'];
    clientAssetNameId = json['client_asset_name_id'];
    imsInternalAssetId = json['ims_internal_asset_id'];
    name = json['name'];
    sku = json['sku'];
    clientShownName = json['client_shown_name'];
    unit = json['unit'];
    purchasePrice = json['purchase_price'];
    openStock = json['open_stock'];
    openStockValue = json['open_stock_value'];
    stockUsed = json['stock_used'];
    reorderLevel = json['reorder_level'];
    vendorId = json['vendor_id'];
    manufacturerId = json['manufacturer_id'];
    brand = json['brand'];
    sellingPrice = json['selling_price'];
    purchaseDate = json['purchase_date'];
    expiryDate = json['expiry_date'];
    warrantyPeriod = json['warranty_period'];
    image = json['image'];
    description = json['description'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    facility = json['facility'] != null
        ? new Facility.fromJson(json['facility'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['facility_id'] = this.facilityId;
    data['supplier_id'] = this.supplierId;
    data['location_id_data'] = this.locationIdData;
    data['business_type_id_data'] = this.businessTypeIdData;
    data['client_asset_name_id'] = this.clientAssetNameId;
    data['ims_internal_asset_id'] = this.imsInternalAssetId;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['client_shown_name'] = this.clientShownName;
    data['unit'] = this.unit;
    data['purchase_price'] = this.purchasePrice;
    data['open_stock'] = this.openStock;
    data['open_stock_value'] = this.openStockValue;
    data['stock_used'] = this.stockUsed;
    data['reorder_level'] = this.reorderLevel;
    data['vendor_id'] = this.vendorId;
    data['manufacturer_id'] = this.manufacturerId;
    data['brand'] = this.brand;
    data['selling_price'] = this.sellingPrice;
    data['purchase_date'] = this.purchaseDate;
    data['expiry_date'] = this.expiryDate;
    data['warranty_period'] = this.warrantyPeriod;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.facility != null) {
      data['facility'] = this.facility!.toJson();
    }
    return data;
  }
}

class Facility {
  int? id;
  String? referenceUuid;
  String? name;
  int? sortOrder;
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
      this.sortOrder,
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
    sortOrder = json['sort_order'];
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
    data['sort_order'] = this.sortOrder;
    data['type'] = this.type;
    data['onefm_facility_internal_id'] = this.onefmFacilityInternalId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
