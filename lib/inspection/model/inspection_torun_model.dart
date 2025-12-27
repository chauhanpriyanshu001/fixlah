// ignore: file_names
class InspectionToRunResponse {
  bool? success;
  Data? data;

  InspectionToRunResponse({this.success, this.data});

  InspectionToRunResponse.fromJson(Map<String, dynamic> json) {
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
  List<InspectionDataItem>? data;
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
      data = <InspectionDataItem>[];
      json['data'].forEach((v) {
        data!.add(InspectionDataItem.fromJson(v));
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

class InspectionDataItem {
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
  int? categoriesCount;
  int? categoriesWithItemsCount;
  bool? canRun;
  Facility? facility;
  List<Categories>? categories;

  InspectionDataItem(
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
      this.categoriesCount,
      this.categoriesWithItemsCount,
      this.canRun,
      this.facility,
      this.categories});

  InspectionDataItem.fromJson(Map<String, dynamic> json) {
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
    categoriesCount = json['categories_count'];
    categoriesWithItemsCount = json['categories_with_items_count'];
    canRun = json['can_run'];
    facility =
        json['facility'] != null ? Facility.fromJson(json['facility']) : null;
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
    data['categories_count'] = categoriesCount;
    data['categories_with_items_count'] = categoriesWithItemsCount;
    data['can_run'] = canRun;
    if (facility != null) {
      data['facility'] = facility!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
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

class Categories {
  int? id;
  int? inspectionTemplateId;
  String? name;
  int? sortOrder;
  int? itemsCount;

  Categories(
      {this.id,
      this.inspectionTemplateId,
      this.name,
      this.sortOrder,
      this.itemsCount});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionTemplateId = json['inspection_template_id'];
    name = json['name'];
    sortOrder = json['sort_order'];
    itemsCount = json['items_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inspection_template_id'] = inspectionTemplateId;
    data['name'] = name;
    data['sort_order'] = sortOrder;
    data['items_count'] = itemsCount;
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
