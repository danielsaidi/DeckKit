//
//  Hobby.swift
//  Demo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import DeckKit
import Foundation
import SwiftUI

struct Hobby: Identifiable {
    
    var number: Int
    var name: String
    var color: Color
    var text: String
    var imageName: String

    var image: Image { Image(systemName: imageName) }
}

extension Hobby {

    var id: String { name }

    static var demoCollection: [Hobby] = [
        Hobby(number: 01, name: "Drawing", color: .green, text: "Perfect for when you have a lot of paper.", imageName: "pencil"),
        Hobby(number: 02, name: "Origami", color: .blue, text: "Perfect for when you have a lot of failed drawings.", imageName: "doc"),
        Hobby(number: 03, name: "Paper Planes", color: .yellow, text: "Perfect for when you have a lot of failed origamis.", imageName: "paperplane"),
        Hobby(number: 04, name: "Lassoing", color: .red, text: "Perfect for when your paper planes fly away.", imageName: "lasso"),
        Hobby(number: 05, name: "Writing", color: .orange, text: "Write an exciting story about your life.", imageName: "doc.text"),
        Hobby(number: 06, name: "Reading", color: .brown, text: "Read that exciting story about your life.", imageName: "book.closed"),
        Hobby(number: 07, name: "Trashbinning", color: .purple, text: "Realise that the story of your life isn't that exciting.", imageName: "trash"),
        Hobby(number: 08, name: "Studying", color: .pink, text: "Make something exciting out of your life.", imageName: "graduationcap"),
        Hobby(number: 09, name: "Macgyvering", color: .teal, text: "Create a space ship out of a paperclip. Now THAT'S exciting!", imageName: "paperclip"),
        Hobby(number: 10, name: "Bungee Jumping", color: .indigo, text: "Also exciting, but remember to connect yourself with a rope!", imageName: "person.fill.turn.down"),
        Hobby(number: 11, name: "Music", color: .green, text: "Ok, music is an actual hobby. Like listening to music, playing music...and eating music?", imageName: "music.note"),
        Hobby(number: 12, name: "Watching stuff", color: .blue, text: "This can be really creepy if you do it in the wrong way.", imageName: "eye"),
        Hobby(number: 13, name: "Smelling stuff", color: .yellow, text: "Sure, there are plenty of nice things to smell, but this is getting weird.", imageName: "eye"),
        Hobby(number: 14, name: "Kissing stuff", color: .red, text: "Just stop!", imageName: "mouth"),
        Hobby(number: 15, name: "Sleeping", color: .orange, text: "Can you imagine that some people says this isn't a hobby!?", imageName: "zzz"),
        Hobby(number: 16, name: "Star gazing", color: .brown, text: "Perfect for when you fail to sleeping.", imageName: "star"),
        Hobby(number: 17, name: "Lightning gazing", color: .purple, text: "Make sure to stay far away!", imageName: "cloud.bolt"),
        Hobby(number: 18, name: "Umbrella spinning", color: .pink, text: "Don't combine this with lightning gazing!", imageName: "umbrella"),
        Hobby(number: 19, name: "Tornado gazing", color: .teal, text: "Remember to stay far away...and to close that umbrella!", imageName: "tornado"),
        Hobby(number: 20, name: "Swift", color: .indigo, text: "The best hobby!", imageName: "swift"),
    ]
}

extension Hobby {

    static var preview: Self {
        let list = Hobby.demoCollection
        return list.randomElement() ?? list[0]
    }
}
