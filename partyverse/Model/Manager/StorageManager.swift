import Foundation
import SupabaseStorage
import Supabase

class StorageManager {
    
    static let shared = StorageManager()
    
    private let apikey = Bundle.main.object(forInfoDictionaryKey: "SupabaseAccessToken") as! String
    
    private let secret = Bundle.main.object(forInfoDictionaryKey: "SupabaseSecretToken") as! String
    
    lazy var storage = SupabaseStorageClient(url: "https://vwkinpuayzmtdzvqoako.supabase.co/storage/v1", headers: [
        "Authorization": "Bearer \(secret)",
        "apikey" : apikey,
    ])
    
    func uploadProfilePhoto(for user: AppUser, photoData: Data) async throws {
        let file = File(name: "profile_photo", data: photoData, fileName: "profile_photo.jpg", contentType: "jpg")
        
        do {
            try await storage.from(id: "avatarsiOS").list(path: "\(user.uuid)")
            let result = try await storage.from(id: "avatarsiOS").update(path: "\(user.uuid)/profile_photo.jpg", file: file, fileOptions: FileOptions(cacheControl: "2400"))
            print(result)
        } catch {
            let result = try await storage.from(id: "avatarsiOS").upload(path: "\(user.uuid)/profile_photo.jpg", file: file, fileOptions: FileOptions(cacheControl: "2400"))
            print(result)
        }
    }
    
    
    func fetchProfilePhoto(for user: AppUser) async throws -> Data {
        return try await storage.from(id: "avatarsiOS").download(path: "\(user.uuid)/profile_photo.jpg")
    }
    
}
