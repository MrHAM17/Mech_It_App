

import 'package:flutter/material.dart';
import 'package:mech_it/user/break_downs_services_page.dart';
import 'package:mech_it/user/selected_services_page.dart';
import 'package:provider/provider.dart';

import 'package:mech_it/user/selected_services_page.dart';

class RoutineMaintenanceServicesPage extends StatefulWidget {
  @override
  _RoutineMaintenanceServicesPageState createState() => _RoutineMaintenanceServicesPageState();
}





class SelectedThingsModel extends ChangeNotifier
{
  List<String> selectedThings = [];

  // Add a method to remove a things from the list
  void removeFromSelectedThings(String things) {
    selectedThings.remove(things);
    notifyListeners();
  }

  void addToSelectedThings(String things) {
    selectedThings.add(things);
    notifyListeners();
  }
}







class _RoutineMaintenanceServicesPageState extends State<RoutineMaintenanceServicesPage> {
  int selectedIndex = 0; // Index to track the selected screen.
  final PageController pageController = PageController(initialPage: 0);
  int selectedButtonIndex = 0; // to track the current screen & its button

  // List of screens corresponding to the buttons.
  final List<Widget> screens = [
    InteriorScreen(),
    ExteriorScreen(),
    ChassisScreen(),
  ];

  // Update the selected button index based on the current screen index
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
                'Routine Maintenance Services',
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
                            selectedButtonIndex = 0; // Set the selected index for Interior button
                          });
                          changeScreen(0); // Navigate to InteriorScreen
                        },
                        child: Text('Interior'), // Use screen title
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedButtonIndex == 0 ? Colors.blue : Colors.grey, // Change button color based on selection
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 1; // Set the selected index for Exterior button
                          });
                          changeScreen(1); // Navigate to ExteriorScreen
                        },
                        child: Text('Exterior'), // Use screen title
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
                          selectedThings: selectedThings,
                          selectedProblems: selectedProblems, // Pass the selected problems list

                        )),
                      );

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SelectedServicesPage(
                      //       selectedThings: [],  // Pass an empty list initially
                      //       selectedProblems: [], // Pass an empty list initially
                      //     ), // Provide the NextScreen widget
                      //   ),
                      // );
                    },
                    child: Container(
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
                          Text('Subtotal Fare: ₹'),
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
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
List<String> selectedThings = [];







// This is Main 1st Screennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
class InteriorScreen extends StatefulWidget {
  @override
  _InteriorScreenState createState() => _InteriorScreenState();
}

class _InteriorScreenState extends State<InteriorScreen> {
  // Define your state variables here
  bool isChecked_OnePointOne = false; // Add this line
  bool isChecked_OnePointTwo = false; // Add this line

  String subProblemName_OnePointOne = "Alexogen sensor change"; // Subproblem name 1
  String expectedRent_OnePointOne = "Expected rent 670"; // Expected rent 1
  String subProblemName_OnePointTwo = "Change the break sensor"; // Subproblem name 2
  String expectedRent_OnePointTwo = "Expected rent 670"; // Expected rent 2

  List<String> selectedSubProblems = []; // Maintain a list for selected subproblems

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
                          CustomCheckbox(
                            value: isChecked_OnePointOne, // Pass the checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked_OnePointOne = value ?? false;
                              });
                            },
                          ), // Checkbox here
                          Expanded(
                            child: Text(
                              "Alexogen sensor change                          (Expected rent 670)",
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
                          CustomCheckbox(
                            value: isChecked_OnePointTwo, // Pass the checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked_OnePointTwo = value ?? false;
                              });
                            },
                          ), // Checkbox here
                          Expanded(
                            child: Text(
                              "Change the break sensor                          (Expected rent 670)",
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
                        // setState(() {
                        //   selectedThings.add("Sensor change");  // Add selected problem to the list @ code's part for adding in list
                        // });

                        if (isChecked_OnePointOne && !selectedSubProblems.contains(subProblemName_OnePointOne) )
                        {
                          setState(() {   selectedThings.add(subProblemName_OnePointOne + "   " + expectedRent_OnePointOne); });
                        }
                        if (isChecked_OnePointTwo &&  !selectedSubProblems.contains(subProblemName_OnePointTwo))
                        {
                          setState(() {  selectedThings.add(subProblemName_OnePointTwo + "   " + expectedRent_OnePointTwo); });
                        }

                        // Reset the checkboxes
                        // setState(() {
                        //   isChecked_OnePointOne = true;
                        //   isChecked_OnePointTwo = true;
                        // });

                      },
                      child: Text(
                        "Add to selected cart",
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
      create: (_) => SelectedThingsModel(), // Create an instance of your model
      child: Consumer<SelectedThingsModel>(
        builder: (context, selectedThingsModel, child) {
          return GestureDetector( // Return GestureDetector
            onTap: () {
              _showCustomBottomSheetOnePointOne(
                context,
                'Sensor change',
                'It contains 2 services',
              );
            },
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Sensor change',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'It contains 2 services',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Divider(), // Horizontal line or shadow
              ],
            ),
          );
        },
      ),

    );
  }
}







