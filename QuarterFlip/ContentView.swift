// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isFlipping = false
    @State private var coinSide = "heads"
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Swipe to flip the coin")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(coinSide)
                    .resizable()
                    .scaledToFit()
                    .rotation3DEffect(
                        .degrees(isFlipping ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 0))
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                self.isFlipping.toggle()
                                self.coinSide = self.coinSide == "heads" ? "tails" : "heads"
                            }
                        }
                    }
                Spacer()
            }
        }
        .gesture(DragGesture(minimumDistance: 50)
                    .onEnded({ _ in
                        withAnimation {
                            self.isFlipping.toggle()
                            self.coinSide = self.coinSide == "heads" ? "tails" : "heads"
                        }
                    }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
