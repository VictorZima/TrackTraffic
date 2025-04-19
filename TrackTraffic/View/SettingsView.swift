//
//  SettingsView.swift
//  TrackTraffic
//
//  Created by VictorZima on 10/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button {
                viewModel.showLocation()
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
            .sheet(isPresented: $viewModel.isLocationPresented) {
                LocationView()
            }
            
            Button {
                viewModel.showTrack()
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
            .sheet(isPresented: $viewModel.isTrackPresented) {
                TrackView()
            }
            
            Button {
                viewModel.showPerson()
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
            .sheet(isPresented: $viewModel.isPersonPresented) {
                PersonView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
