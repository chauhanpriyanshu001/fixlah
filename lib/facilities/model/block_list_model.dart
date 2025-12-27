class BlockResponse {
  int? id;
  int? facilityId;
  String? name;
  String? onefmBlockInternalId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<Floors>? floors;

  BlockResponse(
      {this.id,
      this.facilityId,
      this.name,
      this.onefmBlockInternalId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.floors});

  BlockResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    name = json['name'];
    onefmBlockInternalId = json['onefm_block_internal_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['floors'] != null) {
      floors = <Floors>[];
      json['floors'].forEach((v) {
        floors!.add(Floors.fromJson(v));
      });
    }
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
    if (floors != null) {
      data['floors'] = floors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Floors {
  int? id;
  int? facilityId;
  int? facilityBlockId;
  String? name;
  String? onefmFloorInternalId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<Units>? units;

  Floors(
      {this.id,
      this.facilityId,
      this.facilityBlockId,
      this.name,
      this.onefmFloorInternalId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.units});

  Floors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityId = json['facility_id'];
    facilityBlockId = json['facility_block_id'];
    name = json['name'];
    onefmFloorInternalId = json['onefm_floor_internal_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facility_id'] = facilityId;
    data['facility_block_id'] = facilityBlockId;
    data['name'] = name;
    data['onefm_floor_internal_id'] = onefmFloorInternalId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Units {
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

  Units(
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

  Units.fromJson(Map<String, dynamic> json) {
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
