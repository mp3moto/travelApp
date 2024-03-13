//
//  ContentView.swift
//  travelApp
//
//  Created by Ренат on 02.03.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    let yandexRaspisanie = createDataProvider()
    var body: some View {
        VStack {
            //-------------------------------
            Button("getNearestStations") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let stations = try await service.getNearestStations(
                            lat: 59.864177,
                            lng: 30.319163,
                            distance: 50
                        )
                        print(stations)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("scheduleBetweenStations") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let schedule = try await service.getScheduleBetweenStations(
                            from: "s2000003",
                            to: "s9613091"
                        )
                        print(schedule)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("scheduleForStation") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let schedule = try await service.getScheduleForStation(
                            station: "s9606444"
                        )
                        print(schedule)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("getThread") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let thread = try await service.getThread(uid: "7424x7426x7432_0_9606434_g24_4")
                        print(thread)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("getNearestSettlement") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let nearestSettlement = try await service.getNearestSettlement(
                            lat: 54.917995,
                            lng: 55.497075
                        )
                        print(nearestSettlement)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("getCarriers") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let carriers = try await service.getCarriers(
                            code: 112
                        )
                        print(carriers)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("getCopyright") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let copyright = try await service.getCopyright()
                        print(copyright)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            //-------------------------------
            Button("getAllStations") {
                guard let service = yandexRaspisanie else { return }
                Task {
                    do {
                        let allStations = try await service.getAllStations()
                        print(allStations ?? "")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func createDataProvider() -> YandexScheduleService? {
    do {
        let server = try Servers.server1()
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        return YandexScheduleService(
            client: client,
            apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a"
        )
    } catch {
        return nil
    }
}
