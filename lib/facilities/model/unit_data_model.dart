class UnitData {
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

  UnitData(
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

  UnitData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
