import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias NearestStations = Components.Schemas.Stations
typealias ScheduleBetweenStations = Components.Schemas.Search
typealias ScheduleForStation = Components.Schemas.Schedule
typealias Thread = Components.Schemas.Thread
typealias NearestSettlement = Components.Schemas.NearestSettlement
typealias Carriers = Components.Schemas.Carriers
typealias Copyright = Components.Schemas.Copyright
typealias AllStations = Components.Schemas.StationsList

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

protocol ScheduleForStationServiceProtocol {
    func getScheduleForStation(station: String) async throws -> ScheduleForStation
}

protocol ThreadServiceProtocol {
    func getThread(uid: String) async throws -> Thread
}

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
}

protocol CarriersServiceProtocol {
    func getCarriers(code: Int) async throws -> Carriers
}

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
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

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThread(uid: String) async throws -> Thread {
        let response = try await client.thread(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let response = try await client.nearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: 50
        ))
        return try response.ok.body.json
    }
}

final class CarriersService: CarriersServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarriers(code: Int) async throws -> Carriers {
        let response = try await client.carrier(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }
    
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.copyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
    
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.stations_list(query: .init(
            apikey: apikey
        ))
        
        var html: String
        
        try html = await String(collecting: response.ok.body.html, upTo: Int.max)
        print(html.count)
        let data = html.data(using: .utf8)
        print(data?.count ?? -10)
        let decoder = JSONDecoder()
        do {
            let json = try decoder.decode(AllStations.self, from: data!)
        } catch {
            print(error)
        }
        //print(json.countries?.count)
        //return json
        return try decoder.decode(AllStations.self, from: data!)
        
        
        //return try response.ok.body.html
    }
    
}
