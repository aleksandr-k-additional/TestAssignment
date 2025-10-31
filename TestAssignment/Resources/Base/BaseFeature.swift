//
//  BaseFeature.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//


import UIKit

protocol Feature: AnyObject {
    var navigationController: UINavigationController { get }
    func startFlow()
    func finishFlow(_: Result<FeatureSuccess, FeatureError>)
}

enum FeatureSuccess {
    case completed
    case cancelled
}

enum FeatureError: Error {
    case unexpectedDeinit
}

class BaseFeature: Feature {
    private var completion: (Result<FeatureSuccess, FeatureError>) -> Void
    private var finished = false
    var navigationController: UINavigationController

    init(in navigation: UINavigationController, completion: @escaping (Result<FeatureSuccess, FeatureError>) -> Void) {
        self.completion = completion
        navigationController = navigation
        
    }

    func startFlow() {
        
    }

    func finishFlow(_ result: Result<FeatureSuccess, FeatureError>) {
        finished = true
        switch result {
            case .success:
                print("log(.successFinish)")
            case .failure:
                print("log(level: .error, .failureFinish)")
        }
        completion(result)
    }

    deinit {
        if !finished {
            finishFlow(.failure(.unexpectedDeinit))
        }
        print("log(.deinitialization)")
    }
}
