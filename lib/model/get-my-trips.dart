class GetMyTrips {
  bool status;
  String errNum;
  String msg;
  Trip data;

  GetMyTrips({this.status, this.errNum, this.msg, this.data});

  GetMyTrips.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Trip.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Trip {
  int currentPage;
  List<Trips> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Links> links;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Trip(
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

  Trip.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Trips>();
      json['data'].forEach((v) {
        data.add(new Trips.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Trips {
  int id;
  String masafrId;
  String typeOfTrips;
  String typeOfServices;
  String onlyWomen;
  String fromPlace;
  String fromLongitude;
  String fromLatitude;
  String toPlace;
  String toLongitude;
  String toLatitude;
  String startDate;
  String endDate;
  String description;
  String active;
  String onProgress;
  String createdAt;
  String updatedAt;

  Trips(
      {this.id,
        this.masafrId,
        this.typeOfTrips,
        this.typeOfServices,
        this.onlyWomen,
        this.fromPlace,
        this.fromLongitude,
        this.fromLatitude,
        this.toPlace,
        this.toLongitude,
        this.toLatitude,
        this.startDate,
        this.endDate,
        this.description,
        this.active,
        this.onProgress,
        this.createdAt,
        this.updatedAt});

  Trips.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    masafrId = json['masafr_id'];
    typeOfTrips = json['type_of_trips'];
    typeOfServices = json['type_of_services'];
    onlyWomen = json['only_women'];
    fromPlace = json['from_place'];
    fromLongitude = json['from_longitude'];
    fromLatitude = json['from_latitude'];
    toPlace = json['to_place'];
    toLongitude = json['to_longitude'];
    toLatitude = json['to_latitude'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    active = json['active'];
    onProgress = json['on_progress'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['masafr_id'] = this.masafrId;
    data['type_of_trips'] = this.typeOfTrips;
    data['type_of_services'] = this.typeOfServices;
    data['only_women'] = this.onlyWomen;
    data['from_place'] = this.fromPlace;
    data['from_longitude'] = this.fromLongitude;
    data['from_latitude'] = this.fromLatitude;
    data['to_place'] = this.toPlace;
    data['to_longitude'] = this.toLongitude;
    data['to_latitude'] = this.toLatitude;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['active'] = this.active;
    data['on_progress'] = this.onProgress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String url;
  String label;
  bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}