abstract class BaseAuthentication <USER, ID>{

  Future<USER>? signIn(String email, String password);

  Future<String>? signUp(String email, String password);

  Future<String>? getCurrentUser();

  Future<void>? signOut();

  Future<String>? forgotPasswordEmail(String email);
  
}