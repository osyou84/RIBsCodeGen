//
//  CreateRIBCommand.swift
//  RIBsCodeGen
//
//  Created by 今入　庸介 on 2021/02/04.
//

import Foundation
import SourceKittenFramework
import PathKit

enum ViewCreationOptions: String {
    case none
    case createUIKit
    case createSwiftUI
    
    var templateDirectory: String {
        switch self {
        case .none:
            "/Default"
        case .createUIKit:
            "/OwnsUIKitView"
        case .createSwiftUI:
            "/OwnsSwiftUIView"
        }
    }
}

struct CreateRIBCommand: Command {
    let needsCreateTargetFile: Bool
    let targetDirectory: String
    let templateDirectory: String
    let target: String
    let viewCreationOptions: ViewCreationOptions
    let isNeedle: Bool

    init(paths: [String],
         setting: Setting,
         target: String,
         viewCreationOptions: ViewCreationOptions,
         isNeedle: Bool) {
        var targetPaths = [String?]()

        let targetRouterPath = paths.filter({ $0.contains("/" + target + "Router.swift") }).first
        targetPaths.append(targetRouterPath)

        let targetInteractorPath = paths.filter({ $0.contains("/" + target + "Interactor.swift") }).first
        targetPaths.append(targetInteractorPath)

        let targetBuilderPath = paths.filter({ $0.contains("/" + target + "Builder.swift") }).first
        targetPaths.append(targetBuilderPath)

        switch viewCreationOptions {
        case .none:
            break
        case .createUIKit:
            let targetViewControllerPath = paths.filter({ $0.contains("/" + target + "ViewController.swift") }).first
            targetPaths.append(targetViewControllerPath)
        case .createSwiftUI:
            let targetViewControllerPath = paths.filter({ $0.contains("/" + target + "ViewController.swift") }).first
            targetPaths.append(targetViewControllerPath)
            let targetSwiftUIViewPath = paths.filter({ $0.contains("/" + target + "View.swift") }).first
            targetPaths.append(targetSwiftUIViewPath)
        }

        needsCreateTargetFile = targetPaths.contains(nil)

        targetDirectory = setting.targetDirectory
        let parentDirectory = isNeedle ? setting.templateDirectory + "/Needle" : setting.templateDirectory + "/Normal"
        templateDirectory = parentDirectory + viewCreationOptions.templateDirectory
        
        self.target = target
        self.viewCreationOptions = viewCreationOptions
        self.isNeedle = isNeedle
    }

    func run() -> Result {
        print("\nStart creating \(target) RIB.".bold)

        guard needsCreateTargetFile else {
            return .success(message: "No need to add RIB, it already be exists.".yellow.bold)
        }

        do {
            try createDirectory()
        } catch {
            print("  Failed to creating directory.".red.bold)
            return .failure(error: .failedCreateDirectory)
        }

        do {
            try createFiles()
        } catch {
            print("  Failed to creating file.".red.bold)
            print("  Check the template directory.".red.bold)
            return .failure(error: .failedCreateFile)
        }

        return .success(message: "Successfully finished creating \(target) RIB.".green.bold)
    }
}

// MARK: - Private methods
private extension CreateRIBCommand {
    func createDirectory() throws {
        let filePath = targetDirectory + "/\(target)"
        print("  Creating directory: \(filePath)")
        guard !Path(filePath).exists else {
            print("  Skip to create directory: \(filePath)".yellow)
            return
        }
        try Path(filePath).mkdir()
    }

    func createFiles() throws {
        var fileTypes: [String]
        
        switch viewCreationOptions {
        case .none:
            fileTypes = ["Router", "Interactor", "Builder"]
        case .createUIKit:
            fileTypes = ["Router", "Interactor", "Builder", "ViewController"]
        case .createSwiftUI:
            fileTypes = ["Router", "Interactor", "Builder", "ViewController", "View"]
        }

        // target = RIB Name
        try fileTypes.forEach { fileType in
            let filePath = targetDirectory + "/\(target)/\(target)\(fileType).swift"
            
            print("  Creating file: \(filePath)")
            let template: String = try Path(templateDirectory + "/\(fileType).swift").read()
            let replacedText = template
                .replacingOccurrences(of: "___VARIABLE_productName___", with: "\(target)")
                .replacingOccurrences(of: "___VARIABLE_productName_lowercased___", with: "\(target.lowercasedFirstLetter())")
            try Path(filePath).write(replacedText)
            let formattedText = try Formatter.format(path: filePath)
            try Path(filePath).write(formattedText)
        }
    }
}
