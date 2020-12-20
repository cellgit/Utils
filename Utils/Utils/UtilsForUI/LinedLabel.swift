//
//  LinedLabel.swift
//  Utils
//
//  Created by 刘宏立 on 2020/12/19.
//

/**
 * 画有横线的label: 如价格中间画有横线
 */

import UIKit

class LinedLabel: UILabel {
    
    let lineColor: CGColor
    let lineWidth: CGFloat
    
    init(lineColor: CGColor, lineWidth: CGFloat) {
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect ) {
        super .draw(rect)
        /// 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //创建一个矩形，它的所有边都内缩3
        
        
        let drawingRect = self .bounds.insetBy(dx: 3, dy: 3)
        //创建并设置路径
        let path = CGMutablePath ()
        path.move(to: CGPoint (x:drawingRect.minX - 10, y:drawingRect.midY))
        path.addLine(to: CGPoint (x:drawingRect.maxX + 10, y:drawingRect.midY))
        //添加路径到图形上下文
        context.addPath(path)
        //设置笔触颜色
        context.setStrokeColor(lineColor)
        //设置笔触宽度
        context.setLineWidth(lineWidth)
        //绘制路径
        context.strokePath()
        context.setLineCap(.round)
    }
    
}

