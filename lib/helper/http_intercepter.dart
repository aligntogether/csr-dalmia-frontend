  import 'package:dalmia/helper/sharedpref.dart';
  import 'package:http_interceptor/http_interceptor.dart';
  import 'package:http_interceptor/models/interceptor_contract.dart';

  import '../Constants/constants.dart';

  class HttpInterceptor implements InterceptorContract {
    //
    // @override
    // Future<RequestData> interceptRequest({required RequestData data}) async {
    //   try {
    //     data.headers["X-Access-Token"] = 'your_access_token';
    //   } catch (e) {
    //     print(e);
    //   }
    //   return data;
    // }
    //
    // @override
    // Future<ResponseData> interceptResponse({required ResponseData data}) async => data;
    //
    // @override
    // Future<bool> shouldInterceptRequest() {
    //   // TODO: implement shouldInterceptRequest
    //   throw UnimplementedError();
    // }

    @override
    Future<bool> shouldInterceptResponse() async{

      // TODO: implement shouldInterceptResponse
      return true;
    }

    @override
    Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
      // TODO: implement interceptRequest
      String token= await SharedPrefHelper.getSharedPref(ACCESS_TOKEN_SHAREDPREF_KEY, null, false);
      request.headers["X-Access-Token"] = token;
      print("token is $token");
      return request;
    }

    @override
    Future<BaseResponse> interceptResponse({required BaseResponse response})async {

      // TODO: implement interceptResponse

      return response;
    }

    @override
    Future<bool> shouldInterceptRequest() async{
      // TODO: implement shouldInterceptRequest
      return true;
    }
  }

