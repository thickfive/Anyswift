//
//  StrokeText.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI
import UIKit

public struct StrokeGradient {
    public let gradient: Gradient
    public let startPoint: UnitPoint
    public let endPoint: UnitPoint
}

/// 双重渐变, 支持颜色透明度
public struct StrokeText: UIViewRepresentable {
    let text: String
    var textAlignment: NSTextAlignment = .center
    var font: UIFont = .systemFont(ofSize: 20, weight: .bold)
    var textGradient: StrokeGradient?
    var strokeGradient: StrokeGradient?
    var strokeWidth: CGFloat = 2
    var blendMode: CGBlendMode = .normal // .xor 镂空
    var adjustsFontSizeToFitWidth: Bool = false
    var numberOfLines: Int = 1
    var lineBreakMode: NSLineBreakMode = .byWordWrapping
    
    public init(_ text: String) {
        self.text = text
    }
    
    public func makeUIView(context: Context) -> StrokeLabel {
        let label = StrokeLabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }
    
    public func updateUIView(_ uiView: StrokeLabel, context: Context) {
        let label = uiView
        label.font = font
        label.text = text
        label.textAlignment = textAlignment
        label.lineBreakMode = lineBreakMode
        label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        label.numberOfLines = numberOfLines
        label.strokeWidth = strokeWidth
        label.strokeGradient = strokeGradient
        label.textGradient = textGradient
        label.blendMode = blendMode
        label.setNeedsDisplay()
    }
    
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: StrokeLabel, context: Context) -> CGSize? {
        // 允许设置宽度, 保持文字高度不被压缩
        let size = CGSize(width: proposal.width ?? 0, height: Double.greatestFiniteMagnitude)
        let height = uiView.sizeThatFits(size).height
        return CGSize(width: proposal.width ?? uiView.intrinsicContentSize.width, height: height)
    }
}

public extension StrokeText {
    func font(_ font: UIFont) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        var copy = self
        copy.textAlignment = textAlignment
        return copy
    }
    
    func textColor(_ color: Color) -> Self {
        return textGradient(gradient: Gradient(colors: [color, color]), startPoint: .leading, endPoint: .trailing)
    }
    
    func textGradient(gradient: Gradient, startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) -> Self {
        var copy = self
        copy.textGradient = StrokeGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
        return copy
    }
    
    func strokeWidth(_ width: CGFloat) -> Self {
        var copy = self
        copy.strokeWidth = width
        return copy
    }
    
    func strokeColor(_ color: Color) -> Self {
        return strokeGradient(gradient: Gradient(colors: [color, color]), startPoint: .leading, endPoint: .trailing)
    }
    
    func strokeGradient(gradient: Gradient, startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) -> Self {
        var copy = self
        copy.strokeGradient = StrokeGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
        return copy
    }
    
    func blendMode(_ mode: CGBlendMode) -> Self {
        var copy = self
        copy.blendMode = mode
        return copy
    }
    
    func numberOfLines(_ numberOfLines: Int) -> Self {
        var copy = self
        copy.numberOfLines = numberOfLines
        return copy
    }
    
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        var copy = self
        copy.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return copy
    }
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        var copy = self
        copy.lineBreakMode = lineBreakMode
        return copy
    }
}

public class StrokeLabel: UILabel {
    public var strokeWidth: CGFloat = 0
    public var strokeGradient: StrokeGradient?
    public var textGradient: StrokeGradient?
    public var blendMode: CGBlendMode = .normal
    
    override public func drawText(in rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            super.drawText(in: rect)
            return
        }

        context.saveGState()
        
        self.textColor = .black
        context.setTextDrawingMode(.fill)
        super.drawText(in: rect)
        let maskImage1 = context.makeImage()!
        
        context.clear(rect) // 去掉文字, 保留遮罩图片的颜色透明度
        context.translateBy(x: 0, y: bounds.maxY)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: bounds, mask: maskImage1)
        drawLinearGradient(textGradient!, context: context) // 文字渐变
        let maskImage2 = context.makeImage()!
        
        context.restoreGState()
        context.clear(rect)

        self.textColor = .black
        context.setLineWidth(strokeWidth)
        context.setLineJoin(.round)
        context.setTextDrawingMode(.fillStroke)
        super.drawText(in: rect)
        let maskImage3 = context.makeImage()!
        
        context.clear(rect) // 去掉文字, 保留遮罩图片的颜色透明度
        context.translateBy(x: 0, y: bounds.maxY)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: bounds, mask: maskImage3)
        drawLinearGradient(strokeGradient!, context: context) // 描边渐变
        
        context.setBlendMode(blendMode)
        context.draw(maskImage2, in: rect, byTiling: false)
    }
    
    func drawLinearGradient(_ sg: StrokeGradient, context: CGContext) {
        let colors = sg.gradient.stops.map { UIColor($0.color).cgColor } as CFArray
        let locations = sg.gradient.stops.map { $0.location }
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: locations)!
        // 交换 y 轴坐标
        let sPoint = CGPoint(x: sg.startPoint.x * bounds.size.width, y: sg.endPoint.y * bounds.size.height)
        let ePoint = CGPoint(x: sg.endPoint.x * bounds.size.width, y: sg.startPoint.y * bounds.size.height)
        // 渐变方向不在水平/竖直/对角线时, 用起点/终点颜色填充
        context.drawLinearGradient(gradient, start: sPoint, end: ePoint, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        
    }
    
    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += strokeWidth
        size.height += strokeWidth
        return size
    }
}
