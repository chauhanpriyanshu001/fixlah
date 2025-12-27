import 'package:fixlah/auth/provider/login_provider.dart';
import 'package:fixlah/auth/provider/splash_provider.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:fixlah/home/provider/home_provider.dart';
import 'package:fixlah/inspection/provider/inspection_provider.dart';
import 'package:fixlah/issues/provider/issues_provider.dart';
import 'package:fixlah/userdata/userdata_provider.dart';
import 'package:fixlah/work%20order/provider/work_order_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  // Used for authentication
  ChangeNotifierProvider(
    create: (context) => LoginState(),
  ),
  ChangeNotifierProvider(
    create: (context) => IssuesProvider(),
  ),
  // Used on Splash Screen to check the authentication
  ChangeNotifierProvider(
    create: (context) => SplashProvider(),
  ),
  // Used on Multiple Screen to get Loggged in User Data
  ChangeNotifierProvider(
    create: (context) => UserdataProvider(),
  ),
  // Used on Homw Screen to get data for issuses, work order and inspection
  ChangeNotifierProvider(
    create: (context) => HomeProvider(),
  ),
  // Used on Facilities Screen to get and select facilities
  ChangeNotifierProvider(
    create: (context) => FacilitiesProvider(),
  ),
  // Used on work order Screen
  ChangeNotifierProvider(
    create: (context) => WorkOrderProvider(),
  ),
  // Used on inspection
  ChangeNotifierProvider(
    create: (context) => InspectionProvider(),
  ),
];
