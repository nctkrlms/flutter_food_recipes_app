import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:foods_codes/dummy_data.dart';
import 'package:like_button/like_button.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  static const routeName = '/meal-detail-screen';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(
              context,
              'Ingredients',
            ),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
              ),
            ),
            buildSectionTitle(
              context,
              'Steps',
            ),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: RotatedBox(
        quarterTurns: 3,

        child: AnimatedButton(

          height: 35,
          width: 150,
          text: !isFavorite(mealId) ? '+ADD TO FAV' : '-SUB FROM FAV',
          textStyle: const TextStyle(color: Colors.orangeAccent),
          isSelected: true,
          isReverse: true,
          selectedTextColor: Colors.orangeAccent ,
          selectedBackgroundColor: !isFavorite(mealId) ? Colors.black : Colors.white,
          transitionType: TransitionType.RIGHT_TOP_ROUNDER,
          animationDuration: const Duration(milliseconds: 800),

          backgroundColor: !isFavorite(mealId) ? Colors.white : Colors.black,
          borderColor: Colors.black54,
          borderRadius: 50,
          borderWidth: 2,



          // onPressed: () =>toggleFavorite(mealId),

          onPress: () => toggleFavorite(mealId),
        ),
      ),
    );
  }
}
