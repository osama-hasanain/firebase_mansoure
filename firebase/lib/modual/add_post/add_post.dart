import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/styles/colors.dart';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPost extends StatelessWidget {
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){
        if(state is SocialCreatePostSuccessState)
          Navigator.pop(context);
      },
      builder: (context,state){
        var model = SocialCubit.get(context).model;
        return Scaffold(
            appBar: defaultAppBar(
                context : context,
                title : 'Create New Post',
                actions: [
                  defaultTextButton(
                      text: 'create',
                      onPressed: () {
                        DateTime now = DateTime.now();
                        if(SocialCubit.get(context).postImage!=null)
                          SocialCubit.get(context).uploadPostImage(
                              dateTime: now.toString(),
                              text: postController.text
                          );
                        else
                          SocialCubit.get(context).createPost(
                              dateTime: now.toString(),
                              text: postController.text
                          );

                      }),
                  SizedBox(width: 10,),
                ]
            ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState || state is SocialUploadPostImageLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState || state is SocialUploadPostImageLoadingState)
                  SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundImage:NetworkImage(model!.image!)
                    ),
                    SizedBox(width: 10,),
                    Text(
                      model.name!,
                      style: Theme.of(context).textTheme.subtitle1
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'whats is on your mind ..',
                    ),
                    controller: postController,
                  ),
                ),
                if(SocialCubit.get(context).postImage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 130.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          )
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        child: CircleAvatar(
                          backgroundColor: defualtColor,
                          radius: 20,
                          child: Icon(
                            IconBroken.Close_Square,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        onTap: (){
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5,),
                            Text('add photo'),
                          ],
                        ),
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('# tags'),
                        onPressed: (){},
                      ),
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
