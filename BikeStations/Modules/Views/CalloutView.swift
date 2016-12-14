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
    var loadingView : LoadingView?
    var bikeStation : BikeStation?
    let controller =  BikeStationController()
    
    @IBOutlet weak var labelName: UILabel! {
    
        didSet {
            labelName.text = bikeStation!.name
        }
    }
    
    @IBOutlet weak var docksAvailableLabel: UILabel!
    @IBOutlet weak var bikesAvailableLabel: UILabel!
    @IBOutlet weak var lastReportLabel: UILabel!
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, frame : CGRect, bikeStation : BikeStation) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.parentFrame = frame
        self.bikeStation = bikeStation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCallout(frame: parentFrame!)
        fetchStationInformation()
    }
    
    func fetchStationInformation() {
        
        loadingView = LoadingView.init(frame: view.bounds)
        view.addSubview(loadingView!)
        
        controller.getBikeStationInfo(stationId: bikeStation!.stationId!) { [unowned self] (result) in
            
            self.setupView(for: result)
        }
    }
    
    fileprivate func setupView(for result : Result<BikeStationInfo, ErrorType>) {
    
        DispatchQueue.main.async {
            
            switch result {
            case .success(let info):
                
                self.docksAvailableLabel.text = "\(info.docksAvailable!)"
                self.bikesAvailableLabel.text = "\(info.bikesAvailable!)"
                self.lastReportLabel.text = info.lastReported
                self.loadingView?.removeFromSuperview()
                
            case .failure(let error):
                self.loadingView?.indicator.isHidden = true
                self.loadingView?.loadingLabel.text = error.localizedDescription
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalloutView {

    fileprivate func showCallout(frame : CGRect) {
        
        let screenSize = UIScreen.main.bounds.size
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.view.frame = CGRect(x: 15, y: 70, width: screenSize.width - 30, height: 200)
        }) { (finished) in
            
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.view.alpha = 1
            }
        }
    }
    
    func dismissCallout() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { (finished) in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
