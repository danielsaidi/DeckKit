# DeckKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 /><br />
    <img src="https://img.shields.io/github/v/release/danielsaidi/DeckKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/cocoapods/p/DeckKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://img.shields.io/github/license/danielsaidi/DeckKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About DeckKit

`DeckKit` is a tiny SwiftUI library that can help you create deck-based apps. It can look like this...or completely different: 

<p align="center">
    <img src="Resources/Demo.gif" width=300 />
</p>


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

I will improve documentation if anyone requests it (just create an issue), but basically it works like this:

* `CardItem` is a protocol that inherits `Identifiable` and `Equatable`
* A `Deck` can be created with a `CardItem` collection.

A `Deck` can be used as a plain data object, but can also bre presented with `SwiftUI`.


## SwiftUI

`DeckKit` contains two `SwiftUI` views for presenting a `Deck`:

* `StackedDeck` stacks cards on top of eachother and lets the user swipe cards off the top.
* `HorizontalDeck` presents cards in a horizontal list and lets the user swipe horizontally.

You can build your own `Deck`-based views as well, using plain `SwiftUI` views.


## Demo app

This repo contains a basic, universal demo app that runs on iOS 14 and macOS 11.

Just open the `Demo` project and run the app on either platform.

The library could run on `tvOS` and `watchOS` as well, but there are currently no such demos.


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
