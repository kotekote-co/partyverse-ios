import SwiftUI

struct ProfileHost: View {
    let profileName = "Alex"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Hello, \(profileName)!")
                    .font(.title)
                    .bold()
            }
            Spacer()
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
