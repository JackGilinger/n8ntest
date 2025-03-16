# Emotional Diary - Technical Task

## Project Description
A mobile application for tracking the user's emotional state. Minimalistic and intuitive interface with basic necessary functionality.

## Main functionality

### 1. Authorization screen ✅
- Only basic authorization (email/password) via callbacks
- Login via an existing account
- Ability to reset password

### 2. Main screen ✅
- Simplified date selection via standard DatePicker
- List of entries for the selected day
- Add new entry button
- Filter entries by period (day/week/month)

### 3. Entry creation/editing screen ✅
- Selection of the main emotion from a preset list (joy, sadness, anger, fear, surprise)
- Emotion intensity scale (1-5)
- Text field for describing the situation
- Ability to add tags
- Selection of entry time

### 4. Statistics screen ✅
- Simple display of emotion distribution via native widgets
- Display of emotion intensity via basic elements
- Cloud of frequently used tags

### 5. Settings screen ✅
- Notification settings
- Export data to PDF
- Change application language (English/Russian)
- Dark/light theme

## Technical description

### Project structure ✅
```
lib/
├─ screens/
│ ├─ auth/
│ │ └─ auth_screen.dart # Authorization screen ✅
│ ├─ home/
│ │ └─ home_screen.dart # Main screen with calendar ✅
│ ├─ emotion/
│ │ └─ add_emotion_screen.dart # Screen for adding emotion ✅
│ ├─ statistics/
│ │ └─ statistics_screen.dart # Statistics screen ✅
│ └─ settings/
│ └─ settings_screen.dart # Settings screen ✅
├─ widgets/
│ ├─ emotion_card.dart # Emotion card ✅
│ └─ emotion_picker.dart # Emotion picker widget ✅
├─ models/
│ └─ emotion_record.dart # Emotion record model ✅
└─ utils/
└─ theme.dart # Theme settings ✅
```

### Component implementation status:

#### Screens:
- ✅ auth_screen.dart: All authorization logic is passed via callback
- ✅ home_screen.dart: Logic for working with data via callback
- ✅ add_emotion_screen.dart: Logic for saving via callback
- ✅ statistics_screen.dart: Getting data via callback
- ✅ settings_screen.dart: Settings via callback

#### Widgets:
- ✅ emotion_card.dart: Events via callback
- ✅ emotion_picker.dart: Selection via callback

#### Models:
- ✅ emotion_record.dart: Clean data model

#### Utilities:
- ✅ theme.dart: Light and dark themes implemented

### Important implementation notes:

1. All business logic should be passed via callbacks in widget constructors:
```dart
EmotionCard({
required EmotionRecord emotion,
required Function(EmotionRecord) onEdit,
 required Function(EmotionRecord) onDelete,
 });
 ```

2. Data storage:
- All storage logic should be implemented externally
- Widgets only display data and call callbacks

3. Network requests:
- All network work should be implemented externally
- Widgets receive only ready data

4. Working with the platform:
- Access to system functions via callbacks

### Security ✅
- Data encryption during storage
- Protection from unauthorized access
- Regular backup

### Testing
- ✅ Unit tests for models
- ✅ Unit tests for services
- ✅ Widget tests for main screens
- 📝 Integration tests (in progress)
- 📝 Performance tests (in progress)

### Needs improvement:

#### 1. Functionality:
- 📝 Implement export data to PDF
- 📝 Add offline mode
- 📝 Improve notification system

#### 2. Testing:
- 📝 Add integration tests
- 📝 Conduct load testing
- 📝 Security testing

#### 3. Documentation:
- 📝 Add API documentation
- 📝 Create user guide
- 📝 Prepare documentation for publication

### Next release plan:
1. Implement offline mode
2. Improve data export
3. Improve performance
4. Expand notification functionality
5. Add new types of statistics
