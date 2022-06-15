import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryItem(
            isActive: true,
            title: "All",
            press: (){},
          ),
          const SizedBox(width: 20,),
          CategoryItem(
            title: "Giày dán",
            press: (){},
          ),
          const SizedBox(width: 20,),
          CategoryItem(
            title: "Giàn đúc",
            press: (){},
          ),

        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key,required this.title, required this.press,this.isActive = false,}) : super(key: key);
  final bool isActive;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        backgroundColor: isActive? const Color(0xFF070a15) : const Color(0xFFd7d9dd),
        label: Text(title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isActive? const Color(0xFFd7d9dd) : const Color(0xFF070a15),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}