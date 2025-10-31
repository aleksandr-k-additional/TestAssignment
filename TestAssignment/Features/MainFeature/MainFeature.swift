//
//  MainFeature.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import UIKit
import SwiftUI

class MainFeature: BaseFeature {
    override func startFlow() {
        super.startFlow()
        
        openList()
    }
    
    func openList() {
        let model = NewsListViewModel()
        let view = NewsListView(viewModel: model)
        let controller = UIHostingController(rootView: view)
        
        model.onDetails = { [weak self] in
            self?.openDetails(article: $0)
        }
        
        navigationController.viewControllers = [controller]
    }
    
    func openDetails(article: Article) {
        let model = NewsDetailsViewModel(article: article)
        let view = NewsDetailsView(viewModel: model)
        let controller = BaseHostingController(rootView: view)
        
        navigationController.pushViewController(controller, animated: true)
    }
    
}
