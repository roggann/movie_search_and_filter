# movie_search_and_filter

A new Flutter project.

## Getting Started

this is a project for building a mobile application using Flutter that allows users to search for movies using a public API and apply filters to refine their search results. 

the whole code + unit tests + readMe file is on dev branch 

this app includes these features :
 #1 fetch all movies from the TMDB(The Movie Database) after integrating with its api.
 #2 search functionality using the title typed by the user in the search text field.
 #3 filtration feature using three movie features (genre, release year, rating).

# the project structure goes like this:
I used Feature-First Architecture because it offers a structured approach to app development,
allowing to focus on building and maintaining individual features efficiently.
## api folder : it contains the dio HTTP networking client and its interceptors and exceptions
## common widgets folder : for common widgets used by more than one feature.
## features folder : is for features of the app and each feature may have sub features

inside every feature there are 4 layers:
### application layer: it has the providers used for this feature
### data layer: it has the repository that fetches the data from endpoints
### domain layer: it has the models used for this features
### presentation layer : it has all screens and widget used for this feature also has common widgets between sub-features.

unit tests folders have the same structure.
