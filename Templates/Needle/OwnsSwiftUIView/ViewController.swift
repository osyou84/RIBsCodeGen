//
//  ___VARIABLE_productName___ViewController.swift
//
//  Created by RIBsCodeGen.
//

import RIBs
import SwiftUI

protocol ___VARIABLE_productName___PresentableListener: ___VARIABLE_productName___ViewListener {
}

final class ___VARIABLE_productName___ViewController: UIViewController, ___VARIABLE_productName___Presentable, ___VARIABLE_productName___ViewControllable {
    private var dataSource = ___VARIABLE_productName___View.DataSource()
    private lazy var rootView = ___VARIABLE_productName___View(dataSource: dataSource)

    weak var listener: ___VARIABLE_productName___PresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.listener = listener

        let hostingController = UIHostingController(rootView: rootView)
        hostingController.view.backgroundColor = .clear
        hostingController.sizingOptions = [.intrinsicContentSize]
        
        addChild(hostingController)
        view.fill(with: hostingController.view)
        hostingController.didMove(toParent: self)
    }
}

// MARK: - ___VARIABLE_productName___Presentable
extension ___VARIABLE_productName___ViewController {

}
