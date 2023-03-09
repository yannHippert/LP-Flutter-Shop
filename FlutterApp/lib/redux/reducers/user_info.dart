import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';

UserInfo userInfoReducer(UserInfo userInfo, action) {
  if (action is LoginAction) {
    return UserInfo(email: action.email);
  }

  if (action is LogoutAction) {
    return const UserInfo(email: "");
  }

  return userInfo;
}
