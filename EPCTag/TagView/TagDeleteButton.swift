//
//  DeleteButton.swift
//  EPCTag
//
//  Created by LioWu on 2017/8/23.
//  Copyright © 2017年 expedia. All rights reserved.
//

import UIKit

class TagDeleteButton: UIButton {

    let deleteLayerSize:CGFloat = 6
    let roundBgLayerRadius:CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let roundBgPath = UIBezierPath(arcCenter: CGPoint(x:frame.width/2,y:frame.height/2), radius: roundBgLayerRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let roundBgLayer = CAShapeLayer()
        roundBgLayer.path = roundBgPath.cgPath
        roundBgLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(roundBgLayer)
        
        let deleteLayerPath = UIBezierPath()
        let iconFrame = CGRect(
            x: (rect.width - deleteLayerSize) / 2.0,
            y: (rect.height - deleteLayerSize) / 2.0,
            width: deleteLayerSize,
            height: deleteLayerSize
        )
        deleteLayerPath.move(to: iconFrame.origin)
        deleteLayerPath.addLine(to: CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
        deleteLayerPath.move(to: CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
        deleteLayerPath.addLine(to: CGPoint(x: iconFrame.minX, y: iconFrame.maxY))
        UIColor.green.setStroke()
        deleteLayerPath.stroke()
        
        let deleteLayer = CAShapeLayer()
        deleteLayer.path = deleteLayerPath.cgPath
        deleteLayer.lineWidth = 2
        deleteLayer.lineCap = "round"
        deleteLayer.strokeColor = UIColor.green.cgColor
        layer.addSublayer(deleteLayer)
    }

}
