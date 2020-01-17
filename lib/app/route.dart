import 'package:tinh_tien/app/pages/expense_page/expense_page.dart';
import 'package:tinh_tien/app/pages/home_page/home_page.dart';
import 'package:tinh_tien/app/pages/share_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/already_have_activity_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/welcome_page.dart';

const WElCOME_PAGE = "/";
const HOME_PAGE = "/home";
const EXPENSE_PAGE = "/expense";
const ALREADY_HAVE_ACTIVITY_PAGE = "/already";
const SHARE_PAGE = "/share";

final routes = {
  WElCOME_PAGE: (context) => WelcomePage(),
  HOME_PAGE: (context) => HomePage(),
  EXPENSE_PAGE: (context) => ExpensePage(),
  ALREADY_HAVE_ACTIVITY_PAGE: (context) => AlreadyHaveActivityPage(),
  SHARE_PAGE: (context) => SharePage(),
};
