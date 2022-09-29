//
//  PokeImageView.swift
//  PokeTask
//
//  Created by Burak AKCAN on 24.09.2022.
//

import UIKit

class PokeImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
