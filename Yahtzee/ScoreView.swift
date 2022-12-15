//
//  ScoreView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct ScoreView: View {
    let diceValues : [Int]
    //let diceValues = [1, 2, 3, 4, 5]
    @State private var placeholder = "T" // t for test
    @State private var implementedScores = [0, 0, 0, 0, 0, 0, 0, 0, 0,
                                            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.opacity(0.7).ignoresSafeArea()
                VStack {
                    Group {
                        CustomText(text: "Score Possibilities:")
                        NavigationLink("See Score Sheet", destination: SheetView())
                            .buttonStyle(SmallCustomButtonStyle(holdValue: "Hold"))
                    }
                    Group {
                        CustomTextSmall(text: "Aces: \(calcDiceNumber(number: 1))")
                            .padding(3)
                        CustomTextSmall(text: "Twos: \(calcDiceNumber(number: 2))")
                            .padding(3)
                        CustomTextSmall(text: "Threes: \(calcDiceNumber(number: 3))")
                            .padding(3)
                        CustomTextSmall(text: "Fours: \(calcDiceNumber(number: 4))")
                            .padding(3)
                        CustomTextSmall(text: "Fives: \(calcDiceNumber(number: 5))")
                            .padding(3)
                        CustomTextSmall(text: "Sixes: \(calcDiceNumber(number: 6))")
                            .padding(3)
                    }
                    Group {
                        CustomTextSmall(text: "3 of a kind: \(calc3OfAKind())")
                            .padding(3)
                        CustomTextSmall(text: "4 of a kind: \(calc4OfAKind())")
                            .padding(3)
                        CustomTextSmall(text: "Full House: \(calcFullHouse())")
                            .padding(3)
                        CustomTextSmall(text: "Small Straight: \(calcSmallStraight())")
                            .padding(3)
                        CustomTextSmall(text: "Large Straight: \(calcLargeStraight())")
                            .padding(3)
                        CustomTextSmall(text: "Yahtzee: \(calcYahtzee())")
                            .padding(3)
                        CustomTextSmall(text: "Chance: \(calcChance())")
                            .padding(3)
                    }
                }
            }
        }
    }
    func calcDiceNumber(number: Int) -> Int {
        var count = 0
        for i in (0..<5) {
            if diceValues[i] == number {
                count += diceValues[i]
            }
        }
        return count
    }
    
    func totalTopScores() -> Int{
        var topTotal = 0
        topTotal = calcDiceNumber(number: 1) + calcDiceNumber(number: 2) + calcDiceNumber(number: 3) + calcDiceNumber(number: 4) + calcDiceNumber(number: 5) + calcDiceNumber(number: 6)
        return topTotal
    }
    
    func calcTopBonus() -> Int {
        let topTotal = totalTopScores()
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
        let topTrueTotal = totalTopScores() + calcTopBonus()
        return topTrueTotal
    }
    
    func calc3OfAKind() -> Int {
        var amountOfOnes = 0
        var amountOfTwos = 0
        var amountOfThrees = 0
        var amountOfFours = 0
        var amountOfFives = 0
        var amountOfSixes = 0
        var sum = 0
        for i in (0..<5) {
            sum += diceValues[i]
        }
        for i in (0..<5) {
            if diceValues[i] == 1
            {
                amountOfOnes += 1
            }
            if diceValues[i] == 2
            {
                amountOfTwos += 1
            }
            if diceValues[i] == 3
            {
                amountOfThrees += 1
            }
            if diceValues[i] == 4
            {
                amountOfFours += 1
            }
            if diceValues[i] == 5
            {
                amountOfFives += 1
            }
            if diceValues[i] == 6
            {
                amountOfSixes += 1
            }
        }
        let amountOfDice = [amountOfOnes, amountOfTwos, amountOfThrees, amountOfFours, amountOfFives, amountOfSixes]
        for i in (0..<6) {
            if amountOfDice[i] >= 3 {
                return sum
            }
        }
        return 0
    }
    
    func calc4OfAKind() -> Int {
        var amountOfOnes = 0
        var amountOfTwos = 0
        var amountOfThrees = 0
        var amountOfFours = 0
        var amountOfFives = 0
        var amountOfSixes = 0
        var sum = 0
        for i in (0..<5) {
            sum += diceValues[i]
        }
        for i in (0..<5) {
            if diceValues[i] == 1
            {
                amountOfOnes += 1
            }
            if diceValues[i] == 2
            {
                amountOfTwos += 1
            }
            if diceValues[i] == 3
            {
                amountOfThrees += 1
            }
            if diceValues[i] == 4
            {
                amountOfFours += 1
            }
            if diceValues[i] == 5
            {
                amountOfFives += 1
            }
            if diceValues[i] == 6
            {
                amountOfSixes += 1
            }
        }
        let amountOfDice = [amountOfOnes, amountOfTwos, amountOfThrees, amountOfFours, amountOfFives, amountOfSixes]
        for i in (0..<6) {
            if amountOfDice[i] >= 4 {
                return sum
            }
        }
        return 0
    }
    
    func calcFullHouse() -> Int {
        var amountOfOnes = 0
        var amountOfTwos = 0
        var amountOfThrees = 0
        var amountOfFours = 0
        var amountOfFives = 0
        var amountOfSixes = 0
        var sum = 0
        for i in (0..<5) {
            sum += diceValues[i]
        }
        for i in (0..<5) {
            if diceValues[i] == 1
            {
                amountOfOnes += 1
            }
            if diceValues[i] == 2
            {
                amountOfTwos += 1
            }
            if diceValues[i] == 3
            {
                amountOfThrees += 1
            }
            if diceValues[i] == 4
            {
                amountOfFours += 1
            }
            if diceValues[i] == 5
            {
                amountOfFives += 1
            }
            if diceValues[i] == 6
            {
                amountOfSixes += 1
            }
        }
        let amountOfDice = [amountOfOnes, amountOfTwos, amountOfThrees, amountOfFours, amountOfFives, amountOfSixes]
        var indexToSkip = 0
        var trioExists = false
        var duoExists = false
        for i in (0..<6) {
            if amountOfDice[i] >= 3 {
                trioExists = true
                indexToSkip = i
                break
            }
        }
        for i in (0..<6) {
            if i == indexToSkip {
                break
            }
            if amountOfDice[i] >= 2 {
                duoExists = true
                break
            }
        }
        if(trioExists == true && duoExists == true)
        {
            return 25
        }
        return 0
    }
    
    func calcSmallStraight() -> Int {
        var areDicePresent = [false, false, false, false, false, false]
        for i in (0..<5) {
            if diceValues[i] == 1
            {
                areDicePresent[1-1] = true
            }
            if diceValues[i] == 2
            {
                areDicePresent[2-1] = true
            }
            if diceValues[i] == 3
            {
                areDicePresent[3-1] = true
            }
            if diceValues[i] == 4
            {
                areDicePresent[4-1] = true
            }
            if diceValues[i] == 5
            {
                areDicePresent[5-1] = true
            }
            if diceValues[i] == 6
            {
                areDicePresent[6-1] = true
            }
        }
        var isSmallStraight = true
        for i in (0..<4) {
            if areDicePresent[i] == false {
                isSmallStraight = false
            }
        }
        if isSmallStraight == true {
            return 30
        }
        isSmallStraight = true
        for i in (1..<5) {
            if areDicePresent[i] == false {
                isSmallStraight = false
            }
        }
        if isSmallStraight == true {
            return 30
        }
        isSmallStraight = true
        for i in (2..<6) {
            if areDicePresent[i] == false {
                isSmallStraight = false
            }
        }
        if isSmallStraight == true {
            return 30
        }
        return 0
    }
    
    func calcLargeStraight() -> Int {
        var areDicePresent = [false, false, false, false, false, false]
        for i in (0..<5) {
            if diceValues[i] == 1
            {
                areDicePresent[1-1] = true
            }
            if diceValues[i] == 2
            {
                areDicePresent[2-1] = true
            }
            if diceValues[i] == 3
            {
                areDicePresent[3-1] = true
            }
            if diceValues[i] == 4
            {
                areDicePresent[4-1] = true
            }
            if diceValues[i] == 5
            {
                areDicePresent[5-1] = true
            }
            if diceValues[i] == 6
            {
                areDicePresent[6-1] = true
            }
        }
        var isLargeStraight = true
        for i in (0..<5) {
            if areDicePresent[i] == false {
                isLargeStraight = false
            }
        }
        if isLargeStraight == true {
            return 40
        }
        isLargeStraight = true
        for i in (1..<6) {
            if areDicePresent[i] == false {
                isLargeStraight = false
            }
        }
        if isLargeStraight == true {
            return 40
        }
        return 0
    }
    
    func calcYahtzee() -> Int {
        var isYahtzee = true
        for d in (1...6)
        {
            for i in (0..<5)
            {
                if diceValues [i] != d
                {
                    isYahtzee = false
                }
            }
            if isYahtzee == true {return 50}
            isYahtzee = true
        }
        return 0
    }
    
    func calcChance() -> Int {
        var chance = 0
        for i in (0..<5) {
            chance += diceValues[i]
        }
        return chance
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(diceValues: [0, 0, 0, 0, 0, 0])
    }
}
