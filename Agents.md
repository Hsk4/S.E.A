# Development Guidelines for Future Agents

## Overview

This document outlines the coding standards and linting rules that must be followed for all code contributions to the S.E.A System project. These guidelines ensure code quality, maintainability, and consistency across the entire codebase.

## Dart Linting Standards

All Dart code must pass Flutter's linting checks before being committed. Our project uses **Flutter v9 linting rules** as defined in the official Dart linter documentation: https://dart.dev/tools/linter-rules

### Required Linting Configuration

The project is configured with a comprehensive `analysis_options.yaml` file in `apps/mobile/analysis_options.yaml` that enforces 160+ linting rules across two categories:

#### 1. **Error Rules** (Critical - Prevent Runtime Issues)

These rules must **never** be violated:
- **`avoid_empty_else`** - Every if statement must have a meaningful else block
- **`avoid_print`** - Use logging framework instead of print()
- **`avoid_relative_lib_imports`** - Use package imports (e.g., `package:mobile/...`)
- **`avoid_returning_null_for_future`** - Return proper Future values
- **`close_sinks`** - Always close Sink objects to prevent resource leaks
- **`cancel_subscriptions`** - Cancel all StreamSubscriptions to prevent memory leaks
- **`hash_and_equals`** - If overriding `==`, also override `hashCode`
- **`throw_in_finally`** - Never throw exceptions in finally blocks
- **`unrelated_type_equality_checks`** - Don't compare unrelated types with `==`

#### 2. **Style Rules** (Code Quality & Consistency)

These rules enforce consistent code formatting and best practices:

**Type Annotations:**
- **`always_declare_return_types`** - Every function must declare its return type
- **`type_annotate_public_apis`** - Public functions/variables must have type hints
- **`type_init_formals`** - Use initializing formals for constructors

**Naming Conventions:**
- **`camel_case_types`** - Classes and types use UpperCamelCase
- **`camel_case_extensions`** - Extension names use UpperCamelCase
- **`constant_identifier_names`** - Constants use lowerCamelCase or UPPER_SNAKE_CASE
- **`file_names`** - File names use snake_case (e.g., `app_card.dart`)
- **`library_names`** - Library names use lowercase with underscores

**Null Safety:**
- **`avoid_null_checks_in_equality_operators`** - Use proper null-safe comparisons
- **`avoid_returning_null`** - Return valid values instead of null when possible
- **`avoid_returning_null_for_stream`** - Return empty Stream instead of null
- **`cast_nullable_to_non_nullable`** - Properly handle nullable to non-nullable casting
- **`unnecessary_null_checks`** - Remove redundant null checks

**Const & Immutability:**
- **`prefer_const_constructors`** - Use const constructors when possible
- **`prefer_const_declarations`** - Use const for compile-time constants
- **`prefer_const_literals_to_create_immutables`** - Use const literals in immutable structures
- **`prefer_final_fields`** - Mark fields as final if not reassigned
- **`prefer_final_locals`** - Mark local variables as final if not reassigned
- **`prefer_final_in_for_each`** - Use final in forEach callbacks

**Code Organization:**
- **`sort_child_properties_last`** - Widget child properties should come last
- **`sort_constructors_first`** - Define constructors before other methods
- **`sort_pub_dependencies`** - Sort dependencies alphabetically in pubspec.yaml
- **`directives_ordering`** - Order imports: dart, package, relative imports

**String Handling:**
- **`prefer_single_quotes`** - Use single quotes for strings (not double quotes)
- **`prefer_interpolation_to_compose_strings`** - Use string interpolation instead of concatenation
- **`unnecessary_string_escapes`** - Remove unnecessary escape characters
- **`unnecessary_string_interpolations`** - Remove unnecessary `${}` wrappers

**Collections & Iterations:**
- **`prefer_collection_literals`** - Use `[]` and `{}` instead of constructors
- **`prefer_spread_collections`** - Use spread operator `...` for collections
- **`prefer_for_elements_to_map_fromIterable`** - Prefer for-elements over functional approaches
- **`prefer_foreach`** - Use forEach for simple iterations

**Widget & Flutter Specific:**
- **`use_key_in_widget_constructors`** - Pass `key` parameter to widget constructors
- **`use_build_context_synchronously`** - Don't use BuildContext after async operations
- **`sized_box_for_whitespace`** - Use SizedBox for spacing, not Container
- **`sized_box_shrink_expand`** - Use SizedBox.shrink() and SizedBox.expand()
- **`use_full_hex_values_for_flutter_colors`** - Use full 8-digit hex colors (with alpha)

