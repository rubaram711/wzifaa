import 'package:flutter/material.dart';
import 'package:wazefaa/screens/CVs_page.dart';
import 'package:wazefaa/screens/add_cv_page.dart';
import 'package:wazefaa/screens/add_job_page.dart';
import 'package:wazefaa/screens/authentication/forget_password_screen.dart';
import 'package:wazefaa/screens/authentication/login_screen.dart';
import 'package:wazefaa/screens/authentication/register_screen.dart';
import 'package:wazefaa/screens/blog_details.dart';
import 'package:wazefaa/screens/career_details_page.dart';
import 'package:wazefaa/screens/company_details.dart';
import 'package:wazefaa/screens/contact_us_page.dart';
import 'package:wazefaa/screens/custom_splash_screen.dart';
import 'package:wazefaa/screens/favorate_pages/favorite_page.dart';
import 'package:wazefaa/screens/home_page.dart';
import 'package:wazefaa/screens/profile-page.dart';
import 'package:wazefaa/screens/radio.dart';
import 'package:wazefaa/screens/search_for_jobs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.indigo, fontFamily: 'Cairo',
        tabBarTheme: const TabBarTheme(
            labelStyle: TextStyle(color: Colors.white), // color for text
            indicator: UnderlineTabIndicator( // color for indicator (underline)
                borderSide: BorderSide(color:Colors.white))),
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomePage(),
          '/blog_details': (context)=> const BlogDetails(),
          '/profile': (context) => const ProfilePage(),
          '/CVs': (context) => const CVsPage(),
          '/contact_us': (context) => const ContactUsPage(),
          '/company_details': (context) => const CompanyDetails(),
          '/career_details': (context) => const CareerDetails(),
          '/forget_password': (context) => const ForgetPasswordScreen(),
          '/add_job':(context)=>const AddJobPage(),
          '/add_cv':(context)=>const AddCvPage(),
          '/favorite':(context)=>const  FavoritePage(),
          '/search_for_job':(context)=>const SearchForJob(),
          '/radio':(context)=>const TheRadio(),
    },
        home: const SplashScreen());
  }
}
