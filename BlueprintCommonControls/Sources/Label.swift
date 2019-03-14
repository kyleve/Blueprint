import Blueprint
import UIKit


/// Displays text content.
public struct Label: Element {

    /// The text to be displayed.
    public var text: String
    public var font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var color: UIColor = .black
    public var alignment: NSTextAlignment = .left
    public var numberOfLines: Int = 0
    public var lineBreakMode: NSLineBreakMode = .byWordWrapping
    
    public init(text: String, configure: (inout Label) -> Void = { _ in }) {
        self.text = text
        configure(&self)
    }
    
    private var attributedText: NSAttributedString {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        return NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
    }

    public var content: ElementContent {
        var element = AttributedLabel(attributedText: attributedText)
        element.numberOfLines = numberOfLines
        return ElementContent(child: element)
    }

    public func backingViewDescription(bounds: CGRect, subtreeExtent: CGRect?) -> ViewDescription? {
        return nil
    }

}
