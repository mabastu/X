//
//  ProfileVC.swift
//  X
//
//  Created by Mabast on 2024-08-14.
//

import UIKit
import Combine
import SDWebImage

class ProfileVC: UIViewController {
    
    private var viewModel = ProfileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 370))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        layoutUI()
        
        profileTableView.tableHeaderView = headerView
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrieveUser()
    }
    
    private func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            self?.headerView.profileName.text = user.displayName
            self?.headerView.userName.text = "@\(user.username)"
            self?.headerView.followingCount.text = "\(user.following)"
            self?.headerView.followrsCount.text = "\(user.followers)"
            self?.headerView.bio.text = user.bio
            self?.headerView.profileAvatarImage.sd_setImage(with: URL(string: user.avatarPath))
        }.store(in: &subscriptions)
    }
    
    func layoutUI() {
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else { return UITableViewCell()
        }
        return cell
    }
}
