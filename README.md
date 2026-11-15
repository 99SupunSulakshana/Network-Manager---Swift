Overview: what the project teaches (GET, decoding dates, typed errors, headers and tokens, POST, PATCH and DELETE).
Getting started: the iOS and Xcode versions you need, and where to paste your GoREST token. It also reminds readers not to commit their token.
Screens: a table of the 7 options in the bottom picker, what each one does, and which screen file it uses.
Project structure: a short map of the folders and files.
Networking layer: tables explaining every function in HTTPMethod, Endpoint and NetworkManager, the configureDecoder closure, and each NetworkManagerError and TransportError case.
View models: DataViewModel<T> with the withLoader modifier, and the four UserViewModel functions with their HTTP method and path.
Models: the fields of Quote, Joke, Joke2, User, UserResponse and UserMeta.
GoREST v3 notes: the three problems you ran into here. User IDs are strings, gender causes a 422, and each email can only be used once.
Test URLs: the constants in Constants.swift that trigger each error type on purpose.
