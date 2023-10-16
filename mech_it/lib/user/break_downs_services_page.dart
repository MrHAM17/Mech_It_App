

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mech_it/user/routine_maintenance_services_page.dart';
import 'package:cupertino_icons/cupertino_icons.dart';


class BreakDownsServicesPage extends StatefulWidget {
  @override
  _BreakDownsServicesPageState createState() => _BreakDownsServicesPageState();
}







class SelectedProblemsModel extends ChangeNotifier
{
  List<String> selectedProblems = [];

  // Add a method to remove a problem from the list
  void removeFromSelectedProblems(String problem) {
    selectedProblems.remove(problem);
    notifyListeners();
  }

  void addToSelectedProblems(String problem) {
    selectedProblems.add(problem);
    notifyListeners();
  }
}







class _BreakDownsServicesPageState extends State<BreakDownsServicesPage> {
  int selectedIndex = 0; // Index to track the selected screen.
  final PageController pageController = PageController(initialPage: 0);
  int selectedButtonIndex = 0; // to track the current screen & its button


  // List of screens corresponding to the buttons.
  final List<Widget> screens = [
    ExteriorScreen(),
    EngineScreen(),
    ChassisScreen(),
    InteriorScreen(),
  ];

  // Add the updateSelectedButtonIndex method here
  void updateSelectedButtonIndex(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Function to change the selected screen index
  void changeScreen(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image and Overlay
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Image.asset(
              'assets/user images/mechanic_services.png',
            ),
          ),
          Container(
            color: Color.fromRGBO(0, 0, 250, 0.3),
          ),

          // Title "Break Downs Services"
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(bottom: 100),
              child: Text(
                'Break Downs Services',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),

          // Bottom Sheet with Buttons and Screens
          Positioned(
            bottom: 2,
            left: 4,
            right: 4,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  // "Select one of your vehicles" Text
                  Align(
                    alignment: Alignment.topLeft, // Adjust the alignment as needed
                    child: Row(
                      children: [
                        SizedBox(width: 14, height: 40),
                        Icon(Icons.directions_car), // Car icon
                        SizedBox(width: 10, height: 40),
                        Text(
                          'Select one of your vehicles',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 0; // Set the selected index for Exterior button
                          });
                          changeScreen(0); // Navigate to ExteriorScreen
                        },
                        child: Text('Exterior'), // Use screen title
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedButtonIndex == 0 ? Colors.blue : Colors.grey, // Change button color based on selection
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 1; // Set the selected index for Engine button
                          });
                          changeScreen(1); // Navigate to EngineScreen
                        },
                        child: Text('Engine'), // Use screen title
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedButtonIndex == 1 ? Colors.blue : Colors.grey, // Change button color based on selection
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 2; // Set the selected index for Chassis button
                          });
                          changeScreen(2); // Navigate to ChassisScreen
                        },
                        child: Text('Chassis'), // Use screen title
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedButtonIndex == 2 ? Colors.blue : Colors.grey, // Change button color based on selection
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 3; // Set the selected index for Interior button
                          });
                          changeScreen(3); // Navigate to InteriorScreen
                        },
                        child: Text('Interior'), // Use screen title
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedButtonIndex == 3 ? Colors.blue : Colors.grey, // Change button color based on selection
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Swipeable Screens
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                        updateSelectedButtonIndex(index); // Update the selected button index
                      },
                      children: screens,
                    ),
                  ),

                  // Fixed Rectangle Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectedServicesPage(
                      selectedProblems: selectedProblems, // Pass the selected problems list

                    )),
                  );
                },
                child:  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Circular Ring with Number Icon
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Icon(Icons.stop_circle), // Number icon
                          ),
                        ),
                        SizedBox(width: 8),

                        // "View Selected" Text
                        Text('View Selected'),

                        Spacer(),

                        // "Subtotal Fare: 0.0" Text
                        Text('Subtotal Fare: 0.0 ₹'),
                        Icon(Icons.stop), // Number icon
                      ],
                    ),
                  ),
              ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}







class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }
}

List<String> selectedProblems = [];







// Define your screens here
class SelectedServicesPage extends StatelessWidget
{
  final List<String> selectedProblems;

  SelectedServicesPage({required this.selectedProblems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Services"),
      ),
      body: ListView.builder(
        itemCount: selectedProblems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedProblems[index]),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                // You can remove the item from the selectedProblems list here
                // Example: selectedProblems.removeAt(index);
                // To update the state in the parent widget, use the state management solution you've chosen.
                Provider.of<SelectedProblemsModel>(context, listen: false)
                    .removeFromSelectedProblems(selectedProblems[index]);
              },
            ),
          );
        },
      ),
    );
  }
}





// This is Main 1st Screennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
class ExteriorScreen extends StatefulWidget {
  @override
  _ExteriorScreenState createState() => _ExteriorScreenState();
}

