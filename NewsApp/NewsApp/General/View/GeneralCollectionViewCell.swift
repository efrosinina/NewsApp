//
//  GeneralCollectionViewCell.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit
import SnapKit

final class GeneralCollectionViewCell: UICollectionViewCell {
    
    //MARK: -- GUI Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image") ?? UIImage.add
        
        return imageView
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        
        return view
        
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = .white
        
        return label
    }()
    
    //MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Private Methods
    private func setupUI() {
        addSubviews([imageView, blackView, titleLabel])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        blackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(blackView)
            make.leading.trailing.equalTo(blackView).offset(5)
        }
    }
}