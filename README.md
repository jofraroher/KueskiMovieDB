# KueskiMovieDB
An application to display popular movies and those currently in theaters. You can arrange the movies in a list or in columns, as well as sort the results by name and date. You can also save your favorite movies.

![Challenge](https://github.com/user-attachments/assets/79409768-d449-4922-ab49-efb61c287ba3)


## Features
- [x] List of popular movies.
- [x] List of now playing movies.
- [x] Switching between list and grid.
- [x] Error handling.
- [x] Show movie details:
    - Name.
    - Poster.
    - Genres.
    - Overview.
    - Popularity.
    - Release date.
    - Languages.
    - Vote average.
- [x] Save favorite movies.
- [x] Infinite scroll.
- [x] Sort by name and date.
## Requirements
- Xcode version 15 or higher
- Optional: This project uses [SPM](https://developer.apple.com/documentation/xcode/swift-packages), and Xcode automatically downloads the dependencies. In case of an error, reset the package caches and resolve the package versions.
## Project Setup
Just download the project and open `KueskiMovieDB.xcodeproj`After doing so, add your authentication key in the `KueskiAPIConfiguration` file under the `BASE_AUTHENTICATION_KEY` value.

<img width="856" alt="SetupKey" src="https://github.com/user-attachments/assets/c04db9e1-1f6f-413f-8e76-052b191e1892">

## Unit tests
You can run unit test coverage directly by selecting the KueskiMovieDBTest target, which will allow you to view the coverage.

<img width="856" alt="Screenshot 2024-08-20 at 1 15 20 p m" src="https://github.com/user-attachments/assets/e744b981-e108-4ee5-8e5d-b2fa9264644f">

## Project architecture
I decided to use the VIPER architecture for this project due to the following points:
- Clear Separation of Responsibilities:
  - VIPER divides the application into five distinct components: View, Interactor, Presenter, Entity, and Router. This separation allows each component to focus on a specific task, such as data presentation, business logic, and navigation. Compared to other architectures, like MVC or MVVM, VIPER provides a clearer structure that prevents a single component from managing multiple responsibilities, aligning with the SOLID principle of Single Responsibility. This makes code maintenance and evolution easier.

- Enhanced Testability:
  - Thanks to VIPER's separation of concerns, it is easier to write unit tests for each component in isolation. High-level components depend on abstractions (protocols), allowing for more effective testing and mocking of dependencies. In contrast, architectures like MVC can result in more tightly coupled components, making unit testing and behavior simulation more challenging.
- Reusability and Scalability:
  - VIPER promotes the reusability and scalability of components. Modules are designed to be easily extended without modifying existing code, following the SOLID principle of Open/Closed. This is particularly useful in a project like ours, where adding new features (such as a favorites view) can be done without restructuring the current application.
- Clear Dependency Management:
  - VIPER uses dependency injection and protocols to manage interactions between components, reducing coupling and improving modularity. This approach makes it easier to integrate new technologies or make changes to the project without affecting other parts of the system. In comparison, other architectures like MVVM may face issues if dependency management is not handled correctly, leading to less modular code.
- Code Organization and Scalability:
  - VIPER’s modular structure organizes code in a way that each component has a well-defined responsibility. This improves code navigation and understanding, especially in large and complex applications. Unlike MVC architecture, where the view and controller can become very extensive and difficult to manage, VIPER maintains a clear separation between business logic and presentation, making the application easier to scale and maintain.

## Questions
- How long did you spend on this?
  - Since I received the challenge, I have been dedicating at least 4 to 5 hours a day to it, so I estimate that I spent about 20 hours in total.
- Did you complete your implementation?
  - Yes, it seems that all the points were completed, in addition to the bonus and the unit tests.
- What would you have added if you had more time?
  - Several points come to mind, but I’ll list the main ones:
    - I would have adjusted the list and grid views to avoid having two views with different designs, making the use of GenericCollectionView more generic.
    - I would address Core Data cache management, as automatic memory management can cause issues when performing multiple operations (e.g., saving, deleting, and searching for movies).
    - I would remove the dependency on SDWebImage. Initially, I was working on my own component for downloading images but encountered issues with caching, leading to unexpected behavior and re-downloads.
    - Implementing a service to return the authentication key for the movie API is another consideration; while it's never safe to store any API keys in the application, it may be practical for the current purposes.
    - Additionally, some refactoring might be needed in the classes containing business logic.
- What was the most difficult part of the app?
  - It could be memory and object management in Core Data. Whenever a new list of movies is returned, it should be validated to check if they have been added as favorites to update the interface. Although memory operations are generally fast, there might be a point where we have thousands of records in the database and thousands of movies to compare for saved favorites, which could slow down the app. 
- What was your favorite part of the app?
- Think of and implement a solution where I wouldn't have to create multiple controllers for each screen (such as popular movies or now playing). Instead, there could be a single view where the only thing that changes would be the data source to display the information. I believe this would significantly reduce development time in case a different type of listing is needed in the future (such as showing a list of saved favorite movies).
- Is there anything else you’d like to add?
  - It's not common to perform unit tests on views, but I did it to achieve the unit test coverage required for the challenge. Additionally, I created the detail view with SwiftUI solely to demonstrate the interoperability between views and how a good, scalable architecture can adapt to any technology.
