//
//  ChatPracticeView.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI

struct ChatPracticeView: View {
    @ObservedObject var viewModel = ChatPracticeViewModel()

    var body: some View {
        Text("Chat Practice Page")
            .font(.largeTitle)
            .padding()
    }
}

struct ChatPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ChatPracticeView()
    }
}
