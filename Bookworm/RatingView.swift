//
//  RatingView.swift
//  Bookworm
//
//  Created by Mój Maczek on 02/11/2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int // Binding shares data between views, it's used for structs
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
//                .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
//                .accessibilityAddTraits(number > rating ? [] : [.isSelected])
            }
        }
        .buttonStyle(.plain) // Thansk to this, stars can be tapped separately!!!
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
