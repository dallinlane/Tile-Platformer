import UIKit.UIFont

struct Fonts {
    var titleFont: UIFont
    var buttonFont: UIFont

    init() {
        self.titleFont = Fonts.generateFont(fontName: "PressStart2P-Regular", fontSize: height / 10)  // This works because we're calling a static method
        self.buttonFont = Fonts.generateFont(fontName: "Doto-VariableFont_ROND,wght", fontSize: height / 20)
    }
       
   // Static method for generating the font
    static func generateFont(fontName: String, fontSize: CGFloat ) -> UIFont {
        
        let defaultFont = UIFont(name: "Doto-Black", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)

        guard let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf") else{ return defaultFont}
       
       do {
           let data = try Data(contentsOf: fontURL)
           let provider = CGDataProvider(data: data as CFData)
           
           guard let cgFont = CGFont(provider!) else { return defaultFont }
           
           CTFontManagerRegisterGraphicsFont(cgFont, nil)
           
           
           guard let font = cgFont.postScriptName else { return defaultFont}
           
           if let uiFont = UIFont(name: font as String, size: fontSize) {
               return uiFont
           }
       
       } catch {
           print("Error loading font data: \(error)")
       }
        
        return defaultFont

       
   }

}
