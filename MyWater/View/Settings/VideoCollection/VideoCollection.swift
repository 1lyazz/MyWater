//  VideoCollection.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class VideoCollection: UIView {
    
    // MARK: - UI Elements

    private lazy var videoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.addShadow()
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
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension VideoCollection {
    private func setupView() {
        [videoCollection].forEach(addSubview)
    }

    private func setupViewConstraints() {
        videoCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionView

extension VideoCollection: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoCollection.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let data = videoData[indexPath.item]
        cell.configure(with: data.url, previewImg: data.previewImg)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 180)
    }
}
