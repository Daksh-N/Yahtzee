//
//  ScoreView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct ScoreView: View {
    let diceValues : [Int]
    @State private var placeholder = "T" // t for test
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                CustomText(text: "Scores:")
                    .padding(24)
                CustomText(text: "Aces: \(calcAces())")
                CustomText(text: "Twos: \(calcTwos())")
                CustomText(text: "Threes: \(calcThrees())")
                CustomText(text: "Fours: \(calcFours())")
                CustomText(text: "Fives: \(calcFives())")
                CustomText(text: "Sixes: \(calcSixes())")
                CustomText(text: "Total Score: \(totalTopScores())")
                CustomText(text: "Bonus(If 63 or Over): \(calcTopBonus())")
                CustomText(text: "Total: \(calcTopTrueTotal())")
            }
        }
    }
    func calcAces() -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == 1 {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func calcTwos() -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == 2 {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func calcThrees() -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == 3 {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func calcFours() -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == 4 {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func calcFives() -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == 5 {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func calcSixes() -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == 6 {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func totalTopScores() -> Int{
        var topTotal = 0
        topTotal = calcAces() + calcTwos() + calcThrees() + calcFours() + calcFives() + calcSixes()
        return topTotal
    }
    
    func calcTopBonus() -> Int {
        var topTotal = totalTopScores()
        var topBonus = 0
        if (topTotal >= 63) {
            topBonus = 35
        }
        else {
            topBonus = 0
        }
        return topBonus
    }
    
    func calcTopTrueTotal() -> Int {
        var topTrueTotal = totalTopScores() + calcTopBonus()
        return topTrueTotal
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(diceValues: [0, 0, 0, 0, 0, 0])
    }
}
