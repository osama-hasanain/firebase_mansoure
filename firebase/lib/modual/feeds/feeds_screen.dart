import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/model/social_post.dart';
import 'package:firebase/shared/styles/colors.dart';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
          if(SocialCubit.get(context).posts.isNotEmpty)
            return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage('https://image.freepik.com/free-photo/puzzled-hesitant-man-with-beard-shrugs-hands-with-hesitation_273609-40923.jpg'),
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'communicate with friends',
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>postItemBuilder(context,SocialCubit.get(context).posts[index],index),
                        separatorBuilder: (context,index)=>SizedBox(height: 8,),
                        itemCount: SocialCubit.get(context).posts.length
                    ),
                    SizedBox(height: 8,)
                  ],
                ),
              );
          else
            return Center(child: CircularProgressIndicator(),);
      },
    );
  }
  Widget postItemBuilder(context,SocialPostModel itemPost,int postId) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(itemPost.image!),
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
                              itemPost.name!,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  height: 1.4
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            Icon(
                              Icons.check_circle,
                              color: defualtColor,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          itemPost.dateTime!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.more_horiz),
                    iconSize: 16,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[200],
                ),
              ),
              Text(
                itemPost.text!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical:8.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       alignment: WrapAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end:4.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 onPressed: (){},
              //                 child: Text(
              //                   '#software',
              //                   style: Theme.of(context).textTheme.caption!.copyWith(
              //                     color: defualtColor,
              //                   ),)
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 4.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 onPressed: (){},
              //                 child: Text(
              //                   '#flutter',
              //                   style: Theme.of(context).textTheme.caption!.copyWith(
              //                     color: defualtColor,
              //                   ),)
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(itemPost.postImage!='')
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image : DecorationImage(
                      image: NetworkImage(itemPost.postImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                '${SocialCubit.get(context).postLikes[postId]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                '0 comment',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[200],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(SocialCubit.get(context).model!.image!),
                                radius: 15,
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Text(
                                  'Write a comment ...',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700]
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),

                            ],
                          ),
                          onTap: (){},
                        )
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(width: 3,),
                            Text(
                              'Like',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[postId]);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
