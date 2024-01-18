part of 'bloc.dart';

class ProfileData {
  late final ProfileModel data;
  late final String status, message;

  ProfileData.fromJson(Map<String, dynamic> json) {
    data = ProfileModel.fromJson(json['data'] ?? []);
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class ProfileModel {
  late final int id, cityId;
  late final String image,
      fullname,
      phone,
      identityNumber,
      iban,
      bankName,
      carLicenceImage,
      carFormImage,
      carInsuranceImage,
      carFrontImage,
      carBackImage,
      carType;
  late final CarModel carModel;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    image = json['image'] ?? "";
    fullname = json['fullname'] ?? "";
    phone = json['phone'] ?? "";
    cityId = json['city_id'] ?? 0;
    identityNumber = json['identity_number'] ?? "";
    iban = json['iban'] ?? "";
    bankName = json['bank_name'] ?? "";
    carLicenceImage = json['car_licence_image'] ?? "";
    carFormImage = json['car_form_image'] ?? "";
    carInsuranceImage = json['car_insurance_image'] ?? "";
    carFrontImage = json['car_front_image'] ?? "";
    carBackImage = json['car_back_image'] ?? "";
    carType = json['car_type'] ?? "";
    carModel = CarModel.fromJson(json['car_model'] ?? {});
  }
}

class CarModel {
  late final int id, brandId;
  late final String name, createdAt, updatedAt;

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    brandId = json['brand_id'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }
}
