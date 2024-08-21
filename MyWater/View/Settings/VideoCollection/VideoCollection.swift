//  VideoCollection.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class VideoCollection: UIView {
    
    // MARK: - UI Elements

    private lazy var videoCollection: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false

        collection.dataSource = self
        collection.delegate = self
        collection.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")

        return collection
    }()

    private let videoData: [(url: URL, previewImg: UIImage)] = [
        (URL(string: "https://www.youtube.com/embed/9iMGFqMmUFs") ?? URL(fileURLWithPath: ""),
         UIImage(named: "tedWaterPreview") ?? UIImage()),
        (URL(string: "https://www.youtube.com/embed/2iccTWJ2dmU") ?? URL(fileURLWithPath: ""),
         UIImage(named: "benefitsWaterPreview") ?? UIImage()),
        (URL(string: "https://www.youtube.com/embed/cDCEGMjbNug") ?? URL(fileURLWithPath: ""),
         UIImage(named: "killWaterPreview") ?? UIImage())
    ]

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupView()
        setupViewConstraints()
        setupShadow()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Creation

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25)
        section.orthogonalScrollingBehavior = .continuous

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - Private Methods

private extension VideoCollection {
    private func setupView() {
        addSubview(videoCollection)
    }

    private func setupViewConstraints() {
        videoCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
}

// MARK: - UICollectionViewDataSource

extension VideoCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = videoCollection.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as? VideoCell else {
            return UICollectionViewCell()
        }
        let data = videoData[indexPath.item]
        cell.configure(with: data.url, previewImg: data.previewImg)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VideoCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath.row)")
    }
}
