import SwiftUI

struct ProfileView: View {
    @Binding var appUser: AppUser?
    
    var body: some View {
        if let appUser = appUser {
            VStack {
                Text(appUser.uuid)
                
                Text(appUser.email ?? "No email")
                
                Button {
                    Task {
                        do {
                            try await AuthManager.shared.signOut()
                            self.appUser = nil
                        } catch {
                            print("error signing out")
                        }
                    }
                } label: {
                    Text("Sign out")
                        .foregroundColor(.red)
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
