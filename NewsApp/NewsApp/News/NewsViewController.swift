//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    //MARK: -- GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 35)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 21)
        
        return label
    }()
    
    //MARK: -- Properties
    private let edgesInset = 10
    private let viewModel: NewsViewModelProtocol
    
    //MARK: -- Life cycle
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: -- Private methods
    private func setupUI() {
        scrollView.addSubview(contentView)
        contentView.addSubviews([titleLabel, dateLabel, imageView, descriptionLabel])
        view.addSubview(scrollView)
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "Image")
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(edgesInset)
            make.leading.trailing.equalToSuperview().inset(edgesInset)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(edgesInset)
            make.trailing.leading.equalToSuperview().inset(edgesInset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(edgesInset)
            make.trailing.leading.equalToSuperview().inset(edgesInset)
            make.bottom.equalToSuperview().inset(edgesInset)
        }
    }
}
