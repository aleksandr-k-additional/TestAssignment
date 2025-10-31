//
//  SplashView.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import SwiftUI

struct SplashView: View {
    var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            Text("News app splash screen")
                .font(.largeTitle)
                .padding(40)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
        .task {
            try? await Task.sleep(for: .seconds(2))
            viewModel.onComplete()
        }
    }
}

#Preview {
    UINavigationController(rootViewController: UIHostingController(rootView: SplashView(viewModel: .init())))
}
