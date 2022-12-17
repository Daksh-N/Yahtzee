//
//  SheetView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/15/22.
//

import SwiftUI

struct SheetView: View {
    @State private var displayStrings = ["Aces: ", "Twos: ", "Threes: ", "Fours: ", "Fives: ", "Sixes: ", "Total Score: ", "Bonus: ", "Top Total: ", "3 of a kind: ", "4 of a kind: ", "Full House: ", "Small Straight: ", "Large Straight: ", "Yahtzee: ", "Chance: ", "Yahtzee Bonuses: ", "Bottom Total: ", "Top Total: ", "Grand Total: "]
    @State var implementedScores : [Int]
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                CustomTextSmall(text: "Score Sheet:")
                    //.padding()
                HStack {
                    VStack {
                        ForEach (0..<20) { i in
                            CustomTextTiny(text: displayStrings[i])
                        }
                        .padding(1)
                    }
                    VStack {
                        ForEach (0..<6) { i in
                            CustomTextTiny(text: "\(implementedScores[i])")
                        }
                        .padding(1)
                        CustomTextTiny(text: "\(calcTopTotal())")
                            .padding(1)
                        CustomTextTiny(text: "\(calcTopBonus())")
                            .padding(1)
                        CustomTextTiny(text: "\(calcTrueTopTotal())")
                            .padding(1)
                        ForEach(6..<14) { i in
                            CustomTextTiny(text: "\(implementedScores[i])")
                        }
                        .padding(1)
                        CustomTextTiny(text: "\(calcBottomTotal())")
                            .padding(1)
                        CustomTextTiny(text: "\(calcTrueTopTotal())")
                            .padding(1)
                        CustomTextTiny(text: "\(calcGrandTotal())")
                            .padding(1)
                    }
                }
            }
            Spacer()
        }
    }
    func calcTopTotal() -> Int {
        var sum = 0
        for i in (0..<6) {
            sum += implementedScores[i]
        }
        return sum
    }
    
    func calcTopBonus() -> Int {
        if calcTopTotal() >= 63
        {
            return 35
        }
        else
        {
            return 0
        }
    }
    
    func calcTrueTopTotal() -> Int {
        return calcTopTotal() + calcTopBonus()
    }
    
    func calcBottomTotal() -> Int {
        var sum = 0
        for i in (6..<14) {
            sum += implementedScores[i]
        }
        return sum
    }
    
    func calcGrandTotal() -> Int {
        return calcTrueTopTotal() + calcBottomTotal()
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(implementedScores: [-1, -1, -1, -1, -1, -1,
                                       -1, -1, -1, -1, -1, -1, -1, -1])
    }
}
