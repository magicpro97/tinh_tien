import 'package:tinh_tien/app/pages/expense_page/expense_page.dart';
import 'package:tinh_tien/app/pages/home_page/home_page.dart';
import 'package:tinh_tien/app/pages/welcome_page.dart';

const WElCOME_PAGE = "/";
const HOME_PAGE = "/home";
const EXPENSE_PAGE = "/expense";

final routes = {
  WElCOME_PAGE: (context) => WelcomePage(),
  HOME_PAGE: (context) => HomePage(),
  EXPENSE_PAGE: (context) => ExpensePage(),
};
