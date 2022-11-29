//
//  Hobby.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import DeckKit
import Foundation
import SwiftUI

struct Hobby: DeckItem {
    
    let id = UUID().uuidString
    
    var name: String
    var text: String
    var imageName: String
    var color: Color = .demoColors.randomElement() ?? .white
    
    var backgroundColor: Color { color }
    var foregroundColor: Color {
        switch backgroundColor {
        case .white: return .black
        default: return .white
        }
    }
    var image: Image { Image(systemName: imageName) }
}

extension Hobby {

    static var demoCollection: [Hobby] = [
        Hobby(name: "Drawing", text: "Perfect for when you have a lot of paper.", imageName: "pencil"),
        Hobby(name: "Origami", text: "Perfect for when you have a lot of failed drawings.", imageName: "doc"),
        Hobby(name: "Paper Planes", text: "Perfect for when you have a lot of failed origamis.", imageName: "paperplane"),
        Hobby(name: "Lassoing", text: "Perfect for when your friends run away because you throw paper planes at them.", imageName: "lasso"),
        Hobby(name: "Writing", text: "Write an exciting story about your life.", imageName: "doc.text"),
        Hobby(name: "Reading", text: "Read the exciting story about your life.", imageName: "book.closed"),
        Hobby(name: "Trashbinning", text: "Realise that the story of your life isn't that exciting.", imageName: "trash"),
        Hobby(name: "Studying", text: "Make something out of your life...perhaps it will become exciting?", imageName: "graduationcap"),
        Hobby(name: "Macgyvering", text: "Create space rockets out of paperclips. Now THAT'S exciting!", imageName: "paperclip"),
        Hobby(name: "Bungee Jumping", text: "Also exciting, but remember to connect yourself with a rope!", imageName: "person.fill.turn.down"),
        Hobby(name: "Music", text: "Ok, this is an actual hobby. Listening to music, playing music...eating music?", imageName: "music.note"),
        Hobby(name: "Watching stuff", text: "Be careful! It can be really creepy if you do it in the wrong way. Also, you can't watch music.", imageName: "eye"),
        Hobby(name: "Smelling stuff", text: "This is getting weird.", imageName: "eye"),
        Hobby(name: "Kissing stuff", text: "Just stop!", imageName: "mouth"),
        Hobby(name: "Sleeping", text: "Some says that even this is a hobby!", imageName: "zzz"),
        Hobby(name: "Star gazing", text: "Perfect for when you fail to do the sleeping hobby thing!", imageName: "star"),
        Hobby(name: "Lightning gazing", text: "Make sure to stay far away!", imageName: "cloud.bolt"),
        Hobby(name: "Umbrella dancing", text: "Don't combine this with lightning gazing!", imageName: "umbrella"),
        Hobby(name: "Tornado gazing", text: "Make sure to stay extra far away! And close that umbrella!", imageName: "cloud.bolt"),
        Hobby(name: "Pyromaniac stuff", text: "No one should ever claim that this is a hobby. It's illegal!!!", imageName: "flame"),
        Hobby(name: "Swift", text: "The best hobby! And perfectly legal 👌", imageName: "swift"),
    ]
}
