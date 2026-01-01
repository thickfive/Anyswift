//
//  Font.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public extension Font {
    static func size(_ size: CGFloat) -> FontSize {
        FontSize(size: size)
    }
    
    struct FontSize {
        /// font size
        public var size: CGFloat
        
        public var system: SystemFont {
            SystemFont(size: size)
        }
    }

    struct SystemFont {
        /// font size
        public var size: CGFloat
        
        public var ultraLight: Font {
            Font.system(size: size, weight: .ultraLight)
        }
        
        public var thin: Font {
            Font.system(size: size, weight: .thin)
        }
        
        public var light: Font {
            Font.system(size: size, weight: .light)
        }
        
        public var regular: Font {
            Font.system(size: size, weight: .regular)
        }
        
        public var medium: Font {
            Font.system(size: size, weight: .medium)
        }
        
        public var semibold: Font {
            Font.system(size: size, weight: .semibold)
        }
        
        public var bold: Font {
            Font.system(size: size, weight: .bold)
        }
        
        public var heavy: Font {
            Font.system(size: size, weight: .heavy)
        }
        
        public var black: Font {
            Font.system(size: size, weight: .black)
        }
    }
}

import UIKit

public extension UIFont {
    static func size(_ size: CGFloat) -> FontSize {
        FontSize(size: size)
    }
    
    struct FontSize {
        /// font size
        public var size: CGFloat
        
        public var system: SystemFont {
            SystemFont(size: size)
        }
    }

    struct SystemFont {
        /// font size
        public var size: CGFloat
        
        public var ultraLight: UIFont {
            UIFont.systemFont(ofSize: size, weight: .ultraLight)
        }
        
        public var thin: UIFont {
            UIFont.systemFont(ofSize: size, weight: .thin)
        }
        
        public var light: UIFont {
            UIFont.systemFont(ofSize: size, weight: .light)
        }
        
        public var regular: UIFont {
            UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        public var medium: UIFont {
            UIFont.systemFont(ofSize: size, weight: .medium)
        }
        
        public var semibold: UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        public var bold: UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
        
        public var heavy: UIFont {
            UIFont.systemFont(ofSize: size, weight: .heavy)
        }
        
        public var black: UIFont {
            UIFont.systemFont(ofSize: size, weight: .black)
        }
    }
}
