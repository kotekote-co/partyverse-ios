import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = PfpViewModel()
    
    @Binding var appUser: AppUser?
    @State var showPhotoActionSheet = false
    @State var showPhotoLibrary = false
    @State var selectedPhoto: PhotosPickerItem?
    @State var profileImage =  Image(systemName: "person")
    
    var body: some View {
        if let appUser = appUser {
            NavigationStack {
                ZStack {
                    VStack {
                        VStack {
                            Text(appUser.uuid)
                            
                            Text(appUser.email ?? "No email")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SettingView(appUser: $appUser)
                        } label: {
                            Label("settings", systemImage: "gear")
                        }
                        .buttonStyle(.borderless)
                        .labelStyle(.iconOnly)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .cornerRadius(16)
                            .onTapGesture {
                                showPhotoActionSheet.toggle()
                            }
                            .confirmationDialog("Select A Profile Photo", isPresented: $showPhotoActionSheet) {
                                Button {
                                    showPhotoLibrary.toggle()
                                } label: {
                                    Text("Photo Library")
                                }
                            }
                            .photosPicker(isPresented: $showPhotoLibrary, selection: $selectedPhoto, photoLibrary: .shared())
                            .onChange(of: selectedPhoto) { newValue in
                                guard let photoItem = selectedPhoto else {
                                    return
                                }
                                
                                Task {
                                    if let photoData = try await photoItem.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: photoData) {
                                        do {
                                            try await StorageManager.shared.uploadProfilePhoto(for: appUser, photoData: photoData)
                                        } catch {
                                            print(error)
                                        }
                                        await MainActor.run {
                                            profileImage = Image(uiImage: uiImage)
                                        }
                                    }
                                }
                            }
                    }
                }
                .onAppear {
                    Task {
                        do {
                            let uiImage = try await viewModel.fetchProfilePhoto(for: appUser)
                            await MainActor.run {
                                profileImage = Image(uiImage: uiImage)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(appUser: .constant(.init(uuid: "", email: "")))
    }
}
