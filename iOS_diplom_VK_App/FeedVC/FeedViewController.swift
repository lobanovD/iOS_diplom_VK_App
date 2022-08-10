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
        
        NetworkService.shared.getFeed { responce in
            print(responce?.response.items.first)
        }
        


    }
    



}
