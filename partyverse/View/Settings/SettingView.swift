import SwiftUI

struct SettingView: View {
    @Binding var appUser: AppUser?
    
    @State private var isPresented = false
    
    var body: some View {
        List {
            Button {
                isPresented.toggle()
            } label: {
                Label("log out", systemImage: "door.left.hand.open")
                    .foregroundColor(.red)
            }
            .confirmationDialog("do you really want to log out?",
                                isPresented: $isPresented) {
                Button("log out", role: .destructive) {
                    Task {
                        do {
                            try await AuthManager.shared.signOut()
                            self.appUser = nil
                        } catch {
                            print("error signing out")
                        }
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(appUser: .constant(.init(uuid: "1234", email: "example@mail.com")))
    }
}
