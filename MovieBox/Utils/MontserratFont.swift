//
//  MontserratFont.swift
//  MovieBox
//
//  Created by Mine Rala on 23.05.2025.
//


import SwiftUI

enum MontserratFont: String {
    case regular = "Montserrat-Regular"
    case bold = "Montserrat-Bold"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
    case light = "Montserrat-Light"
    case thin = "Montserrat-Thin"
    // Gerekirse diğer stilleri de ekleyebilirsin
}

extension Font {
    static func montserrat(_ style: MontserratFont, size: CGFloat) -> Font {
        .custom(style.rawValue, size: size)
    }
}
