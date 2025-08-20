//
//  ___VARIABLE_productName___View.swift
//
//  Created by RIBsCodeGen.
//

import SwiftUI

protocol ___VARIABLE_productName___ViewListener: AnyObject {
}

struct ___VARIABLE_productName___View: View {
    class DataSource: ObservableObject {
        init() {}
    }
    
    weak var listener: ___VARIABLE_productName___ViewListener?
    
    @ObservedObject var dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    var body: some View {
        Text("___VARIABLE_productName___View")
    }
}

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(dataSource: ___VARIABLE_productName___View.DataSource())
    }
}
