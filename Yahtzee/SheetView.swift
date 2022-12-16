//
//  SheetView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/15/22.
//

import SwiftUI

struct SheetView: View {
    @State private var displayStrings = ["Aces: ", "Twos: ", "Threes: ", "Fours: ", "Fives: ", "Sixes: ", "Total Score: ", "Bonus: ", "Top Total: ", "3 of a kind: ", "4 of a kind: ", "Full House: ", "Small Straight: ", "Large Straight: ", "Yahtzee: ", "Chance: ", "Yahtzee Bonus: ", "Bottom Total: ", "Top Total: ", "Grand Total: "]
    @State private var implementedScores = [0, 0, 0, 0, 0, 0,
                                            0, 0, 0, 0, 0, 0, 0]
    @State private var scoreDisplays = ["1", "2", "3", "4", "5", "6",
                                        "7", "8", "9", "10", "11", "12", "13"]
    // "slots" 7, 8, 9, 17, 18, 19, 20 are all non-player scores
    @State private var permittedLogs = 1
    @State private var writeButtonDisplay = "Write Score"
    let inheritedScores : [Int]
    let selectedScore : Int
    let selectedScoreIndex : Int
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                HStack {
                    VStack {
                        ForEach (0..<20) { i in
                            CustomTextTiny(text: displayStrings[i])
                        }
                        .padding(1)
                    }
                    VStack {
                        ForEach (0..<6) { i in
                            CustomTextTiny(text: scoreDisplays[i])
                                .padding(1)
                        }
                        CustomTextTiny(text: "-")
                            .padding(1)
                        CustomTextTiny(text: "-")
                            .padding(1)
                        CustomTextTiny(text: "-")
                            .padding(1)
                        ForEach (6..<13) { i in
                            CustomTextTiny(text: scoreDisplays[i])
                                .padding(1)
                        }
                        CustomTextTiny(text: "-")
                            .padding(1)
                        CustomTextTiny(text: "-")
                            .padding(1)
                        CustomTextTiny(text: "-")
                            .padding(1)
                        CustomTextTiny(text: "-")
                            .padding(1)
                    }
                }
                Button(writeButtonDisplay + " (\(selectedScore))")
                {
                    if permittedLogs > 0 {
                        scoreDisplays[selectedScoreIndex] = "\(selectedScore)"
                        implementedScores[selectedScoreIndex] = selectedScore
                        permittedLogs -= 1
                    }
                    if permittedLogs <= 0 {
                        // do stuff
                        writeButtonDisplay = "Score Already Written"
                    }
                }
                .buttonStyle(SheetButtonStyle())
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(inheritedScores: [0], selectedScore: 0, selectedScoreIndex: 0)
    }
}
