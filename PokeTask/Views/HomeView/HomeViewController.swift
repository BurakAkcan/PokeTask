//
//  HomeViewController.swift
//  PokeTask
//
//  Created by Burak AKCAN on 26.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private  var detailList : PokemonDetails = []
    private  var index:Int = 1
    
  
    //MARK: - Views
    private var pokeCardView = CardView()
    private var loadingLabel = PokeLabel(fontSize: 24, weight: .regular)
    private var  refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        let iconImage = UIImage(systemName: "arrow.clockwise")
        button.tintColor = ColorConstant.refreshButtonTintColor
        button.setImage(iconImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getPokeDetails()
        applyConstraints()
        gestureCard()
        
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        setRoundButtonRadius()
    }
    
    //MARK: - Functions
    
    private func setUpViews(){
        view.layer.backgroundColor = ColorConstant.homeViewColor
        view.addSubview(pokeCardView)
        view.addSubview(loadingLabel)
        view.addSubview(refreshButton)
    }
    
    private func setRoundButtonRadius(){
        refreshButton.layer.cornerRadius = refreshButton.frame.size.width/2
        refreshButton.clipsToBounds = true
        refreshButton.addTarget(self, action: #selector(tappedRefreshButton), for: .touchUpInside)
        
    }
    
    private func gestureCard(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedCard))
        pokeCardView.isUserInteractionEnabled = true
        pokeCardView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    func getPokeDetails(){
        loadingLabel.text = LabelsTextConstant.loadingText
        PokemonManager.shared.getPokemonDetails { details in
            self.detailList = details ?? []
        
            DispatchQueue.main.async {
                self.loadingLabel.isHidden = true
                guard let mydetailList = details,
                      !mydetailList.isEmpty else {return}
                let item = mydetailList[0]
                guard  item.stats[0].name.contains("hp"),
                       item.stats[1].name.contains("attack"),
                       item.stats[2].name.contains("defense")  else{return}
                let pokeViewModel:PokeViewModel = PokeViewModel(id: item.id, name: item.name, hp: item.stats[0].value, attack: item.stats[1].value, defense: item.stats[2].value)
                self.communicationToSetCard(pokeViewModel: pokeViewModel)
            }
        }
    }
    
    private func communicationToSetCard(pokeViewModel:PokeViewModel){
        let dict = ["sent":pokeViewModel]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: dict)
    }
    
   
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            pokeCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokeCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: pokeCardView.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: pokeCardView.centerYAnchor),
            refreshButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding().pd16),
            refreshButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding().pd48),
            refreshButton.heightAnchor.constraint(equalToConstant: Padding().pd48),
            refreshButton.widthAnchor.constraint(equalToConstant: Padding().pd48)
        ])
    }
}
       //MARK: - HomeViewController Extensions
extension HomeViewController{
    @objc func tappedCard(){
        
        guard !detailList.isEmpty,
              detailList.count > 0 else {return}
        
        if index < detailList.count{
            
            let item = detailList[index]
            guard  item.stats[0].name.contains("hp"),
                   item.stats[1].name.contains("attack"),
                   item.stats[2].name.contains("defense")  else{return}
            
            let pokeViewModel:PokeViewModel = PokeViewModel(id: item.id, name: item.name, hp: item.stats[0].value, attack: item.stats[1].value, defense: item.stats[2].value)
            
            if index % 2 == 0 {
                DispatchQueue.main.async {
                    self.pokeCardView.fromLeftToRightRotate()
                    }
            }else{
                DispatchQueue.main.async {
                    self.pokeCardView.fromBottomToTopRotate()
                }
            }
            communicationToSetCard(pokeViewModel: pokeViewModel)
            index += 1
            if index == detailList.count  {
                index = 0
            }
        }
    }
    
    @objc private func tappedRefreshButton(){
        guard !detailList.isEmpty,
              detailList.count > 0 else {return}
        let item = detailList[0]
        let pokeViewModel = PokeViewModel(id: item.id, name: item.name, hp: item.stats[0].value, attack: item.stats[1].value, defense: item.stats[2].value)
        communicationToSetCard(pokeViewModel: pokeViewModel)
        index = 1
    }
}
