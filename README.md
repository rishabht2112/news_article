# Flutter Article App

A Flutter application that displays a list of articles fetched from a public API, with search, infinite scroll, favorites, and detail view functionality.

## Features

- Fetch and display articles from `https://jsonplaceholder.typicode.com/posts`
- Search articles by title or body (client-side)
- Infinite scrolling with lazy loading
- Pull-to-refresh functionality
- Tap on an article to view full content in a detailed screen
- Favorite/unfavorite articles with persistent local storage
- View all favorites in a dedicated tab
- Responsive UI

## Setup Instructions

1. Clone the Repository
  git clone https://github.com/your-username/news_article.git
  cd news_article

2. Install Dependencies
  flutter pub get

4. Run the App
  flutter run

## Tech Stack

**Flutter SDK**: 3.x
**State Management**: Provider
**HTTP Client**: http package
**Persistence**: shared_preferences

## State Management Explanation 

The app uses the Provider package to manage its state. The main state is handled by the ArticleProvider, which fetches and filters the articles, handles favorite status, and manages the UI state. The app updates the UI reactively by notifying listeners when the data changes (e.g., when a new article is fetched or a favorite status is toggled).

## Known Issues / Limitations

**No backend for Authentication**: The app does not include authentication features (such as login/logout), which means users can only access the content publicly. Adding user authentication could allow users to create accounts and manage personal preferences like saved articles or personalized feeds.
**No Offline Support**: The app relies on a constant internet connection to fetch articles. There's no local caching implemented, meaning the app cannot function without an internet connection.
**No Data Caching**: Articles are fetched every time the app loads, resulting in slower startup times.

## Screenshots (Optional) 

Drive link: https://drive.google.com/drive/folders/1Hw7LQGtB4x3hzo7fpYTP40ZKsEg5y0jP?usp=drive_link
