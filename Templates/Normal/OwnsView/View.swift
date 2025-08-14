//
//  ___VARIABLE_productName___View.swift
//
//  Created by RIBsCodeGen.
//

import SwiftUI

public protocol ___VARIABLE_productName___ViewListener: AnyObject {
}

public struct ___VARIABLE_productName___View: View {
    public class DataSource: ObservableObject {
        public init() {}
    }
    
    public weak var listener: ___VARIABLE_productName___ViewListener?
    
    @ObservedObject var dataSource: DataSource
    
    public init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    public var body: some View {
        Text(___VARIABLE_productName___View)
    }
}

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View()
    }
}
