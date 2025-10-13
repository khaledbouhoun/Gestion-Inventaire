import 'package:get/get.dart';
import 'package:invontar/class/crud.dart';
import 'package:invontar/constant/linkapi.dart';
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
    // Simulate fetching data from an API or database
    user = Get.arguments['user'];
    dossier = Get.arguments['dossier'];
    exercice = Get.arguments['exercice'];
    fetchSettings();
    fetchInventaireEntete();
    fetchArticles();
  }

  Future<void> fetchInventaireEntete() async {
    try {
      isLoading.value = true;

      final response = await crud.get(appLink.getInventaireEnteteUrl(exercice!.eXEDATEDEB!.year, dossier!.dosBdd!));

      if (response.statusCode == 200) {
        inventaireentetelist = (response.body['inventaires'] as List).map((item) => InventaireEnteteModel.fromJson(item)).toList();
        print('✅ Loaded ${inventaireentetelist.length} inventory items');
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
    await fetchInventaireEntete();
    await fetchArticles();
  }

  Future<void> onTapInventaire(InventaireEnteteModel inventaire) async {
    Get.to(() => Details(), arguments: {'user': user, 'dossier': dossier, 'exercice': exercice, 'inventaire': inventaire});
  }

  void onLogout() {
    Get.offAll(Login());
  }
}
