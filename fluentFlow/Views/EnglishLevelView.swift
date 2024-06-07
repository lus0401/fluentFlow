import SwiftUI
import WebKit

// WKWebView를 Wrapping하는 구조체
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

// 메인 뷰
struct EnglishLevelView: View {
    
    @Binding var isLoggedIn: Bool
    
    @State private var selectedOption: String? = nil
    @State private var showWebView: Bool = false
    
    let cefrLevels = ["C1", "B2", "B1", "A2", "A1"]
    
    let levelDescriptions = [
        "C1": "고급",
        "B2": "중상급",
        "B1": "중급",
        "A2": "초급자",
        "A1": "입문자"
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "line.horizontal.3")
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.largeTitle)
                }
                .padding(20)

                Text("현재 영어레벨은 어느정도이신가요?")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("적절한 대화 생성을 위해 필요해요!\n외부에 공개되지 않아요.")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                Button(action: {
                    showWebView.toggle()
                }) {
                    Text("CEFR이란?")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .underline()
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }
                .sheet(isPresented: $showWebView) {
                    WebView(url: URL(string: "https://en.wikipedia.org/wiki/Common_European_Framework_of_Reference_for_Languages")!)
                }

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(cefrLevels, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                            }) {
                                HStack(spacing: 10) {
                                    Text(option)
                                        .font(.largeTitle)
                                        .padding(7)
                                    VStack(alignment: .leading) {
                                        Divider().opacity(0)
                                        Text(option)
                                            .font(.headline)
                                        Spacer().frame(height: 5)
                                        Text(levelDescriptions[option] ?? "")
                                            .font(.caption)
                                    }
                                }
                                .padding(5)
                                .frame(maxWidth: .infinity)
                                .background(selectedOption == option ? Color.green.opacity(0.3) : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedOption == option ? Color.green : Color.clear, lineWidth: 2)
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
                            .background(selectedOption == nil ? Color.gray : Color.yellow)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(selectedOption == nil)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct EnglishLevelView_Previews: PreviewProvider {
    @State static var isLoggedIn = true
    
    static var previews: some View {
        EnglishLevelView(isLoggedIn: $isLoggedIn)
    }
}
