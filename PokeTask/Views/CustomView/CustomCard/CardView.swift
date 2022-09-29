//
//  CardView.swift
//  PokeTask
//
//  Created by Burak AKCAN on 25.09.2022.
//

import UIKit




class CardView: UIView {
    
    //MARK: - Views
    
    private var containerView:UIView = {
       var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 480)
        return view
    }()
    
    private let pokeNameLabel = PokeLabel(fontSize: 24, weight: .regular)
    private let pokeAttackLabel = PokeLabel(fontSize: 32, weight: .medium)
    private let pokeHpLabel = PokeLabel(fontSize: 32, weight: .medium)
    private let pokeDefenseLabel = PokeLabel(fontSize: 32, weight: .medium)
    private let constantHpLabel = PokeLabel(fontSize: 18, weight: .regular)
    private let constantDefenseLabel = PokeLabel(fontSize: 18, weight: .regular)
    private let constantAttackLabel = PokeLabel(fontSize: 18, weight: .regular)
    private let pokeImageView = PokeImageView(frame: .zero)
    private let pokeSkillsStackView = UIStackView()
    private let hpStackView = UIStackView()
    private let attackStackView = UIStackView()
    private let defenseStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUpViews()
        applyConstraints()
        setConsLabelText()
        setHpStackView()
        setDefenseStackView()
        setAttackStackView()
        setPokeSkillsStackView()
        listenCardTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
         containerView.bounds = self.frame
    }
    
    private func listenCardTap(){
        NotificationCenter.default.addObserver(self, selector: #selector(showPoke(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
    
    private func setUpViews(){
        addSubview(containerView)
        addSubview(pokeNameLabel)
        addSubview(pokeImageView)
        addSubview(pokeSkillsStackView)
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func setHpStackView(){
        hpStackView.axis = .vertical
        hpStackView.distribution = .fillEqually
        hpStackView.spacing = 0
        hpStackView.addArrangedSubview(constantHpLabel)
        hpStackView.addArrangedSubview(pokeHpLabel)
        hpStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setAttackStackView(){
       attackStackView.axis = .vertical
       attackStackView.distribution = .fillEqually
       attackStackView.spacing = 0
       attackStackView.addArrangedSubview(constantAttackLabel)
       attackStackView.addArrangedSubview(pokeAttackLabel)
       attackStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setDefenseStackView(){
       defenseStackView.axis = .vertical
       defenseStackView.distribution = .fillEqually
       defenseStackView.spacing = 0
       defenseStackView.addArrangedSubview(constantDefenseLabel)
       defenseStackView.addArrangedSubview(pokeDefenseLabel)
       defenseStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setPokeSkillsStackView(){
        pokeSkillsStackView.axis = .horizontal
        pokeSkillsStackView.distribution = .fillEqually
        pokeSkillsStackView.spacing = 0
        pokeSkillsStackView.addArrangedSubview(hpStackView)
        pokeSkillsStackView.addArrangedSubview(attackStackView)
        pokeSkillsStackView.addArrangedSubview(defenseStackView)
        pokeSkillsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setConsLabelText(){
        constantHpLabel.text = LabelsTextConstant.hpLabelText
        constantAttackLabel.text = LabelsTextConstant.attackLabelText
        constantDefenseLabel.text = LabelsTextConstant.defenseLabelText
    }
    private func set(model:PokeViewModel){
        setImage(with: model.id)
        pokeNameLabel.text = model.name
        pokeHpLabel.text = String(model.hp)
        pokeAttackLabel.text = String(model.attack)
        pokeDefenseLabel.text = String(model.defense)
    }
    private func setImage(with id:Int){
        PokemonManager.shared.downloadImage(from: id) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.pokeImageView.image = image
                }
            }
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            //Set containerView constraints
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //Set pokeNameLabel constraints
            pokeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pokeNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: Padding().pd18),
            //Set imageView constraints
            pokeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pokeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokeImageView.heightAnchor.constraint(equalToConstant: 114),
            pokeImageView.widthAnchor.constraint(equalToConstant: 102),
            //Set pokeSkillsStackView
            pokeSkillsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding().pd18),
            pokeSkillsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding().pd18),
            pokeSkillsStackView.heightAnchor.constraint(equalToConstant: 59),
            pokeSkillsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding().pd23)
           
        ])
    }
}

extension CardView{
    @objc func showPoke(_ notification:NSNotification){
        if let model = notification.userInfo?["sent"] as? PokeViewModel{
            set(model: model)
        }
    }
}
