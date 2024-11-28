import 'package:flutter/material.dart';
import 'package:realestate/common/data-models/server-response.model.dart';
import 'package:realestate/common/widgets/common/app-loader-utils.dart';
import 'package:realestate/common/widgets/common/notification-utils.random.dart';
import 'package:realestate/constant/messages.dart';

class BaseViewModel extends ChangeNotifier {
  Future<bool> performAPIAction({
    required Future<ServerResponse> Function() action,
    bool showSuccessToast = true,
    bool showErrorToast = true,
  }) async {
    try {
      AppLoaderUtil.showSecondaryLoading(defaultLoadingMessage);
      var response = await action();
      AppLoaderUtil.dismiss();
      showSuccessToast ? NotificationUtil.toast(response.msg.toString()) : null;
      return response.status == 'success' ? true : false;
    } catch (e) {
      AppLoaderUtil.dismiss();
      showErrorToast
          ? NotificationUtil.toast(e.toString(), isError: true)
          : null;

      return false;
    }
  }
}
