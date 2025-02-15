import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var quitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIStyle.configTitleLabel(label: gameOverLabel, view: view)
        UIStyle.styleButtons(buttons: [restartButton, quitButton], view: view, textColor: [UIColor.green, UIColor.blue], spacing: 100 ,backgroundColor: [UIColor.black, UIColor.orange])
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        switchViewControllers(storyboardID: "GameViewController")
    }
    
    @IBAction func quitButtonPressed(_ sender: UIButton) {
        switchViewControllers(storyboardID: "MainViewController")
    }
    
}
