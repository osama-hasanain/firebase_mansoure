import 'package:firebase/layout/cubit/cubit.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/styles/colors.dart';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        var model = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = model!.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;
        return Scaffold(
            appBar: defaultAppBar(
                context : context,
                title : 'Edit Profile',
                actions: [
                  defaultTextButton(
                      text: 'update',
                      onPressed: (){
                        SocialCubit.get(context).updateUser(
                          bio: bioController.text,
                          name: nameController.text,
                          phone: phoneController.text
                        );
                      }
                  ),
                  SizedBox(width: 10,)
                ]
            ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUpdateUserLoadingState)
                    SizedBox(height: 10,),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 130.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null ?
                                      NetworkImage(model.cover!)
                                       : FileImage(coverImage) as ImageProvider,
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
                                      IconBroken.Camera,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 57,
                                backgroundImage: profileImage==null ?
                                NetworkImage(model.image!) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: defualtColor,
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage!=null)
                          Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                defaultButton(
                                    text: 'Upload profile',
                                    pressed: (){
                                      SocialCubit.get(context).uploadProfileImage(
                                          name: nameController.text,
                                          bio: bioController.text,
                                          phone: phoneController.text
                                      );
                                    }
                                ),
                                if(state is SocialUploadProfileImageLoadingState)
                                  SizedBox(height: 5,),
                                if(state is SocialUploadProfileImageLoadingState)
                                  LinearProgressIndicator()
                              ],
                            ),
                          ),
                        ),
                        if(SocialCubit.get(context).coverImage!=null)
                          Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                defaultButton(
                                    text: 'upload cover',
                                    pressed: (){
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          bio: bioController.text,
                                          phone: phoneController.text
                                      );
                                    }
                                ),
                                if(state is SocialUploadCoverImageLoadingState)
                                  SizedBox(height: 5,),
                                if(state is SocialUploadCoverImageLoadingState)
                                 LinearProgressIndicator()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10,),
                  defaultTextFormField(
                      controller: nameController,
                      label: 'User Name',
                      prefixIcon: Icon(IconBroken.User),
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10,),
                  defaultTextFormField(
                      controller: bioController,
                      label: 'Bio',
                      prefixIcon: Icon(IconBroken.Info_Circle),
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10,),
                  defaultTextFormField(
                      controller: phoneController,
                      label: 'Phone',
                      prefixIcon: Icon(IconBroken.Call),
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}