//
//  PostCell.swift
//  X
//
//  Created by Mabast on 2024-08-12.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func didTapReply()
    func didTapLike()
    func didTapRepost()
    func didTapShare()
}

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    weak var delegate: PostCellDelegate?
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(resource: .imageAvatar)
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let displayName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mabast"
        return label
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@mabastu"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let postTextContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "This is a mockup text, it is going to take multiple lines to fill the whole cell, so it is going to be longer than the default text."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let reply: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let repost: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let like: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let share: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImage)
        contentView.addSubview(displayName)
        contentView.addSubview(username)
        contentView.addSubview(postTextContent)
        contentView.addSubview(reply)
        contentView.addSubview(repost)
        contentView.addSubview(like)
        contentView.addSubview(share)
        configureConstraints()
        configureButtons()
    }
    
    @objc private func replyTapped() {
        delegate?.didTapReply()
    }
    
    @objc private func likeTapped() {
        delegate?.didTapLike()
    }
    
    @objc private func repostTapped() {
        delegate?.didTapRepost()
    }
    
    @objc private func shareTapped() {
        delegate?.didTapShare()
    }
    
    func configureButtons() {
        reply.addTarget(self, action: #selector(replyTapped), for: .touchUpInside)
        like.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        repost.addTarget(self, action: #selector(repostTapped), for: .touchUpInside)
        share.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.widthAnchor.constraint(equalToConstant: 50),
            
            displayName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            displayName.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 20),
            
            username.leadingAnchor.constraint(equalTo: displayName.trailingAnchor, constant: 10),
            username.centerYAnchor.constraint(equalTo: displayName.centerYAnchor),
            
            postTextContent.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 10),
            postTextContent.leadingAnchor.constraint(equalTo: displayName.leadingAnchor),
            postTextContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            
            reply.topAnchor.constraint(equalTo: postTextContent.bottomAnchor, constant: 10),
            reply.leadingAnchor.constraint(equalTo: postTextContent.leadingAnchor),
            reply.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            repost.leadingAnchor.constraint(equalTo: reply.trailingAnchor, constant: 60),
            repost.centerYAnchor.constraint(equalTo: reply.centerYAnchor),
            
            like.leadingAnchor.constraint(equalTo: repost.trailingAnchor, constant: 60),
            like.centerYAnchor.constraint(equalTo: reply.centerYAnchor),
            
            share.leadingAnchor.constraint(equalTo: like.trailingAnchor, constant: 60),
            share.centerYAnchor.constraint(equalTo: reply.centerYAnchor),
            
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
