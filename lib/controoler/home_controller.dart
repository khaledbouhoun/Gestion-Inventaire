import 'package:get/get.dart';
import 'package:invontar/class/crud.dart';
import 'package:invontar/constant/linkapi.dart';
import 'package:invontar/controoler/login_controller.dart';
import 'package:invontar/data/model/articles_model.dart';
import 'package:invontar/data/model/exercice_model.dart';
import 'package:invontar/data/model/dossei_model.dart';
import 'package:invontar/data/model/inventaireentete_model.dart';
import 'package:invontar/data/model/settings_model.dart';
import 'package:invontar/data/model/user_model.dart';
import 'package:invontar/view/screen/details.dart';
import 'package:invontar/view/screen/login.dart';

class HomeController extends GetxController {
  final Crud crud = Crud();
  final AppLink appLink = Get.find<AppLink>();
  // final LoginController loginController = Get.put(LoginController());
  List<InventaireEnteteModel> inventaireentetelist = <InventaireEnteteModel>[];
  RxBool isLoading = false.obs;
  RxBool isLoadingArticles = false.obs;
  RxBool loadingInventaireId = false.obs;

  UserModel? user;
  DossierModel? dossier;
  ExerciceModel? exercice;

  List<ArticlesModel> articles = <ArticlesModel>[];

  BuySettings buySettings = BuySettings();
  SellSettings sellSettings = SellSettings();

  @override
  void onInit() {
    super.onInit();
    print("Home controller initializing ...");

    user = Get.arguments['user'];
    dossier = Get.arguments['dossier'];
    exercice = Get.arguments['exercice'];

    if (user == null) {
      print("Error: Missing  Use is null.");
    }
    if (dossier == null) {
      print("Error: Missing  Dosseie is null.");
    }
    if (exercice == null) {
      print("Error: Missing  exceric is null.");
    }

    print("user = ${user!.userLogin ?? 'N/A'} dossie = ${dossier!.dosBdd ?? 'N/A'} exercice = ${exercice!.eXEDATEDEB!.year ?? 'N/A'} ");

    onRefresh();
  }

  Future<void> fetchInventaireEntete() async {
    try {
      isLoading.value = true;

      final response = await crud.get(appLink.getInventaireEnteteUrl(exercice!.eXEDATEDEB!.year, user!.userLogin!, dossier!.dosBdd!));
      print('response : $response');

      if (response.statusCode == 200) {
        inventaireentetelist = (response.body['inventaires'] as List).map((item) => InventaireEnteteModel.fromJson(item)).toList();
        print('✅ Loaded ${inventaireentetelist.length} inventory items');
      }
      if (response.statusCode == 404) {
        inventaireentetelist = [];
      } else {
        throw Exception('Échec de la récupération des dossiers');
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchSettings() async {
    try {
      isLoading.value = true;

      final response = await crud.get(appLink.getSetting(dossier!.dosBdd!));

      print('response : $response');
      if (response.statusCode == 200) {
        buySettings = BuySettings.fromJson(response.body['buy_settings']);
        sellSettings = SellSettings.fromJson(response.body['sell_settings']);
      } else {
        throw Exception('Échec de la récupération des dossiers');
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchArticles() async {
    try {
      isLoadingArticles.value = true;
      await Future.delayed(const Duration(seconds: 2));
      final response = await crud.get(appLink.getArticlesUrl(dossier!.dosBdd!));
      print('response : $response');

      if (response.statusCode == 200) {
        articles = (response.body['ARTICLESS'] as List).map((e) => ArticlesModel.fromJson(e)).toList();
        print('✅ Loaded ${articles.length} articles');
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoadingArticles.value = false;
      update();
    }
  }

  Future<void> onRefresh() async {
    print("refreching ... user : ${user!.userLogin} dossie : ${dossier!.dosBdd} exercice : ${exercice!.eXEDATEDEB!.year} ");
    await fetchInventaireEntete();
    if (inventaireentetelist.isNotEmpty) {
      await fetchSettings();
      await fetchArticles();
    }
  }

  Future<void> onTapInventaire(InventaireEnteteModel inventaire) async {
    Get.to(() => Details(), arguments: {'inventaire': inventaire});
  }

  void onLogout() {
    Get.offAll(() => const Login());
  }
}
