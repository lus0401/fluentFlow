import SwiftUI

struct OptionsEditView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State var showingAlert: Bool = false
    
    var body: some View {
        NavigationView {
            List {
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
            .onAppear {
                // Load user data when the view appears
                print("User: \(userSettings.selectedEnglishLevel ?? "No Level Selected"), Purposes: \(userSettings.selectedPurposes.joined(separator: ", "))")
            }
        }
    }
    
    @ViewBuilder
    private func profileCell() -> some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.all, 15)
                .background(.yellow)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 3) {
                Text(userSettings.selectedEnglishLevel ?? "Unknown")
                    .font(.system(size: 24))
                    .fontWeight(.regular)
                
                Text(userSettings.selectedPurposes.joined(separator: ", "))
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
            .padding(.horizontal, 6)
        }
        .padding(.vertical, 10)
    }
    
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

struct OptionsEditView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsEditView()
            .environmentObject(UserSettings())
    }
}
