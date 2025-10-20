# RTL/LTR Layout Implementation Plan

## Tasks
- [x] Create lib/foundation/localization/locale_provider.dart for managing locale state
- [x] Update lib/main.dart to support dynamic locale switching and set textDirection based on locale
- [x] Update lib/screens/app/providers/theme_provider.dart for RTL-specific theme adjustments if needed
- [x] Update lib/screens/app/login_page.dart to ensure layouts adapt to direction
- [x] Update lib/screens/app/home_page.dart to ensure sidebar and content adapt to direction
- [x] Test the app by switching locales and verifying layouts in both RTL and LTR modes
- [ ] Run the app on different screen sizes to ensure responsiveness
- [ ] Check for any remaining hardcoded alignments or issues with controls (buttons, text fields, etc.)
