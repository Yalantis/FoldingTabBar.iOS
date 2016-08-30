//
//  ChatViewController.swift
//  Example-Swift
//
//  Created by Serhii Butenko on 29/8/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

private let ChatDemoImageName = "imageName"
private let DemoUserName = "userName"
private let ChatDemoMessageText = "messageText"
private let ChatDemeDateText = "dateText"

private let reuseIdentifier = "ChatCollectionViewCell"

class ChatViewController: UIViewController {
    
    typealias Message = [String: String]
    
    private var messages: [Message] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        messages = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("YALChatDemoList", ofType: "plist")!) as! [Message]
    }
}

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ChatCollectionViewCell
        
        let message = messages[indexPath.row]
        
        cell.configure(
            withImage: UIImage(named: message[ChatDemoImageName]!)!,
            userName: message[DemoUserName]!,
            messageText: message[ChatDemoMessageText]!,
            dateText: message[ChatDemeDateText]!
        )
        
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: view.bounds.width, height: layout.itemSize.height)
    }
}

extension ChatViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.hidesBottomBarWhenPushed = true
    }
}
