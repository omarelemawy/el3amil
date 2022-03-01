class MosafrInformationModel {
  bool status;
  String errNum;
  String msg;
  Data data;

  MosafrInformationModel({this.status, this.errNum, this.msg, this.data});

  MosafrInformationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int id;
  String name;
  String photo;
  String rate;
  String idPhoto;
  String gender;
  String email;
  String countryCode;
  String phone;
  String verificationCode;
  String activeTry;
  String emailVerifiedAt;
  String isVerified;
  String lastTryVerify;
  String lastSendVerifyCode;
  String nationalIdNumber;
  String nationality;
  String carName;
  String carModel;
  String carNumber;
  String carImageEast;
  String carImageWest;
  String carImageNorth;
  String drivingLicensePhoto;
  Null rememberToken;
  String smsNotifications;
  String emailNotifications;
  String balance;
  String trust;
  String createdAt;
  String updatedAt;
  int negativePointsCount;
  int complainsCount;
  int tripCount;

  Data(
      {this.id,
        this.name,
        this.photo,
        this.rate,
        this.idPhoto,
        this.gender,
        this.email,
        this.countryCode,
        this.phone,
        this.verificationCode,
        this.activeTry,
        this.emailVerifiedAt,
        this.isVerified,
        this.lastTryVerify,
        this.lastSendVerifyCode,
        this.nationalIdNumber,
        this.nationality,
        this.carName,
        this.carModel,
        this.carNumber,
        this.carImageEast,
        this.carImageWest,
        this.carImageNorth,
        this.drivingLicensePhoto,
        this.rememberToken,
        this.smsNotifications,
        this.emailNotifications,
        this.balance,
        this.trust,
        this.createdAt,
        this.updatedAt,
        this.negativePointsCount,
        this.complainsCount,
        this.tripCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    rate = json['rate'] == "0" ? "1" : json['rate'];
    idPhoto = json['id_photo'];
    gender = json['gender'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    verificationCode = json['verification_code'];
    activeTry = json['active_try'];
    emailVerifiedAt = json['email_verified_at'];
    isVerified = json['is_verified'];
    lastTryVerify = json['last_try_verify'];
    lastSendVerifyCode = json['last_send_verify_code'];
    nationalIdNumber = json['national_id_number'];
    nationality = json['nationality'];
    carName = json['car_name'];
    carModel = json['car_model'];
    carNumber = json['car_number'];
    carImageEast = json['car_image_east'];
    carImageWest = json['car_image_west'];
    carImageNorth = json['car_image_north'];
    drivingLicensePhoto = json['driving_license_photo'];
    rememberToken = json['remember_token'];
    smsNotifications = json['sms_notifications'];
    emailNotifications = json['email_notifications'];
    balance = json['balance'];
    trust = json['trust'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    negativePointsCount = json['negative_points_count'];
    complainsCount = json['complains_count'];
    tripCount = json['trip_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['rate'] = this.rate;
    data['id_photo'] = this.idPhoto;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['verification_code'] = this.verificationCode;
    data['active_try'] = this.activeTry;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_verified'] = this.isVerified;
    data['last_try_verify'] = this.lastTryVerify;
    data['last_send_verify_code'] = this.lastSendVerifyCode;
    data['national_id_number'] = this.nationalIdNumber;
    data['nationality'] = this.nationality;
    data['car_name'] = this.carName;
    data['car_model'] = this.carModel;
    data['car_number'] = this.carNumber;
    data['car_image_east'] = this.carImageEast;
    data['car_image_west'] = this.carImageWest;
    data['car_image_north'] = this.carImageNorth;
    data['driving_license_photo'] = this.drivingLicensePhoto;
    data['remember_token'] = this.rememberToken;
    data['sms_notifications'] = this.smsNotifications;
    data['email_notifications'] = this.emailNotifications;
    data['balance'] = this.balance;
    data['trust'] = this.trust;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['negative_points_count'] = this.negativePointsCount;
    data['complains_count'] = this.complainsCount;
    data['trip_count'] = this.tripCount;
    return data;
  }
}