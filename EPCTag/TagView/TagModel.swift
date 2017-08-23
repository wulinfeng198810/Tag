//
//  TagModel.swift
//  EPCTag
//
//  Created by LioWu on 2017/8/23.
//  Copyright © 2017年 expedia. All rights reserved.
//

import UIKit



class TagModel: NSObject {
    
    var isCategoryTag:Bool
    let id:String
    let title:String
    let tag: Int
    let fontSize:CGFloat
    let height:CGFloat
    let maxWidth:CGFloat
    let isDeleteMode:Bool
    let size:CGSize
    
    var ext:[String:Any]?
    
    init(isCategoryTag:Bool, id:String, title:String, tag:Int, fontSize:CGFloat, height:CGFloat, maxWidth:CGFloat, isDeleteMode:Bool) {
        self.isCategoryTag = isCategoryTag
        self.id = id
        self.tag = tag
        self.title = title
        self.fontSize = fontSize
        self.height = height
        self.maxWidth = maxWidth
        self.isDeleteMode = isDeleteMode
        
        let tagTitleMaxWidth = maxWidth - (isDeleteMode ? 1.5*height : height)
        let attribute = [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)]
        let titleSize = (title as NSString).boundingRect(with: CGSize(width: tagTitleMaxWidth, height: height), options: .usesLineFragmentOrigin, attributes: attribute, context: nil).size
        let margin = height/2
        let width = margin + titleSize.width + (isDeleteMode ? height : margin)
        size = CGSize(width: width, height: height)
        
        super.init()
    }
}
