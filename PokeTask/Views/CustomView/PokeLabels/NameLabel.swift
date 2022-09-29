//
//  NameLabel.swift
//  PokeTask
//
//  Created by Burak AKCAN on 24.09.2022.
//

import UIKit

class NameLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlign:NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlign
        
    }
    
    private func configure(){
        adjustsFontSizeToFitWidth = true
        font = UIFont.rounded(ofSize: 24, weight: .medium)
        minimumScaleFactor = 0.6
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
    }
}
