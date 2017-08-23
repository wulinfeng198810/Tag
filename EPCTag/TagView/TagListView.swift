//
//  TagListView.swift
//  EPCTag
//
//  Created by LioWu on 2017/8/23.
//  Copyright © 2017年 expedia. All rights reserved.
//

import UIKit


protocol TagModelDelegate {
    func tagClick(tagListView:TagListView, tag:TagModel)
    func tagDeleteClick(tagListView:TagListView,tag:TagModel)
}

class TagListView: UIView {
    
    let margin:CGFloat = 20
    let tagMargin:CGFloat = 10
    var allTagSize:CGSize = CGSize.zero
    var delegate:TagModelDelegate?

    var isDeleteMode:Bool = false {
        didSet{
            setupSubviews()
        }
    }
    
    var dataSource:[TagModel]? {
        didSet{
            setupSubviews()
        }
    }
    
    var filterData = [TagModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        guard let dataSource = dataSource else {
            return
        }
        
        for subView in subviews {
            subView.removeFromSuperview()
        }
        
        var tagArray = [TagModel]()
        for i in 0..<dataSource.count {
            let tagModel = dataSource[i]
            if (filterData.filter({ $0.id == tagModel.id }).first != nil) {
                continue
            }
            tagArray.append(tagModel)
        }
        
        var lastTagFrame = CGRect(x: margin, y: margin, width: 0, height: 0)
        var xOffset:CGFloat = 0
        var yOffset:CGFloat = 0
        
        tagArray.enumerated().forEach({ (offset, tagModel) in
            
            if lastTagFrame.maxX + margin + tagMargin + tagModel.size.width > bounds.width {
                xOffset = margin
                yOffset = lastTagFrame.maxY + margin
            } else {
                xOffset = lastTagFrame.maxX + (lastTagFrame.maxX == margin ? 0 : tagMargin)
                yOffset = lastTagFrame.minY
            }
            
            let tagFrame = CGRect(x: xOffset, y: yOffset, width: tagModel.size.width, height: tagModel.height)
            let tagView = TagView(frame: tagFrame)
            tagView.tagModel = tagModel
            tagView.deleteBlock = {
                self.delegate?.tagDeleteClick(tagListView:self, tag: tagModel)
            }
            tagView.clickBlock = {
                self.delegate?.tagClick(tagListView:self, tag: tagModel)
            }
            addSubview(tagView)
            
            lastTagFrame = tagFrame
            if offset == tagArray.count - 1 {
                allTagSize = CGSize(width: bounds.width, height: lastTagFrame.maxY + margin)
                frame.size = allTagSize
            }
        })
    }
}
