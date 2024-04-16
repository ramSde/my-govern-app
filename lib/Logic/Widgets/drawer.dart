import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:lottie/lottie.dart';
import 'package:mygovern/Logic/Helper/helper.dart';
import 'package:mygovern/Logic/Widgets/googlemap.dart';
import 'package:mygovern/Screens/Authentication/signinpage.dart';
import 'package:mygovern/Screens/Profile/profile.dart';
import 'package:mygovern/Screens/Request_Document/request_doc_list.dart';
import 'package:mygovern/Screens/drawerscreens/aboutus.dart';
import 'package:mygovern/Screens/drawerscreens/setting.dart';

class Drawerbtn extends StatefulWidget {
  const Drawerbtn({Key? key}) : super(key: key);

  @override
  State<Drawerbtn> createState() => _DrawerbtnState();
}

class _DrawerbtnState extends State<Drawerbtn> {
  final style = const TextStyle(fontSize: 24);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // late Future<Position> _currentLocation;
  // Set<Marker> _markers = {};

  // String googleApikey = "AIzaSyBDcdrYoBxOBQJn9gHTQf8s6Keb32Yf7g0";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  // LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Jan Seva Kendra";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/jansevadrawer.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              },
              child: const Text(
                'Profile',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestDocumentList(),
                  ),
                );
              },
              child: const Text(
                'Request Document',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                launchMap("Jan Seva Kendra");
              },
              child: const Text(
                'Nearest Janseva Kendra',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Setting(),
                  ),
                );
              },
              child: const Text(
                'Settings',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ),
                );
              },
              child: const Text(
                'About Us',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await _signOut();
                ScaffoldMessenger.of(context).showSnackBar(animationsnackbar(
                    "Logout", "Logout Successfully ", ContentType.help));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInpage(),
                  ),
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'v1.0.0',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 20,
                      color: Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
