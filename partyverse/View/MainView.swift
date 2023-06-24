import SwiftUI

struct MainView: View {
    @State private var showingProfile = false
    @State var appUser: AppUser?
    
    var body: some View {
        ZStack {
            MapView()
            HStack {
                Spacer()
                VStack {
                    Button() {
                        showingProfile.toggle()
                    } label: {
                        Label("profile", systemImage: "person.crop.circle")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.all, 15)
                    .sheet(isPresented: $showingProfile) {
                        ZStack {
                            if let _ = appUser {
                                ProfileView(appUser: $appUser)
                            } else {
                                SignInView(appUser: $appUser)
                            }
                        }
                        .presentationDragIndicator(.visible)
                        .onAppear {
                            Task {
                                self.appUser = try await AuthManager.shared.getCurrentSession()
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environment(\.locale, Locale.init(identifier: "en"))
                .previewDisplayName("en")
            MainView()
                .environment(\.locale, Locale.init(identifier: "ru"))
                .previewDisplayName("ru")
        }
    }
}
