import 'package:bloc/bloc.dart';
import 'package:firebase/model/social_user/social_user.dart';
import 'package:firebase/modual/socail_register/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterState>{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);



  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password
  }){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.
    createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error){
      print(error);
      //emit(SocialRegisterErrorState(error));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId
  }){
    SocialUserModel model = SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio: 'write you bio ..',
      image: 'https://as2.ftcdn.net/v2/jpg/02/16/53/83/1000_F_216538330_BrUpvHtcYlCEgqsPMIWXgrEIFvyiviYw.jpg',
      cover: 'https://image.freepik.com/free-photo/3d-rendering-business-meeting-working-room-office-building_105762-1992.jpg',
      isEmailVerified: false
    );
    FirebaseFirestore.instance
     .collection('users')
     .doc(uId)
     .set(model.toMap())
      .then((value){
      emit(SocialCreateSuccessState(uId));
     }).
      catchError((error){
       emit(SocialCreateErrorState(error));
      });

  }

}