//
//  ContentView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct ContentView: View {
    // These are the dice values
    @State private var diceValues = [0, 0, 0, 0, 0]
    // These are the dice animation values
    @State private var rotationValues = [0.0, 0.0, 0.0, 0.0, 0.0]
    // These are the values that tell if a dice is being holded or not
    @State private var holdValues = ["Hold", "Hold", "Hold", "Hold", "Hold"]
    // This is the number of rolls left- self explanatory
    @State private var numberOfRolls = 3
    // These are the Scores that the player earns, not the scores calculated from what the player earns
    @State private var scores = [-1, // i=0 | Aces
                                 -1, // i=1 | Twos
                                 -1, // i=2 | Threes
                                 -1, // i=3 | Fours
                                 -1, // i=4 | Fives
                                 -1, // i=5 | Sixes
                                 -1, // i=6 | 3 of a kind
                                 -1, // i=7 | 4 of a kind
                                 -1, // i=8 | Full House
                                 -1, // i=9 | Small Straight
                                 -1, // i=10 | Large Straight
                                 -1, // i=11 | Yahtzee
                                 -1, // i=12 | Chance
                                 -1] // i=13 | Yahtzee Bonuses
    // When the player writes a score, this variable holds the value
    @State private var selectedScore = 0
    // Since the scores are in an array, we also need the index
    @State private var selectedScoreIndex = 0
    // I plan on iterating through a for-loop for the score-sheet, so here's the types of scores as strings on an array
    @State private var displayStrings = ["Aces: ", "Twos: ", "Threes: ", "Fours: ", "Fives: ", "Sixes: ", "Total Score: ", "Bonus: ", "Top Total: ", "3 of a kind: ", "4 of a kind: ", "Full House: ", "Small Straight: ", "Large Straight: ", "Yahtzee: ", "Chance: ", "Yahtzee Bonuses: ", "Bottom Total: ", "Top Total: ", "Grand Total: "]
    // Along with the variable above "displayStrings"- I will obviously needs to have the actual scores next to them, so here they are in Integer-Array Form
    @State private var scoreDisplays = ["-", "-", "-", "-", "-", "-",
                                        "-", "-", "-", "-", "-", "-", "-", "-"]
    // A counter to keep track of how many Yahtzee Bonuses you have
    @State private var amountOfYahtzeeBonuses = 0
    
    // Number of turns you have left
    @State private var numberOfTurns = 13
    
    // In the name
    @State private var testBoolean = false
    
    // View
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.opacity(0.7).ignoresSafeArea()
                VStack {
                    Text("")
                        .padding(1)
                    CustomText(text: "Yahtzee!")
                    CustomTextTiny(text: "\(numberOfTurns) Turns Left")
                    ForEach (0..<5){ i in
                        HStack {
                            Image("pips \(diceValues[i])")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .rotationEffect(.degrees(rotationValues[i]))
                                .rotation3DEffect(.degrees(rotationValues[i]), axis: (x: 1, y: 1, z: 1))
                                .padding(7)
                                .onTapGesture {
                                    //contains code that will go in rollTheDice()
                                    //chooseRandom(times: 3, i: i)
                                    //withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                                    //rotationValues[i] += 360
                                    //}
                                }
                            
                            Button(holdValues[i]) {
                                if(holdValues[i] == "Hold")
                                {
                                    holdValues[i] = "Un-Hold"
                                }
                                else if holdValues[i] == "Un-Hold"
                                {
                                    holdValues[i] = "Hold"
                                }
                            }
                            .buttonStyle(CustomButtonStyle(holdValue: holdValues[i]))
                        }
                    }
                    Picker("Select Score Method", selection: $selectedScore) {
                        Group {
                            Text("Aces: \(calcDiceNumber(number:1))").tag(calcDiceNumber(number: 1))
                            Text("Twos: \(calcDiceNumber(number:2))").tag(calcDiceNumber(number: 2))
                            Text("Threes: \(calcDiceNumber(number:3))").tag(calcDiceNumber(number: 3))
                            Text("Fours: \(calcDiceNumber(number:4))").tag(calcDiceNumber(number: 4))
                            Text("Fives: \(calcDiceNumber(number:5))").tag(calcDiceNumber(number: 5))
                            Text("Sixes: \(calcDiceNumber(number:6))").tag(calcDiceNumber(number: 6))
                        }
                        Group {
                            Text("3 of a kind: \(calc3OfAKind())").tag(calc3OfAKind())
                            Text("4 of a kind: \(calc4OfAKind())").tag(calc4OfAKind())
                            Text("Full House: \(calcFullHouse())").tag(calcFullHouse())
                            Text("Small Straight: \(calcSmallStraight())").tag(calcSmallStraight())
                            Text("Large Straight: \(calcLargeStraight())").tag(calcLargeStraight())
                            Text("Yahtzee: \(calcYahtzee())").tag(calcYahtzee())
                            Text("Chance: \(calcChance())").tag(calcChance())
                            Text("Yahtzee Bonus: \(calcYahtzeeBonuses())").tag(calcYahtzeeBonuses())
                        }
                    }
                    HStack{
                        Button("Roll (\(numberOfRolls))") {
                            if numberOfRolls > 0 {
                                rollTheDice()
                                numberOfRolls -= 1
                            }
                        }
                        .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                        Button("Put Score")
                        {
                            if(scores[calcIndexBasedOnScore()] < 0 && calcIndexBasedOnScore() != 13)
                            {
                                selectedScoreIndex = calcIndexBasedOnScore()
                                scores[selectedScoreIndex] = selectedScore
                                numberOfTurns -= 1
                            }
                            else if(calcIndexBasedOnScore() == 13 && (scores[13] == -1 || scores[13] == 100 || scores[13] == 200))
                            {
                                if(scores[13] == -1)
                                {
                                    scores[13] += 101
                                }
                                else
                                {
                                    scores[13] += 100
                                }
                            }
                            reset()
                        }
                        .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                    }
                    HStack{
                        NavigationLink("Help", destination: InstructionsView())
                            .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                        Button("Reset") {
                            resetGame()
                        }
                        .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                        /*
                         NavigationLink("See Score", destination: ScoreView(diceValues: randomValues))
                         .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                         */
                    }
                    HStack{
                        NavigationLink("See Score", destination: SheetView(implementedScores: scores))
                            .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                    }
                }
            }
        }
    }
    func chooseRandom(times: Int, i: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                diceValues[i] = Int.random(in: 1...6)
                chooseRandom(times: times - 1, i: i)
            }
        }
    }
    
    func calcIndexBasedOnScore() -> Int {
        if selectedScore == calcDiceNumber(number: 1) {return 0}
        if selectedScore == calcDiceNumber(number: 2) {return 1}
        if selectedScore == calcDiceNumber(number: 3) {return 2}
        if selectedScore == calcDiceNumber(number: 4) {return 3}
        if selectedScore == calcDiceNumber(number: 5) {return 4}
        if selectedScore == calcDiceNumber(number: 6) {return 5}
        if selectedScore == calc3OfAKind() {return 6}
        if selectedScore == calc4OfAKind() {return 7}
        if selectedScore == calcFullHouse() {return 8}
        if selectedScore == calcSmallStraight() {return 9}
        if selectedScore == calcLargeStraight() {return 10}
        if selectedScore == calcYahtzee() {return 11}
        if selectedScore == calcChance() {return 12}
        if selectedScore == calcYahtzeeBonuses() {return 13}
        return -1
    }
    
    func rollTheDice() {
        //Roll All Unheld Dice
        for i in (0..<5) {
            if(holdValues[i] == "Hold") {
                chooseRandom(times: 3, i: i)
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                    rotationValues[i] += 360
                }
            }
        }
    }
    
    func reset() {
        //Resets for the next turn
        diceValues = [0, 0, 0, 0, 0]
        numberOfRolls = 3
        holdValues = ["Hold", "Hold", "Hold", "Hold", "Hold"]
    }
    
    func resetGame() {
        //Resets the actual game
        diceValues = [0, 0, 0, 0, 0]
        numberOfRolls = 3
        holdValues = ["Hold", "Hold", "Hold", "Hold", "Hold"]
        for i in (0..<14) {
            scores[i] = -1
        }
        numberOfTurns = 13
    }
    
    func runCalculations() {
        scores[0] = calcDiceNumber(number: 1)
        scores[1] = calcDiceNumber(number: 2)
        scores[2] = calcDiceNumber(number: 3)
        scores[3] = calcDiceNumber(number: 4)
        scores[4] = calcDiceNumber(number: 5)
        scores[5] = calcDiceNumber(number: 6)
        scores[6] = calc3OfAKind()
        scores[7] = calc4OfAKind()
        scores[8] = calcFullHouse()
        scores[9] = calcSmallStraight()
        scores[10] = calcLargeStraight()
        scores[11] = calcYahtzee()
        scores[12] = calcChance()
        scores[13] = calcYahtzeeBonuses()
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
                //do nothing
            }
            else if amountOfDice[i] >= 2 {
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
    
    func calcYahtzeeBonuses() -> Int {
        if(calcYahtzee() == 50 && scores[11] == 50)
        {
            return 100
        }
        return 0
    }
}

