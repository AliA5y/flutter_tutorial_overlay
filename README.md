# Flutter Tutorial Overlay

A customizable Flutter widget for creating interactive app tutorials and onboarding experiences. This package allows you to highlight specific UI elements and display informative tooltips to guide users through your app's features.

## Features

- 🎯 **Target Highlighting**: Highlight any widget using GlobalKey
- 💬 **Customizable Tooltips**: Rich tooltips with titles, descriptions, and action buttons
- 🎨 **Flexible Styling**: Customize colors, borders, blur effects, and button styles
- 📱 **Responsive Design**: Automatically positions tooltips to fit screen boundaries
- 🔄 **Step-by-Step Navigation**: Navigate through multiple tutorial steps
- ⚡ **Easy Integration**: Simple setup with minimal code

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_tutorial_overlay: ^1.0.0
```

Then run:

```sh
flutter pub get
```

## Quick Start

1. Import the package

```dart
import 'package:flutter_tutorial_overlay/flutter_tutorial_overlay.dart';
```

2. Create GlobalKeys for your target widgets

```dart
final GlobalKey _buttonKey = GlobalKey();
final GlobalKey _menuKey = GlobalKey();
```

3. Assign keys to your widgets

```dart
ElevatedButton(
  key: _buttonKey,
  onPressed: () {},
  child: Text('Target Button'),
)
```

4. Create tutorial steps and show the overlay

```dart
void _startTutorial() {
  final steps = [
    TutorialStep(
      targetKey: _buttonKey,
      title: "Welcome!",
      description: "This is your main action button. Tap it to perform the primary action.",
    ),
    TutorialStep(
      targetKey: _menuKey,
      title: "Menu",
      description: "Access additional options and settings from this menu.",
    ),
  ];

  final tutorial = TutorialOverlay(
    context: context,
    steps: steps,
    onComplete: () {
      print('Tutorial completed!');
    },
  );

  tutorial.show();
}
```

## Advanced Usage

### Customization Options

```dart
TutorialOverlay(
  context: context,
  steps: steps,
  // Tooltip styling
  tooltipBackgroundColor: Colors.white,
  tooltipBorderRadius: 12.0,
  tooltipMaxWidth: 300.0,
  tooltipPadding: EdgeInsets.all(16.0),

  // Text styling
  titleTextColor: Colors.black87,
  descriptionTextColor: Colors.black54,

  // Highlight styling
  highlightRadius: 8.0,
  highlightBorderWidth: 2.0,
  highlightBorderColor: Colors.blue,
  targetPadding: 8.0,

  // Overlay styling
  blurSigma: 6.0,
  blurOpacity: 20,
  overlayTint: Color(0x8A000000),

  // Button customization
  nextButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  skipButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey,
  ),
  finishButtonStyle: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
  ),

  // Button text
  nextText: "Continue",
  skipText: "Skip Tour",
  finishText: "Done",

  // Behavior
  dismissable: true,
  showButtons: true,

  // Callbacks
  onNext: () => print('Next step'),
  onSkip: () => print('Tutorial skipped'),
  onFinish: () => print('Tutorial finished'),
  onComplete: () => print('Tutorial completed'),
);
```

### Hiding Buttons

You can create a tap-to-continue tutorial by hiding the buttons:

```dart
TutorialOverlay(
  context: context,
  steps: steps,
  showButtons: false,
  dismissable: true, // Allow tap anywhere to continue
);
```

## API Reference

### TutorialStep

| **Property** | **Type**  | **Description**                      |
| ------------ | --------- | ------------------------------------ |
| targetKey    | GlobalKey | The key of the widget to highlight   |
| title        | String    | The title text for the tooltip       |
| description  | String    | The description text for the tooltip |

### TutorialOverlay

| **Property**           | **Type**           | **Default**        | **Description**                   |
| ---------------------- | ------------------ | ------------------ | --------------------------------- |
| context                | BuildContext       | required           | The build context                 |
| steps                  | List<TutorialStep> | required           | List of tutorial steps            |
| onComplete             | VoidCallback?      | null               | Called when tutorial completes    |
| tooltipMaxWidth        | double             | 320.0              | Maximum width of tooltips         |
| tooltipBackgroundColor | Color              | Colors.white       | Background color of tooltips      |
| titleTextColor         | Color?             | null               | Color of title text               |
| descriptionTextColor   | Color?             | null               | Color of description text         |
| highlightRadius        | double             | 12.0               | Border radius of highlight        |
| highlightBorderColor   | Color              | Colors.transparent | Border color of highlight         |
| highlightBorderWidth   | double             | 0.0                | Border width of highlight         |
| targetPadding          | double             | 0.0                | Padding around target widget      |
| blurSigma              | double             | 6.0                | Blur intensity of overlay         |
| blurOpacity            | double             | 20                 | Opacity of overlay blur           |
| overlayTint            | Color              | Color(0x8A000000)  | Tint color of the overlay         |
| dismissable            | bool               | false              | Allow tap to dismiss              |
| showButtons            | bool               | true               | Show navigation buttons           |
| nextButtonStyle        | ButtonStyle?       | null               | Style for the "Next" button       |
| skipButtonStyle        | ButtonStyle?       | null               | Style for the "Skip" button       |
| finishButtonStyle      | ButtonStyle?       | null               | Style for the "Finish" button     |
| nextText               | String             | "Next"             | Text for the "Next" button        |
| skipText               | String             | "Skip"             | Text for the "Skip" button        |
| finishText             | String             | "Finish"           | Text for the "Finish" button      |
| onNext                 | VoidCallback?      | null               | Callback when moving to next step |
| onSkip                 | VoidCallback?      | null               | Callback when tutorial is skipped |
| onFinish               | VoidCallback?      | null               | Callback when tutorial finishes   |

## Examples

Check out the `/example` folder for a complete sample app demonstrating various features and customization options.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you find this package helpful, please give it a ⭐ on GitHub!

For issues and feature requests, please visit our issue tracker.
