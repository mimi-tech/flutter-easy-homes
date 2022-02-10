import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_homes/reg/constants/variables_0ne.dart';
import 'package:easy_homes/reg/screens/recover/recover_txn.dart';
import 'package:easy_homes/reg/screens/txn.dart';
import 'package:easy_homes/reg/screens/verify_mobile.dart';
import 'package:easy_homes/utils/progressHudFunction.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_homes/reg/constants/variables.dart';

import 'package:easy_homes/colors/colors.dart';
import 'package:easy_homes/dimes/dimen.dart';
import 'package:easy_homes/reg/constants/animation_text.dart';
import 'package:easy_homes/reg/constants/btn.dart';
import 'package:flutter/services.dart';
import 'package:easy_homes/utils/progressHudFunction.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_homes/reg/constants/fonts.dart';
import 'package:easy_homes/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class RecoverPass extends StatefulWidget {
  @override
  _RecoverPassState createState() => _RecoverPassState();
}

class _RecoverPassState extends State<RecoverPass> {
  TextEditingController _mobile = TextEditingController();
  bool _publishModal = false;

  String _countryCode = '';
  Color btnColor = kTextFieldBorderColor;

  Widget indicator(){
    return Platform.isIOS?CupertinoActivityIndicator():CircularProgressIndicator();
  }
  Widget spacer() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.05);
  }
  Widget mainBody(){
    return ProgressHUDFunction(
      inAsyncCall: _publishModal,
      progressIndicator: indicator(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            spacer(),

            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: kHorizontal),
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset('assets/imagesFolder/go_back.svg')
              ),
            ),
            Center(child: SvgPicture.asset('assets/imagesFolder/mobile.svg')),
            RegText(title: kMobileTitle2,),
            spacer(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: kHorizontal),
                child: Platform.isIOS
                    ? CupertinoTextField(
                  controller: _mobile,
                  autocorrect: true,
                  autofocus: true,

                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CountryCodePicker(
                      textStyle:  GoogleFonts.oxanium(
                        fontSize: ScreenUtil().setSp(kFontSize, ),
                        fontWeight: FontWeight.bold,

                        color: kTextColor,
                      ),
                      onInit: (code) {
                        _countryCode = code.toString();
                      },
                      onChanged: (code){
                        _countryCode = code.toString();
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'NG',
                      favorite: ['+234','NG'],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: (kTextFieldBorderColor),
                  style: Fonts.textSize,
                  placeholderStyle:GoogleFonts.oxanium(
                    fontSize: ScreenUtil().setSp(kFontSize, ),
                    color: kHintColor,
                  ),
                  inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
                  ],
                  placeholder: kMobileHint,
                  onChanged: (String value) {
                    Variables.mobile = value;
                    if(_mobile.text.length >=10 ){
                      setState(() {
                        btnColor = kLightBrown;
                      });
                    }else{
                      setState(() {

                        btnColor = kTextFieldBorderColor;
                      });
                    }
                  },
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorder),
                      border: Border.all(color: kLightBrown)),
                )
                    : TextField(
                  controller: _mobile,
                  autocorrect: true,
                  autofocus: true,

                  cursorColor: (kTextFieldBorderColor),
                  keyboardType: TextInputType.number,
                  style: Fonts.textSize,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CountryCodePicker(
                          textStyle:  GoogleFonts.oxanium(
                            fontSize: ScreenUtil().setSp(kFontSize, ),
                            fontWeight: FontWeight.bold,

                            color: kTextColor,
                          ),
                          onInit: (code) {
                            _countryCode = code.toString();
                          },
                          onChanged: (code){
                            _countryCode = code.toString();
                          },
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'NG',
                          favorite: ['+234','NG'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        ),
                      ),

                      hintText: kMobileHint,
                      hintStyle:GoogleFonts.oxanium(
                        fontSize: ScreenUtil().setSp(kFontSize, ),
                        color: kHintColor,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 18.0, 20.0, 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              kBorder)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: kLightBrown))



                  ),


                  inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (String value) {
                    Variables.mobile = value;
                    if(_mobile.text.length >=10 ){
                      setState(() {
                        btnColor = kLightBrown;
                      });
                    }else{
                      setState(() {

                        btnColor = kTextFieldBorderColor;
                      });
                    }
                  },
                )),

            /*displaying Next button*/
            spacer(),
            Btn(nextFunction: (){moveToNext();},bgColor: btnColor,),


          ],
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Platform.isIOS?CupertinoPageScaffold(
            child:mainBody()
        ):Scaffold(
            body:mainBody()
        )
    );
  }

  Future<void> moveToNext() async {
    /*check if mobile number is not empty*/
    if ((_mobile.text == null) || (_mobile.text.length == 0)) {
      Fluttertoast.showToast(
          msg: kMobileError,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: kBlackColor,
          textColor: kRedColor);
    } else if (_mobile.text.length < 10) {
      Fluttertoast.showToast(
          msg: 'Error please check your phone number',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: kBlackColor,
          textColor: kRedColor);
    } else{
      if (_mobile.text.startsWith('0')) {
        String a = _mobile.text.substring(1);
        _mobile.text = a;
      }
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        _publishModal = true;
      });

      //check if phone number is already existing
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('userReg')
          .where('ph', isEqualTo: _countryCode + _mobile.text.trim())
          .get();

      final List <DocumentSnapshot> documents = result.docs;
if (documents.length == 1) {
        setState(() {
          _publishModal = false;
        });

        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RecoverTxn(doc:documents)));


      }else {
        setState(() {
          _publishModal = false;
        });
        VariablesOne.notifyFlutterToastError(title: 'Sorry this phone number does not exist');


      }

    }
  }
}



