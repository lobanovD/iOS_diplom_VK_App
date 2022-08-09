//
//  FeedViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 08.08.2022.
//

import UIKit


final class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let params = URLQueryItem(name: GetFeed.name, value: GetFeed.value)
        
        NetworkService.shared.request(path: GetFeed.path, methodParams: params) { data, error in
            print(data)
        }

    }
    



}
