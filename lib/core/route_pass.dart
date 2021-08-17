class SignUp2Args {
  String email;
  bool isGoogle;

  SignUp2Args(this.email, this.isGoogle);
}

class HireSignupPageArgs {
  String name, country;

  HireSignupPageArgs(this.name, this.country);
}

class ProfileOverViewExtensionPageArgs {
  bool isSubmitted;

  ProfileOverViewExtensionPageArgs(this.isSubmitted);
}

class HireChatPageArgs {
  String uid, name, photoUrl;

  HireChatPageArgs({this.uid, this.name, this.photoUrl});
}
