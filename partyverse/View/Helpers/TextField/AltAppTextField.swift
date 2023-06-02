import SwiftUI

struct AltAppTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeHolder, text: $text)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

struct AltAppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AltAppTextField(placeHolder: "Email adress", text: .constant(""))
    }
}
