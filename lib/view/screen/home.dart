import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invontar/constant/color.dart';
import 'package:invontar/controoler/home_controller.dart';
import 'package:invontar/fonctions/alertexitapp.dart';
import 'package:invontar/view/widget/inventaireentete_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: controller.onRefresh,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.primaryColor.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: const Icon(Icons.refresh_outlined, color: AppColor.primaryColor, size: 24),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: controller.onLogout,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.primaryColor.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: const Icon(Icons.logout_outlined, color: AppColor.primaryColor, size: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: alertExitApp,
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: controller.onRefresh,
                color: AppColor.primaryColor,
                backgroundColor: AppColor.background,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: controller.isLoading.value || controller.isLoadingArticles.value
                      ? Center(child: CircularProgressIndicator(color: AppColor.primaryColor, strokeWidth: 2))
                      : controller.inventaireentetelist.isEmpty
                      ? Center(
                          child: const Text(
                            textAlign: TextAlign.center,
                            'Aucun inventaire \nouvert trouvé pour \nVous',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.black, letterSpacing: -0.5),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return InventaireEnteteWidget(
                              onTap: () => controller.onTapInventaire(controller.inventaireentetelist[index]),
                              inventaire: controller.inventaireentetelist[index],
                            );
                          },
                          itemCount: controller.inventaireentetelist.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