// This is Main 2nd Screennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
class ExteriorScreen extends StatefulWidget {
  @override
  _ExteriorScreenState createState() => _ExteriorScreenState();
}

class _ExteriorScreenState extends State<ExteriorScreen> {
  // Define your state variables here
  bool isChecked = false;
  bool isChecked_TwoPointOne = false; // Add this line

  String subProblemName_TwoPointOne = "Size 16 BOSCH change pad"; // Subproblem name 1
  String expectedRent_TwoPointOne = "(Expected rent 360)"; // Expected rent 1

  void _showCustomBottomSheetTwoPointOne(BuildContext context, String title, String content)
  {
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
                          CustomCheckbox(
                            value: isChecked_TwoPointOne, // Pass the checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked_TwoPointOne = value ?? false;
                              });
                            },
                          ),  // Checkbox here
                          Expanded(
                            child: Text(
                              "Size 16 BOSCH change pad                          (Expected rent 360)",
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
                        // setState(() {
                        //   selectedThings.add("Brake");  // Add selected problem to the list @ code's part for adding in list
                        // });

                        if (isChecked_TwoPointOne) {
                          setState(() {
                            selectedThings.add(subProblemName_TwoPointOne + "   " + expectedRent_TwoPointOne);
                          });
                        }
                      },
                      child: Text(
                        "Add to selected cart",
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
      create: (_) => SelectedThingsModel(), // Create an instance of your model
      child: Consumer<SelectedThingsModel>(
        builder: (context, selectedThingsModel, child) {
          return GestureDetector( // Return GestureDetector
            onTap: () {
              // Open the bottom screen for Text 1
              _showCustomBottomSheetTwoPointOne(
                context,
                'Brake',
                'It contains 1 serving',
              );
            },
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Brake',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'It contains 1 serving',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Divider(), // Horizontal line or shadow
              ],
            ),
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

class _ChassisScreenState extends State<ChassisScreen> {
  // Define your state variables here
  bool isChecked = false;
  bool isChecked_ThreePointOne = false; // Add this line

  String subProblemName_ThreePointOne = "Average sized 1 coach"; // Subproblem name 2
  String expectedRent_ThreePointOne = "(Expected rent 400)"; // Expected rent 2

  void _showCustomBottomSheetThreePointOne(BuildContext context, String title, String content)
  {
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
                          CustomCheckbox(
                            value: isChecked_ThreePointOne, // Pass the checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked_ThreePointOne = value ?? false;
                              });
                            },
                          ),   // Checkbox here
                          Expanded(
                            child: Text(
                              "Average sized 1 coach                          (Expected rent 400)",
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
                        // setState(() {
                        //   selectedThings.add("Coach");  // Add selected problem to the list @ code's part for adding in list
                        // });

                        if (isChecked_ThreePointOne) {
                          setState(() {
                            selectedThings.add(subProblemName_ThreePointOne + "   " + expectedRent_ThreePointOne);
                          });
                        }
                      },
                      child: Text(
                        "Add to selected cart",
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
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (_) => SelectedThingsModel(), // Create an instance of your model
      child: Consumer<SelectedThingsModel>(
        builder: (context, selectedThingsModel, child) {
          return GestureDetector(
            onTap: () {
              // Open the bottom screen for Text 1
              _showCustomBottomSheetThreePointOne(
                context,
                'Coach',
                'It contains 1 serving',
              );
            },
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Coach',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'It contains 1 serving',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Divider(), // Horizontal line or shadow
              ],
            ),
          );

        },
      ),
    );
  }
}








void main() {
  runApp(MaterialApp(home: RoutineMaintenanceServicesPage()));
}
