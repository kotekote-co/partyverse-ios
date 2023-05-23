import SwiftUI


struct LoginView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
