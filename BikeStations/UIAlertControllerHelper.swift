
import UIKit


extension UIAlertController {

    class func presentAlert(title : String = "BikeStations", message : String, parent : UIViewController) {
    
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction(parent))
        
        parent.show(alert, sender: nil)
    }
    
    fileprivate class func cancelAction(_ parentViewController : UIViewController) -> UIAlertAction {
    
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler:{ (action) in
            parentViewController.dismiss(animated: true, completion: nil)
        })
        
        return action
    }
}
