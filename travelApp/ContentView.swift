//
//  ContentView.swift
//  travelApp
//
//  Created by Ренат on 02.03.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            //scheduleBetweenStations()
            //scheduleForStation(station: "s9606444")
            //getThread(uid: "7424x7426x7432_0_9606434_g24_4")
            //getNearestSettlement(lat: 54.917995, lng: 55.497075)
            //getCarriers(code: 112)
            //getCopyright()
            getAllStations()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func stations() {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a"
        )
        
        Task {
            let stations = try await service.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            print(stations)
        }
    } catch {
        print(error)
    }
}

func scheduleBetweenStations() {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = ScheduleBetweenStationsService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let schedule = try await service.getScheduleBetweenStations(
                from: "c146",
                to: "c213"
            )
            print(schedule)
        }
    } catch {
        print(error)
    }
}

func scheduleForStation(station: String) {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = ScheduleForStationService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let schedule = try await service.getScheduleForStation(station: station)
            print(schedule)
        }
    } catch {
        print(error)
    }
}

func getThread(uid: String) {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = ThreadService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let thread = try await service.getThread(uid: uid)
            print(thread)
        }
    } catch {
        print(error)
    }
}

func getNearestSettlement(lat: Double, lng: Double) {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let nearestSettlement = try await service.getNearestSettlement(lat: lat, lng: lng)
            print(nearestSettlement)
        }
    } catch {
        print(error)
    }
}

func getCarriers(code: Int) {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = CarriersService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let carriers = try await service.getCarriers(code: code)
            print(carriers)
        }
    } catch {
        print(error)
    }
}

func getCopyright() {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let copyright = try await service.getCopyright()
            print(copyright)
        }
    } catch {
        print(error)
    }
}

func getAllStations() {
    do {
        let server = try Servers.server1()
        
        let client = Client(
            serverURL: server,
            transport: URLSessionTransport()
        )
        
        let service = AllStationsService(client: client, apikey: "4cb1fc8d-00eb-473c-a43a-6cf48561e21a")
        
        Task {
            let allStations = try await service.getAllStations()
            print(allStations)
        }
    } catch {
        print(error)
    }
}
