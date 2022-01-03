import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/modual/edit_profile/edit_profile.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        var model = SocialCubit.get(context).model;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 130.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(model!.cover!),
                                fit: BoxFit.cover,
                              )
                          ),

                        ),
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(model.image!),
                          radius: 57,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model.name!,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize : 17,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                    model.bio!,
                    style: Theme.of(context).textTheme.caption
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '265',
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Follower',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '1790',
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Add photos',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: (){
                          navigate(context, EditProfile());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: ()async{
                          await FirebaseMessaging.instance.subscribeToTopic(model.uId!);
                        },
                        child: Text('Activate notification')
                    ),
                    OutlinedButton(
                        onPressed: ()async{
                          await FirebaseMessaging.instance.unsubscribeFromTopic(model.uId!);
                        },
                        child: Text('Disable notification')
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
