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
            scheduleForStation(station: "s9606444")
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
