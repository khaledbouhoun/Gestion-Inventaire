import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:invontar/constant/color.dart';
import 'package:invontar/data/model/inventaireentete_model.dart';
import 'package:intl/intl.dart';

class InventaireEnteteWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final InventaireEnteteModel inventaire;

  const InventaireEnteteWidget({super.key, required this.inventaire, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.primaryColor.withOpacity(0.3), width: 2),
              boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 4))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Inventory #${inventaire.ineno}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          DateFormat('dd-MMM-yyyy').format(inventaire.inedate ?? DateTime.now()),
                          style: TextStyle(fontSize: 18, color: AppColor.primaryColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined, color: AppColor.primaryColor, size: 25),
                      const SizedBox(width: 15),
                      const Text('View Details', style: TextStyle(color: Color.fromARGB(255, 27, 111, 136), fontSize: 16)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, color: AppColor.primaryColor, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
