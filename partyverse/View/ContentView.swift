import SwiftUI

struct ContentView: View {
    @State private var showingProfile = false
    
    @State var appUser: AppUser?
    
    var body: some View {
        NavigationView {
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appUser: nil)
            .environment(\.locale, Locale.init(identifier: "en"))
    }
}
