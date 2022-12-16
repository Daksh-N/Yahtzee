//
//  SheetView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/15/22.
//

import SwiftUI

struct SheetView: View {
    @State private var buttonStrings = ["Aces: ", "Twos: ", "Threes: ", "Fours: ", "Fives: ", "Sixes: ", "Total Score: ", "Bonus: ", "Top Total: ", "3 of a kind: ", "4 of a kind: ", "Full House: ", "Small Straight: ", "Large Straight: ", "Yahtzee: ", "Chance: ", "Yahtzee Bonus: ", "Bottom Total: ", "Top Total: ", "Grand Total: "]
    @State private var implementedScores = [0, 0, 0, 0, 0, 0, 0, 0, 0,
                                            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let inheritedScores : [Int]
    let selectedScore : Int
    let selectedScoreIndex : Int
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                CustomText(text: "Sample Text")
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(inheritedScores: [0], selectedScore: 0, selectedScoreIndex: 0)
    }
}
