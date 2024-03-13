import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

final class YandexScheduleService: TransportScheduleDataProviderProtocol {
    private let apiKey: String
    private let client: Client
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apiKey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.search(query: .init(
            apikey: apiKey,
            from: from,
            to: to
        ))
        return try response.ok.body.json
    }
    
    func getScheduleForStation(station: String) async throws -> ScheduleForStation {
        let response = try await client.schedule(query: .init(
            apikey: apiKey,
            station: station
        ))
        return try response.ok.body.json
    }
    
    func getThread(uid: String) async throws -> ThreadItem {
        let response = try await client.thread(query: .init(
            apikey: apiKey,
            uid: uid
        ))
        return try response.ok.body.json
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let response = try await client.nearestSettlement(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: 50
        ))
        return try response.ok.body.json
    }
    
    func getCarriers(code: Int) async throws -> Carriers {
        let response = try await client.carrier(query: .init(
            apikey: apiKey,
            code: code
        ))
        return try response.ok.body.json
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.copyright(query: .init(
            apikey: apiKey
        ))
        return try response.ok.body.json
    }
    
    func getAllStations() async throws -> AllStations? {
        let decoder = JSONDecoder()
        let response = try await client.stations_list(query: .init(
            apikey: apiKey
        ))
        
        let html = try await String(collecting: response.ok.body.html, upTo: Int.max)
        guard let data = html.data(using: .utf8) else { return nil }
        
        do {
            let json = try decoder.decode(AllStations.self, from: data)
            return json
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
