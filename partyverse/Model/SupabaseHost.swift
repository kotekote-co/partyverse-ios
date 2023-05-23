import Foundation
import Supabase

let url = URL(string: "https://vwkinpuayzmtdzvqoako.supabase.co")

let client = SupabaseClient(supabaseURL: url!, supabaseKey: Bundle.main.object(forInfoDictionaryKey: "SupabaseAccessToken") as! String)
