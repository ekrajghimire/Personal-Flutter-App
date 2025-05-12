# Portfolio App Structure

## Directory Structure 


lib/
├── main.dart
├── config/
│ ├── theme.dart
│ └── routes.dart
├── models/
│ ├── project.dart
│ ├── service.dart
│ ├── blog_post.dart
│ └── user_profile.dart
├── screens/
│ ├── onboarding/
│ │ ├── onboarding_screen.dart
│ │ └── onboarding_content.dart
│ ├── home/
│ │ └── home_screen.dart
│ ├── about/
│ │ └── about_screen.dart
│ ├── services/
│ │ └── services_screen.dart
│ ├── projects/
│ │ ├── projects_screen.dart
│ │ └── project_detail_screen.dart
│ ├── portfolio/
│ │ └── portfolio_screen.dart
│ ├── blog/
│ │ ├── blog_screen.dart
│ │ └── blog_detail_screen.dart
│ └── contact/
│ └── contact_screen.dart
├── widgets/
│ ├── common/
│ │ ├── animated_text.dart
│ │ ├── custom_button.dart
│ │ └── profile_photo.dart
│ ├── projects/
│ │ └── project_card.dart
│ ├── services/
│ │ └── service_card.dart
│ └── blog/
│ └── blog_card.dart
├── services/
│ ├── api_service.dart
│ └── storage_service.dart
└── utils/
├── constants.dart
└── helpers.dart