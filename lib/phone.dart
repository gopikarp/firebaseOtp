import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp_ui/home.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
    // _verifyPhone();
  }

  var phone = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                      // controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91 $phone',
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {},
                      verificationFailed: (FirebaseAuthException e) {
                        // if (e.code == 'invalid-phone-number') {
                        //   print('The provided phone number is not valid.');
                        // }
                        print(e);
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        Navigator.pushNamed(context, "verify",
                            arguments: {"id": verificationId});
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    // varifyPhone();
                    // Navigator.pushNamed(context, 'verify');
                  },
                  child: Text("Send the code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//1
  // varifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '${countryController.text + phone}',
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }
//2
  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '${countryController.text + phone}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => home()),
  //                 (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String? verficationID, int? resendToken) {
  //         setState(() {
  //           _verificationCode = verficationID;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           _verificationCode = verificationID;
  //         });
  //       },
  //       timeout: Duration(seconds: 10));
  // }
//3
  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '${countryController.text + phone}',
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => home(),
  //       //   ),
  //       // );
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       // if (e.code == 'invalid-phone-number') {
  //       //   print('The provided phone number is not valid.');
  //       // }

  //       // print('fail/////////////');
  //     },
  //     timeout: Duration(seconds: 120),
  //     codeSent: (String verificationId, int? resendToken) async {
  //       // Update the UI - wait for the user to enter the SMS code
  //       String smsCode = 'xxxx';

  //       // Create a PhoneAuthCredential with the code
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //           verificationId: verificationId, smsCode: smsCode);

  //       // Sign the user in (or link) with the credential
  //       await _auth.signInWithCredential(credential);
  //       Navigator.pushNamed(context, 'verify');
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );

  //   // varifyPhone();
  //   // Navigator.pushNamed(context, 'verify');
  // }
}



  // await FirebaseAuth.instance.verifyPhoneNumber(
  //                     phoneNumber: '${countryController.text + phone}',
  //                     verificationCompleted:
  //                         (PhoneAuthCredential credential) async {
  //                       await _auth.signInWithCredential(credential);
  //                       // Navigator.of(context).push(
  //                       //   MaterialPageRoute(
  //                       //     builder: (context) => home(),
  //                       //   ),
  //                       // );
  //                     },
  //                     verificationFailed: (FirebaseAuthException e) {
  //                       // if (e.code == 'invalid-phone-number') {
  //                       //   print('The provided phone number is not valid.');
  //                       // }

  //                       // print('fail/////////////');
  //                     },
  //                     timeout: Duration(seconds: 120),
  //                     codeSent:
  //                         (String verificationId, int? resendToken) async {
  //                       // Update the UI - wait for the user to enter the SMS code
  //                       String smsCode = 'xxxx';

  //                       // Create a PhoneAuthCredential with the code
  //                       PhoneAuthCredential credential =
  //                           PhoneAuthProvider.credential(
  //                               verificationId: verificationId,
  //                               smsCode: smsCode);

  //                       // Sign the user in (or link) with the credential
  //                       await _auth.signInWithCredential(credential);
  //                       Navigator.pushNamed(context, 'verify');
  //                     },
  //                     codeAutoRetrievalTimeout: (String verificationId) {},
  //                   );
  //                   // varifyPhone();
  //                   // Navigator.pushNamed(context, 'verify');