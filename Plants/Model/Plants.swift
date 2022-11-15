//
//  Plants.swift
//  Plants
//
//  Created by Josileudo Rodrigues on 12/11/22.
//

import SwiftUI

// MARK: Plants model
struct Plant: Identifiable {
    var id: UUID = .init();
    var imageName: String;
    var title: String;
    var price: String;
}

var plants: [Plant] = [
    .init(imageName: "asplenium", title: "Asplenium Nidus", price: "$56.70"),
    .init(imageName: "crassula", title: "Crassula Ovata", price: "$38.35"),
    .init(imageName: "nephrolepis", title: "nephrolepis", price: "$106.54"),
    .init(imageName: "peperomia", title: "peperomia", price: "$87.99")
]
