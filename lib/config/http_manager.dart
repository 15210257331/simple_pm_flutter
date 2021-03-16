import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simple_pm_flutter/model/base_bean.dart';

/// 基于dio封装HTTP请求

class HttpManager {

  //单例模式
  static HttpManager _instance;
  Dio _dio;
  BaseOptions _options;

  //单例模式，只创建一次实例
  static HttpManager getInstance() {
    if (_instance == null) {
      _instance = new HttpManager();
    }
    return _instance;
  }

  //构造函数
  HttpManager() {
    _options = new BaseOptions(
        //连接时间为5秒
        connectTimeout: 30000,
        //响应时间为3秒
        receiveTimeout: 30000,
        //设置请求头
        // headers: {"resource": "android"},
        //默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: "application/json; charset=utf-8",
        //共有三种方式json,bytes(响应字节),stream（响应流）,plain
        responseType: ResponseType.json
    );
    _dio = new Dio(_options);

    // 设置Cookie 拦截器
    // _dio.interceptors.add(CookieManager(CookieJar()));

    // 打印日志 拦截器
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    // 请求响应 拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          String token = "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJjb20ueGRmLmJsaW5nIiwiYXVkIjoiY2xpZW50IiwidXNlcmNvZGUiOiJjcm1hZG1pbiIsImV4cCI6MTYxNjU2NjY4MiwiaWF0IjoxNjE1MzU3MDgyfQ.Lc7cGT9GFUi1IaoLOrHG0pj5QqTeHkiVabM7q_yhRxGA5HHdaLVETEKJZvwfn_olVVvPUEmWF9m_7dydFZPV-Q";
          options.headers['token'] = token;
          return options;
        },
        onResponse: (Response response) {
          try {
            ///一般只需要处理200的情况，300、400、500保留错误信息
            if (response.statusCode == 200 || response.statusCode == 201) {
              int code = response.data["code"];
              if(code == 10000) {
                response.data = BaseBean.fromJson(response.data);
                return response;
              } else {
                EasyLoading.showError(response.data['msg']);
                Map<String, dynamic> res = {
                  'code': response.data['code'],
                  'msg': response.data['msg'],
                  'data': null
                };
                response.data = BaseBean.fromJson(res);
                return response;
              }
            }
          } catch (e) {
            return response;
          }
        },
        onError: (DioError e) {
          // print("在错误之前的拦截信息");
          return e;
        })
    );
  }

  //get请求方法
  get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      print('getHttp exception: $e');
      formatError(e);
    }
  }

  //post请求
  post(url, {params, body, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.post(url, data: body, queryParameters: params, options: options, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      print('postHttp exception: $e');
      formatError(e);
    }

  }

  //post Form请求
  postForm(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.post(url,
          options: options, cancelToken: cancelToken, data: data);
      print('postHttp response: $response');
    } on DioError catch (e) {
      print('postHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //下载文件
  downLoadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await _dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
            print('$count $total');
          });
      print('downLoadFile response: $response');
    } on DioError catch (e) {
      print('downLoadFile exception: $e');
      formatError(e);
    }
    return response;
  }

  //取消请求
  cancleRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("连接超时");
      EasyLoading.showError('连接超时');
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求超时");
      EasyLoading.showError("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("响应超时");
      EasyLoading.showError("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("出现异常");
      EasyLoading.showError("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求取消");
      EasyLoading.showError("请求取消");
    } else {
      print("未知错误");
      EasyLoading.showError("未知错误");
    }
  }
}