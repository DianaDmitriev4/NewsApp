//
//  DetailsCollectionViewCell.swift
//  newsApp
//
//  Created by User on 30.11.2023.
//

import UIKit
import SnapKit

final class DetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // MARK: - Initializations
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(article: ArticleCellViewModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        if let data = article.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "news")
        }
    }
    
    // MARK: - Private func
    private func setupUI() {
        addSubviews(views: [
            imageView,
            titleLabel,
            descriptionLabel
        ])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(self.frame.height)
            make.top.leading.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
}
