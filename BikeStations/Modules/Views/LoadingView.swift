//
//  LoadingView.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/4/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    var indicator : UIActivityIndicatorView!
    var loadingLabel : UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(red: 120/255, green: 165/255, blue: 163/255, alpha: 1)
        
        makeActivityIndicator(frame: frame)
        makeLoadingLabel(frame: indicator.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    fileprivate func makeActivityIndicator(frame : CGRect) {
        
        indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        indicator.frame = CGRect.init(x: (frame.size.width / 2) - 25, y: 30, width: 50, height: 50)
        indicator.startAnimating()
        
        addSubview(indicator)
    }
    
    fileprivate func makeLoadingLabel(frame : CGRect) {
        
        loadingLabel = UILabel.init(frame: CGRect.init(x: 0, y: frame.origin.y + 70, width: self.frame.size.width, height: 40))
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.systemFont(ofSize: 22)
        loadingLabel.textAlignment = .center
        loadingLabel.center = center
        loadingLabel.text = "Loading..."
        
        addSubview(loadingLabel)
    }
}
