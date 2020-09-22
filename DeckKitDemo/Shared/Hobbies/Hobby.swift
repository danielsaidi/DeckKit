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

struct Hobby: CardItem {
    
    let id = UUID().uuidString
    
    var name: String
    var text: String
    var imageName: String
    var color: Color
    
    var backgroundColor: Color { color }
    var foregroundColor: Color { .white }
    var image: Image { Image(systemName: imageName) }
}

extension Hobby {
    
    static var demoCollection: [Hobby] {
        [
            Hobby(name: "Drawing", text: "Perfect for when you have a lot of paper.", imageName: "pencil", color: .gray),
            Hobby(name: "Origami", text: "Perfect for when you have a lot of paper planes.", imageName: "doc", color: .purple),
            Hobby(name: "Paper Planes", text: "Perfect for when you have a lot of failed origamis.", imageName: "paperplane", color: .blue),
            Hobby(name: "Lassoing", text: "Perfect for when your friends run away because you throw paper planes at them.", imageName: "lasso", color: .yellow),
            Hobby(name: "Writing", text: "Write an exciting story about your life.", imageName: "doc.text", color: .green),
            Hobby(name: "Reading", text: "Read the exciting story about your life.", imageName: "book.closed", color: .red),
            Hobby(name: "Trashbinning", text: "Realise the story of your life isn't that exciting.", imageName: "trash", color: .orange),
            Hobby(name: "Study", text: "Make something out of your life...perhaps it will become exciting?", imageName: "graduationcap", color: .pink),
            Hobby(name: "Macgyvering", text: "Create space rockets out of paperclips. Now THAT'S exciting!", imageName: "paperclip", color: .black),
            Hobby(name: "Bungee Jumping", text: "Also exciting...but remember to connect yourself with a rope!", imageName: "person.fill.turn.down", color: .blue),
            Hobby(name: "Music", text: "Ok, this is an actual hobby. Listening to music, playing music...eating music?", imageName: "music.note", color: .green),
            Hobby(name: "Watching stuff", text: "Be careful! It can be really creepy if you do it in the wrong way. Also, you can't watch music.", imageName: "eye", color: .yellow),
            Hobby(name: "Smelling stuff", text: "This is getting weird.", imageName: "eye", color: .pink),
            Hobby(name: "Kissing stuff", text: "Just stop!", imageName: "mouth", color: .red),
            Hobby(name: "Sleeping", text: "Some says that even this is a hobby!", imageName: "zzz", color: .black),
            Hobby(name: "Star gazing", text: "Perfect for when you fail to do the sleeping hobby thing!", imageName: "star", color: .black),
            Hobby(name: "Lightning gazing", text: "Make sure to stay far away!", imageName: "cloud.bolt", color: .orange),
            Hobby(name: "Umbrella dancing", text: "Don't combine this with lightning gazing!", imageName: "umbrella", color: .pink),
            Hobby(name: "Tornado gazing", text: "Make extra sure to stay far away! And close that umbrella!", imageName: "cloud.bolt", color: .gray),
            Hobby(name: "Pyromaniac stuff", text: "No one should ever claim that this is a hobby. It's illegal!!!", imageName: "flame", color: .orange),
            Hobby(name: "Swift", text: "The best hobby! And perfectly legal 👌", imageName: "swift", color: .orange),
        ]
    }
}
