import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/modual/social_login/social_login.dart';
import 'package:firebase/provider/themes.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/components/constant.dart';
import 'package:firebase/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'layout/cubit/state.dart';
import 'layout/social_layout.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("onMessage Background: ${message.messageId}");
  showToast(text: 'onMessage Background', state:ToastState.SUCCESS);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print('Token $token');

  FirebaseMessaging.onMessage.listen((event) {
    print('onMessage'+event.data.toString());
    showToast(text: 'onMessage', state:ToastState.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp'+event.data.toString());
    showToast(text: 'onMessageOpenedApp', state:ToastState.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  Widget widget = SocialUserLogin();
  uId = CacheHelper.getDate(key: 'uId');
  if(uId!=null) widget = SocialLayout();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=>SocialCubit()..getUserDate()..getPosts(),
        )
      ],
      child: BlocConsumer<SocialCubit,SocialState>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            home: widget,
          );
        },
      ),
    );
  }
}

