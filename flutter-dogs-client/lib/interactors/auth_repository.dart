import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

// Вход по gmail
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await signWithCredentials(credential);
  final FirebaseUser user = authResult.user;

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  return 'signInWithGoogle succeeded: $user';
}

Future<AuthResult> signWithCredentials(AuthCredential credential) async {
  return _auth.signInWithCredential(credential);
}

// Выход из профиля
void signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Sign Out");
}
