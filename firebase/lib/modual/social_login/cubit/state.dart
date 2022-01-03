abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState{}
class SocialLoginLoadingState extends SocialLoginState{}
class SocialLoginSuccessState extends SocialLoginState{
  String uId;
  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginState{
  String error;
  SocialLoginErrorState(this.error);
}