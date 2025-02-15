import UIKit

struct UIStyle {
    
    
    static func configTitleLabel(label: UILabel, view: UIView){
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = Fonts().titleFont
        label.textColor = UIColor.black
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: height/5)
        ])
        
        label.sizeToFit()
 
    }
    
    static func styleButtons(buttons: [UIButton], view: UIView,  textColor: [UIColor], spacing: CGFloat, backgroundColor: [UIColor]) {
        guard !buttons.isEmpty else { return }
        
        for (index, button) in buttons.enumerated() {
            
            button.translatesAutoresizingMaskIntoConstraints = false

            button.titleLabel?.font = Fonts().buttonFont
            button.titleLabel?.numberOfLines = 1
            button.backgroundColor = backgroundColor[index]
            button.setTitleColor(textColor[index], for: .normal)  // Correct way to set text color
            button.layer.cornerRadius = 10

            
            if let text = button.titleLabel?.text, let font = button.titleLabel?.font {
                let textSize = (text as NSString).size(withAttributes: [.font: font])
                
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: textSize.height + 20),
                    button.widthAnchor.constraint(equalToConstant:  textSize.width + 50)
                       ])
            }
            
            view.addSubview(button) // Ensure the button is added to the view
    
        }
        
        // Use a UIStackView to handle layout
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Center vertically
        ])
    }
    
    static func formatLabel(label : UILabel, x : CGFloat, text : String, textColor : UIColor, backgroundColor : UIColor, labelWidth : Int, y : Int, labelHeight : Int){
        label.text = text
        label.font = UIFont.systemFont(ofSize:  height / 20)
        label.textAlignment = .center
        
        label.frame = CGRect(x: Int(width - x), y: y, width: labelWidth, height: labelHeight)
        label.textColor = textColor
        label.backgroundColor = backgroundColor

        label.numberOfLines = 1

        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
    }
  


    

}
