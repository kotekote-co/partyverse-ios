import SwiftUI

struct ContentView: View {
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Button() {
                        showingProfile.toggle()
                    } label: {
                        Label("profile", systemImage: "person.crop.circle")
                    }
                    .padding(.all, 15)
                    .sheet(isPresented: $showingProfile) {
                        
                    }
                    Spacer()
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
