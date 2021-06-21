import 'dart:typed_data';

import 'package:cashpoint/src/Models/LogIn.dart';
import 'package:cashpoint/src/Models/RegesterForMobile.dart';
import 'package:cashpoint/src/Models/addCashierModel.dart';
import 'package:cashpoint/src/Models/addPoints.dart';
import 'package:cashpoint/src/Models/advertiseWithUs.dart';
import 'package:cashpoint/src/Models/advertisments.dart';
import 'package:cashpoint/src/Models/allOrders.dart';
import 'package:cashpoint/src/Models/banks.dart';
import 'package:cashpoint/src/Models/cashierModel.dart';
import 'package:cashpoint/src/Models/categories.dart';
import 'package:cashpoint/src/Models/change-language.dart';
import 'package:cashpoint/src/Models/changePasswordCashierModel.dart';
import 'package:cashpoint/src/Models/checkPaidCashier.dart';
import 'package:cashpoint/src/Models/contactUs.dart';
import 'package:cashpoint/src/Models/countriesModel.dart';
import 'package:cashpoint/src/Models/deleteCashierModel.dart';
import 'package:cashpoint/src/Models/deleteNotification.dart';
import 'package:cashpoint/src/Models/forgetPassword.dart';
import 'package:cashpoint/src/Models/generalSlider.dart';
import 'package:cashpoint/src/Models/getAllData.dart';
import 'package:cashpoint/src/Models/getAllDataForClient.dart';
import 'package:cashpoint/src/Models/getGeneralData.dart';
import 'package:cashpoint/src/Models/lastLogin.dart';
import 'package:cashpoint/src/Models/myNotifications.dart';
import 'package:cashpoint/src/Models/myPayments.dart';
import 'package:cashpoint/src/Models/myProfileClient.dart';
import 'package:cashpoint/src/Models/myProfileDataForStore.dart';
import 'package:cashpoint/src/Models/payOffCommisionModel.dart';
import 'package:cashpoint/src/Models/rateOrder.dart';
import 'package:cashpoint/src/Models/readMembershipNum.dart';
import 'package:cashpoint/src/Models/readNotifictionCashier.dart';
import 'package:cashpoint/src/Models/replacePoints.dart';
import 'package:cashpoint/src/Models/resetPassword.dart';
import 'package:cashpoint/src/Models/showOrderModel.dart';
import 'package:cashpoint/src/Models/signUp.dart';
import 'package:cashpoint/src/Models/storeDetails.dart';
import 'package:cashpoint/src/Models/storeSlider.dart';
import 'package:cashpoint/src/Models/stores.dart';
import 'package:cashpoint/src/Models/suggestStore.dart';
import 'package:dio/dio.dart';
import 'package:cashpoint/src/Network/NetworkUtilities.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class ApiProvider {
  var _scafold;
  var context;

  ApiProvider(this._scafold, this.context);



  Future<LogIn> logIn(
      {var phone, var password,var membership_num, var device_token, var type}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "membership_num": membership_num,
      "phone": phone,
      "password": password,
      "device_token": device_token,
      "type": type,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "login",
      body: formData,
      headers: headers,
    );
    return LogIn.fromJson(response.data);
  }

  Future<ForgetPasswordModel> forgetPassword({var phone,var membership_num, var type}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "membership_num": membership_num,
      "type": type,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "forget-password",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }

  Future<ForgetPasswordModel> forgetPasswordForCashier({var phone}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-forget-password",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }


  Future<DeleteCashierModel> deleteCashier({var cashier_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "cashier_id": cashier_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "delete-cashier",
      body: formData,
      headers: headers,
    );
    return DeleteCashierModel.fromJson(response.data);
  }


  Future<DeleteCashierModel> confirmForgetPassworfCashier({var phone,var membership_num,var code}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "membership_num": membership_num,
      "code": code,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-confirm-reset-code",
      body: formData,
      headers: headers,
    );
    return DeleteCashierModel.fromJson(response.data);
  }

  Future<ForgetPasswordModel> phoneVerificationForgetPassword(
      {var phone, var code,var membership_num, var type}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "membership_num": membership_num,
      "code": code,
      "type": type,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "confirm-reset-code",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }

  Future<ForgetPasswordModel> phoneVerificationMobileRegister(
      {var phone, var code, var country_id}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "code": code,
      "country_id": country_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "client-phone-verification",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }


  Future<ResetPasswordModel> resendCodeForPhoneRegister(
      {var phone,var country_id}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "country_id": country_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "client-resend-code",
      body: formData,
      headers: headers,
    );
    return ResetPasswordModel.fromJson(response.data);
  }


  Future<SignUpModel> signUp({
    var name,
    var phone,
    var country_id,
    var password,
    var password_confirmation,
    var terms_conditions,
    var device_token,
    var email,
    var image,
  }) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "name": name,
      "country_id": country_id,
      "password": password,
      "password_confirmation": password_confirmation,
      "terms_conditions": terms_conditions,
      "device_token": device_token,
      "email": email,
      "language": localization.currentLanguage.toString(),
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "client-register",
      body: formData,
      headers: headers,
    );
    return SignUpModel.fromJson(response.data);
  }

  Future<ResetPasswordModel> resetPassword(
      {var phone, var password, var password_confirmation,var membership_num, var type}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "membership_num": membership_num,
      "password": password,
      "password_confirmation": password_confirmation,
      "type": type,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "reset-password",
      body: formData,
      headers: headers,
    );
    return ResetPasswordModel.fromJson(response.data);
  }


  Future<ChangePasswordCashierModel> resetPasswordForCashier(
      {var phone, var password, var password_confirmation}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "password": password,
      "password_confirmation": password_confirmation,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-reset-password",
      body: formData,
      headers: headers,
    );
    return ChangePasswordCashierModel.fromJson(response.data);
  }


  Future<ForgetPasswordModel> changePassword(
      {var current_password, var new_password, var password_confirmation,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "current_password": current_password,
      "new_password": new_password,
      "password_confirmation": password_confirmation,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "change_password",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }




  Future<ForgetPasswordModel> changePhoneNumber(
      {var country_id, var phone, var type,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "country_id": country_id,
      "phone": phone,
      "type": type,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "change-phone-number",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }


  Future<ForgetPasswordModel> sendCodeForChangingPhone(
      {var country_id, var phone, var type,var code ,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "country_id": country_id,
      "phone": phone,
      "type": type,
      "code": code,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "check_code_change_phone",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }

  Future<RegesterForMobileModel> registerForMobile(
      {var phone, var country_id}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
//      "country_id": country_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "client-register-mobile",
      body: formData,
      headers: headers,
    );
    return RegesterForMobileModel.fromJson(response.data);
  }
  //AllDataModel

  Future<AllDataModelForStore> editClintProfile(
      {var name,var email, var image,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "client-edit-profile",
      body: formData,
      headers: headers,
    );
    return AllDataModelForStore.fromJson(response.data);
  }

  Future<AllDataModelForStore> editCashierProfile(
      {var name,var description, var image,var apiToken,var latitude,var longitude}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "name": name,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-edit-profile",
      body: formData,
      headers: headers,
    );
    return AllDataModelForStore.fromJson(response.data);
  }

  Future<AllDataModelForStore> editStoreProfile(
      {var name,var description, var image,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "name": name,
      "description": description,
      "logo": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "store-edit-profile",
      body: formData,
      headers: headers,
    );
    return AllDataModelForStore.fromJson(response.data);
  }

  Future<SuggestStoreModel> suggestStore(
      {var description,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "description": description,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "suggest-store",
      body: formData,
      headers: headers,
    );
    return SuggestStoreModel.fromJson(response.data);
  }



  Future<DeleteNotificationModel> deleteNotification(
      {var notification_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "notification_id": notification_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "delete_Notification",
      body: formData,
      headers: headers,
    );
    return DeleteNotificationModel.fromJson(response.data);
  }

  Future<DeleteNotificationModel> deleteNotificationCashier(
      {var notification_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "notification_id": notification_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-delete_Notification",
      body: formData,
      headers: headers,
    );
    return DeleteNotificationModel.fromJson(response.data);
  }

  Future<ContactUsModel> contactUs(
      {var message,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "message": message,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "contact-us",
      body: formData,
      headers: headers,
    );
    return ContactUsModel.fromJson(response.data);
  }

  Future<AllDataModelForStore> getAllDataForStore({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("get-all-data", headers: headers);
    return AllDataModelForStore.fromJson(response.data);
  }
  Future<AllDataModelForStore> getAllDataForCashier({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("cashier-get-all-data", headers: headers);
    return AllDataModelForStore.fromJson(response.data);
  }

  Future<AllDataModelForClient> getAllDataForClient({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("get-all-data", headers: headers);
    return AllDataModelForClient.fromJson(response.data);
  }

  Future<MyProfileClientModel> getMyProfileClient({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("my-profile", headers: headers);
    return MyProfileClientModel.fromJson(response.data);
  }

  Future<MyProfileDataForStoreModel> getMyProfileStore({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("my-profile", headers: headers);
    return MyProfileDataForStoreModel.fromJson(response.data);
  }

  Future<AllOrdersModel> getAllOrders({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("all-order", headers: headers);
    return AllOrdersModel.fromJson(response.data);
  }

//  Future<ShowOrderModel> showOrder({String apiToken, bool networkError}) async {
//    Map<String, String> headers = {
////      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
//    };
//
//    Response response = await NetworkUtil(_scafold, networkError, context)
//        .get("order", headers: headers);
//    return ShowOrderModel.fromJson(response.data);
//  }

  Future<ShowOrderModel> showOrder(
      {var transaction_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "transaction_id": transaction_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "order",
      body: formData,
      headers: headers,
    );
    return ShowOrderModel.fromJson(response.data);
  }







  Future<AllOrdersModel> getAllOrdersCashier({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("cashier-all-order", headers: headers);
    return AllOrdersModel.fromJson(response.data);
  }


  Future<LastLoginModel> logOutService({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("last-login", headers: headers);
    return LastLoginModel.fromJson(response.data);
  }

  Future<LastLoginModel> logOutServiceCashier({String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };

    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("cashier-last-login", headers: headers);
    return LastLoginModel.fromJson(response.data);
  }


//  Future<LastLoginModel> logOutCashier({String apiToken, bool networkError}) async {
//    Map<String, String> headers = {
////      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
//    };
//
//    Response response = await NetworkUtil(_scafold, networkError, context)
//        .get("cashier-logout", headers: headers);
//    return LastLoginModel.fromJson(response.data);
//  }
  Future<LastLoginModel> logOutCashier(
      {var device_token,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "device_token": device_token,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-logout",
      body: formData,
      headers: headers,
    );
    return LastLoginModel.fromJson(response.data);
  }

//  Future<LastLoginModel> logOut({String apiToken, bool networkError}) async {
//    Map<String, String> headers = {
////      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
//    };
//
//    Response response = await NetworkUtil(_scafold, networkError, context)
//        .get("logout", headers: headers);
//    return LastLoginModel.fromJson(response.data);
//  }

  Future<LastLoginModel> logOut(
      {var device_token,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "device_token": device_token,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "logout",
      body: formData,
      headers: headers,
    );
    return LastLoginModel.fromJson(response.data);
  }



  Future<CountriesModel> getCountries(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("countries", headers: headers);
    return CountriesModel.fromJson(response.data);
  }


  Future<GeneralSliderModel> getGeneralSlider(
      { bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("general-slider", headers: headers);
    return GeneralSliderModel.fromJson(response.data);
  }

  Future<CategoriesModel> getCategories(
      { bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("categories", headers: headers);
    return CategoriesModel.fromJson(response.data);
  }


  Future<NotificationsModel> getNotifications(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("list-notifications", headers: headers);
    return NotificationsModel.fromJson(response.data);
  }

  Future<NotificationsModel> getNotificationsCashier(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("cashier-list-notifications", headers: headers);
    return NotificationsModel.fromJson(response.data);
  }
  Future<ChangeLanguageModel> changeLanguage({
    var apiToken,
    var language,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "language": language,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "change-language",
      body: formData,
      headers: headers,
    );
    return ChangeLanguageModel.fromJson(response.data);
  }


  Future<ChangeLanguageModel> changeLanguageCashier({
    var apiToken,
    var language,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "language": language,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-change-language",
      body: formData,
      headers: headers,
    );
    return ChangeLanguageModel.fromJson(response.data);
  }

  Future<GeneralDataModel> getGeneralData(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("general-data", headers: headers);
    return GeneralDataModel.fromJson(response.data);
  }

  Future<StoreSliderModel> getStoreSlider(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("sliders", headers: headers);
    return StoreSliderModel.fromJson(response.data);
  }

  Future<StoreSliderModel> addImagesToSlider(
      {var image,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    List<MultipartFile> _photos = [];
    for (int i = 0; i < image.length; i++) {
      ByteData byteData = await image[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
          filename: '${image[i].toString()}.jpg');
      _photos.add(multipartFile);
    }
    print(_photos) ;
    FormData formData = FormData.fromMap({
      "image":image.length > 0 ? _photos : null ,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "add-sliders",
      body: formData,
      headers: headers,
    );
    return StoreSliderModel.fromJson(response.data);
  }

  Future<ForgetPasswordModel> deleteImageOfStoreSlider(
      {var image_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "image_id": image_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "delete-slider",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }



  Future<ForgetPasswordModel> deleteAdvertisement(
      {var advertisement_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "advertisement_id": advertisement_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "delete-advertisement",
      body: formData,
      headers: headers,
    );
    return ForgetPasswordModel.fromJson(response.data);
  }

  Future<StoresModel> getAllStoresOfCategory(
      {var latitude,var longitude,var category_id }) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "category_id": category_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "all-stores",
      body: formData,
      headers: headers,
    );
    return StoresModel.fromJson(response.data);
  }

  Future<StoresModel> getStoresOfCategoryWithLat(
      {var latitude,var longitude,var category_id ,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "latitude": latitude,
      "longitude": longitude,
      "category_id": category_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "stores",
      body: formData,
      headers: headers,
    );
    return StoresModel.fromJson(response.data);
  }


  Future<StoreDetailsModel> getStoreDetails(
      {var store_id }) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "store_id": store_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "store",
      body: formData,
      headers: headers,
    );
    return StoreDetailsModel.fromJson(response.data);
  }

  Future<MemberShipModel> readMemberShipNum(
      {var membership_num ,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "membership_num": membership_num,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "store-read-membership-num",
      body: formData,
      headers: headers,
    );
    return MemberShipModel.fromJson(response.data);
  }


  Future<MemberShipModel> readMemberShipNumCashier(
      {var membership_num ,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "membership_num": membership_num,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-read-membership-num",
      body: formData,
      headers: headers,
    );
    return MemberShipModel.fromJson(response.data);
  }

  Future<MemberShipModel> readMemberShipQR(
      {var qrcode ,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "qrcode": qrcode,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "store-read-qrcode",
      body: formData,
      headers: headers,
    );
    return MemberShipModel.fromJson(response.data);
  }

  Future<MemberShipModel> readMemberShipQRCashier(
      {var qrcode ,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "qrcode": qrcode,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-read-qrcode",
      body: formData,
      headers: headers,
    );
    return MemberShipModel.fromJson(response.data);
  }

  Future<AddPointsModel> addPoints(
      {var cash,var user_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "cash": cash,
      "user_id": user_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "add-points",
      body: formData,
      headers: headers,
    );
    return AddPointsModel.fromJson(response.data);
  }

  Future<AddPointsModel> addPointsCashier(
      {var cash,var user_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "cash": cash,
      "user_id": user_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-add-points",
      body: formData,
      headers: headers,
    );
    return AddPointsModel.fromJson(response.data);
  }
  Future<AddPointsModel> confirmAddingPoints(
      {var transaction_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "transaction_id": transaction_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "confirm-transaction",
      body: formData,
      headers: headers,
    );
    return AddPointsModel.fromJson(response.data);
  }


  Future<AddPointsModel> confirmAddingPointsCashier(
      {var transaction_id,var apiToken}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "transaction_id": transaction_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-confirm-transaction",
      body: formData,
      headers: headers,
    );
    return AddPointsModel.fromJson(response.data);
  }


  Future<PayOffCommissionModel> payOffCommission({
    var apiToken,
    var payment_type,
    var image,
    var my_fatoora,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "payment_type": payment_type,
      "my_fatoora": my_fatoora,
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "pay-off-commissions",
      body: formData,
      headers: headers,
    );
    return PayOffCommissionModel.fromJson(response.data);
  }


  Future<CashierModel> getCashiers(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("all-cashier", headers: headers);
    return CashierModel.fromJson(response.data);
  }

  Future<MyPaymentsModel> getMyPayments(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("my-payments", headers: headers);
    return MyPaymentsModel.fromJson(response.data);
  }


  Future<AdvertisementsModel> getAdvertisements(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("advertisements", headers: headers);
    return AdvertisementsModel.fromJson(response.data);
  }

  Future<BanksModel> getBanks(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
//      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("banks", headers: headers);
    return BanksModel.fromJson(response.data);
  }


  Future<ReadNotificationCashier> readNotificationCashier(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("cashier-is-read", headers: headers);
    return ReadNotificationCashier.fromJson(response.data);
  }

  Future<CheckPaidCashier> checkPaidCashier(
      {String apiToken, bool networkError}) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    Response response = await NetworkUtil(_scafold, networkError, context)
        .get("check-value-of-store-commission", headers: headers);
    return CheckPaidCashier.fromJson(response.data);
  }

  Future<AdvertiseWithUsModel> advertiseWithUs({
    var apiToken,
    var link,
    var image,
    var user_id,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "link": link,
      "user_id": user_id,
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "advertise-with-us",
      body: formData,
      headers: headers,
    );
    return AdvertiseWithUsModel.fromJson(response.data);
  }

  Future<AddCashierModel> addCashier({
    var apiToken,
    var phone,
    var image,
    var password,
    var password_confirmation,
    var name,
    var language,
    var description,
    var latitude,
    var longitude,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "password": password,
      "password_confirmation": password_confirmation,
      "name": name,
      "language": language,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "add-cashier",
      body: formData,
      headers: headers,
    );
    return AddCashierModel.fromJson(response.data);
  }


  Future<AddCashierModel> editCashier({
    var apiToken,
    var cashier_id,
    var phone,
    var image,
    var password,
    var password_confirmation,
    var name,
    var language,
    var description,
    var latitude,
    var longitude,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "cashier_id": cashier_id,
      "password": password,
      "password_confirmation": password_confirmation,
      "name": name,
      "language": language,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "image": image == null ? null : await MultipartFile.fromFile(image.path),
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "edit-cashier",
      body: formData,
      headers: headers,
    );
    return AddCashierModel.fromJson(response.data);
  }


  Future<AddCashierModel> cashierLogin({
    var phone,
    var password,
    var device_token,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "phone": phone,
      "password": password,
      "device_token": device_token,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-login",
      body: formData,
      headers: headers,
    );
    return AddCashierModel.fromJson(response.data);
  }

  Future<ReplacePointsModel> replacePoints({
    var apiToken,
    var type,
    var bank_account,
    var bank_id,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "type": type,
      "bank_account": bank_account,
      "bank_id":bank_id,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "replace-points",
      body: formData,
      headers: headers,
    );
    return ReplacePointsModel.fromJson(response.data);
  }

  Future<RateOrderModel> rateOrder({
    var apiToken,
    var transaction_id,
    var rate,
    var description,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "transaction_id": transaction_id,
      "rate": rate,
      "description":description,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "client-rate",
      body: formData,
      headers: headers,
    );
    return RateOrderModel.fromJson(response.data);
  }



  Future<AdvertiseWithUsModel> refundRequest({
    var apiToken,
    var transaction_id,
    var refund_request_reason,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "transaction_id":transaction_id,
      "refund_request_reason":refund_request_reason,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "refund-request",
      body: formData,
      headers: headers,
    );
    return AdvertiseWithUsModel.fromJson(response.data);
  }
  Future<AdvertiseWithUsModel> refundRequestCashier({
    var apiToken,
    var transaction_id,
    var refund_request_reason,
  }) async {
    Map<String, String> headers = {
//      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer " + apiToken,
    };
    FormData formData = FormData.fromMap({
      "transaction_id":transaction_id,
      "refund_request_reason":refund_request_reason,
    });
    Response response = await NetworkUtil(_scafold, true, context).post(
      "cashier-refund-request",
      body: formData,
      headers: headers,
    );
    return AdvertiseWithUsModel.fromJson(response.data);
  }
}
