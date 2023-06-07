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
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack {
                    // MARK: Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    
                    // MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
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
                        Text(bottomSheetTranslationProrated.formatted())
                    } content: {
                        ForecastView()
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                    }
                    
                    // MARK: Tab Bar
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                }
                .navigationBarHidden(true)
            }
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
