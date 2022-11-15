//
//  Home.swift
//  Plants
//
//  Created by Josileudo Rodrigues on 15/11/22.
//

import SwiftUI

struct Home: View {
    @State var offsetY: CGFloat = 0;
    @State var currentIndex: CGFloat = 0;
    
    var body: some View {
        GeometryReader {
            let size = $0.size;
            
            // MARK: Since card size is the size of the screen width;
            let cardSize = size.width;
            
            VStack(spacing: 0) {
                ForEach(plants) { plant in
                    PlantView(plant: plant, size: size);
                }
            }
            .frame(width: size.width)
            .padding(.top, size.height - cardSize)
            .offset(y: offsetY)
            .offset(y: -currentIndex * cardSize)
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
            // MARK: Slowing down the gesture
                .onChanged({ value in
                    offsetY = value.translation.height * 0.5
                }).onEnded({value in
                    let translation = value.translation.height
                    
                    if translation > 0 {
                        // 250 -> Update it for own usage
                        if currentIndex > 0 && translation > 250 {
                            currentIndex -= 1;
                        }
                    } else {
                        if currentIndex < CGFloat(plants.count - 1) && -translation > 250 {
                            currentIndex += 1;
                        }
                    }
                    
                    withAnimation(.easeInOut){
                        offsetY = .zero
                    }
                })
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView();
    }
}

// MARK: Coffee View
struct PlantView:  View {
    var plant: Plant;
    var size: CGSize;
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size;
            
            Image(plant.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
        }
        .frame(height: size.width);
    }
}
