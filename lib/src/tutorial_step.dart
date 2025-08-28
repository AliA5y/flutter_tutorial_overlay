import 'package:flutter/material.dart';

/// Represents a single step in a tutorial sequence.
/// 
/// Each step defines a target widget to highlight and the content to display
/// in the associated tooltip.
class TutorialStep {
  /// The GlobalKey of the widget to highlight in this tutorial step.
  /// 
  /// This key must be assigned to the widget you want to target before
  /// showing the tutorial.
  final GlobalKey targetKey;
  
  /// The description text displayed in the tooltip.
  /// 
  /// This is the main content that explains what the highlighted element does
  /// or how the user should interact with it.
  final String description;
  
  /// The title text displayed at the top of the tooltip.
  /// 
  /// This should be a brief, descriptive title for the tutorial step.
  final String title;

  /// Creates a new tutorial step.
  /// 
  /// All parameters are required:
  /// - [targetKey]: The key of the widget to highlight
  /// - [description]: The explanatory text for this step
  /// - [title]: The title for this step
  TutorialStep({
    required this.targetKey,
    required this.description,
    required this.title,
  });
}