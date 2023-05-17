//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit
import SnapKit

final class BusinessViewController: UIViewController {
    //MARK: -- GUI Variables
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20,
                                           bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - view.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self // Делегат будет сам реализовывать ViewController
        collectionView.delegate = self //Чтобы обрабатывать нажатие на ячейки
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    //MARK: -- Properties
    private var viewModel: NewsListViewModelProtocol
    
    //MARK: -- Initialization
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.loadData(searchText: nil)
    }
    
    //MARK: -- Private methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
        
        viewModel.showError = { error in
            print(error)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        collectionView.register(DetailsCollectionViewCell.self,
                                forCellWithReuseIdentifier: "DetailsCollectionViewCell")
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
extension BusinessViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as?
                ArticleCellViewModel else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                                for: indexPath) as? GeneralCollectionViewCell else { return UICollectionViewCell() }
            cell.setupTitleCell(article: article)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell",
                                                                for: indexPath) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
<<<<<<< Updated upstream
            let article = viewModel.getArticle(for: indexPath.row + 1)
            cell.setup(article: article)
=======
            cell.set(article: article)
>>>>>>> Stashed changes
            return cell
        }
    }
}

//MARK: -- UICollectionViewDelegate
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
<<<<<<< Updated upstream
        let article = viewModel.getArticle(for: indexPath.section == 0 ? 0 : indexPath.row + 1)
=======
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return }
>>>>>>> Stashed changes
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.sections[1].items.count - 15) {
            viewModel.loadData(searchText: nil)
            
        }
    }
}

//MARK: -- UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionItemSize = CGSize(width: width,
                                          height: width)
        let secondSectionItemSize = CGSize(width: width,
                                           height: 100)
        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
    }
}


