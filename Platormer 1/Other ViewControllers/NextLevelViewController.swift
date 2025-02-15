import UIKit

class NextLevelViewController: UIViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "player1")
        
        UIStyle.formatLabel(label: roundLabel, x: 3 * (width/4), text: "Round: " + String(round), textColor: UIColor.white, backgroundColor: UIColor.clear, labelWidth: Int(width/2), y: Int(height/15), labelHeight: Int(height/5))
        
        roundLabel.font = Fonts().buttonFont.withSize(height/8)
        
        imageView.frame = CGRect(x: CGFloat(Int(width/2 - height/6)), y: height/3, width: height/3, height: height/3)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            switchViewControllers(storyboardID: "GameViewController")
        }
        
    }
    
}
