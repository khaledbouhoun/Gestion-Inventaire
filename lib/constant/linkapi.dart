import 'package:get/get.dart';
import 'package:invontar/main.dart';

class AppLink extends GetxController {
  MyServices myServices = Get.find();

  late String? basesys;
  late String? server;
  late String? port;

  late String baseUrl;

  String sretuen() {
    basesys = "C:\\Evaluation\\Systeme\\Systeme.FDB";
    basesys = myServices.sharedPreferences.getString("BaseSys");
    server = myServices.sharedPreferences.getString("server");
    port = myServices.sharedPreferences.getString("port");
    baseUrl = "http://$server:$port";

    if (server == null || port == null || server!.isEmpty || port!.isEmpty) {
      return ""; // Return an empty string if server or port is null
    } else {
      return baseUrl; // Return the base URL if server and port are valid
    }
  }

  String getDossieUrl() => "${sretuen()}/dossier";
  String getanne(String base) => "${sretuen()}/anee?Base=$base";
  String getSetting(String base) => "${sretuen()}/Setting?Base=$base";
  String getuserUrl(String id) => "${sretuen()}/user?DosNo=$id&BaseSys=$basesys";
  String getArticlesUrl(String base) => "${sretuen()}/articles?Base=$base";
  String getInventaireEnteteUrl(int annee, String base) => "${sretuen()}/inventaire?Base=$base&exerice=$annee";
  String getInventaireDetailsUrl(String indno, String inddate, String base) =>
      "${sretuen()}/INVENTAIRD?Base=$base&INDDATE=$inddate&INDNO=$indno";
  String saveInventaireDetailsUrl(String base) => "${sretuen()}/INVENTAIRD?Base=$base";
}
