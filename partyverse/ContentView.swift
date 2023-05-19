import SwiftUI

struct ContentView: View {
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button() {
                    showingProfile.toggle()
                } label: {
                    Label("", systemImage: "person.crop.circle")
                }
                .sheet(isPresented: $showingProfile) {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
