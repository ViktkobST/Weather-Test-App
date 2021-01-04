//
//  ModuleBuilder.swift
//  KrasnayaPolyanaTest
//
//  Created by Виктор Кобыхно on 1/4/21.
//

import UIKit

protocol ModuleBuilderProtocol: class {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkingService = WeatherNetworking()
        let presenter = MainPresenter(view: view, networkingService: networkingService)
        view.presenter = presenter
        return view
    }
}
