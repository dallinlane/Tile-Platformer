import UIKit

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIStyle.configTitleLabel(label: highScoreLabel, view: view)
   
        UIStyle.formatLabel(label: scoreLabel, x: width/2 + height/6, text: String(highScore), textColor: UIColor.blue.withAlphaComponent(0.5), backgroundColor: UIColor.clear, labelWidth: Int(height/3), y: Int(2 * height/5), labelHeight: Int(height/5))
        
        scoreLabel.font = Fonts().buttonFont.withSize(height/8)
        
        configReturnButton()
    }
    
    @IBAction func toHomeScreen(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    func configReturnButton() {
        returnButton.setTitleColor(UIColor.yellow, for: .normal)
        returnButton.backgroundColor = UIColor.black
        returnButton.layer.cornerRadius = 10
        returnButton.frame.origin.x = width/2 - returnButton.frame.width / 2
        returnButton.frame.origin.y = height * 3/4 - returnButton.frame.height / 2
        returnButton.bounds.size = CGSize(width: height/4, height: height/8)
        returnButton.titleLabel?.font = UIFont.systemFont(ofSize: height/15)
    }
}
