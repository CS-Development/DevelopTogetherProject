//
//  CollectionViewControllerProtocol.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import Foundation

public protocol CollectionViewControllerProtocol: AnyObject {
    func setNavigationTitle(_ title: String)
    func setSectionInset(top:Float, left:Float, bottom:Float, right:Float)
    func setupCollectionViewCellToUseMaxWidth()
    func reload()
}
