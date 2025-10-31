//
//  OnboardingFeature.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import UIKit
import SwiftUI


class OnboardingFeature {
    let onFinish: () -> Void

    init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }

    func start() -> UIViewController {
        let model = SplashViewModel()

        model.onComplete = onFinish

        let view = SplashView(viewModel: model)
        let hostingController = UIHostingController(rootView: view)
        
        return hostingController
    }
}
