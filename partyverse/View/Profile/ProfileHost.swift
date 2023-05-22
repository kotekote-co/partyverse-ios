import SwiftUI
import Supabase

struct ProfileHost: View {
    let profileName = "Alex"
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack {
                    Text("Hello, \(profileName)!")
                        .font(.title)
                        .bold()
                }
                Spacer()
                VStack {
                    ProfileCircleImage()
                }
                .padding()
                VStack {
                    NavigationLink {
                        LoginView()
                    } label: {
                        Label("login", systemImage: "folder")
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
