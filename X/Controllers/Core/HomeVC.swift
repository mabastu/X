//
//  HomeVC.swift
//  X
//
//  Created by Mabast on 2024-08-12.
//

import UIKit

class HomeVC: UIViewController {
    
    private let timeline: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timeline)
        timeline.dataSource = self
        timeline.delegate = self
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeline.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        logo.contentMode = .scaleAspectFit
        let imageLogo = UITraitCollection.current.userInterfaceStyle == .dark ? UIImage(resource: .xDarkMode) : UIImage(resource: .xWhiteMode)
        logo.image = imageLogo
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        middleView.addSubview(logo)
        navigationItem.titleView = middleView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(didTapProfile))
        navigationController?.navigationBar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
    }
    
    @objc private func didTapProfile() {
        navigationController?.pushViewController(ProfileVC(), animated: true)
    }


}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
}

extension HomeVC: PostCellDelegate {
    func didTapReply() {
        print("reply")
    }
    
    func didTapLike() {
        print("like")
    }
    
    func didTapRepost() {
        print("repost")
    }
    
    func didTapShare() {
        print("share")
    }
}
