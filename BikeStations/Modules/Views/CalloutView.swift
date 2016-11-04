//
//  AnotationView.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MapKit

class CalloutView: UIViewController {
    
    var parentFrame : CGRect?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, frame : CGRect) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.parentFrame = frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showCallout(frame: parentFrame!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func showCallout(frame : CGRect) {
    
        let screenSize = UIScreen.main.bounds.size
        
        view.frame = CGRect(x: 15, y: frame.origin.y - view.frame.size.height - 15, width: screenSize.width - 30, height: 200)
        view.center = CGPoint.init(x: view.frame.size.width / 2, y: frame.size.height / 2)
        UIView.animate(withDuration: 0.3) { 
            self.view.alpha = 1
        }
        
        
    }
}
