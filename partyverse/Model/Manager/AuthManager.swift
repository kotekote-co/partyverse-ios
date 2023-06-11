import Foundation
import Supabase

struct AppUser {
    let uuid: String
    let email: String?
}

class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://vwkinpuayzmtdzvqoako.supabase.co")!, supabaseKey: Bundle.main.object(forInfoDictionaryKey: "SupabaseAccessToken") as! String)
    
    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        return AppUser(uuid: session.user.id.uuidString, email: session.user.email)
    }
    
    // MARK: Registration
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        let regAuthResponse = try await client.auth.signUp(email: email, password: password)
        guard let session = regAuthResponse.session else {
            print("no session when registering user")
            throw NSError()
        }
        return AppUser(uuid: session.user.id.uuidString, email: session.user.email)
    }
    
    // MARK: Sign in
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        let session = try await client.auth.signIn(email: email, password: password)
        return AppUser(uuid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        return AppUser(uuid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithGoogle(idToken: String, nonce: String) async throws -> AppUser {
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .google, idToken: idToken, nonce: nonce ))
        print(session)
        print(session.user)
        return AppUser(uuid: session.user.id.uuidString, email: session.user.email)
    }
    
//    func network(idToken: String, nonce: String) async throws {
//        let url = URL(string: "https://vwkinpuayzmtdzvqoako.supabase.co/auth/v1/token?grant_type=id_token")!
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.addValue("key"
//                            , forHTTPHeaderField: "apikey")
//
//        let json = [
//            "id_token": idToken,
//            "provider": "google"
//        ]
//
//        let jsonData = try JSONSerialization.data(withJSONObject: json)
//        print(json)
//        print(jsonData)
//        urlRequest.httpBody = jsonData
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        print(String(data: data, encoding: .utf8))
//    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
}
