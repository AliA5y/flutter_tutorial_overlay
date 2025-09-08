# Migration Guide

## Migrating from v1.0.0 to v1.0.1

Version 1.0.1 introduces step-specific callbacks and deprecates the global `onNext` callback. This guide will help you migrate your existing code.

### What's Changed

1. **New**: `TutorialStep.tag` property for step identification
2. **New**: `TutorialStep.onStepNext` callback for step-specific handling
3. **Deprecated**: `TutorialOverlay.onNext` callback

### Migration Steps

#### 1. Replace Global onNext with Step-Specific Callbacks

## Before (v1.0.0):\*

```dart
final tutorial = TutorialOverlay(
  context: context,
  steps: [
    TutorialStep(
      targetKey: buttonKey,
      title: "Button",
      description: "This is a button",
    ),
    TutorialStep(
      targetKey: menuKey,
      title: "Menu",
      description: "This is a menu",
    ),
  ],
  onNext: () {
    print('User went to next step');
    // Global handling for all steps
  },
);
```

## After (v1.0.1):

```dart
final tutorial = TutorialOverlay(
  context: context,
  steps: [
    TutorialStep(
      targetKey: buttonKey,
      title: "Button",
      description: "This is a button",
      tag: "main_button", // Optional but recommended
      onStepNext: (stepTag) {
        print('User completed step: $stepTag');
        // Step-specific handling
        if (stepTag == "main_button") {
          // Handle button step completion
        }
      },
    ),
    TutorialStep(
      targetKey: menuKey,
      title: "Menu",
      description: "This is a menu",
      tag: "navigation_menu",
      onStepNext: (stepTag) {
        print('User completed step: $stepTag');
        // Different handling for menu step
        if (stepTag == "navigation_menu") {
          // Handle menu step completion
        }
      },
    ),
  ],
  // Remove onNext - it's deprecated
);
```

#### 2. Add Tags for Better Step Identification

Tags are optional but highly recommended for analytics and step-specific logic:

```dart

TutorialStep(
  targetKey: myKey,
  title: "Feature Title",
  description: "Feature description",
  tag: "feature_intro", // Use meaningful, unique identifiers
  onStepNext: (stepTag) {
    // stepTag will be "feature_intro"
    analytics.logEvent('tutorial_step_completed', {'step': stepTag});
  },
)
```

If you don't provide a tag, the step index (as a string) will be used:

```dart
TutorialStep(
  targetKey: myKey,
  title: "Feature Title",
  description: "Feature description",
  // No tag provided
  onStepNext: (stepTag) {
    // stepTag will be "0", "1", "2", etc. based on step position
    print('Step $stepTag completed');
  },
)
```

#### 3. Analytics Integration Example

Here's how to upgrade your analytics tracking:

### Before:

```dart

TutorialOverlay(
  context: context,
  steps: steps,
  onNext: () {
    // Can't tell which step was completed
    analytics.logEvent('tutorial_step_completed');
  },
)
```

### After:

```dart
TutorialOverlay(
  context: context,
  steps: [
    TutorialStep(
      targetKey: searchKey,
      title: "Search",
      description: "Find content easily",
      tag: "search_feature",
      onStepNext: (stepTag) {
        analytics.logEvent('tutorial_step_completed', {
          'step_id': stepTag,
          'step_name': 'Search Feature',
        });
      },
    ),
    TutorialStep(
      targetKey: profileKey,
      title: "Profile",
      description: "Manage your account",
      tag: "profile_management",
      onStepNext: (stepTag) {
        analytics.logEvent('tutorial_step_completed', {
          'step_id': stepTag,
          'step_name': 'Profile Management',
        });
      },
    ),
  ],
)
```

## Breaking Changes

None. This is a non-breaking change. Your existing code will continue to work but will show deprecation warnings in the debug console.

## Timeline

v1.0.1: onNext is deprecated but still functional
v2.0.0: onNext will be removed entirely

## Benefits of Migration

Better Organization: Step-specific callbacks keep related logic together
Enhanced Analytics: Track individual step completion with tags
Improved Debugging: Know exactly which step triggered an action
Future-Proofing: Prepare for v2.0.0 when deprecated features are removed

## Need Help?

### If you encounter issues during migration:

Check the example app for updated patterns
Review the API documentation
Open an issue on GitHub

## Gradual Migration Strategy

### You can migrate step by step:

Phase 1: Add tags to existing steps
Phase 2: Add onStepNext callbacks alongside existing onNext
Phase 3: Remove onNext callback
Phase 4: Enhance step-specific logic as needed
This allows you to migrate at your own pace while maintaining functionality.
