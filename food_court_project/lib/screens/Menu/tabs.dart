import 'package:flutter/material.dart';

// import 'package:meals/models/meal.dart';
// import 'package:meals/screens/categories.dart';
// import 'package:meals/screens/filters.dart';
// import 'package:meals/screens/meals.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:food_court_project/screens/sales_analysis_screen.dart';
import 'package:food_court_project/screens/Menu/menu_management_screen.dart';
import 'package:food_court_project/screens/Menu/testColor.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite.');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Marked as a favorite!');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // void _setScreen(String identifier) {
  //   Navigator.of(context).pop();
  //   if (identifier == 'filters') {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (ctx) => const FiltersScreen(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Widget activePage = CategoriesScreen(
    //   onToggleFavorite: _toggleMealFavoriteStatus,
    // );

    //Set default
    Widget activePage;
    String activePageTitle;

    // if (_selectedPageIndex == 1) {
    // activePage = MealsScreen(
    //   meals: _favoriteMeals,
    //   onToggleFavorite: _toggleMealFavoriteStatus,
    // );
    // }
    switch (_selectedPageIndex) {
      case 0:
        {
          activePageTitle = 'Sales Analysis';
          activePage = const SalesAnalysisScreen();
        }
        break;
      case 1:
        {
          activePageTitle = 'Management menu';
          activePage = const MenuManagermentScreen();
        }
        break;
      case 2:
        {
          activePageTitle = 'Menu';
          activePage = const TestScreen();
        }
        break;
      case 3:
        {
          activePageTitle = 'Cart';
          activePage = const TestScreen();
        }
        break;
      case 4:
        {
          activePageTitle = 'Account';
          activePage = const TestScreen();
        }
        break;
      default:
        {
          activePageTitle = 'Sales Analysis';
          activePage = const SalesAnalysisScreen();
        }
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: _setScreen,
      // ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Sales analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_rounded),
            label: 'Management',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
