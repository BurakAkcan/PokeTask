//
//  PokeLabel.swift
//  PokeTask
//
//  Created by Burak AKCAN on 27.09.2022.
//

import UIKit


class PokeLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize:CGFloat,weight:UIFont.Weight){
        self.init(frame: .zero)
        font = UIFont.rounded(ofSize: fontSize, weight: weight)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.6
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        textAlignment = .center
        
    }
}
