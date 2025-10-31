//
//  ApplicationFeature.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import UIKit

class ApplicationFeature {
    var window: UIWindow
    
    private var onboardingFeature: OnboardingFeature?
    private var mainFeature: MainFeature?
    
    init(window: UIWindow) {
        self.window = window
        
        startOnboardingFeature()
    }
    
    private func startOnboardingFeature() {
        onboardingFeature = OnboardingFeature { [weak self] in
            self?.onboardingFeature = nil
            self?.startMainFeature()
        }
        
        let controller = onboardingFeature!.start()
        setRootViewController(controller)
    }
    
    private func startMainFeature() {
        let navigation = UINavigationController()
        
        mainFeature = MainFeature(in: navigation) { _ in
            //Not used for now
        }
        
        mainFeature?.startFlow()
        
        setRootViewController(navigation)
    }
    
    private func setRootViewController(_ rootViewController: UIViewController, completion: (() -> Void)? = nil) {
        guard window.rootViewController != rootViewController else {
            completion?()
            return
        }
        
        window.rootViewController = rootViewController
    }

    
}
