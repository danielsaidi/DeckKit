# DeckKit

<p align="center">
    <a href="https://github.com/danielsaidi/DeckKit">
        <img src="https://badge.fury.io/gh/danielsaidi%2FDeckKit.svg?style=flat" alt="Version" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/DeckKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" alt="Swift 5.1" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About DeckKit

`DeckKit` is a tiny library that can help you create deck-based apps.

I will add improved documentation and a demo app after the library gets 10 stars. Until then, create issues or reach out to me if you need help.


## Creating a deck

With `DeckKit`, you can create a `Deck` of `Card`s, then present it in various ways.

A `Deck` is a generic collection that can handle any kind of `Cards`. `Card` is a protocol that can be implemented in many different ways.

`DeckKit` contains a `BasicCard` protocol, with a `StandardBasicCard` implementation. It can be used to create a `BasicCardView` or any custom views you implement that support `BasicCard`.

The library also contains a `DeckStackView`, which presents any deck as a stack. You just have to provide it with a custom card view builder.

Until there is a demo app, you can have a look at the previews.


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
