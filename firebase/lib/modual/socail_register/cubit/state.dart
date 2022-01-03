abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState{}
class SocialRegisterLoadingState extends SocialRegisterState{}
class SocialRegisterSuccessState extends SocialRegisterState{}
class SocialRegisterErrorState extends SocialRegisterState{
  String error;
  SocialRegisterErrorState(this.error);
}

class SocialCreateLoadingState extends SocialRegisterState{}
class SocialCreateSuccessState extends SocialRegisterState{
  String uId;
  SocialCreateSuccessState(this.uId);
}
class SocialCreateErrorState extends SocialRegisterState{
  String error;
  SocialCreateErrorState(this.error);
}