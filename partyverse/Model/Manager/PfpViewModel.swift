import UIKit

class PfpViewModel: ObservableObject {
    
    func fetchProfilePhoto(for user: AppUser) async throws -> UIImage {
        let data = try await StorageManager.shared.fetchProfilePhoto(for: user)
        guard let image = UIImage(data: data) else {
            throw NSError()
        }
        
        return image
    }
}
