//
//  GeneralNewsViewController.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit
import SnapKit

final class GeneralNewsViewController: UIViewController {
    
    //MARK: -- GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title for news"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 35)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Image")
        
        return view
    }()
    
    private lazy var descriprionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Пальма - это, пожалуй, самое теплолюбивое дерево, которое у многих ассоциируется с райскими пляжами и жаркими странами. В любых тропических и субтропических странах, у любого тёплого моря можно найти это вечнозелёное растение. На территории России пальму можно увидеть на побережье Черного моря. Пальма растёт в Греции, Китае, Бразилии, Таиланде и многих других странах."
        textView.font = .systemFont(ofSize: 25)
        
        return textView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "30.04.2023"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    //MARK: -- Properties
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: -- Private methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([titleLabel, dateLabel, imageView, descriprionTextView])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
        }
        
        descriprionTextView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
