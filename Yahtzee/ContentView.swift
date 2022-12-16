//
//  ContentView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var scores = []
    @State private var randomValues = [0, 0, 0, 0, 0]
    @State private var heldDice = [false, false, false, false, false]
    @State private var randomValue = 0
    @State private var rotationValues = [0.0, 0.0, 0.0, 0.0, 0.0]
    @State private var holdValues = ["Hold", "Hold", "Hold", "Hold", "Hold"]
    @State private var numberOfRolls = 3
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.opacity(0.7).ignoresSafeArea()
                VStack {
                    CustomText(text: "Yahtzee!")
                    ForEach (0..<5){ i in
                        HStack {
                            Image("pips \(randomValues[i])")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .rotationEffect(.degrees(rotationValues[i]))
                                .rotation3DEffect(.degrees(rotationValues[i]), axis: (x: 1, y: 1, z: 1))
                                .padding()
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
                    HStack{
                        Button("Roll (\(numberOfRolls))") {
                            if numberOfRolls > 0 {
                                rollTheDice()
                                numberOfRolls -= 1
                            }
                        }
                        .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                        Button("Reset") {
                            reset()
                        }
                        .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                    }
                    HStack{
                        NavigationLink("Help", destination: InstructionsView())
                            .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                        /*
                        NavigationLink("See Score", destination: ScoreView(diceValues: randomValues))
                            .buttonStyle(CustomButtonStyle(holdValue: "Hold"))
                         */
                    }
                }
            }
        }
    }
    func chooseRandom(times: Int, i: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                randomValues[i] = Int.random(in: 1...6)
                chooseRandom(times: times - 1, i: i)
            }
        }
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
        //Resets the game
        randomValues = [0, 0, 0, 0, 0]
        numberOfRolls = 3
        holdValues = ["Hold", "Hold", "Hold", "Hold", "Hold"]
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
