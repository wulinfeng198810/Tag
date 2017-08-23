//
//  ViewController.swift
//  EPCTag
//
//  Created by LioWu on 2017/8/23.
//  Copyright © 2017年 expedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tagListView:TagListView?
    var selectedTagListView:TagListView?

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
         "subcategoryName":"10Spa Sasd"],
        ["subcategoryId":"11",
         "subcategoryName":"11Sf Hdssd"],
        ["subcategoryId":"12",
         "subcategoryName":"12G,Pds"],
        ["subcategoryId":"13",
         "subcategoryName":"13Pasd Asdsfd SDsdesdgf"],
        ["subcategoryId":"14",
         "subcategoryName":"14Spa Sasd"],
        ["subcategoryId":"15",
         "subcategoryName":"15Sf Lopp"],
        ["subcategoryId":"16",
         "subcategoryName":"16G"],
        ["subcategoryId":"17",
         "subcategoryName":"17Pasd Asdsfd SDsdesdgf"],
        ["subcategoryId":"18",
         "subcategoryName":"18Sp"],
        ["subcategoryId":"19",
         "subcategoryName":"19Sf Jsdds DSds"]
        ]
        ],
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTagListView = TagListView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
        selectedTagListView?.backgroundColor = UIColor.red
        view.addSubview(selectedTagListView!)
        selectedTagListView?.isDeleteMode = true
        selectedTagListView?.delegate = self
        
        tagListView = TagListView(frame: CGRect(x: 0, y: 300, width: view.bounds.width, height: 10))
        tagListView?.backgroundColor = UIColor.green
        view.addSubview(tagListView!)
        tagListView?.isDeleteMode = false
        tagListView?.dataSource = fetchCategoryTagModel()
        tagListView?.delegate = self
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
        if tagListView == self.tagListView {
            tagListView.filterData.append(tag)
            tagListView.setupSubviews()
            
            if tag.isCategoryTag {
                tagListView.filterData.removeAll()
                tagListView.dataSource = fetchSubcategoryTagModel(categoryID: tag.id)
            }
            
            
            // add to Selected Lsit
            if selectedTagListView?.dataSource == nil {
                selectedTagListView?.dataSource = [TagModel]()
            }
            let tagModel = TagModel(isCategoryTag: tag.isCategoryTag, id: tag.id, title: tag.title, tag: tag.tag, fontSize: tag.fontSize, height: tag.height, maxWidth: tag.maxWidth, isDeleteMode: true)
            selectedTagListView?.dataSource?.append(tagModel)
            selectedTagListView?.dataSource = selectedTagListView?.dataSource
        }
        
        
    }
    
    func tagDeleteClick(tagListView:TagListView, tag: TagModel) {
        
//        if tagListView == self.selectedTagListView {
//            if let str = tagListView?.dataSource?.filter({ $0 == tag.title }).first {
//                tagListView.dataSource?.remove(at: (tagListView?.dataSource?.index(of: str))!)
//                tagListView.dataSource = tagListView?.dataSource
//            }
//        }
        
    }
}

