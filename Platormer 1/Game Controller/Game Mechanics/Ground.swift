import UIKit
import SpriteKit

class Ground{
    var scene : SKScene!
    var skView: SKView!
    var numberOfRectangles = 0
    var floorHeight = height / 2.5
    let movementSpeed = 0.5 //max(1.0 - Double(round) * 0.0102, 0.2)
    var currentFloorHeight = 0.0
    var spriteGenerator : Sprites
    var floorStopped = false
    var tilesPassed = 0
    var waypointIndex = 0
    let waypointSprite = SKSpriteNode()
    var wayPointPassed = false
    var spriteMovementAmount = 0
    
    var activeTimers: [Timer] = []

    var scoreTimer: Timer?
    
    init(scene: SKScene, skView: SKView) {
        self.scene = scene
        self.skView = skView
                
        spriteGenerator = Sprites(scene: scene)
        createBackground()

        scene.addChild(waypointSprite)

        spriteGenerator.addSprite(name: "player", y: 113, scale: 0.5)
        spriteGenerator.addSprite(name: "monster", y: 142, scale: 1)
        
        startTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(releaseTrap), name: NSNotification.Name("ReleaseTrap"), object: nil)
    }
    
    func updateScore(_ scoreToAdd: Int) {
        NotificationCenter.default.post(name: NSNotification.Name("UpdateScore"), object: nil, userInfo: ["score": scoreToAdd])
    }
    
    func configureWaypoint(_ index: Int){
        waypointSprite.texture = SKTexture(imageNamed: "waypoint")
        waypointSprite.size = CGSize(width: 50, height: 100)

        waypointSprite.position = CGPoint(x: CGFloat(index * 50), y: currentFloorHeight - 50)
        
            
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: movementSpeed)
        
        let updateWaypointPassed = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.wayPointPassed = self.waypointSprite.position.x <= mainXPOS
        }
        
        let sequence = SKAction.sequence([moveLeft, updateWaypointPassed])
        
        
        waypointSprite.run(SKAction.repeat(sequence, count: spriteMovementAmount), withKey: "moveAction")
            
    }
    
    @objc func releaseTrap() {
        let sprite = SKSpriteNode()
        sprite.texture = SKTexture(imageNamed: "trap")
        sprite.size = CGSize(width: 200, height: 200)

        guard let monsterCurrentX = spriteGenerator.monsterSprite?.position.x else { return }
        guard let monsterCurrentY = spriteGenerator.monsterSprite?.position.y else { return }
        
        sprite.position = CGPoint(x: monsterCurrentX, y: height + 200)

        scene.addChild(sprite)
        
        let fallDown = SKAction.moveTo(y: monsterCurrentY + 40, duration: 1.0)
        fallDown.timingMode = .easeOut
        
        let completion = SKAction.run {
            highScore = max(highScore, score)
            NotificationCenter.default.post(name: NSNotification.Name("NextRound"), object: nil)
        }

        let sequence = SKAction.sequence([fallDown, completion])
        
        sprite.run(sequence)
        
    }

    
 }





