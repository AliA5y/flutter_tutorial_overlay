import 'package:flutter/material.dart';
import 'package:flutter_tutorial_overlay/flutter_tutorial_overlay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutorial Overlay Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TutorialExample(),
    );
  }
}

class TutorialExample extends StatefulWidget {
  @override
  _TutorialExampleState createState() => _TutorialExampleState();
}

class _TutorialExampleState extends State<TutorialExample> {
  final GlobalKey _fabKey = GlobalKey();
  final GlobalKey _drawerKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _titleKey = GlobalKey();
  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial Example', key: _titleKey),
        actions: [
          IconButton(icon: Icon(Icons.help_outline), onPressed: _startTutorial),
        ],
        leading: IconButton(
          key: _drawerKey,
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home')),
            ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Tutorial Example!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Text(
              'This example demonstrates how to use the Flutter Tutorial Overlay package. Tap the help icon in the app bar to start the tutorial.',
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                key: _listKey,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text('List Item ${index + 1}'),
                      subtitle: Text('This is a sample list item'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _startBasicTutorial,
                  child: Text('Basic Tutorial'),
                ),
                ElevatedButton(
                  onPressed: _startCustomTutorial,
                  child: Text('Custom Tutorial'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Floating Action Button pressed!')),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _startTutorial() {
    final steps = [
      TutorialStep(
        targetKey: _titleKey,
        title: "App Title",
        description:
            "This is the title of your app. It helps users understand what the app is about.",
      ),
      TutorialStep(
        targetKey: _drawerKey,
        title: "Navigation Menu",
        description:
            "Tap this button to open the navigation drawer and access different sections of the app.",
      ),
      TutorialStep(
        targetKey: _listKey,
        title: "Content List",
        description:
            "This is where your main content is displayed. You can scroll through items here.",
      ),
      TutorialStep(
        targetKey: _fabKey,
        title: "Add Button",
        description:
            "Use this floating action button to add new items or perform the main action in your app.",
      ),
    ];

    final tutorial = TutorialOverlay(
      context: context,
      steps: steps,
      onComplete: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Tutorial completed! 🎉')));
      },
    );

    tutorial.show();
  }

  void _startBasicTutorial() {
    final steps = [
      TutorialStep(
        targetKey: _fabKey,
        title: "Basic Tutorial",
        description: "This is a basic tutorial with default styling.",
      ),
    ];

    final tutorial = TutorialOverlay(
      context: context,
      steps: steps,
      showButtons: false,
      dismissable: true,
    );

    tutorial.show();
  }

  void _startCustomTutorial() {
    final steps = [
      TutorialStep(
        targetKey: _fabKey,
        title: "Custom Styled Tutorial",
        description:
            "This tutorial has custom styling with different colors and button styles.",
      ),
    ];

    final tutorial = TutorialOverlay(
      context: context,
      steps: steps,
      tooltipBackgroundColor: Colors.purple.shade50,
      titleTextColor: Colors.purple.shade800,
      descriptionTextColor: Colors.purple.shade600,
      highlightBorderColor: Colors.purple,
      highlightBorderWidth: 3,
      nextButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      skipButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
      ),
      nextText: "Got it!",
      skipText: "Close",
      blurSigma: 10,
    );

    tutorial.show();
  }
}
