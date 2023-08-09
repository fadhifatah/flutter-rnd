# Research and Development

A new Flutter project. This project is created to test, try and error, run and build any Flutter possibilities. This is also a good place to exercise what has been learnt and/or what will be developed before it published. Proper to experiment things. Much like cookbook, codelab and demo combined as one.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Main Menu

Display all available Research and Development menu as a button in scrollable [Wrap](https://api.flutter.dev/flutter/widgets/Wrap-class.html)-ed widget. This app use custom fonts: `Fragment Mono` and `Roboto Mono`. All menus may changed at further development. It is deep link integrated with `go_router` by host: `frnd.fadhifatah.dev`, supported scheme: `http` and `https`. Contains route to other menu as well.

<img src="assets/github/showcase.gif" width="360"/>

Main Menu contains several features example, such as:
| Name | Description |
|-|-|
| **navigation** | A basic navigation in Flutter. New app will be opened! [updated: access this menu with new url `/navigation`] |
| **navigation2** | A advanced navigation with handling various routes possibilities. A working deeplink to be expected as well. New app will be opened! [updated: access this menu with new url `/navigation2`] |
| **jsonplaceholder** | An example of data fetching with basic http package. In additiona, also display an example nested scroll |
| **pexels** | Just like **jsonplaceholder**, but much more advanced with pagination. Add data manager aspect to get a better data parsing and request/response handler, especially a status code |

### [Update: 20230809]
- Now deep link is implemented using go_router library.
- Go to Main Menu using `https://frnd.fadhifatah.dev/`
- Go to **navigation** using `https://frnd.fadhifatah.dev/navigation`
- Go to **navigation2** using `https://frnd.fadhifatah.dev/navigation2`
