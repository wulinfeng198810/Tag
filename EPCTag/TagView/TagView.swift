//
//  TagView.swift
//  EPCTag
//
//  Created by LioWu on 2017/8/23.
//  Copyright © 2017年 expedia. All rights reserved.
//

import UIKit


typealias DeleteBlock = ()->()
typealias ClickBlock = ()->()

class TagView: UIButton {

    var tagModel:TagModel? {
        didSet{
            setupSubviews()
        }
    }
    
    let tagLabel = UILabel()
    lazy var deleteButton = TagDeleteButton(frame: CGRect.zero)
    var deleteBlock:DeleteBlock?
    var clickBlock:ClickBlock?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        guard let tagModel = tagModel  else {
            return
        }
        layer.cornerRadius = tagModel.height/2
        backgroundColor = UIColor.lightGray
        
        let margin = tagModel.height/2
        let width = tagModel.size.width - (tagModel.isDeleteMode ? 1.5*tagModel.height : tagModel.size.height)
        tagLabel.frame = CGRect(x: margin, y: 0, width: width, height: tagModel.height)
        tagLabel.font = UIFont.systemFont(ofSize: tagModel.fontSize)
        tagLabel.text = tagModel.title
        addSubview(tagLabel)
        
        if tagModel.isDeleteMode {
            deleteButton.frame = CGRect(x: tagModel.size.width - tagModel.size.height, y: 0, width: tagModel.size.height, height: tagModel.size.height)
            addSubview(deleteButton)
            deleteButton.addTarget(self, action: #selector(deleteClick), for: .touchUpInside)
        }
        
        tagModel.isDeleteMode ? () : addTarget(self, action: #selector(tagClick), for: .touchUpInside)
    }
    
    func deleteClick() {
        deleteBlock?()
    }
    
    func tagClick() {
        clickBlock?()
    }
}
