import SwiftUI

struct ContentView: View {
    @State private var showingProfile = false
    
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
                            ProfileHost()
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
        ContentView()
            .environment(\.locale, Locale.init(identifier: "ru"))
        ContentView()
            .environment(\.locale, Locale.init(identifier: "en"))
    }
}
