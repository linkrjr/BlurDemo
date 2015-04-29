//
//  ViewController.swift
//  BlurDemo
//
//  Created by Ronaldo GomesJr on 29/04/2015.
//  Copyright (c) 2015 Technophile. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    let PanelHeight:CGFloat = 340.0
    
    var panel:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tintColor = UIColor.whiteColor()
        
        let tap = UITapGestureRecognizer(target: self, action: "onTap:")
        self.view.addGestureRecognizer(tap)
        
    }


    func onTap(tap:UITapGestureRecognizer) {
        
        if self.panel == nil {
            self.openPanel()
        } else {
            self.closePanel()
        }
        
    }
    
    func closePanel() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            var frame = self.panel!.frame
            frame.origin.y = frame.origin.y + frame.size.height
            self.panel!.frame = frame
            
        }) { (finished) -> Void in
            
            self.panel?.removeFromSuperview()
            self.panel = nil
            
        }
    }
    
    func createPanel() {
        
        var panelRect = CGRectMake(0.0 as CGFloat, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)
        var blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var visualEffectView = UIVisualEffectView(effect: blur)
        
        visualEffectView.frame = panelRect
        self.panel = visualEffectView
        self.panel?.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        
        var tap = UIPanGestureRecognizer(target: self, action: "onDrag:")
        self.panel?.addGestureRecognizer(tap)
        
        var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
        var vibrancyContainer = UIVisualEffectView(effect: vibrancy)
        var vibrancyContainerFrame = self.panel?.bounds
        vibrancyContainer.frame = CGRectInset(vibrancyContainerFrame!, 40, 20)
        
        var label = UILabel(frame: vibrancyContainer.bounds)
        label.backgroundColor = UIColor.clearColor()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed neque mi, viverra sit amet ligula id, eleifend iaculis arcu. Pellentesque volutpat venenatis mauris, non tempus eros dapibus a. Duis aliquam augue quis justo lobortis, vel faucibus mauris convallis. Aenean dictum egestas ultricies. Vivamus sit amet adipiscing libero. Curabitur faucibus justo id elit dictum condimentum. Curabitur dictum bibendum sem id pharetra. Nunc eu diam eros. Donec tempus tincidunt velit ut malesuada. Nunc convallis nisl sit amet velit vestibulum, et porttitor elit euismod. Sed ut placerat dolor. Vivamus quis tellus bibendum, auctor ligula quis, bibendum nibh."
        label.numberOfLines = 8
        label.font = UIFont(name: "Avenir Next", size: 14)
        vibrancyContainer.contentView.addSubview(label)
        
        self.panel?.addSubview(vibrancyContainer)
        self.view.addSubview(self.panel!)
        
        
    }
    
    
    func openPanel() {
    
        if self.panel == nil {
            self.createPanel()
        }
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            
            var frame = self.panel?.frame
            var frameY = frame?.origin.y
            var frameHeight = frame?.size.height
            frame?.origin.y = frameY! - frameHeight!
            self.panel!.frame = frame!
            
        }) { (finished) -> Void in
            
        }
        
    }
    
    func maxPanelY() -> CGFloat {
        return self.view.frame.size.height
    }

    func minPanelY() -> CGFloat {
        return 0
    }
    
    func onDrag(pan:UIPanGestureRecognizer) {
        var offset = pan.translationInView(self.panel!)
        
        var frame = self.panel!.frame
        frame.origin.y = frame.origin.y + offset.y
        frame.origin.y = min(frame.origin.y, self.maxPanelY())
        frame.origin.y = max(frame.origin.y, self.minPanelY())
        
        self.panel!.frame = frame
        
        pan.setTranslation(CGPointZero, inView: self.panel)
        
        if pan.state == UIGestureRecognizerState.Ended && self.panel!.frame.origin.y > (self.maxPanelY()/2) {
            self.closePanel()
        }
        
    }
    
    @IBAction func infoTapped(sender:AnyObject) {
        if self.panel == nil {
            self.openPanel()
        }
    }
    
}

