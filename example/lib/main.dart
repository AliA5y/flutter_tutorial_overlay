import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
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
  TutorialExampleState createState() => TutorialExampleState();
}

class TutorialExampleState extends State<TutorialExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _fabKey = GlobalKey();
  final GlobalKey _drawerKey = GlobalKey();
  final GlobalKey _titleKey = GlobalKey();
  final GlobalKey _listKey = GlobalKey();
  final GlobalKey _searchKey = GlobalKey();

  String lastCompletedStep = 'None';
  final List<String> completedSteps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial Example', key: _titleKey),
        actions: [
          IconButton(
            key: _searchKey,
            icon: Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Search pressed!')));
            },
          ),
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
              'Tutorial Overlay v1.0.1',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step Tracking (New!)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Last completed step: $lastCompletedStep'),
                    SizedBox(height: 8),
                    Text('Completed steps: ${completedSteps.join(", ")}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This example demonstrates the new step-specific callbacks and tagging features. Tap the help icon to start the tutorial.',
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
                  onPressed: _startNewFeatureTutorial,
                  child: Text('New Features'),
                ),
                ElevatedButton(
                  onPressed: _startTrackingTutorial,
                  child: Text('With Tracking'),
                ),
                ElevatedButton(
                  onPressed: _startLegacyTutorial,
                  child: Text('Legacy (Deprecated)'),
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
        title: 'App Title',
        description:
            'This is the title of your app. It helps users understand what the app is about.',
        tag: 'app_title',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
        },
      ),
      TutorialStep(
        targetKey: _searchKey,
        title: 'Search Feature',
        description: 'Use this search button to find content quickly.',
        tag: 'search_button',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
        },
      ),
      TutorialStep(
        targetKey: _drawerKey,
        title: 'Navigation Menu',
        description:
            'Tap this button to open the navigation drawer and access different sections of the app.',
        tag: 'navigation_drawer',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
        },
      ),
      TutorialStep(
        targetKey: _listKey,
        title: 'Content List',
        description:
            'This is where your main content is displayed. You can scroll through items here.',
        tag: 'content_list',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
        },
      ),
      TutorialStep(
        targetKey: _fabKey,
        title: 'Add Button',
        description:
            'Use this floating action button to add new items or perform the main action in your app.',
        tag: 'add_button',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
        },
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

  void _startNewFeatureTutorial() {
    final steps = [
      TutorialStep(
        targetKey: _fabKey,
        title: 'New in v1.0.1',
        description:
            'This tutorial demonstrates the new step-specific callbacks and tagging features!',
        tag: 'new_features_demo',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
          // Show additional info
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Step-specific callback executed for: $stepTag'),
            ),
          );
        },
      ),
    ];

    final tutorial = TutorialOverlay(
      context: context,
      steps: steps,
      tooltipBackgroundColor: Colors.green.shade50,
      titleTextColor: Colors.green.shade800,
      descriptionTextColor: Colors.green.shade600,
      highlightBorderColor: Colors.green,
      nextText: 'Cool!',
      skipText: 'Skip',
    );

    tutorial.show();
  }

  void _startTrackingTutorial() {
    final steps = [
      TutorialStep(
        targetKey: _searchKey,
        title: 'Analytics Integration',
        description:
            'Each step can now be tracked individually for better analytics.',
        tag: 'analytics_search',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
          // Simulate analytics call
          _logAnalyticsEvent(stepTag);
        },
      ),
      TutorialStep(
        targetKey: _fabKey,
        title: 'User Behavior Tracking',
        description: 'Monitor which tutorial steps users complete most often.',
        tag: 'analytics_fab',
        onStepNext: (stepTag) {
          _trackStepCompletion(stepTag);
          _logAnalyticsEvent(stepTag);
        },
      ),
    ];

    final tutorial = TutorialOverlay(
      context: context,
      steps: steps,
      tooltipBackgroundColor: Colors.purple.shade50,
      titleTextColor: Colors.purple.shade800,
      descriptionTextColor: Colors.purple.shade600,
      highlightBorderColor: Colors.purple,
    );

    tutorial.show();
  }

  // Example of the deprecated approach (will show warning)
  void _startLegacyTutorial() {
    final steps = [
      TutorialStep(
        targetKey: _fabKey,
        title: 'Legacy Approach',
        description:
            'This uses the deprecated onNext callback. Check the debug console for warnings.',
        // No tag or onStepNext - using legacy approach
      ),
      TutorialStep(
        targetKey: _listKey,
        title: 'Legacy Approach',
        description:
            'This uses the deprecated onNext callback. Check the debug console for warnings.',
        // No tag or onStepNext - using legacy approach
      ),
    ];

    final tutorial = TutorialOverlay(
      context: context,
      steps: steps,
      // This will trigger a deprecation warning
      // ignore: deprecated_member_use
      onNext: () {
        print('Legacy onNext callback - this is deprecated!');
      },
      tooltipBackgroundColor: Colors.orange.shade50,
      titleTextColor: Colors.orange.shade800,
      descriptionTextColor: Colors.orange.shade600,
      highlightBorderColor: Colors.orange,
    );

    tutorial.show();
  }

  void _trackStepCompletion(String stepTag) {
    setState(() {
      lastCompletedStep = stepTag;
      if (!completedSteps.contains(stepTag)) {
        completedSteps.add(stepTag);
      }
    });
  }

  void _logAnalyticsEvent(String stepTag) {
    // Simulate analytics logging
    print('📊 Analytics: Tutorial step completed - $stepTag');
    print('📊 Total completed steps: ${completedSteps.length}');
  }
}
