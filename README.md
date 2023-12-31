# Research and Development

A new Flutter project. This project is created to test, try and error, run and build any Flutter possibilities. This is also a good place to exercise what has been learnt and/or what will be developed before it published. A proper way to experiment things. Much like cookbook, codelab and demo combined as one.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Design Pattern

### MVVM x Architecture

#### Diagram

In this section, I'll try to combine Modern App Arch. and Clean Arch. to be much simpler, in my opinion, both are using Inward Dependencies and Layered architecture, so any project structure that comply with them does.

TL;DR
- Entities from Clean Architecture will be used as Data Layer from Modern App Architecture. It has Data Source and Repository that contains Business Logic Rules, API Request, Local DB and/or Core Module.

- Domain Layer will be filled with Use Case(s) for each Business Logic Implementations for every feature. This layer should be consumed in View Model (or any Presenters available). Each feature may contains UI State to determine what data should be presented to user and also its state whether it has error response, maintenance notification or any blocking prompt that user should notice.

- UI Layer, it contains every page feature that communicate with View Model. Its only jobs is to present content. 

##### Clean Architecture

<img src="https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg"/>

##### Modern App Architecture (from Android)

<img src="https://developer.android.com/static/topic/libraries/architecture/images/mad-arch-overview.png"/>

#### The project tree (plan)

```
app ┐
    ├ data ┐
    │      ├ remote ┐
    │      │        ├ api ┐
    │      │        │     ├ api_service: *get, *post,
    │      │        │     │
    │      │        │     └ host: base_url, flavors
    │      │        │
    │      │        └ dto: *response, *request, *param
    │      │
    │      ├ local ┐
    │      │       ├ sql/room ┐ 
    │      │       │          ├ db_service: *insert, *update, *delete, *query
    │      │       │          │
    │      │       │          └ table: *insert, *update, *delete, *query
    │      │       │
    │      │       └ shared_pref: app_pref, enc_pref
    │      │
    │      └ repository : *repository(api_service, db_service, *_pref)
    │
    ├ domain : *usecase(*repository)
    │
    └ feature : (example: home, data_list, detail, login, create_account, form_page, etc.)
```

## Main Menu

Display all available Research and Development menu as a button in scrollable [Wrap](https://api.flutter.dev/flutter/widgets/Wrap-class.html)-ed widget. This app use custom fonts: `Fragment Mono` and `Roboto Mono`. All menus may changed at further development. It is deep link integrated by [`go_router`](https://pub.dev/packages/go_router) with a host: `frnd.fadhifatah.dev`, supported scheme: `http` and `https`. Contains route to other menu as well.

<img src="assets/github/showcase.gif" width="360"/>

Main Menu contains several feature examples, such as:
| Name | Description |
|-|-|
| **navigation** | A basic navigation in Flutter. New app will be opened! [updated: access this menu with new url `/navigation`] |
| **navigation2** | A advanced navigation with handling various routes possibilities. A working deeplink to be expected as well. New app will be opened! [updated: access this menu with new url `/navigation2`] |
| **jsonplaceholder** | An example of data fetching with basic http package, using [JSONPlaceholder](https://jsonplaceholder.typicode.com/). In addition, display an example of nested scroll too |
| **pexels** | Just like **jsonplaceholder**, but much more advanced with implementation of pagination as the highlighted feature. A pagination package that is used in this example is [`infinite_scroll_pagination`](https://pub.dev/packages/infinite_scroll_pagination). This example use [Pexels](https://www.pexels.com/api/) to gather the required data. Also, add data manager aspect to get a better data parsing and request/response handler, especially a status code |

### [Update: 20230809]
- Now deep link is implemented using go_router library.
- Go to Main Menu using `https://frnd.fadhifatah.dev/`
- Go to **navigation** using `https://frnd.fadhifatah.dev/navigation`
- Go to **navigation2** using `https://frnd.fadhifatah.dev/navigation2`

### [Update 20230829]
- Design Pattern and Architecture structure plan