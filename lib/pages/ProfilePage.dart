// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizapp/models/profile_model.dart';
import 'package:quizapp/pages/NavDrawer.dart';
import 'package:quizapp/resources/repository.dart';

import 'ImageFromGallaryEx.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profilePageState();
  }
}

class _profilePageState extends State<ProfilePage> {
  var _image;
  Repository repository = Repository();
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type, (val) => setImage(val))
        )
        );
  }


  setImage(val){
    setState(() {
      _image = val;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late String imagePath = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";

  @override
  initState() {
    getData();
  }

  getData() async {
    _image = NetworkImage(imagePath);
    repository.getProfile("profile-1").listen((list) {
      if(list.isNotEmpty){
      var event = list[0];
      nameController.text = event.name;
      designationController.text = event.designation;
      phoneController.text = event.phone;
      locationController.text = event.location;
      descriptionController.text = event.description;
      }
    });

  }

  saveProfileData() async {
    repository.saveOrUpdateProfile(ProfileModel(new DateTime.now().millisecondsSinceEpoch, "profile-1", nameController.value.text, designationController.value.text, phoneController.value.text, locationController.value.text, descriptionController.value.text));
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
           // height: 450,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildImage(),
                  TextField(
                    controller: nameController,
                    decoration: getInputDecoration(hintText: ' Name'),
                  ),
                  TextField(
                    controller: designationController,
                    decoration: getInputDecoration(hintText: 'Designation'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: getInputDecoration(hintText: 'Phone'),
                  ),
                  TextField(
                    controller: locationController,
                    decoration: getInputDecoration(hintText: 'Location'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: getInputDecoration(hintText: 'Description'),
                  ),
                  getSaveButton(),
                ])));
  }

  Widget getSaveButton() {
    return Container(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue, onPrimary: Colors.white),
          child: Text('Save'),
          onPressed: saveProfileData,
        ));
  }

  InputDecoration getInputDecoration({@required hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        letterSpacing: 2,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }



  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildImage() {
   
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: _image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () {
            _handleURLButtonPress(context, ImageSourceType.gallery);
          }),
        ),
      ),
    );
  }
}
