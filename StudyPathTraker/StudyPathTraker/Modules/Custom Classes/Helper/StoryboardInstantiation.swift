//
//  StoryboardInstantiation.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/13/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

/// A free function to get instances from ViewControllers from Storyboards via their identifier.
///
/// - Parameters:
///   - ofType: The type of the ViewController to return
///   - type: The type of ViewController that's needed
///   - storyboard: Storyboard name
///   - identifier: ViewController identifier
/// - Returns: Instance of the specified ViewController type
func viewController<T: UIViewController>(ofType: T.Type, from storyboard: String, identifier: String) -> T? {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T
}
