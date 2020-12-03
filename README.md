# DeckKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/DeckKit">
        <img src="https://badge.fury.io/gh/danielsaidi%2FDeckKit.svg?style=flat" alt="Version" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/DeckKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About DeckKit

`DeckKit` is a tiny SwiftUI library that can help you create deck-based apps.

With `DeckKit`, you can present any model that implements `CardItem` as cards. It can look like this: 

<p align="center">
    <img src="Resources/Demo.gif" width=300 />
</p>

I will add a stunning (well...) logo and improve the documentation after the library gets 50 stars or the first external issue. Until then, create issues or reach out to me if you need help.


## Installation

### Swift Package Manager

```
https://github.com/danielsaidi/DeckKit.git
```

### CocoaPods

```
pod DeckKit
```


## How does it work

I will add better documentation if anyone starts using this library, but basically it works like this:

* `CardItem` is a protocol that inherits `Identifiable` and `Equatable`
* A `Deck` can be created with any `CardItem` collection.

Decks can be used as plain data objects, but can also bre presented with SwiftUI.


## Presenting a deck

A `Deck` can be presented in many ways, including these two built in views:

* `StackedDeck` stacks cards on top of eachother and lets the user swipe cards off the top.
* `HorizontalDeck` presents cards in a horizontal list.

You can easily build your own `Deck`-based views as well, using plain SwiftUI.


## Demo app

This repo contains a very basic, universal demo app that runs on iOS 14 and macOS 11.

Just open the `DeckKitDemo` project and run the app on either platform.

The library could run on tvOS as well, but the demo currently has no tvOS app.


## Acknowledgements

This library wouldn't have been made without [this amazing card tutorial](https://www.swiftcompiled.com/swiftui-cards/).


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## License

DeckKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
