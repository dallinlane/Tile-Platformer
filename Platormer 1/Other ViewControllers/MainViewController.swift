import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var gameTitleTextLabel: UILabel!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    @IBOutlet weak var highScoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIStyle.configTitleLabel(label: gameTitleTextLabel, view: view)
        UIStyle.styleButtons(buttons: [startGameButton, highScoreButton], view: view, textColor: [UIColor.green, UIColor.yellow], spacing: 40, backgroundColor: [UIColor.black, UIColor.black])
    }
    
        

}
