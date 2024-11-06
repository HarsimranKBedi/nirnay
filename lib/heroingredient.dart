import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirnay/heroingredientlist.dart';

class HeroIngredient extends StatefulWidget {
  @override
  _HeroIngredientState createState() => _HeroIngredientState();
}

class _HeroIngredientState extends State<HeroIngredient> {
  @override
  void initState() {
    super.initState();
   
  }

  void _showIngredientDetails(HeroIngredientList ingredient) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ingredient.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price: ${ingredient.price}'),
              SizedBox(height: 10.h),
              Text('Market Status: ${ingredient.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ingredients.shuffle(); 

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 25.w, right: 25.w),
              child: Text(
                'Explore by Crop Price',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 12.h, left: 25.w, right: 25.w, bottom: 25.h),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 15.h,
            ),
            itemCount: 4, 
            itemBuilder: (context, index) {
              final element = ingredients[index];
              return Stack(
                children: [
                  Container(
                    height: 180.h,
                    width: 136.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: AssetImage(element.image),
                        fit: BoxFit.cover,
                        opacity: 0.88,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    top: 90.h,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w, top: 0),
                      width: 136.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 242, 242)
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13.r),
                          topRight: Radius.circular(13.r),
                          bottomLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                element.title,
                                style: GoogleFonts.roboto(fontSize: 12.sp),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showIngredientDetails(element); 
                                },
                                icon: Icon(Icons.remove_red_eye, size: 20.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
