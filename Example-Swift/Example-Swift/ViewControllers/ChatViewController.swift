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
  
  fileprivate var messages: [Message] = []
  fileprivate let cellAnumationDuration: Double = 0.25
  fileprivate let animationDelayStep: Double = 0.1
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  //MARK: - View & VC life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messages = NSArray(contentsOfFile: Bundle.main.path(forResource: "YALChatDemoList", ofType: "plist")!) as! [Message]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    prepareVisibleCellsForAnimation()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    animateVisibleCells()
  }
  
}

extension ChatViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCollectionViewCell
    
    let message = messages[(indexPath as NSIndexPath).row]
    
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    return CGSize(width: view.bounds.width, height: layout.itemSize.height)
  }
}

extension ChatViewController {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segue.destination.hidesBottomBarWhenPushed = true
  }
}

//MARK: - Cell's animation

private extension ChatViewController {
  
  func prepareVisibleCellsForAnimation() {
    collectionView.visibleCells.forEach {
      $0.frame = CGRect(
        x: -$0.bounds.width,
        y: $0.frame.origin.y,
        width: $0.bounds.width,
        height: $0.bounds.height
      )
      $0.alpha = 0
    }
  }
  
  func animateVisibleCells() {
    collectionView.visibleCells.enumerated().forEach { offset, cell in
      cell.alpha = 1
      UIView.animate(
        withDuration: self.cellAnumationDuration,
        delay: Double(offset) * self.animationDelayStep,
        options: .curveEaseOut,
        animations: {
          cell.frame = CGRect(
            x: 0,
            y: cell.frame.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
          )
      })
    }
  }
  
}
