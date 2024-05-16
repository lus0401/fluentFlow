//
//  ProfileView.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//


import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @State var showingAlert: Bool = false
    
    var body: some View {
//
//        if let user = viewModel.user {
//            Text("Username: \(user.username)")
//            Text("Email: \(user.email)")
//        } else {
//            Text("No user data available")
//        }
        
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
                        Text("sWIFI Screen")
                    }
                    
                    navigationLinkCell(imageName: "lock.fill",
                              cellTitle: "Password"){
                        Text("password Screen")
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
                Text("Lee HyeKyung")
                    .font(.system(size: 24))
                    .fontWeight(.regular)
                
                Text("blablablabla ")
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
