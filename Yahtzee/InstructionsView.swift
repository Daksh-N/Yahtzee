//
//  InstructionsView.swift
//  Yahtzee
//
//  Created by Daksh Nakra on 12/12/22.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.7).ignoresSafeArea()
            VStack {
                CustomText(text: "Instructions")
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
