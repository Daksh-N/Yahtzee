//
//  InstructionsView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.opacity(0.7).ignoresSafeArea()
                VStack {
                    Text("Yahtzee is a simple but complicated game involving 5 dice, here's how to play it:")
                        .padding(18)
                    Text("You have 13 turns, and within those 13 turns, 1 up to 3 rolls, and within those rolls, the ability to \"hold\" dice, or save them so you can try to score points by earning certain types of such")
                        .padding(1)
                    Text("There are many ways to score points (however, each type can only be used once in the whole game), and here's each of them:")
                        .padding(1)
                    Text("Aces: Roll as many ones as you can and they get totaled, same logic applies for Twos-Sixes, but with the amount of dice with the respective number getting totaled")
                        .padding(1)
                    Text("The Top Bonus can be acquired if the player scores 63 or more points on the top section only (Aces-Sixes), which is a value of 35")
                        .padding(1)
                    Text("3 and 4 of a kind: In the name, get either 3 or 4 of a kind to gain the respective type of points. Every single die value gets totaled for the actual score value")
                        .padding(1)
                    Text("Full House: You have a pair (2 of a kind) and 3 of a kind both, that of seperate numbers, but instead of the dice being totaled, you just score 25 points no matter what")
                        .padding(1)
                    NavigationLink("Next Page", destination: InstructionsContinuedView())
                        .padding(18)
                }
                .padding()
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
