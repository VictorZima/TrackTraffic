//
//  TabBarButton.swift
//  TrackTraffic
//
//  Created by VictorZima on 10/04/2025.
//

import SwiftUI

struct TabBarButton: View {
    let systemImageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImageName)
                    .renderingMode(.template)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? Color("tabBarButtonGray") : Color("tabBarButtonLightGray"))
                Text(title)
                    .foregroundColor(isSelected ? Color("tabBarButtonGray") : Color("tabBarButtonLightGray"))
                    .font(.caption)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TabBarButton(systemImageName: "dollarsign.gauge.chart.lefthalf.righthalf", title: "Summary", isSelected: true, action: { })
}
