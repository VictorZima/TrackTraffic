//
//  SettingsView.swift
//  TrackTraffic
//
//  Created by VictorZima on 10/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var showLocationView = false
    @State private var showTrackView = false
    @State private var showPersonView = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button {
                showLocationView = true
            } label: {
                Text("Locations")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            }
            .sheet(isPresented: $showLocationView) {
                LocationView()
            }
            
            Button {
                showTrackView = true
            } label: {
                Text("Tracks")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            }
            .sheet(isPresented: $showTrackView) {
                TrackView()
            }
            
            Button {
                showPersonView = true
            } label: {
                Text("Drivers")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            }
            .sheet(isPresented: $showPersonView) {
                PersonView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
