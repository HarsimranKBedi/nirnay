import 'package:flutter/material.dart';

class HeroIngredientList {
  final String title;
  final String subtitle;
  final String image;
  final String price; 
  final String status; 

  HeroIngredientList({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price, 
    required this.status, 
  });
}

List<HeroIngredientList> ingredients = [
  HeroIngredientList(
    title: 'Rice',
    subtitle: 'Versatile and humble.',
    image: 'assets/rice.jpg',
    price: '₹50/kg',
    status: 'In Demand', 
  ),
  HeroIngredientList(
    title: 'Cotton',
    subtitle: 'Healthy green crunch.',
    image: 'assets/cotton.jpg',
    price: '₹60/kg',
    status: 'Falling in Market', 
  ),
  HeroIngredientList(
    title: 'Coffee',
    subtitle: 'Earthy and flavorful.',
    image: 'assets/coffee.jpg',
    price: '₹300/kg',
    status: 'In Demand',
  ),
  HeroIngredientList(
    title: 'Jute',
    subtitle: 'Soft, cheesy delight.',
    image: 'assets/jute.jpg',
    price: '₹80/kg',
    status: 'Falling in Market', 
  ),
  HeroIngredientList(
    title: 'Apple',
    subtitle: 'Nutrient-rich green leaf.',
    image: 'assets/apple.jpg',
    price: '₹120/kg',
    status: 'In Demand', 
  ),
  HeroIngredientList(
    title: 'Lentil',
    subtitle: 'Flavorful and pungent.',
    image: 'assets/lentil.jpg',
    price: '₹90/kg',
    status: 'Falling in Market', 
  ),
  HeroIngredientList(
    title: 'Kidney Beans',
    subtitle: 'Juicy and tangy.',
    image: 'assets/kidney beans.jpg',
    price: '₹100/kg',
    status: 'In Demand',
  ),
  HeroIngredientList(
    title: 'Black Gram',
    subtitle: 'Juicy and tangy.',
    image: 'assets/black gram.jpg',
    price: '₹110/kg',
    status: 'Falling in Market', 
  ),
  HeroIngredientList(
    title: 'Banana',
    subtitle: 'Juicy and tangy.',
    image: 'assets/banana.jpg',
    price: '₹40/dozen',
    status: 'In Demand', 
  ),
  HeroIngredientList(
    title: 'Papaya',
    subtitle: 'Juicy and tangy.',
    image: 'assets/papaya.jpg',
    price: '₹30/each',
    status: 'Falling in Market', 
  ),
];