class _ExteriorScreenState extends State<ExteriorScreen> {
  // Define your state variables here
  bool isChecked = false;

  void _showCustomBottomSheetOnePointOne(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Make all corners circular
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Added padding below the icon
                    child: Icon(
                      Icons.arrow_drop_down_circle, // Arrow icon
                      size: 40,
                      color: Colors.blue, // Change the color as desired
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20, // Increased font size for the title
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Title text color
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey, // Content text color
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          // Checkbox(
                          //   value: false, // You can set the initial value accordingly
                          //   onChanged: (bool? value) {
                          //     // Handle checkbox change
                          //   },
                          // ),
                          Expanded(
                            child: Text(
                              "Steering wheel is damaged in vain",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          // Checkbox(
                          //   value: false, // You can set the initial value accordingly
                          //   onChanged: (bool? value) {
                          //     // Handle checkbox change
                          //   },
                          // ),
                          Expanded(
                            child: Text(
                              "Difficulty & decrease in steering wheel",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          // Checkbox(
                          //   value: false, // You can set the initial value accordingly
                          //   onChanged: (bool? value) {
                          //     // Handle checkbox change
                          //   },
                          // ),
                          Expanded(
                            child: Text(
                              "Steering wheel is damaged in empty space",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 190),
                Align(
                  alignment: Alignment.bottomCenter, // Align button to the right
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button click
                        setState(() {
                          selectedProblems.add("Failure to respond to direction");  // Add selected problem to the list @ code's part for adding in list
                        });
                      },
                      child: Text(
                        "Add to selected breakdowns",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0), // Rounded corners
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomBottomSheetOnePointTwo(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Make all corners circular
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Added padding below the icon
                    child: Icon(
                      Icons.arrow_drop_down_circle, // Arrow icon
                      size: 40,
                      color: Colors.blue, // Change the color as desired
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20, // Increased font size for the title
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Title text color
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey, // Content text color
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          Expanded(
                            child: Text(
                              "One of tires explooded & there was intact stub in car",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          Expanded(
                            child: Text(
                              "One of tires exploded & there was no intact tire in car",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 233),
                Align(
                  alignment: Alignment.bottomCenter, // Align button to the right
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button click
                        setState(() {
                          selectedProblems.add("Tires");  // Add selected problem to the list @ code's part for adding in list
                        });
                      },
                      child: Text(
                        "Add to selected breakdowns",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0), // Rounded corners
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomBottomSheetOnePointThree(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Make all corners circular
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Added padding below the icon
                    child: Icon(
                      Icons.arrow_drop_down_circle, // Arrow icon
                      size: 40,
                      color: Colors.blue, // Change the color as desired
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20, // Increased font size for the title
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Title text color
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey, // Content text color
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          Expanded(
                            child: Text(
                              "Battery was replaced within a year",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 282),
                Align(
                  alignment: Alignment.bottomCenter, // Align button to the right
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button click
                        setState(() {
                          selectedProblems.add("Battery light on");  // Add selected problem to the list @ code's part for adding in list
                        });
                      },
                      child: Text(
                        "Add to selected breakdowns",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0), // Rounded corners
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedProblemsModel(), // Create an instance of your model
      child: Consumer<SelectedProblemsModel>(
        builder: (context, selectedProblemsModel, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 1
                  _showCustomBottomSheetOnePointOne(
                    context,
                    'Failure to respond to direction',
                    'It contains 3 sub-problems',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Failure to respond to direction',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'It contains 3 sub-problems',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 2
                  _showCustomBottomSheetOnePointTwo(
                    context,
                    'Tires',
                    'It contains 2 sub-problems',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Tires',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'It contains 2 sub-problems',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 3
                  _showCustomBottomSheetOnePointThree(
                    context,
                    'Battery light on',
                    'It contains 1 sub-problem',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Battery light on',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'It contains 1 sub-problem',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
            ],
          );
        },
      ),
    );
  }
}








// This is Main 2nd Screennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
class EngineScreen extends StatefulWidget {
  @override
  _EngineScreenState createState() => _EngineScreenState();
}

class _EngineScreenState extends State<EngineScreen>  {
  // Define your state variables here
  bool isChecked = false;


  void _showCustomBottomSheetTwoPointOne(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Make all corners circular
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Added padding below the icon
                    child: Icon(
                      Icons.arrow_drop_down_circle, // Arrow icon
                      size: 40,
                      color: Colors.blue, // Change the color as desired
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20, // Increased font size for the title
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Title text color
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey, // Content text color
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          Expanded(
                            child: Text(
                              "Something went wrong",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 257),
                Align(
                  alignment: Alignment.bottomCenter, // Align button to the right
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button click
                        setState(() {
                          selectedProblems.add("Engine doesn't respond to attempts to re-rotate");  // Add selected problem to the list @ code's part for adding in list
                        });
                      },
                      child: Text(
                        "Add to selected breakdowns",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0), // Rounded corners
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomBottomSheetTwoPointTwo(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Make all corners circular
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Added padding below the icon
                    child: Icon(
                      Icons.arrow_drop_down_circle, // Arrow icon
                      size: 40,
                      color: Colors.blue, // Change the color as desired
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20, // Increased font size for the title
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Title text color
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey, // Content text color
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CustomCheckbox(), // Checkbox here
                          Expanded(
                            child: Text(
                              "Running out of fuel",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Checkbox text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 282),
                Align(
                  alignment: Alignment.bottomCenter, // Align button to the right
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button click
                        setState(() {
                          selectedProblems.add("A suuden stop of vehicle");  // Add selected problem to the list @ code's part for adding in list
                        });
                      },
                      child: Text(
                        "Add to selected breakdowns",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0), // Rounded corners
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedProblemsModel(), // Create an instance of your model
      child: Consumer<SelectedProblemsModel>(
        builder: (context, selectedProblemsModel, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 1
                  _showCustomBottomSheetTwoPointOne(
                    context,
                    "Engine doesn't respond to attempts to re-rotate",
                    'No sub-problems',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Engine doesn't respond to attempts to re-rotate",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'No sub-problems',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 2
                  _showCustomBottomSheetTwoPointTwo(
                    context,
                    'A sudden stop of vehicle',
                    'It contains 1 sub-problems',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'A sudden stop of vehicle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'It contains 1 sub-problems',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
            ],
          );
        },
      ),
    );
  }
}









// This is Main 3rd Screennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
class ChassisScreen extends StatefulWidget {
  @override
  _ChassisScreenState createState() => _ChassisScreenState();
}

class _ChassisScreenState extends State<ChassisScreen>  {
  // Define your state variables here
  bool isChecked = false;

  void _showCustomBottomSheetThreePointOne(BuildContext context, String title, String content) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Make all corners circular
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Added padding below the icon
                      child: Icon(
                        Icons.arrow_drop_down_circle, // Arrow icon
                        size: 40,
                        color: Colors.blue, // Change the color as desired
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20, // Increased font size for the title
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Title text color
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey, // Content text color
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CustomCheckbox(), // Checkbox here
                            Expanded(
                              child: Text(
                                "Average damaged to few parts",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black, // Checkbox text color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 282),
                  Align(
                    alignment: Alignment.bottomCenter, // Align button to the right
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button click
                          setState(() {
                            selectedProblems.add("Accident");  // Add selected problem to the list @ code's part for adding in list
                          });
                        },
                        child: Text(
                          "Add to selected breakdowns",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0), // Rounded corners
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedProblemsModel(), // Create an instance of your model
      child: Consumer<SelectedProblemsModel>(
        builder: (context, selectedProblemsModel, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 1
                  _showCustomBottomSheetThreePointOne(
                    context,
                    'Accident',
                    'It contains 1 sub-problem',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Accident',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'It contains 1 sub-problem',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
            ],
          );
        },
      ),
    );
  }

}









// This is Main 4th Screennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
class InteriorScreen extends StatefulWidget {
  @override
  _InteriorScreenState createState() => _InteriorScreenState();
}

class _InteriorScreenState extends State<InteriorScreen> {
  // Define your state variables here
  bool isChecked = false;


  void _showCustomBottomSheetFourPointOne(BuildContext context, String title, String content) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Make all corners circular
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Added padding below the icon
                      child: Icon(
                        Icons.arrow_drop_down_circle, // Arrow icon
                        size: 40,
                        color: Colors.blue, // Change the color as desired
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0), // Added padding above "Failure..."
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20, // Increased font size for the title
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Title text color
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey, // Content text color
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CustomCheckbox(), // Checkbox here
                            Expanded(
                              child: Text(
                                "There no breaks in vehicle",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black, // Checkbox text color
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CustomCheckbox(), // Checkbox here
                            Expanded(
                              child: Text(
                                "Sound in one of the wheels when brake pedal is pressed",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black, // Checkbox text color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 212),
                  Align(
                    alignment: Alignment.bottomCenter, // Align button to the right
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button click
                          setState(() {
                            selectedProblems.add("Brakes");  // Add selected problem to the list @ code's part for adding in list
                          });
                        },
                        child: Text(
                          "Add to selected breakdowns",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0), // Rounded corners
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedProblemsModel(), // Create an instance of your model
      child: Consumer<SelectedProblemsModel>(
        builder: (context, selectedProblemsModel, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Open the bottom screen for Text 1
                  _showCustomBottomSheetFourPointOne(
                    context,
                    'Brakes',
                    'It contains 2 sub-problems',
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Brakes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'It contains 2 sub-problems',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(), // Horizontal line or shadow
            ],
          );
        },
      ),
    );
  }

}









void main() {
  runApp(MaterialApp(home: BreakDownsServicesPage()));
}



