import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/app_widget.dart';
import 'package:portfolio/app/core/repositories/post_repository.dart';
import 'package:portfolio/app/modules/home/home_controller.dart';
import 'package:portfolio/app/modules/login/login_controller.dart';
import 'package:portfolio/app/modules/login/login_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_controller.dart';
import 'modules/home/home_module.dart';
import 'modules/post/post_module.dart';

class AppModule extends MainModule {
  final SharedPreferences sharedPreferences;

  AppModule(this.sharedPreferences);

  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => LoginController()),
        Bind((i) => HomeController(i.get<PostRepository>())),
        Bind((i) => PostRepository(Dio(), AppModule.to.get())),
        Bind((i) => sharedPreferences)
      ];

  @override
  List<Router> get routers => [
        //Router(Modular.initialRoute, module: HomeModule()),
        Router(Modular.initialRoute, module: LoginModule()),
        Router('/home', module: HomeModule()),
        Router('/post', module: PostModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
