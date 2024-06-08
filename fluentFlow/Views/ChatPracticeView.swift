import SwiftUI

struct ChatPracticeView: View {
   // @ObservedObject var viewModel = ChatPracticeViewModel()

    var body: some View {
        VStack {
            HStack {
             Image(systemName: "line.horizontal.3")
             .font(.largeTitle)
             Spacer()
             Image(systemName: "person.crop.circle.fill")
             .font(.largeTitle)
             }
            .padding(20)
            
            Spacer()

            Text("Chat Practice View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Spacer()
        }
        


    }
}

struct ChatPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ChatPracticeView()
    }
}
