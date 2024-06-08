import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State var showingAlert: Bool = false
    @Binding var isNavigationBarHidden: Bool
    
    init(navigationBarHidden: Binding<Bool> = .constant(false)) {
        _isNavigationBarHidden = navigationBarHidden
    }
    
    var body: some View {
        NavigationView {
            List {
                Circle().frame(width: 80, height: 80, alignment: .center)
                
                Section {
                    toggleCell(imageName: "person.fill",
                               cellTitle: "초집중모드",
                               isModeOn: $showingAlert)
                    
                    navigationLinkCell(imageName: "wifi",
                                       cellTitle: "WIFI",
                                       cellInfo: "AFGSE_ER4563") {
                        Text("WIFI Screen")
                    }
                    
                    navigationLinkCell(imageName: "lock.fill",
                                       cellTitle: "Password") {
                        Text("Password Screen")
                    }
                }
                
                Section {
                    navigationLinkCell(imageName: "gear",
                                       cellTitle: "Settings") {
                        Text("Settings Screen")
                    }
                    
                    navigationLinkCell(imageName: "graduationcap",
                                       cellTitle: "English Level") {
                        EnglishLevelView(isLoggedIn: .constant(true))
                    }
                    
                    navigationLinkCell(imageName: "bookmark",
                                       cellTitle: "Purposes") {
                        PurposesView()
                    }
                    
                    navigationLinkCell(imageName: "pencil",
                                       cellTitle: "Edit Profile") {
                        OptionsEditView()
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear {
                self.isNavigationBarHidden = true
            }
        }
        
    }//NavigationView
    
    
    @ViewBuilder
    private func toggleCell(imageName: String, cellTitle: String, isModeOn: Binding<Bool>) -> some View {
        HStack {
            Image(systemName: imageName)
            Toggle(cellTitle, isOn: isModeOn)
        }
    }
    
    @ViewBuilder
    private func navigationLinkCell<V: View>(imageName: String, cellTitle: String,
                                             cellInfo: String? = nil, destination: @escaping () -> V) -> some View {
        HStack {
            Image(systemName: imageName)
            
            if let cellInfo = cellInfo {
                NavigationLink {
                    destination()
                } label: {
                    HStack {
                        Text(cellTitle)
                        Spacer()
                        Text(cellInfo)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                NavigationLink(cellTitle) {
                    destination()
                }
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
            .environmentObject(UserSettings())
    }
}