// inherited from Pig
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Marker Felt", size: 36))
    }
}

// inherited from Pig
struct CustomTextSmall: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Marker Felt", size: 30))
    }
}

// inherited from Pig
struct CustomTextTiny: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Marker Felt", size: 24))
    }
}


// inherited from Pig
struct CustomButtonStyle: ButtonStyle {
    let holdValue : String
    func makeBody(configuration: Configuration) -> some View {
        if(holdValue == "Hold"){
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 24))
                .padding()
                .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else{
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 24))
                .padding()
                .background(.blue).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
    }
}

// also inherited from Pig
struct SmallCustomButtonStyle: ButtonStyle {
    let holdValue : String
    func makeBody(configuration: Configuration) -> some View {
        if(holdValue == "Hold"){
            configuration.label
                .frame(width: 150)
                .font(Font.custom("Marker Felt", size: 20))
                .padding()
                .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else{
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 20))
                .padding()
                .background(.blue).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
    }
}

// 100% sure it's inherited from Pig
struct SelectionButtonStyle: ButtonStyle {
    let selectValue : String
    let selectNumber : Int
    func makeBody(configuration: Configuration) -> some View {
        if(selectValue == "X"){
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(3)
                .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else if (selectValue == "-"){
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(3)
                .background(.gray).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else if (selectNumber >= 0){
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(3)
                .background(.green).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else {
            configuration.label
                .frame(width: 100)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(3)
                .background(.yellow).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

// 100% sure it's inherited from Pig
struct OneThirdSelectionButtonStyle: ButtonStyle {
    let selectValue : String
    let selectNumber : Int
    func makeBody(configuration: Configuration) -> some View {
        if(selectValue == "X"){
            configuration.label
                .frame(width: 33)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(1.5)
                .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else if (selectValue == "-"){
            configuration.label
                .frame(width: 33)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(1.5)
                .background(.gray).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else if (selectNumber >= 0){
            configuration.label
                .frame(width: 33)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(1.5)
                .background(.green).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        else {
            configuration.label
                .frame(width: 33)
                .font(Font.custom("Marker Felt", size: 30))
                .padding(1.5)
                .background(.yellow).opacity(configuration.isPressed ? 0.0 : 1.0)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

// Super Duper Condfident it's inherited from Pig
struct SheetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        //.frame(width: 300)
            .font(Font.custom("Marker Felt", size: 30))
            .padding(3)
            .background(.white).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 Citations:
 - Leo Lai
 - For Loops: https://www.programiz.com/swift-programming/for-in-loop
 - For Loop Error: https://stackoverflow.com/questions/62617491/swiftui-error-closure-containing-control-flow-statement-cannot-be-used-with-fu
 - Yahtzee Score Card Reference: https://www.papertraildesign.com/wp-content/uploads/2020/12/Yahtzee-Score-Card-single.jpg
 - Dice Reference: https://www.shutterstock.com/image-vector/dice-icons-set-traditional-die-six-1758258896
 - More than 10 views:
 https://blog.eppz.eu/more-than-10-views-in-swiftui/#:~:text=Every%20SwiftUI%20Group%20is%20limited,List%20%2C%20ForEach%20etc.).
 **/
