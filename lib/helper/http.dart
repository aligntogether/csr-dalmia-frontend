import 'package:http_interceptor/http/intercepted_http.dart';

import 'http_intercepter.dart';

final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);
// export http;