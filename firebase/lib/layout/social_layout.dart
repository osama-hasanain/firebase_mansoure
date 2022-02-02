import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/modual/add_post/add_post.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SocialLayout extends StatefulWidget {

  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){
        if(state is SocialAddPostState){
          navigate(context, AddPost());
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Search),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification),
                ),
                IconButton(
                  onPressed: (){
                    cubit.changeThemeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            body:
            // ConditionalBuilder(
            //   condition: SocialCubit.get(context).model != null,
            //   fallback: (context)=>Center(child: CircularProgressIndicator(),),
            //   builder: (context){
            //     var model = SocialCubit.get(context).model;
            //    return  Column(
            //       children: [
            //         if (!model!.isEmailVerified!)
            //         Container(
            //             color: Colors.amber.withOpacity(.6),
            //             child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 15),
            //                 child: Row(
            //                   children: [
            //                     Icon(Icons.info_outline),
            //                     SizedBox(width: 10,),
            //                     Expanded(
            //                       child: Text('please verify your email'),
            //                     ),
            //                     defaultTextButton(
            //                         text: 'send',
            //                         onPressed: () {
            //                           FirebaseAuth.
            //                           instance.currentUser!.
            //                           sendEmailVerification()
            //                           .then((value){
            //                             showToast(
            //                                 text: 'check email',
            //                                 state: ToastState.WARNING);
            //                           });
            //                         }
            //                     )
            //                   ],
            //                 )
            //             )
            //         )
            //
            //       ],
            //     );
            //   }
            // )
            cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavigationBarIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat),
                    label: 'Chats'
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload),
                    label: 'Post'
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location),
                    label: 'Users'
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting),
                    label: 'Settings'
                ),
              ],
            ),
        );
      },
    );
  }
}
