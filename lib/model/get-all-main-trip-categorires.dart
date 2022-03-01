class GetAllMainTripCategorires {
  bool status;
  String errNum;
  String msg;
  List<Data> data;

  GetAllMainTripCategorires({this.status, this.errNum, this.msg, this.data});

  GetAllMainTripCategorires.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String categorieName;
  String photo;
  String title;
  String onlySaudi;
  String active;
  String specialDlivery;
  String twoPlace;
  String weekly;
  String counter;
  String createdAt;
  String updatedAt;
  List<Subsections> subsections;

  Data(
      {this.id,
        this.categorieName,
        this.photo,
        this.title,
        this.onlySaudi,
        this.active,
        this.specialDlivery,
        this.twoPlace,
        this.weekly,
        this.counter,
        this.createdAt,
        this.updatedAt,
        this.subsections});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categorieName = json['categorie_name'];
    photo = json['photo'];
    title = json['title'];
    onlySaudi = json['only_saudi'];
    active = json['active'];
    specialDlivery = json['special_dlivery'];
    twoPlace = json['two_place'];
    weekly = json['weekly'];
    counter = json['counter'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subsections'] != null) {
      subsections = new List<Subsections>();
      json['subsections'].forEach((v) {
        subsections.add(new Subsections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categorie_name'] = this.categorieName;
    data['photo'] = this.photo;
    data['title'] = this.title;
    data['only_saudi'] = this.onlySaudi;
    data['active'] = this.active;
    data['special_dlivery'] = this.specialDlivery;
    data['two_place'] = this.twoPlace;
    data['weekly'] = this.weekly;
    data['counter'] = this.counter;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subsections != null) {
      data['subsections'] = this.subsections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subsections {
  int id;
  String categorieId;
  String sectionName;
  String createdAt;
  String updatedAt;

  Subsections(
      {this.id,
        this.categorieId,
        this.sectionName,
        this.createdAt,
        this.updatedAt});

  Subsections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categorieId = json['categorie_id'];
    sectionName = json['section_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categorie_id'] = this.categorieId;
    data['section_name'] = this.sectionName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}