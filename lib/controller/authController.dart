import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString profileUrl = ''.obs;
  RxBool isLoading = false.obs;

  Future<User?> signInwithGoogle() async {
    try {
      isLoading.toggle();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      // firebase user Credentials
      UserCredential userCredentials =
          await _auth.signInWithCredential(credential);

      // firebase user
      User? user = userCredentials.user;
      userName.value = user!.displayName!;
      userEmail.value = user.email!;
      profileUrl.value = user.photoURL!;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
    isLoading.toggle();
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  getSessionUser() {
    User? user = _auth.currentUser;
    // userName.value = user!.displayName!;
    // userEmail.value = user.email!;
    // profileUrl.value = user.photoURL!;
    // _auth.authStateChanges();
    return user;
  }
}
