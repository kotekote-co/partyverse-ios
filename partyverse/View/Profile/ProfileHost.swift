import SwiftUI

struct ProfileHost: View {
    let profileName = "Alex"
    
    var body: some View {
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
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
