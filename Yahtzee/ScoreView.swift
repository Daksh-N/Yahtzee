//
//  ScoreView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct ScoreView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                CustomText(text: "Scores")
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
