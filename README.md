# HCC demo app

An  app created for HCC health care 
<br>Author: Jerry liu, Jimmy yang,Henry han

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

Install Flutter plugin and dart support for intelliJ/VScode, 

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Upon opening the app for the first time, in the [pubsspec.yaml](/Users/jerryliu/demo/pubspec.yaml)
run the following:  
~~~ 
flutter pub get
~~~
The command will fetch all the dependencies

Have simulator / device opened / atteched before building

### Tip
- consider using Future builder for stateful widgets
- try separating the service modules from app pages, for the sake of reuse
- all callbacks would be the type of ``Future``, which usually are from / contained in a async function, and All ``Future``
can be converted into normal data type by an Arrow Function

### Notes
- network support only added to Android platform

### App Pages
- [Home](/Users/jerryliu/demo/lib/home.dart): 
<br>Main entry of the app, contains the bottom nav bar in the page , on which each page is created by the function
 ``createlist(home.dart:101)``, the page is designed to be rendered by [Future builder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
 render decisions are made based on three boolean value:
    - ``isHealth`` determines healthy status or unhealthy status on assessment page
    - ``initStatus`` determines whether the result of questionnaire has expired
    - ``stayLogin`` determines if the user token has expired
 - [YesNo](/Users/jerryliu/demo/lib/YesNo.dart): 
 <br>The Yes No part of questionnaire, all the selection on this page is stored in the ``yndata`` variable
 
 
 - [CheckBoxList](/Users/jerryliu/demo/lib/CheckboxList.dart): 
 <br>The checkbox list is last page of questionnaire, which then nav to the Summary page
 
 - [SummaryPage](/Users/jerryliu/demo/lib/Summary.dart):
 <br>Summary of the result, ``sethealth`` happens here, localstorage are set by using [ flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
 Then takes the parameter ``isHealth`` and nav to Home
 
 - [MePage](/Users/jerryliu/demo/lib/MePage.dart)
 <br> set the name of the user by fetching ``flutter storage`` data in the ``futurebuilder``. call the ``signout`` here
 
 - [login_screen](/Users/jerryliu/demo/lib/login_screen.dart)
<br> contains both login and signup page, the routers are embeded inside this page as async function. This is where all the
local storage ``flutter storage`` are being written

all the other pages are to be considered as a backup or things in dvelopement, be careful before making any deletion


### Service Module
- [HttpConnector](/Users/jerryliu/demo/lib/modules/httpconnector.dart)
    - signout <br> wiping out the localstorage and call the backend ``signout`` api 
    - postInit <br> check the backend for initial status of questionnaire, ``expire/valid``
    - postValid <br> check with backend for the user session expiration status, by passing a ``token``