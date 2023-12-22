//
//  ContentView.swift
//  ArtworkGestures
//
//  Created by Luka Gazdeliani on 22.12.23.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    @State var rotationValue = Angle(degrees: 0)
    @State var dragOffsetSize = CGSize.zero
    @State var magnificationValue = CGFloat.zero
    @State var rotationForComposing = Angle(degrees: 0)
    @State var magnificationForComposing =  1.0
    
    //MARK: Body
    var body: some View {
        let rotateGesture = RotateGesture()
            .onChanged { rotationForComposing = $0.rotation }
            .onEnded { _ in rotationForComposing = .zero }
        
        let magnificationGesture = MagnificationGesture()
            .onChanged { magnificationForComposing = $0 }
            .onEnded { _ in magnificationForComposing = 1.0 }
        
        let scaleAndRotate = magnificationGesture.simultaneously(with: rotateGesture)
        
        VStack {
            HStack(spacing: 50, content: {
                Image(.loki)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .rotationEffect(rotationValue)
                    .gesture(
                        RotateGesture()
                            .onChanged { rotationValue = $0.rotation }
                            .onEnded { _ in rotationValue = .zero }
                    )
                
                Image(.star)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .offset(dragOffsetSize)
                    .gesture(
                        DragGesture()
                            .onChanged { dragOffsetSize = $0.translation}
                            .onEnded { _ in dragOffsetSize = .zero }
                    )
            })
            
            HStack(spacing: 50, content: {
                Image(.dune)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .scaleEffect(1 + magnificationValue)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { magnificationValue = $0 - 1 }
                            .onEnded { _ in magnificationValue = .zero }
                    )
                
                Image(.narnia)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .onLongPressGesture(minimumDuration: 2, perform: {
                        rotationValue += Angle(degrees: 90) //რამე ხო უნდა ექნა და მეტი ვერაფერი მოვიფიქრე :)
                    })
            })
            
            HStack(spacing: 50, content: {
                Image(.lotr)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .rotationEffect(rotationForComposing)
                    .scaleEffect(magnificationForComposing)
                    .gesture(scaleAndRotate)
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