**Other Standards:**
- **`lines_longer_than_80_chars`** - Keep lines ≤ 100 characters
- **`avoid_bool_literals_in_conditional_expressions`** - Don't use booleans in ternaries
- **`prefer_void_to_null`** - Use `void` return type instead of `Null`
- **`only_throw_errors`** - Only throw Error or Exception objects
- **`eol_at_end_of_file`** - Every file must end with a newline

---

## Before Writing Code

### Step 1: Run Linting Analysis
```bash
cd apps/mobile
flutter analyze
```

If the output shows "No issues found!", you're ready to code.

### Step 2: Check Dart Linter Rules
Before implementing any feature:
1. Visit https://dart.dev/tools/linter-rules
2. Search for rules relevant to your code (e.g., nullable types → search "null")
3. Review the **✅ DO** and **❌ DON'T** examples for each rule

### Step 3: Use IDE Support
- **VS Code**: Install "Dart" extension by Dart Code to see lint violations inline
- **Android Studio**: Install Dart/Flutter plugins for real-time linting feedback
- **IntelliJ IDEA**: Linting works out-of-the-box with Dart plugin

### Step 4: Auto-Fix Issues (Optional)
```bash
cd apps/mobile
# Manually review and apply auto-fixes
dart fix --apply
```

---

## Common Linting Violations & Fixes

### ❌ Violation: Missing Return Type
```dart
getUser() {
  return User(name: 'John');
}
```

### ✅ Fix: Always Declare Return Type
```dart
User getUser() {
  return User(name: 'John');
}
```

---

### ❌ Violation: Double Quotes
```dart
String title = "S.E.A System";
```

### ✅ Fix: Use Single Quotes
```dart
String title = 'S.E.A System';
```

---

### ❌ Violation: Relative Imports
```dart
import '../../../core/theme/app_theme.dart';
```

### ✅ Fix: Use Package Imports
```dart
import 'package:mobile/core/theme/app_theme.dart';
```

---

### ❌ Violation: Missing Key in Widget
```dart
class MyWidget extends StatelessWidget {
  const MyWidget();
}
```

### ✅ Fix: Add Key Parameter
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
}
```

---

### ❌ Violation: Container for Spacing
```dart
Container(
  width: 16,
  height: 16,
  color: Colors.transparent,
)
```

### ✅ Fix: Use SizedBox
```dart
SizedBox(width: 16, height: 16)
```

---

### ❌ Violation: Not Final When Possible
```dart
class User {
  String name;
  int age;
}
```

### ✅ Fix: Make Fields Final
```dart
class User {
  final String name;
  final int age;
}
```

---

## Verification Workflow

### Before Every Commit

```bash
# 1. Run analysis
cd apps/mobile
flutter analyze

# 2. Fix any violations
# (Review and fix manually, or use dart fix --apply)

# 3. Rebuild and test
flutter clean
flutter pub get
flutter build apk --debug  # or flutter run

# 4. Verify no regressions
flutter analyze

# 5. Commit only if "No issues found!"
git add .
git commit -m "feat: description following conventional commits"
```

### CI/CD Integration

All pull requests **must pass** `flutter analyze` before merging. If your branch fails analysis:
1. Pull the latest changes
2. Run `flutter analyze` locally
3. Fix all violations
4. Push fixes and re-submit PR

---

## Suppressing Linting Rules

In rare cases where a lint rule conflicts with design intent, you can suppress it:

### Suppress a Single Line
```dart
// ignore: avoid_print
print('Debug info');
```

### Suppress an Entire File
```dart
// ignore_for_file: avoid_print

print('This file uses print');
print('No violations reported');
```

### Suppress a Rule Across Project

Edit `analysis_options.yaml`:
```yaml
linter:
  rules:
    - avoid_print: false  # Disable this rule project-wide
```

**Note:** Only suppress rules if there's a documented reason. Always prefer fixing the code instead.

---

## Resources

- **Dart Linter Rules**: https://dart.dev/tools/linter-rules
- **Flutter Best Practices**: https://flutter.dev/docs/testing/best-practices
- **Effective Dart**: https://dart.dev/guides/language/effective-dart
- **Dart Style Guide**: https://dart.dev/guides/language/effective-dart/style
- **Flutter Null Safety**: https://dart.dev/null-safety

---

## Questions?

If you encounter a linting rule you don't understand:
1. Search the rule name on https://dart.dev/tools/linter-rules
2. Review the rule's documentation and examples
3. Check existing code in `apps/mobile/lib` for usage examples
4. Ask in the project's communication channels

---

**Last Updated:** June 2, 2026  
**Flutter Version:** 3.29.3  
**Dart Version:** 3.7.2
