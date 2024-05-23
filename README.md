<p align="center">
    <img src="Resources/Logo_Rounded.png" alt="DeckKit Logo" title="DeckKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/DeckKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/DeckKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About DeckKit

DeckKit is a Swift SDK that helps you build deck-based apps in SwiftUI.

DeckKit has a `DeckView` that can render any item collection, with support for swipe gestures, edge swipe detection, shuffling, etc. The result can look like this or completely different:

<p align="center" style="border-radius: 10px">
    <img src="Resources/Demo.gif" width=300 alt="Demo video" />
</p>

DeckKit has other views as well, and can be customized to great extent. You can change colors, fonts, etc. and use completely custom views. It also has tools to manage favorite items.



## Installation

DeckKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/DeckKit.git
```



## Getting started

With DeckKit, you can create a `Deck` of any model that implement the `DeckItem` protocol:

```swift
struct Hobby: DeckItem {
    
    var name: String
    var text: String

    var id: String { name }
}
```

You can display a deck of cards with any of the built-in views, like a `DeckView`:

```swift
struct MyView: View {

    @State 
    var hobbies: [Hobby] = ...

    var body: some View {
        DeckView($hobbies) { hobby in
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.blue)
                .overlay(Text(hobby.name))
                .shadow(radius: 10)
        }
    }
}
```

For more information, please see the [getting started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc. 



## Demo Application

The demo app lets you explore the library with iOS, macOS, and visionOS. To try it out, just open and run the `Demo` project.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

DeckKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://www.danielsaidi.com
[GitHub]: https://www.github.com/danielsaidi
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi
[OpenSource]: https://www.danielsaidi.com/opensource

[Documentation]: https://danielsaidi.github.io/DeckKit/documentation/deckkit/
[Getting-Started]: https://danielsaidi.github.io/DeckKit/documentation/deckkit/getting-started
[License]: https://github.com/danielsaidi/DeckKit/blob/master/LICENSE
