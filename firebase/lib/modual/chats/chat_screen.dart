import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/model/social_user/social_user.dart';
import 'package:firebase/modual/chat_details/chat_details_screen.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        if (SocialCubit.get(context).allUsers.length > 0)
          return ListView.separated(
              itemBuilder: (context,index){
                return chatItem(context,SocialCubit.get(context).allUsers[index]);
              },
              separatorBuilder: (context,index){
                return Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]
                  ),
                );
              },
              itemCount: SocialCubit.get(context).allUsers.length
          );
        else
          return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget chatItem(context,SocialUserModel model) =>
     InkWell(
       onTap: (){
         navigate(context,ChatDetailsScreen(model));
       },
       child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.image!),
              radius: 25,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            height: 1.4
                        ),
                      ),
                      SizedBox(width: 5.0,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
    ),
     );

}
 