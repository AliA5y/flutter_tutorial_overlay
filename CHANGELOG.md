## latest

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-09-08

### Added

- `tag` property to `TutorialStep` for unique step identification
- `onStepNext` callback to `TutorialStep` for step-specific next button handling
- `getEffectiveTag()` method to `TutorialStep` that returns the tag or step index as fallback
- Deprecation warning when using the deprecated `onNext` callback

### Deprecated

- `TutorialOverlay.onNext` callback - Use `TutorialStep.onStepNext` instead
  - This provides better step-specific control and cleaner code organization
  - Will be removed in version 2.0.0
  - Migration guide added to documentation

### Changed

- Step-specific callbacks now receive the step tag as a parameter
- Improved documentation with migration examples
- Enhanced API reference with deprecation warnings

### Fixed

- Better callback organization for step-specific handling

### Migration Guide

Replace the global `onNext` callback with step-specific `onStepNext` callbacks:

**Before:**

```dart
TutorialOverlay(
  context: context,
  steps: steps,
  onNext: () => print('Next step'),
)
```

After:

```dart
TutorialOverlay(
  context: context,
  steps: [
    TutorialStep(
      targetKey: myKey,
      title: "Step 1",
      description: "Description",
      tag: "step_1",
      onStepNext: (stepTag) => print('Completed step: $stepTag'),
    ),
  ],
)
```

## [1.0.0] - 2025-08-25

### Added

- Initial release of Flutter Tutorial Overlay
- Interactive tutorial overlay with target highlighting
- Customizable tooltips with titles and descriptions
- Step-by-step navigation through tutorial steps
- Responsive tooltip positioning
- Blur overlay with highlighted target areas
- Customizable styling options for tooltips, buttons, and highlights
- Support for custom button styles and text
- Dismissable overlay option
- Comprehensive callback system (onNext, onSkip, onFinish, onComplete)
- MIT License
- Comprehensive documentation and examples

### Features

- Target widget highlighting using GlobalKey
- Automatic tooltip positioning to avoid screen edges
- Customizable blur effects and overlay tinting
- Button customization (Next, Skip, Finish)
- Responsive design for mobile devices
- Arrow indicators pointing to target elements
