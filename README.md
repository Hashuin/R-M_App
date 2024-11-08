# Rick and Morty Character Explorer

Rick and Morty Character Explorer is a mobile application that allows users to explore characters from the popular animated series Rick and Morty. It leverages real-time data from the characters' API, enabling users to view detailed information about each character, including names, images, and backgrounds.

## Features

- **Character Exploration**: Discover and learn about your favorite Rick and Morty characters.
- **Dynamic Search Bar**: Easily find characters with our search bar.
- **Pagination**: Efficiently navigate through the character list.
- **Smooth Animations**: Enhance interaction with the application.
- **Loading Indicators**: Shimmer effects for a better user experience.

## Technologies Used

- Flutter
- Dart
- Riverpod
- GraphQL
- Hexagonal Architecture

## Getting Started

Follow these steps to set up and run the project:

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/rick-and-morty-character-explorer.git
   cd rick-and-morty-character-explorer
    ```
2. **Set up the environment file:**

   - Create a `.env` file in the root directory.
   - Add the following environment variables to the `.env` file:

     ```bash
     RICK_AND_MORTY_API_URL=https://rickandmortyapi.com/graphql
     ```
3. **Install dependencies**:

   ```bash
   flutter pub get
   ```
4. **Run the application**:

   ```bash
    flutter run
    ```