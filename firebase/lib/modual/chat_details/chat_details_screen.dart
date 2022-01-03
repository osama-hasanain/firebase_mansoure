import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/model/social_user/social_user.dart';
import 'package:firebase/shared/styles/colors.dart';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel userModel;
  TextEditingController controller = TextEditingController();
  ChatDetailsScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receivedId: userModel.uId!);
        return BlocConsumer<SocialCubit,SocialState>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = SocialCubit.get(context);
            var messages = SocialCubit.get(context).messages;
            if(messages.isNotEmpty)
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(userModel.image!),),
                      SizedBox(width: 5,),
                      Text(
                          userModel.name!,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 16.0
                          )
                      )
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              if(SocialCubit.get(context).model!.uId!=messages[index].senderId)
                                return messageItem(messages[index].text!);
                              return myMessageItem(messages[index].text!);
                            },
                            separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                            itemCount: messages.length
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(start: 10),
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your text here ..',

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: defualtColor,
                              height: 50,
                              child: MaterialButton(
                                color: defualtColor,
                                minWidth: 1.0,
                                onPressed: (){
                                  if(controller.text.isNotEmpty) {
                                    cubit.sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: controller.text
                                    );
                                    controller.clear();
                                  }
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            else
              return Center(child: CircularProgressIndicator(),);
          },
        );
      }
    );
  }
  Widget messageItem(String message) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  bottomEnd: Radius.circular(10.0),
                )
            ),
            child: Text(message),
          ),
        ),
      );

  Widget myMessageItem(String message) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: BoxDecoration(
                color: defualtColor.withOpacity(.2),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  bottomStart: Radius.circular(10.0),
                )
            ),
            child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
            ),
          ),
        ),
      );

}
