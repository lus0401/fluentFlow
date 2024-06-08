import SwiftUI

enum Index {
    case one, two, three
}

struct GeometryPracticeView: View {
    @State var index : Index = .one
    
    var body: some View {
        GeometryReader{ geometry in
            VStack (spacing : 0){
                Button(action: {
                    withAnimation{
                        self.index = .one
                    }
                }, label: {
                    Text("1")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(height: geometry.size.height / 3)
                        .padding(.horizontal, self.index == .one ? 100 : 20)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                })
                
                Button(action: {
                    withAnimation{
                        self.index = .two
                    }
                }, label: {
                    Text("2")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(height: geometry.size.height / 3)
                        .padding(.horizontal, self.index == .two ? 100 : 20)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                })

                Button(action: {
                    withAnimation{
                        self.index = .three
                    }
                }, label: {
                    Text("3")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(height: geometry.size.height / 3)
                        .padding(.horizontal, self.index == .three ? 100 : 20)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                })
            }
            .frame(width: geometry.size.width)
            .background(Color.yellow)
        }
    }
}

struct GeometryPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPracticeView()
    }
}
