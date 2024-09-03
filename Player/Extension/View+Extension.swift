//
//  View+Extension.swift
//  Player
//
//  Created by 郭蕙瑄 on 2024/9/3.
//

import Foundation
import UIKit

extension UIView {
    
    func viewZoomOut () {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: [.curveEaseInOut],
                       animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.72, y: 0.72)
        }, completion: nil)
    }
    
    func viewZoomIn () {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: [.curveEaseInOut],
                       animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }, completion: nil)
    }
}
