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
    var body: some View {
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
                            chooseRandom(times: 3, i: i)
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                            rotationValues[i] += 360
                            }
                        }
                        
                        Button(holdValues[i]) {
                            // do stuff
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                }
                Button("Roll") {
                    rollTheDice()
                }
                .buttonStyle(CustomButtonStyle())
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
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50)
            .font(Font.custom("Marker Felt", size: 24))
            .padding()
        //if(configuration.label == "Hold"){
            .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
        //}
            .foregroundColor(.white)
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
 **/
