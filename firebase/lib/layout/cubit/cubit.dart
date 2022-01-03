import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase/layout/cubit/state.dart';
import 'package:firebase/model/message_model.dart';
import 'package:firebase/model/social_post.dart';
import 'package:firebase/model/social_user/social_user.dart';
import 'package:firebase/modual/add_post/add_post.dart';
import 'package:firebase/modual/chats/chat_screen.dart';
import 'package:firebase/modual/feeds/feeds_screen.dart';
import 'package:firebase/modual/settings/settings_screen.dart';
import 'package:firebase/modual/users/users_screen.dart';
import 'package:firebase/shared/components/constant.dart';
import 'package:firebase/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialState>{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;
  int currentIndex = 0;
  var screens =[
    FeedsScreen(),
    ChatsScreen(),
    AddPost(),
    UsersScreen(),
    SettingsScreen(),
  ];
  var titles =[
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  
  void getUserDate(){
    emit(SocialGetLoadingState());
    FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .get()
    .then((value){
      model = SocialUserModel.fromMap(value.data()!);
      emit(SocialGetSuccessState());
    }).catchError((error){
      print(error);
      emit(SocialGetErrorState(error));
    });
  }

  void changeBottomNavigationBarIndex(int index){
    if(index==2){
      emit(SocialAddPostState());
    }else{
        currentIndex = index;
        emit(SocialBottomNavigationBarState());
    }
    if(index==1) getUsers();
  }



  var picker = ImagePicker();

  File? profileImage;
  Future<void> getProfileImage() async{
   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
   if(pickedFile != null) {
     profileImage = File(pickedFile.path);
     emit(SocialGetProfileImageSuccessState());
   }else {
     print('No image selected');
     emit(SocialGetProfileImageErrorState());
   }
  }

  File? coverImage;
  Future<void> getCoverImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetCoverImageSuccessState());
    }else {
      print('No image selected');
      emit(SocialGetCoverImageErrorState());
    }
  }

  String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }){
    emit(SocialUploadProfileImageLoadingState());
     firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => {
          value.ref.getDownloadURL()
              .then((value){
                print(value);
                profileImageUrl = value;
                updateUser(
                  name: name,
                  bio: bio,
                  phone: phone,
                  imageProfile: value,
                );
               })
              .catchError((error){
                print(error);
              })
        })
        .catchError((error){
       emit(SocialUploadProfileImageErrorState());
     });
  }

  String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }){
    emit(SocialUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) => {
      value.ref.getDownloadURL()
          .then((value){
        coverImageUrl = value;
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          imageCover: value,
        );
      })
        .catchError((error){
        print(error);
        emit(SocialUploadCoverImageErrorState());
      })
    })
      .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });

  }

  void updateUser({
   required String name,
   required String bio,
   required String phone,
   String? imageProfile,
   String? imageCover,
  }){
    emit(SocialUpdateUserLoadingState());
    SocialUserModel updateModel = SocialUserModel(
        email: model!.email,
        name: name,
        phone: phone,
        uId: model!.uId,
        bio: bio,
        image: imageProfile??model!.image,
        cover: imageCover??model!.cover,
        isEmailVerified: model!.isEmailVerified
    );

    FirebaseFirestore.instance.collection('users')
        .doc(model!.uId)
        .update(updateModel.toMap())
        .then((value){
          getUserDate();
        })
        .catchError((error){});
  }

  File? postImage;
  Future<void> getPostImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialGetPostImageSuccessState());
    }else {
      print('No image selected');
      emit(SocialGetPostImageErrorState());
    }
  }
  void removePostImage(){
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  String postImageUrl = '';
  void uploadPostImage({
    required String dateTime,
    required String text,
  }){
    emit(SocialUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) => {
      value.ref.getDownloadURL()
          .then((value){
        postImageUrl = value;
        createPost(
          text: text,
          dateTime: dateTime,
          imagePost: value,
        );
      })
          .catchError((error){
        print(error);
        emit(SocialUploadPostImageErrorState());
      })
    })
        .catchError((error){
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? imagePost,
  }){
    emit(SocialCreatePostLoadingState());
    SocialPostModel postModel = SocialPostModel(
        name: model!.name!,
        uId: model!.uId,
        text: text,
        dateTime: dateTime,
        image: model!.image,
        postImage:imagePost??''
    );

    FirebaseFirestore.instance.collection('posts')
        .add(postModel.toMap())
        .then((value){
          emit(SocialCreatePostSuccessState());
          getPosts();
        })
        .catchError((error){});
  }

  List<SocialPostModel> posts = [];
  List<String> postsId = [];
  List<int> postLikes = [];
  void getPosts(){
    posts.clear();
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value){
           value.docs.forEach((element) {
             element.reference
             .collection('likes')
             .get()
             .then((value){
               postLikes.add(value.docs.length);
               postsId.add(element.id);
               posts.add(SocialPostModel.fromMap(element.data()));
             })
             .catchError((error){});
           });
           emit(SocialGetPostsSuccessState());
        })
        .catchError((error){
          emit(SocialGetPostsErrorState(error));
        });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true})
        .then((value){
          emit(SocialSetPostLikeSuccessState());
        }).catchError((error){
          emit(SocialSetPostLikeErrorState(error));
        });
  }

  List<SocialUserModel> allUsers = [];
  void getUsers(){
    allUsers.clear();
    emit(SocialGetAllUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value){
      value.docs.forEach((element) {
        if(element.data()['uId']!= model!.uId.toString())
         allUsers.add(SocialUserModel.fromMap(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    })
      .catchError((error){
        print('My Error '+error.toString());
      emit(SocialGetAllUserErrorState(error.toString()));
    }).onError((error, stackTrace){
      print(error);
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }){
    MessageModelModel messageModel = MessageModelModel(
       senderId: model!.uId!,
       receiverId: receiverId,
       dateTime: dateTime,
       text: text
    );

    FirebaseFirestore.instance
     .collection('users')
     .doc(model!.uId!)
     .collection('chats')
     .doc(receiverId)
     .collection('messages')
     .add(messageModel.toMap())
     .then((value){
       emit(SocialSendMessageSuccessState());
      })
     .catchError((error){
       emit(SocialSendMessageErrorState());
      });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId!)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value){
           FirebaseMessaging.sendMessage(
             title: model!.name!,
             body: messageModel.text!,
             toId: receiverId
           );
          emit(SocialSendMessageSuccessState());
        })
        .catchError((error){
          emit(SocialSendMessageErrorState());
        });

  }

  List<MessageModelModel> messages = [];
  void getMessages({
   required String receivedId,
  }){
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId!)
        .collection('chats')
        .doc(receivedId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModelModel.fromMap(element.data()));
          });
          emit(SocialGetMessagesSuccessState());
        });
  }
}