//
//  HomeView.swift
//  Weather
//
//  Created by Lorenzo Porras on 6/2/23.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    var body: some View {
        NavigationView {
            
            ZStack {
                // MARK: Background Color
                Color.background
                    .ignoresSafeArea()
                
                // MARK: Background Image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                
                // MARK: House Image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack(spacing: -10) {
                    Text("Denver")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    VStack {
                        Text(attributedString)
                        
                        Text("H: 24 L:18")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                
                // MARK: Bottom Sheet
                BottomSheetView(position: $bottomSheetPosition) {
                    Text(bottomSheetPosition.rawValue.formatted())
                } content: {
                    ForecastView()
                }

                
                // MARK: Tab Bar
                TabBar(action: {
                    bottomSheetPosition = .top
                })
            }
            .navigationBarHidden(true)
        }
    }
    private var attributedString: AttributedString {
        var string = AttributedString("19º" + "\n" + "Mostly Clear")
        
        if let temp = string.range(of: "19º") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .white
        }
        
        if let pipe = string.range(of: "|") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .white
        }
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .white
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
