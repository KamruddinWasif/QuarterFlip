// ContentView.swift
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var flipDegrees: Double = 0
    @State private var isSpinning = false
    @State private var showingHead = true
    
    private let lightHaptic = UIImpactFeedbackGenerator(style: .light)
    private let heavyHaptic = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("FLIP A COIN")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Swipe to flip the coin")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                CoinView(showingHead: $showingHead)
                    .frame(width: 100, height: 100)
                    .rotation3DEffect(.degrees(flipDegrees), axis: (x: flipDegrees / 90, y: flipDegrees, z: 0))
                    .animation(.linear(duration: isSpinning ? 0.1 : 1))
                Spacer()
            }
        }
        .gesture(DragGesture(minimumDistance: 50)
                    .onEnded({ _ in
                        withAnimation {
                            self.isSpinning = true
                            self.lightHaptic.impactOccurred()
                            let spinTime = Double.random(in: 1...2)
                            Timer.scheduledTimer(withTimeInterval: spinTime, repeats: false) { _ in
                                self.isSpinning = false
                                self.showingHead = Bool.random()
                                self.heavyHaptic.impactOccurred()
                            }
                            
                            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                                if !self.isSpinning {
                                    timer.invalidate()
                                }
                                self.flipDegrees += 180
                            }
                        }
                    }))
    }
}

struct CoinView: View {
    @Binding var showingHead: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .overlay(Text(showingHead ? "H" : "T").foregroundColor(.white).font(.title))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
