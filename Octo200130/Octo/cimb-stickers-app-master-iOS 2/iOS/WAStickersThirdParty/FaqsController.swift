//
//  FaqsController.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation
import UIKit



class FaqsController: UIViewController {
    // MARK: - Properties
    private let cellIdentifier = "ExpandingFaqCell"
    private var faqsTableView: UITableView = UITableView()
    private var faqData = [FaqCellData]()
    private var heightOfRow:CGFloat?
    private var expandedFaq = [Int]()

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faqData = [FaqCellData(question: "Where can I place stickers?", answer: "For now, our stickers can only be placed on your WhatsApp chat rooms."),
                   FaqCellData(question: "How can I start using stickers?", answer: "Once you’ve downloaded a sticker pack, it will automatically be added to your WhatsApp keyboard tray. You can simply tap and add it to your conversations to express yourself!"),
                   FaqCellData(question: "Will there be more stickers released in the future updates?", answer: "Yes! Our team is already working on some new stickers as we speak. In the meantime, we would love to hear your suggestions on what you’d like to see next. Tell us in our suggestion form!")]
        
        self.view.backgroundColor = AppColor.BackgroundGray
        
        configureNavigationBar()
        configureFaqsTableView()
        self.view.addSubview(faqsTableView)
        
        faqsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        faqsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        faqsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        faqsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addCloseButton(presentationStyle: PresentationStyle.Push)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillLayoutSubviews() {
        }
        
    // MARK: - Handlers
    @objc func goBack() {
        print("go back")
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UI
    func configureNavigationBar() {
        _ = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysOriginal)
        self.title = "FAQ"
    }
    
    func configureFaqsTableView() {
        faqsTableView.tableFooterView = UIView(frame: .zero)
        faqsTableView.delegate = self
        faqsTableView.dataSource = self
        faqsTableView.register(UINib(nibName: "FaqTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        faqsTableView.translatesAutoresizingMaskIntoConstraints = false
        faqsTableView.showsVerticalScrollIndicator = false
        faqsTableView.backgroundColor = UIColor.clear
    }
}

// MARK: - EXTENSIONS
extension FaqsController: UITableViewDelegate, UITableViewDataSource, FaqTableViewCellDelegate {
    func didClickCaretButton(index: Int) {
        print("didClickCaretFromOtherVC")
        caretBtnTapped(index: index)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faqData.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FaqTableViewCell else { return UITableViewCell() }
        
        cell.question = faqData[indexPath.section].question
        cell.answer = faqData[indexPath.section].answer
        cell.layer.cornerRadius = 15
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        cell.index = indexPath.section
        cell.delegate = self
        
//        cell.contentView.layer.cornerRadius = 15
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = true
        
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.shadowColor = AppColor.shadowGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)//CGSizeMake(0, 2.0);
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:15).cgPath
        
        if expandedFaq.contains(indexPath.section) {
            cell.isExpanded = true
        }
        else {
            cell.isExpanded = false
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
        caretBtnTapped(index: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedFaq.contains(indexPath.section) {
            return 130
        } else {
            return 54
        }
    }
    
    @objc func caretBtnTapped(index: Int) {
        if expandedFaq.contains(index) {
            expandedFaq = expandedFaq.filter({ $0 != index})
        }
        else {
            expandedFaq.append(index)
        }
        faqsTableView.reloadData()
    }
}



