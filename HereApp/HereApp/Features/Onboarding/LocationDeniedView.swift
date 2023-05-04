//
//  LocationDeiniedView.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import SwiftUI

struct LocationDeniedView: View {
    
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    let settingsText = "Go to Settings"
    let titleText = "Whoops!"
    let descriptionText = "We need to access your location to provide you with all the stations near you. You can change your decision at any time in Settings."
    
    var body: some View {
        VStack (spacing: 5.0) {
            Group {
                
                Spacer()
                Text(titleText)
                    .fontWeight(.bold)
                    .font(.title)
                Text(descriptionText)
                    
                Spacer()
                settingsButton
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
        }
        .background(backgroundColor)
    }
    
    var settingsButton: some View {
        Button {
            // intent
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(.white)
                    .frame(height: 40.0)
                Text(settingsText)
                    .fontWeight(.bold)
                    .foregroundColor(backgroundColor)
            }
        }
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
