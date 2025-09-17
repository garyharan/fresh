# ❤️ Fresh.Dating

## Sample Rails Hotwire App with Mobile Integration

This is a sample Rails Hotwire application designed to support two mobile apps: one for Android and one for iOS. Both mobile apps are built using Hotwire Native, enabling a seamless, real-time user experience across platforms.

The app was originally intended to be a dating app, but App Store policies prevented its release and it was ultimately shelved. It includes features such as user authentication, profile management, real time chat, event creation and attendance, and real-time updates using Hotwire.

It is open sourced to demonstrate how to build a modern Rails application with Hotwire Native but not intended for commercial use. For commercial use contact us about licensing.

## Features

- User authentication and profile management
- Real-time chat functionality
- User matching based on preferences
- Event creation and attendance tracking
- Real time notifications
- Mobile applications for iOS and Android using Hotwire Native

## Core Architecture

### Backend Framework

- **Ruby on Rails** 8.0.2 with Ruby 3.4.2
- **MVC** (Model-View-Controller) architecture
- **Active Record ORM** for database interactions

### Database & Storage

- **SQLite3** for development (lightweight, file-based)
- **Active Storage** for file uploads (images, documents)
- **Akamai S3-compatible storage** for production file hosting
- **Geocoding integration** for location-based features
- **Soft deletes** using the paranoia gem

### Testing

- **Minitest** for unit
- **Capybara** for integration testing
- **Fixtures** for test data setup as well as some sparse use of inline factories

### Frontend Architecture

#### Web Frontend

- **Hotwire** for SPA-like experience
- **Stimulus** for JavaScript handling
- **Tailwind CSS** for styling with tailwindcss-rails
- **ESBuild** for JavaScript bundling
- **CSS Bundling** for asset pipeline

### Mobile Integration

See [FreshAppIOS](https://github.com/garyharan/FreshAppIOS) and [FreshAppAndroid](https://github.com/garyharan/FreshAppAndroid) for the mobile app codebases.

- **Hotwire Native bridge** for iOS and Android apps
- **Device variant detection** for mobile-specific views
- **Push notification support** via apnotic and noticed gems
- **Cross-platform authentication** handling
