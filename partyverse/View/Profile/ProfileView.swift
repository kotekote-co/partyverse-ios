import SwiftUI

struct ProfileView: View {
    @Binding var appUser: AppUser?
    
    var body: some View {
        if let appUser = appUser {
            NavigationView {
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            NavigationLink {
                                SettingView(appUser: $appUser)
                            } label: {
                                Label("settings", systemImage: "gear")
                            }
                            .padding(.top, 15)
                            .padding(.trailing, 15)
                            .buttonStyle(.borderless)
                            .labelStyle(.iconOnly)
                            Spacer()
                        }
                    }
                    
                    VStack {
                        Text(appUser.uuid)
                        
                        Text(appUser.email ?? "No email")
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(appUser: .constant(.init(uuid: "1234", email: "example@mail.com")))
    }
}
