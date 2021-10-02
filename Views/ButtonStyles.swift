//
//  ButtonStyles.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 01/10/2021.
//

import SwiftUI

struct CustomLinkButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label.foregroundColor(.blue)
    }
}

struct CustomHeaderButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
    }
}
