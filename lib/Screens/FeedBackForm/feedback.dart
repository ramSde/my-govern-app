// class FeedbackForm extends StatefulWidget {
//   const FeedbackForm({Key? key}) : super(key: key);

//   @override
//   State<FeedbackForm> createState() => _FeedbackFormState();
// }

// class _FeedbackFormState extends State<FeedbackForm> {
//   final TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Form(
//         key: _formKey,
//         child: TextFormField(
//           controller: _controller,
//           keyboardType: TextInputType.multiline,
//           decoration: const InputDecoration(
//             hintText: 'Enter your feedback here',
//             filled: true,
//           ),
//           maxLines: 5,
//           maxLength: 4096,
//           textInputAction: TextInputAction.done,
//           validator: (String? text) {
//             if (text == null || text.isEmpty) {
//               return 'Please enter a value';
//             }
//             return null;
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: const Text('Cancel'),
//           onPressed: () => Navigator.pop(context),
//         ),
//         TextButton(
//           child: const Text('Send'),
//           onPressed: () async {
//             // Only if the input form is valid (the user has entered text)
//             if (_formKey.currentState!.validate()) {
//               // We will use this var to show the result
//               // of this operation to the user
//               String message;

//               try {
//                 // Get a reference to the `feedback` collection
//                 final collection =
//                     FirebaseFirestore.instance.collection('feedback');

//                 // Write the server's timestamp and the user's feedback
//                 await collection.doc().set({
//                   'timestamp': FieldValue.serverTimestamp(),
//                   'feedback': _controller.text,
//                 });

//                 message = 'Feedback sent successfully';
//               } catch (e) {
//                 message = 'Error when sending feedback';
//               }

//               // Show a snackbar with the result
//               ScaffoldMessenger.of(context)
//                   .showSnackBar(SnackBar(content: Text(message)));
//               Navigator.pop(context);
//             }
//           },
//         )
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mygovern/Screens/FeedBackForm/validator.dart';

class FormFour extends StatefulWidget {
  @override
  _FormFourState createState() => _FormFourState();
}

class _FormFourState extends State<FormFour> with Validator {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final double minValue = 8.0;
  final GlobalKey<FormState> _formKey = GlobalKey();

  int experienceIndex = 0;

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  void initState() {
    _onCreated();
    super.initState();
  }

  void _onCreated() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _emailController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onTapEmoji(int index) {
    setState(() {
      experienceIndex = index;
    });
  }

  final Color? activeColor = Colors.pink[400];
  final Color? inActiveColor = Colors.grey[50];

  Widget _buildEmoji() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () => _onTapEmoji(1),
            icon: Icon(
              Icons.sentiment_very_dissatisfied,
              color: experienceIndex == 1 ? activeColor : inActiveColor,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () => _onTapEmoji(2),
            icon: Icon(
              Icons.sentiment_dissatisfied,
              color: experienceIndex == 2 ? activeColor : inActiveColor,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () => _onTapEmoji(3),
            icon: Icon(
              Icons.sentiment_satisfied,
              color: experienceIndex == 3 ? activeColor : inActiveColor,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () => _onTapEmoji(4),
            icon: Icon(
              Icons.sentiment_very_satisfied,
              color: experienceIndex == 4 ? activeColor : inActiveColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      child: TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Full  Name',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          bool isEmail(String email) => EmailValidator.validate(email);
          String msg = '';
          if (!isEmail(value!.trim())) {
            msg = 'Please enter a valid email';
          } else {
            msg = "";
          }
          return msg;
        },
        onChanged: (String value) {},
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue, vertical: minValue),
      child: TextFormField(
        controller: _messageController,
        keyboardType: TextInputType.text,
        // maxLines: 2,
        maxLines: 4,

        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: InputBorder.none,
            labelText: 'Description',
            contentPadding: EdgeInsets.symmetric(horizontal: minValue),
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildTextBackground(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(2)),
      child: child,
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        // gradient: LinearGradient(colors: [Colors.pink[700], activeColor]),
      ),
      child: MaterialButton(
        onPressed: () async {
          print("DAta not saved");
          final emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

          if (_emailController.text.contains(emailValid)) {
            try {
              String message;

              // Get a reference to the `feedback` collection
              final collection =
                  FirebaseFirestore.instance.collection('feedback');

              // Write the server's timestamp and the user's feedback
              await collection.doc().set({
                'timestamp': FieldValue.serverTimestamp(),
                'Name':
                    _nameController.text == null ? "" : _nameController.text,
                'Email': _emailController.text,
                'Discription': _messageController.text == null
                    ? ""
                    : _messageController.text,
                'Experience rating': experienceIndex.toString()
              });

              message = 'Feedback sent successfully';
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              Navigator.pop(context);
            } catch (e) {
              String message;

              message = 'Error when sending feedback';
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              Navigator.pop(context);
            }
          }
        },
        padding: EdgeInsets.symmetric(vertical: minValue * 2.4),
        elevation: 0.0,
        color: Colors.white24,
        textColor: Colors.white,
        child: Text('SAVE'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Feedback"),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/feedback_bg.webp'),
                  fit: BoxFit.cover)),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.7)
                ])),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 25.0, right: 25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: minValue * 5,
                          ),
                          Text(
                            "Write Us",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 48.0,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 110.0,
                            child: Container(
                              height: 4,
                              color: Colors.pink[400],
                            ),
                          ),
                          SizedBox(
                            height: minValue * 2,
                          ),
                          Text(
                            "Feel free to write us. We will get back\n to you as soon as we can.",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[200]),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: minValue * 7,
                          ),
                          Text(
                            "How was your experience?",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: minValue,
                          ),
                          _buildEmoji(),
                          SizedBox(
                            height: minValue * 4,
                          ),
                          _buildTextBackground(_buildName()),
                          SizedBox(
                            height: minValue * 2,
                          ),
                          _buildTextBackground(_buildEmail()),
                          SizedBox(
                            height: minValue * 2,
                          ),
                          _buildTextBackground(_buildDescription()),
                          SizedBox(
                            height: minValue * 6,
                          ),
                          _buildSubmitBtn()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
