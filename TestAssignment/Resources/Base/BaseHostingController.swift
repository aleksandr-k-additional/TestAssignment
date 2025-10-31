//
//  BaseHostingController.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import SwiftUI
import UIKit

class BaseHostingController<Content: View>: UIHostingController<Content> {
    
    var configureNavigation: ((UINavigationItem) -> Void)?
    
    init(rootView: Content, configureNavigation: ((UINavigationItem) -> Void)? = nil) {
        self.configureNavigation = configureNavigation
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation?(navigationItem)
    }
}
