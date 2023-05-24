//
//  TechnologyViewController.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit
import SnapKit

final class TechnologyViewController: UIViewController {
    //MARK: -- GUI Variables
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20,
                                           bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - view.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    //MARK: -- Properties
    private var viewModel: NewsListViewModelProtocol
    
    //MARK: -- Life cycle
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.loadData(searchText: nil)
    }
    
    //MARK: -- Private Methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
        
        viewModel.showError = { error in
            self.showAlert()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: -- UICollectionViewDataSource
extension TechnologyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as?
                ArticleCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                            for: indexPath) as? GeneralCollectionViewCell else { return UICollectionViewCell() }
        cell.set(article: article)
        return cell
    }
}

//MARK: -- UICollectionViewDelegate
extension TechnologyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return }
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
}

//MARK: -- UICollectionViewDelegateFlowLayout
extension TechnologyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return  CGSize(width: width, height: width - 120)
    }
}
