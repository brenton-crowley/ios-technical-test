//
//  LocationDeiniedView.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import SwiftUI

struct LocationDeniedView: View {
    
    struct Constants {
        
        static let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
        static let cornerRadius: CGFloat = 10.0
        static let buttonHeight: CGFloat = 54.0
        static let settingsText = "Go to Settings"
        static let titleText = "Whoops!"
        static let descriptionText = "We need to access your location to provide you with all the stations near you. You can change your decision at any time in Settings."
    }
    
    
    var body: some View {
        VStack (spacing: 5.0) {
            Group {
                
                Spacer()
                Text(Constants.titleText)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                Text(Constants.descriptionText)
                    .padding()
                settingsButton
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
        }
        .background(Constants.backgroundColor)
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
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .foregroundColor(.white)
                    .frame(height: Constants.buttonHeight)
                Text(Constants.settingsText)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.backgroundColor)
            }
        }
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
