import PlaygroundSupport
import UIKit

let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
textView.text = "The Quick Brown Fox"
textView.layoutManager.showsInvisibleCharacters = true

PlaygroundPage.current.liveView = textView
