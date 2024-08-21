//  VideoCell.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit
import WebKit

final class VideoCell: UICollectionViewCell {
    
    private var playButton: UIButton = {
        let button = UIButton()
        button.setImage(.playButton, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()

    private var webView: WKWebView = {
        let webView = WKWebView()
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                webView.alpha = 0
                webView.layer.cornerRadius = 30
                webView.layer.masksToBounds = true
            }
        }
        return webView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        makeConstraints()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(playButton)
        contentView.addSubview(webView)
    }

    private func makeConstraints() {
        playButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }

        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    // MARK: Bindings

    private func bind() {
        playButton.addAction(UIAction(handler: { [weak self] _ in
            UIView.animate(withDuration: 0.3, animations: {
                self?.webView.alpha = 1
                self?.playButton.alpha = 0
            }, completion: { _ in
                self?.playButton.isHidden = true
            })
        }), for: .touchUpInside)
    }

    
    func configure(with url: URL, previewImg: UIImage) {
        let request = URLRequest(url: url)
        webView.load(request)
        playButton.setBackgroundImage(previewImg, for: .normal)
    }
}
