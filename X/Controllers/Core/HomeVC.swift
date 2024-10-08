//
//  HomeVC.swift
//  X
//
//  Created by Mabast on 2024-08-12.
//

import UIKit
import FirebaseAuth
import Combine

class HomeVC: UIViewController {
    
    private var viewModel = HomeViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSginOut))
        bindViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeline.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuthentication()
        viewModel.retrieveUser()
    }
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboard {
                self?.completeUserOnboarding()
            }
        }.store(in: &subscriptions)
    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormVC()
        present(vc, animated: true)
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func configureNavigationBar() {
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        logo.contentMode = .scaleAspectFit
        let imageLogo = UIImage(imageLiteralResourceName: "xLogo")
        logo.image = imageLogo
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        middleView.addSubview(logo)
        navigationItem.titleView = middleView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(didTapProfile))
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func didTapProfile() {
        navigationController?.pushViewController(ProfileVC(), animated: true)
    }

    @objc func didTapSginOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
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
