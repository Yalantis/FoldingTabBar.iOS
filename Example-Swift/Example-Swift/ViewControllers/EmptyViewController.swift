//
//  EmptyViewController.swift
//  Example-Swift
//
//  Created by Serhii Butenko on 29/8/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController, YALTabBarDelegate {
    
    func tabBarWillExpand(tabBar: YALFoldingTabBar!) {
        print("will expand")
    }

    func tabBarDidExpand(tabBar: YALFoldingTabBar!) {
        print("did expand")
    }
    
    func tabBarWillCollapse(tabBar: YALFoldingTabBar!) {
        print("will collapse")
    }
    
    func tabBarDidCollapse(tabBar: YALFoldingTabBar!) {
        print("did collapse")
    }
}
