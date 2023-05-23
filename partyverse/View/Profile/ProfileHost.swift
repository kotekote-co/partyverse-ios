import SwiftUI
import Supabase

struct ProfileHost: View {
    var body: some View {
        NavigationView {
            VStack() {
                HStack {
                    Text("greetings \("Alex")")
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
