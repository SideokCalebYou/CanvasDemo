//
//  ViewController.swift
//  CanvasDemo
//
//  Created by sideok you on 4/19/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var trayView: UIView!
  
  var trayOriginalCenter: CGPoint!
  var trayPositionWhenOpen: CGPoint!
  var trayPositionWhenClosed: CGPoint!
  var trayIsOpen: Bool = false
  
  var newlyCreatedFace: UIImageView!
  var newFaceCenter: CGPoint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    trayPositionWhenOpen = CGPoint(x: trayView.center.x, y: trayView.center.y)
    trayPositionWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + 200)
    
    trayView.center = trayPositionWhenClosed
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  @IBAction func onTrayTap(_ sender: Any) {
    toggleTray(velocity: 1.0)
    print("tap is working")
  }

  @IBAction func onTrayPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let point = panGestureRecognizer.location(in: panGestureRecognizer.view)
    
    
    if panGestureRecognizer.state == .began{
      print("Geture began at: \(point)")
      trayOriginalCenter = trayView.center 
    }else if panGestureRecognizer.state == .changed{
      let translation = panGestureRecognizer.translation(in: trayView)
      trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
      print("Gesture changed at: \(point)")
    }else if panGestureRecognizer.state == .ended{
      print("Gesture ended at: \(point)")
      let velocity = panGestureRecognizer.velocity(in: trayView)
      toggleTray(velocity: velocity.y)
    }
  }
  
  func toggleTray(velocity: CGFloat) {
    UIView.animate(withDuration: TimeInterval(0.5), delay: TimeInterval(0.0), usingSpringWithDamping: CGFloat(1.0), initialSpringVelocity: velocity, options: UIViewAnimationOptions.transitionCurlUp,
                               animations: { () -> Void in
                                if self.trayIsOpen {
                                  self.trayView.center = self.trayPositionWhenClosed
                                } else {
                                  self.trayView.center = self.trayPositionWhenOpen
                                }
                                self.trayIsOpen = !self.trayIsOpen
    }) { (Bool) -> Void in }
  }
  
  @IBAction func createNewFaces(_ panGestureRecognizer: UIPanGestureRecognizer) {
    
    
    if panGestureRecognizer.state == .began{
      print("clicked");
      let imageView = panGestureRecognizer.view as! UIImageView
      newlyCreatedFace = UIImageView(image: imageView.image)
      view.addSubview(newlyCreatedFace)
      newlyCreatedFace.center = imageView.center
      newlyCreatedFace.center.y += trayView.frame.origin.y
      newlyCreatedFace.isUserInteractionEnabled = true
      newFaceCenter = newlyCreatedFace.center
    }else if panGestureRecognizer.state == .changed{
      print("moving");
      let translation = panGestureRecognizer.translation(in: newlyCreatedFace)
      newlyCreatedFace.center = CGPoint(x:newFaceCenter.x + translation.x, y: newFaceCenter.y + translation.y)
      
    }else if panGestureRecognizer.state == .ended{
      
      print("done")
      
    }
    
    
    
    
    
    
    
    
  }
  
  

}

