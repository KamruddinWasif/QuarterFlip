// CoinTossHapticFeedback.swift
import UIKit

class CoinTossHapticFeedback {
    
    let lightHaptic = UIImpactFeedbackGenerator(style: .light)
    let heavyHaptic = UIImpactFeedbackGenerator(style: .heavy)
    
    func coinTossed() {
        lightHaptic.impactOccurred()
    }
    
    func coinLanded() {
        heavyHaptic.impactOccurred()
    }
}
