//
//  ProfileVC.swift
//  X
//
//  Created by Mabast on 2024-08-14.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        layoutUI()
        
        let headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 360))
        profileTableView.tableHeaderView = headerView
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
