//
//  InstructionsContinuedView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/16/22.
//

import SwiftUI

struct InstructionsContinuedView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                Text("Small and Large Straights: You must roll either 4(Small) or 5(Large) sequential dice to earn a nice 30(Small) or 40(Large) points, sequential dice meaning dice that can be counted up (ex: 1 2 3 4 and 5)")
                .padding(1)
                Text("Yahtzee: The best type of score, earn five of a kind and you get 50 points, plus if you get more of these on top you can earn up to 300 (100 per additional Yahtzee) bonus points, and extra turns for each Yahtzee")
                .padding(1)
                Text("Chance: This is if you think you got no other option and you're willing to take a chance (hence, the name) at just adding up the dice, filling up that score slot, and going through")
                .padding(1)
                Text("And that's all on how to play the game, good luck and have fun!")
                .padding(1)
            }
            .padding()
        }
    }
}

struct InstructionsContinuedView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsContinuedView()
    }
}
