//
//  ProfileHeader.swift
//  X
//
//  Created by Mabast on 2024-08-14.
//

import UIKit

class ProfileHeader: UIView {
    
    private enum SectionTabs: String {
        case post = "Post"
        case replies = "Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .post:
                return 0
            case .replies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
    
    private var selectedTab: Int = 0 {
        didSet {
            print(selectedTab)
        }
    }
    
    private let profileCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(resource: .spacex)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileAvatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(resource: .imageAvatar)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "Mabast"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "@mabastu"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bio: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 3
        label.textColor = .label
        label.text = "I'm an iOS engineer and I love to code."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateJoinedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
        imageView.tintColor = .label
        return imageView
    }()
    
    private let dateJoinedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Joined Sep 2011"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followingCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        label.text = "1,200"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followrsCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        label.text = "4,271"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followrsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Followers"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followingTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Following"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tabs: [UIButton] = ["Posts", "Replies", "Media" , "Likes"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .label
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    
    private lazy var sectionsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileCoverImage)
        addSubview(profileAvatarImage)
        addSubview(profileName)
        addSubview(userName)
        addSubview(bio)
        addSubview(dateJoinedIcon)
        addSubview(dateJoinedLabel)
        addSubview(followrsCount)
        addSubview(followrsTextLabel)
        addSubview(followingCount)
        addSubview(followingTextLabel)
        addSubview(sectionsStack)
        configureUI()
        configureStackButton()
    }
    
    private func configureStackButton() {
        for (_, button) in sectionsStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let lable = sender.titleLabel?.text else { return }
        switch lable {
        case SectionTabs.post.rawValue:
            selectedTab = 0
        case SectionTabs.replies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            profileCoverImage.topAnchor.constraint(equalTo: topAnchor),
            profileCoverImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileCoverImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileCoverImage.heightAnchor.constraint(equalToConstant: 150),
            
            profileAvatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImage.centerYAnchor.constraint(equalTo: profileCoverImage.bottomAnchor, constant: 5),
            profileAvatarImage.heightAnchor.constraint(equalToConstant: 80),
            profileAvatarImage.widthAnchor.constraint(equalToConstant: 80),
            
            profileName.topAnchor.constraint(equalTo: profileAvatarImage.bottomAnchor, constant: 10),
            profileName.leadingAnchor.constraint(equalTo: profileAvatarImage.leadingAnchor),
            
            userName.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 5),
            userName.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            
            bio.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5),
            bio.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            
            dateJoinedIcon.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 5),
            dateJoinedIcon.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            
            dateJoinedLabel.leadingAnchor.constraint(equalTo: dateJoinedIcon.trailingAnchor, constant: 2),
            dateJoinedLabel.bottomAnchor.constraint(equalTo: dateJoinedIcon.bottomAnchor),
            
            followingCount.topAnchor.constraint(equalTo: dateJoinedLabel.bottomAnchor, constant: 10),
            followingCount.leadingAnchor.constraint(equalTo: dateJoinedIcon.leadingAnchor),
            
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCount.trailingAnchor, constant: 4),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCount.bottomAnchor),
            
            followrsCount.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: 8),
            followrsCount.bottomAnchor.constraint(equalTo: followingCount.bottomAnchor),
            
            followrsTextLabel.leadingAnchor.constraint(equalTo: followrsCount.trailingAnchor, constant: 4),
            followrsTextLabel.bottomAnchor.constraint(equalTo: followingCount.bottomAnchor),
            
            sectionsStack.topAnchor.constraint(equalTo: followingCount.bottomAnchor, constant: 5),
            sectionsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
