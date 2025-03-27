<p align="center">
    <img src="Resources/Icon.png" alt="DeckKit Logo" width="350" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/DeckKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <a href="https://danielsaidi.github.io/DeckKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <img src="https://img.shields.io/github/license/danielsaidi/DeckKit" alt="MIT License" />
</p>


# DeckKit

DeckKit is a SwiftUI SDK that lets you build deck-based apps with ease. It has a `DeckView` that can render any list of items, with support for swipe gestures, edge swipes, shuffling, etc.

<p align="center">
    <img src="Resources/Demo.gif" width=300 alt="Demo video" />
</p>

DeckKit can be customized to great extent. You can change colors, fonts, etc. and use completely custom views. It also has tools to manage favorites.



## Installation

DeckKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/DeckKit.git
```



## Getting started

With DeckKit, you can create a deck of cards with any type that conforms to `Identifiable`:

```swift
struct Hobby: Identifiable {
    
    var name: String
    var text: String

    var id: String { name }
}

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

DeckKit has several view components for presenting decks, e.g. `DeckView` and `DeckPageView`.

See the online [getting started guide][Getting-Started] for more information.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has an app that lets you explore the library on iOS, macOS, and visionOS.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

DeckKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://www.danielsaidi.com
[GitHub]: https://www.github.com/danielsaidi
[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi
[OpenSource]: https://www.danielsaidi.com/opensource

[Documentation]: https://danielsaidi.github.io/DeckKit/
[Getting-Started]: https://danielsaidi.github.io/DeckKit/documentation/deckkit/getting-started

[License]: https://github.com/danielsaidi/DeckKit/blob/master/LICENSE
