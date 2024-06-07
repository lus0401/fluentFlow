import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @State var showingAlert: Bool = false
    
    var body: some View {
        NavigationView {
            List{
                Section{
                    NavigationLink {
                        Text("Profile")
                    } label: {
                        profileCell()
                    }
                }
                Section{
                    toggleCell(imageName: "person.fill",
                               cellTitle: "초집중모드",
                               isModeOn: $showingAlert)
                    
                    navigationLinkCell(imageName: "wifi",
                              cellTitle: "WIFI",
                              cellInfo: "AFGSE_ER4563"){
                        Text("WIFI Screen")
                    }
                    
                    navigationLinkCell(imageName: "lock.fill",
                              cellTitle: "Password"){
                        Text("Password Screen")
                    }

                }
                
                Section{
                    navigationLinkCell(imageName: "gear",
                              cellTitle: "Settings"){
                        Text("Settings Screen")
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                // Load user data when the view appears
                if let user = viewModel.user {
                    print("User: \(user.username), Email: \(user.email)")
                }
            }
        }
    }
    
    @ViewBuilder
    private func profileCell() -> some View {
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.all,15)
                .background(.yellow)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 3){
                Text(viewModel.user?.username ?? "Unknown")
                    .font(.system(size: 24))
                    .fontWeight(.regular)
                
                Text(viewModel.user?.email ?? "Unknown Email")
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
            .padding(.horizontal, 6)
        }
        .padding(.vertical, 10)
    }
    
    @ViewBuilder
    private func toggleCell(imageName: String, cellTitle: String, isModeOn: Binding<Bool>) -> some View {
        HStack{
            Image(systemName: imageName)
            Toggle(cellTitle, isOn:isModeOn)
        }
    }
    
    @ViewBuilder
    private func navigationLinkCell<V: View>(imageName: String, cellTitle: String,
                                    cellInfo: String? = nil, destination: @escaping () -> V) -> some View{
        HStack{
            Image(systemName: imageName)
            
            if let cellInfo = cellInfo {
                NavigationLink {
                    Text(cellTitle)
                } label: {
                    HStack{
                        Text(cellTitle)
                        Spacer()
                        Text(cellInfo)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                NavigationLink(cellTitle){
                    destination()
            }
            }
        }
    }
}

#Preview {
    ProfileView()
}
