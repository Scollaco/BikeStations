//
//  LoadingView.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/4/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(red: 120/255, green: 165/255, blue: 163/255, alpha: 1)
        
        let indicator = activityIndicator(frame: frame)
        addSubview(indicator)
        
        let label = loadingLabel(frame: indicator.frame)
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    fileprivate func activityIndicator(frame : CGRect) -> UIActivityIndicatorView {
        
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect.init(x: (frame.size.width / 2) - 25, y: 30, width: 50, height: 50)
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    fileprivate func loadingLabel(frame : CGRect) -> UILabel {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: frame.origin.y + 70, width: 200, height: 40))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.center = center
        label.text = "Loading..."
        
        return label
    }
}
