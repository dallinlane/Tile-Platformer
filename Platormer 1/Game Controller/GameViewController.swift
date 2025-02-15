import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var skView: SKView!
    var scene : SKScene!
    var lives = 3
    
    var roundLabel = UILabel()
    var livesLabel = UILabel()
    var scoreLabel = UILabel()
    var groundGenerator : Ground!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLevel()
    }
        
   func initializeLevel(){
       
       skView = SKView(frame: self.view.frame)
       self.view.addSubview(skView)
       scene  = SKScene(size: skView.frame.size)
       
       createLabels()
       
       groundGenerator = Ground(scene: scene, skView: skView)

       groundGenerator.createGround()

       skView.presentScene(scene)
       
       NotificationCenter.default.addObserver(self, selector: #selector(decreaseLife), name: NSNotification.Name("DecreaseLife"), object: nil)
       
       NotificationCenter.default.addObserver(self, selector: #selector(updateScore(_:)), name: NSNotification.Name("UpdateScore"), object: nil)
       
       NotificationCenter.default.addObserver(self, selector: #selector(nextRound), name: NSNotification.Name("NextRound"), object: nil)
        
    }
    
    func createLabels() {
        var text = ""
        
        if lives != 0 {
            for _ in 1...lives {
                text += "❤️"
            }
        } else {
            text = "❤️"
        }
     
        UIStyle.formatLabel(label: roundLabel, x: width - 50, text: "Round: \(round)", textColor : UIColor.yellow ,backgroundColor: UIColor.blue, labelWidth: 110, y: 8, labelHeight: 30)
        UIStyle.formatLabel(label: livesLabel, x: 150, text: text, textColor : UIColor.black,  backgroundColor : UIColor.clear, labelWidth: 110, y: 8, labelHeight: 30)
        UIStyle.formatLabel(label: scoreLabel, x: 300, text: "Score: \(score)", textColor : UIColor.blue, backgroundColor : UIColor.yellow, labelWidth: 150, y: 8, labelHeight: 30)
        
        self.view.addSubview(roundLabel)
        self.view.addSubview(livesLabel)
        self.view.addSubview(scoreLabel)
    }
    
    @objc func decreaseLife() {
        lives -= 1
        if lives >= 0 {
            if groundGenerator.wayPointPassed{
                groundGenerator.reloadGround()
                createLabels()
            } else {
                initializeLevel()
            }
     
        } else {
            
            highScore = max(highScore, score)
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name("DecreaseLife"), object: nil)
            
            performSegue(withIdentifier: "toGameOverScreen", sender: self)
        }
    }
    
    @objc func updateScore(_ notification: Notification) {
        if let userInfo = notification.userInfo, let scoreToAdd = userInfo["score"] as? Int {
            score += scoreToAdd
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @objc func nextRound() {
        round += 1
        switchViewControllers(storyboardID: "toNextRound")
    }





}

