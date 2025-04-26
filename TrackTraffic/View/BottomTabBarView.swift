//
//  BottomTabBarView.swift
//  TrackTraffic
//
//  Created by VictorZima on 10/04/2025.
//

import SwiftUI

struct BottomTabBarView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 0,
                                   bottomLeadingRadius: 42,
                                   bottomTrailingRadius: 42,
                                   topTrailingRadius: 0,
                                   style: .continuous)
                .fill(.ultraThickMaterial)
            
            HStack {
                TabBarButton(systemImageName: "house", title: "Main", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabBarButton(systemImageName: "parkingsign.radiowaves.right.and.safetycone", title: "Traffic", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                TabBarButton(systemImageName: "gear", title: "Settings", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
            }
        }
        .frame(height: 70)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BottomTabBarView(selectedTab: .constant(0))
        .padding()
}
