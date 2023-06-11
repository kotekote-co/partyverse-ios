import SwiftUI

struct ProfileView: View {
    @Binding var appUser: AppUser?
    
    var body: some View {
        if let appUser = appUser {
            NavigationView {
                ZStack {
                    VStack {
                        VStack {
                            Text(appUser.uuid)
                            
                            Text(appUser.email ?? "No email")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SettingView(appUser: $appUser)
                        } label: {
                            Label("settings", systemImage: "gear")
                        }
                        .padding(.all, 5)
                        .buttonStyle(.borderless)
                        .labelStyle(.iconOnly)
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
