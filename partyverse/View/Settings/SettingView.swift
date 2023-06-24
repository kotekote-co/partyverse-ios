import SwiftUI

struct SettingView: View {
    @Binding var appUser: AppUser?
    
    @State private var isPresented = false
    
    var body: some View {
        Form {
            Section(header: Label("account-management", systemImage: "person.fill")) {
                Button {
                    isPresented.toggle()
                } label: {
                    Label("log-out", systemImage: "door.left.hand.open")
                        .foregroundColor(.red)
                }
                .confirmationDialog("log-out-desc", isPresented: $isPresented, titleVisibility: .visible) {
                    Button("log-out", role: .destructive) {
                        Task {
                            do {
                                try await AuthManager.shared.signOut()
                                self.appUser = nil
                            } catch {
                                print("error signing out")
                            }
                        }
                    }
                    Button("cancel", role: .cancel) {
                        isPresented.toggle()
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingView(appUser: .constant(.init(uuid: "1234", email: "example@mail.com")))
                .environment(\.locale, Locale.init(identifier: "en"))
                .previewDisplayName("en")
            
            SettingView(appUser: .constant(.init(uuid: "1234", email: "example@mail.com")))
                .environment(\.locale, Locale.init(identifier: "ru"))
                .previewDisplayName("ru")
        }
    }
}
