//
//  NewsVC.swift
//  newsApp
//
//  Created by User on 29.11.2023.
//

import UIKit
import SnapKit

final class NewsVC: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var publicationDateLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .right
        
        return label
    }()
    
    // MARK: - Properties
    private let viewModel: NewsViewModelProtocol
    
    // MARK: - Life cycle
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(views: [
            imageView,
            titleNameLabel,
            descriptionLabel,
            publicationDateLabel
        ])
        
        titleNameLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        publicationDateLabel.text = viewModel.date
       
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "news")
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(30)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleNameLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview().inset(30)
        }
        
        publicationDateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.trailing.leading.bottom.equalToSuperview().inset(30)
        }
    }
}
