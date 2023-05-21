import SwiftUI

struct ProfileCircleImage: View {
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/bc/Juvenile_Ragdoll.jpg"), scale: 1) { image in
                    image.resizable()
                } placeholder: {
                    
                }
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

struct ProfileCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCircleImage()
    }
}
