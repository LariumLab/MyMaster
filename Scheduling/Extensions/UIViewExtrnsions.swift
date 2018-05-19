//
//  UIViewExtrnsions.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 26.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit
import Foundation



extension UIView{
	func showBlurLoader(){
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		activityIndicator.startAnimating()
		
		blurEffectView.contentView.addSubview(activityIndicator)
		activityIndicator.center = blurEffectView.contentView.center
		
		self.addSubview(blurEffectView)
	}
	
	func removeBlurLoader(){
		self.subviews.compactMap {
			$0 as? UIVisualEffectView
			}.forEach {
				$0.removeFromSuperview()
		}
	}
}
