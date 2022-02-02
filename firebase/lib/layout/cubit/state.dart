abstract class SocialState {}


class SocialInitialState extends SocialState{}
class SocialGetLoadingState extends SocialState{}
class SocialGetSuccessState extends SocialState{
  SocialGetSuccessState();
}
class SocialGetErrorState extends SocialState{
  String error;
  SocialGetErrorState(this.error);
}

//get all users
class SocialGetAllUserLoadingState extends SocialState{}
class SocialGetAllUserSuccessState extends SocialState{
  SocialGetAllUserSuccessState();
}
class SocialGetAllUserErrorState extends SocialState{
  String? error;
  SocialGetAllUserErrorState(this.error);
}

// bottom navigate
class SocialBottomNavigationBarState extends SocialState{}

// add post
class SocialAddPostState extends SocialState{}

// get profile image
class SocialGetProfileImageSuccessState extends SocialState{
  SocialGetProfileImageSuccessState();
}
class SocialGetProfileImageErrorState extends SocialState{}

//get posts
class SocialGetPostsSuccessState extends SocialState{
  SocialGetPostsSuccessState();
}
class SocialGetPostsErrorState extends SocialState{
  String error;
  SocialGetPostsErrorState(this.error);
}

// post like
class SocialSetPostLikeSuccessState extends SocialState{}
class SocialSetPostLikeErrorState extends SocialState{
  String error;
  SocialSetPostLikeErrorState(this.error);
}


class SocialGetCoverImageSuccessState extends SocialState{
  SocialGetCoverImageSuccessState();
}
class SocialGetCoverImageErrorState extends SocialState{}

class SocialUploadProfileImageLoadingState extends SocialState{}
class SocialUploadProfileImageSuccessState extends SocialState{}
class SocialUploadProfileImageErrorState extends SocialState{}

class SocialUploadCoverImageLoadingState extends SocialState{}
class SocialUploadCoverImageSuccessState extends SocialState{}
class SocialUploadCoverImageErrorState extends SocialState{}

class SocialUpdateUserLoadingState extends SocialState{}
class SocialUpdateUserErrorState extends SocialState{}

class SocialGetPostImageSuccessState extends SocialState{}
class SocialGetPostImageErrorState extends SocialState{}


class SocialRemovePostImageState extends SocialState{}

//upload image post
class SocialUploadPostImageLoadingState extends SocialState{}
class SocialUploadPostImageSuccessState extends SocialState{}
class SocialUploadPostImageErrorState extends SocialState{}

//create post
class SocialCreatePostLoadingState extends SocialState{}
class SocialCreatePostSuccessState extends SocialState{}
class SocialCreatePostErrorState extends SocialState{}

//chat
class SocialSendMessageLoadingState extends SocialState{}
class SocialSendMessageSuccessState extends SocialState{}
class SocialSendMessageErrorState extends SocialState{}

class SocialGetMessagesSuccessState extends SocialState{}

class SocialChangeThemeModeState extends SocialState{}

