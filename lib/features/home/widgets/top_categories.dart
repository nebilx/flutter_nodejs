import 'package:flutter/material.dart';
import 'package:flutter_nodejs/constants/global_variable.dart';
import 'package:flutter_nodejs/features/home/screens/category_deals_screen.dart';

class TopCatagories extends StatelessWidget {
  const TopCatagories({super.key});

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: ListView.builder(
          itemCount: GlobalVariable.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () => navigateToCategoryPage(
                context,
                GlobalVariable.categoryImages[index]['title']!,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariable.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariable.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
