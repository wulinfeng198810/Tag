//
//  ViewController.swift
//  EPCTag
//
//  Created by LioWu on 2017/8/23.
//  Copyright © 2017年 expedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let chooseTagListView = TagListView()
    let selectedTagListView = TagListView()

    let category = [
    ["categoryId":"0",
     "categoryName":"Spa",
     "subcategory":[
        ["subcategoryId":"00",
         "subcategoryName":"00Spa Sasd"],
        ["subcategoryId":"01",
         "subcategoryName":"01Sf"],
        ["subcategoryId":"02",
         "subcategoryName":"02G"],
        ["subcategoryId":"03",
         "subcategoryName":"03Pasd Asdsfd SDsdesdgf"],
        ]],
    
    ["categoryId":"1",
     "categoryName":"Nosy",
     "subcategory":[
        ["subcategoryId":"10",
         "subcategoryName":"10Spa Sasdsad sadf"],
        ["subcategoryId":"11",
         "subcategoryName":"11Sf Hdssdasdfasdf "],
        ["subcategoryId":"12",
         "subcategoryName":"12G,Pdsasd fasd f"],
        ["subcategoryId":"13",
         "subcategoryName":"13Pasd Asdsfd SDsdesdgf"],
        ["subcategoryId":"14",
         "subcategoryName":"14Spa Sasd sadf as "],
        ["subcategoryId":"15",
         "subcategoryName":"15Sf Loppasd asdf "],
        ["subcategoryId":"16",
         "subcategoryName":"16G"],
        ["subcategoryId":"17",
         "subcategoryName":"17Pasd Asdsfd SDsdesdga sdf f"],
        ["subcategoryId":"18",
         "subcategoryName":"18Sp"],
        ["subcategoryId":"19",
         "subcategoryName":"19Sf Jsdds DSdsasdf asd "]
        ]
        ],
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = view.bounds
        
        selectedTagListView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 0)
        selectedTagListView.backgroundColor = UIColor.red
        selectedTagListView.isDeleteMode = true
        selectedTagListView.delegate = self
        
        chooseTagListView.frame = CGRect(x: 0, y: 300, width: view.bounds.width, height: 10)
        chooseTagListView.backgroundColor = UIColor.green
        chooseTagListView.isDeleteMode = false
        chooseTagListView.dataSource = fetchCategoryTagModel()
        chooseTagListView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(selectedTagListView)
        scrollView.addSubview(chooseTagListView)
        refresh()
    }
    
    func fetchCategoryTagModel() -> [TagModel] {
        var categoryArray = [TagModel]()
        for categoryDict in category {
            let categoryId = categoryDict["categoryId"] as! String
            let categoryName = categoryDict["categoryName"] as! String
            let tagModel = TagModel(isCategoryTag: true, id: categoryId, title: categoryName, tag: 0, fontSize: 17, height: 32, maxWidth: view.bounds.width, isDeleteMode: false)
            categoryArray.append(tagModel)
        }
        return categoryArray
    }
    
    func fetchSubcategoryTagModel(categoryID:String) -> [TagModel] {
        var subcategoryArray = [TagModel]()
        if let subcategoryArr = category.filter({ ($0["categoryId"] as? String) == categoryID} ).first?["subcategory"] as? [[String:String]] {
            for subcategoryDict in subcategoryArr {
                if let subcategoryId = subcategoryDict["subcategoryId"],
                    let subcategoryName = subcategoryDict["subcategoryName"] {
                    let tagModel = TagModel(isCategoryTag: false, id: subcategoryId, title: subcategoryName, tag: 0, fontSize: 17, height: 32, maxWidth: view.bounds.width, isDeleteMode: false)
                    subcategoryArray.append(tagModel)
                }
            }
            
        }
        return subcategoryArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:TagModelDelegate {
    func tagClick(tagListView:TagListView, tag: TagModel) {
        if tagListView == chooseTagListView {
            chooseTagListView.filterData.append(tag)
            
            if tag.isCategoryTag {
                chooseTagListView.filterData.removeAll()
                chooseTagListView.dataSource = fetchSubcategoryTagModel(categoryID: tag.id)
            }
            
            
            // add to Selected Lsit
            let tagModel = TagModel(isCategoryTag: tag.isCategoryTag, id: tag.id, title: tag.title, tag: tag.tag, fontSize: tag.fontSize, height: tag.height, maxWidth: tag.maxWidth, isDeleteMode: true)
            selectedTagListView.dataSource.append(tagModel)
            
            refresh()
        }
    }
    
    func tagDeleteClick(tagListView:TagListView, tag: TagModel) {
        
        if tagListView == selectedTagListView {
            
            if let filterTagModel = chooseTagListView.filterData.filter({ $0.id == tag.id }).first,
                let index = chooseTagListView.filterData.index(of: filterTagModel) {
                chooseTagListView.filterData.remove(at: index)
            }
            
            if tag.isCategoryTag {
                selectedTagListView.dataSource.removeAll()
                self.chooseTagListView.dataSource = fetchCategoryTagModel()
            } else {
                if let tagModel = selectedTagListView.dataSource.filter({ $0.id == tag.id }).first,
                    let index = selectedTagListView.dataSource.index(of: tagModel) {
                    selectedTagListView.dataSource.remove(at: index)
                }
            }
            
            refresh()
        }
    }
    
    func refresh() {
        selectedTagListView.refreshSubviews()
        chooseTagListView.refreshSubviews()
        chooseTagListView.frame = CGRect(origin: CGPoint(x:selectedTagListView.frame.minX, y: selectedTagListView.frame.maxY), size: chooseTagListView.frame.size)
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: chooseTagListView.frame.maxY - scrollView.frame.minY)
    }
}

