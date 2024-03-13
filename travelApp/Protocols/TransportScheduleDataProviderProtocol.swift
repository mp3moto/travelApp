import Foundation

protocol TransportScheduleDataProviderProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
    func getScheduleForStation(station: String) async throws -> ScheduleForStation
    func getThread(uid: String) async throws -> ThreadItem
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
    func getCarriers(code: Int) async throws -> Carriers
    func getCopyright() async throws -> Copyright
    func getAllStations() async throws -> AllStations?
}
