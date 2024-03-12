import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations
typealias ScheduleBetweenStations = Components.Schemas.Search
typealias ScheduleForStation = Components.Schemas.Schedule

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

protocol ScheduleForStationServiceProtocol {
    func getScheduleForStation(station: String) async throws -> ScheduleForStation
}

final class NearestStationsService: NearestStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.search(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        return try response.ok.body.json
    }
}

final class ScheduleForStationService: ScheduleForStationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleForStation(station: String) async throws -> ScheduleForStation {
        let response = try await client.schedule(query: .init(
            apikey: apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}

