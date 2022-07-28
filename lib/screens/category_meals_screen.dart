import 'package:flutter/material.dart';
import 'package:foods_codes/widgets/meal_item.dart';
import '../dummy_data.dart';
import 'package:foods_codes/models/meal.dart';


class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);


  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState(){

    super.initState();

  }
  @override
  void didChangeDependencies(){
    if(!_loadedInitData){
    final routeArgs =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitData = true; }
    super.didChangeDependencies();


  }

  void _removeMeal (String mealId){
    setState((){
      displayedMeals?.removeWhere((meal) => meal.id == mealId);

    });

  }
  // final String categoryId;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            duration: displayedMeals![index].duration,
            affordability: displayedMeals![index].affordability,
            complexity: displayedMeals![index].complexity,

          );
        },
        itemCount: displayedMeals?.length,
      ),
    );
  }
}
