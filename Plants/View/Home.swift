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
        .coordinateSpace(name: "SCROLL")
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
            // MARK: Slowing down the gesture
                .onChanged({ value in
                    offsetY = value.translation.height * 0.5
                }).onEnded({value in
                    let translation = value.translation.height;
                    
                    withAnimation(.easeInOut){
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
        let cardSize = size.width;
        //MARK: Since i want to show three max cards on the display
        let maxCardSizeDisplay = size.width * 3;
        
        GeometryReader { proxy in
            let _size = proxy.size;
            let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height - cardSize);
            let scale = offset <= 0 ? (offset / maxCardSizeDisplay) : 0;
            let reducedScale = 1 + scale;
            let currentCardScale = offset / cardSize;
            
            Image(plant.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: _size.width, height: _size.height)
                .scaleEffect(reducedScale < 0 ? 0.001 : reducedScale, anchor: .init(x: 0.5, y: (1 - currentCardScale / 2.4)))
                .scaleEffect(offset > 0 ? 1 + currentCardScale : 1, anchor: .top)
                // MARK: Remove excess new image view
                .offset(y: offset > 0 ? currentCardScale * 200 : 0)
                .offset(y: currentCardScale * -130)
        }
        .frame(height: size.width);
    }
}
