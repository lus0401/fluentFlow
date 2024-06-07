import SwiftUI

struct PurposesView: View {
    @State private var selectedOptions: Set<String> = []
    
    let purposes = ["여행을 위해", "직장/비즈니스", "학업/유학", "새로운 사람들과 소통", "자기계발", "문화 및 엔터테인먼트"]
    
    let purposesIcons = [
        "여행을 위해": "🌍",
        "직장/비즈니스": "🧑‍💼",
        "학업/유학": "🎓",
        "새로운 사람들과 소통": "🗣️",
        "자기계발": "📚",
        "문화 및 엔터테인먼트": "🎬"
    ]
    
    let purposesDescriptions = [
        "여행을 위해": "For Travel",
        "직장/비즈니스": "For Work/Business",
        "학업/유학": "For Study/Abroad",
        "새로운 사람들과 소통": "To Communicate with New People",
        "자기계발": "For Personal Development",
        "문화 및 엔터테인먼트": "For Culture and Entertainment"
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "line.horizontal.3")
                    .font(.largeTitle)
                Spacer()
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
            }
            .padding(20)

            Text("무엇을 위해 공부하고싶습니까?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            Text("선택한 정보를 바탕으로 대화가 구성되요.\n옵션은 언제든지 수정가능해요.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            Spacer().frame(height: 10)
            
            ScrollView{
                VStack(spacing: 10) {
                    ForEach(purposes, id: \.self) { option in
                        Button(action: {
                            if selectedOptions.contains(option) {
                                selectedOptions.remove(option)
                            } else {
                                selectedOptions.insert(option)
                            }
                        }) {
                            HStack(spacing: 10) {
                                Text(purposesIcons[option] ?? "")
                                    .font(.largeTitle)
                                    .padding(7)
                                VStack(alignment: .leading) {
                                    Divider().opacity(0)
                                    Text(option)
                                        .font(.headline)
                                    Spacer().frame(height: 5)
                                    Text(purposesDescriptions[option] ?? "")
                                        .font(.caption)
                                }
                            }
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .background(selectedOptions.contains(option) ? Color.green.opacity(0.3) : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedOptions.contains(option) ? Color.green : Color.clear, lineWidth: 2)
                            )
                        }
                        .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    // 선택 완료 버튼 동작
                }) {
                    Text("선택 완료")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOptions.isEmpty ? Color.gray : Color.yellow)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(selectedOptions.isEmpty)
            } // ScrollView

        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PurposesView_Previews: PreviewProvider {
    static var previews: some View {
        PurposesView()
    }
}
