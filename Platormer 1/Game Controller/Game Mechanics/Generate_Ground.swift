import UIKit
import SpriteKit

extension Ground {

    func createGround() {
        
        numberOfRectangles = Int(width * 3 / 50) + round * 5
        spriteMovementAmount = numberOfRectangles - Int(width) / 50 - 1
        let half = numberOfRectangles / 2
        waypointIndex = (half / 5) * 5
        
        for i in 0..<numberOfRectangles {
            currentFloorHeight = floorHeight
            
            create_Fill_In_Block(i)
                       
            createGroundSprite(xPosition: i, yPosition: height / -5.778, recHeight: currentFloorHeight, name: "ground")
        }
        
    }

    func createGroundSprite(xPosition: Int, yPosition: CGFloat, recHeight: CGFloat, name: String) {
        let numBricks = Int(recHeight / 50)
  
        for i in 0..<numBricks {
            
            let sprite = SKSpriteNode()
            sprite.texture = SKTexture(imageNamed: "ground" + String(Int.random(in: 2...15)))
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0)
            sprite.size = CGSize(width: 50, height: 50)

            let brickYPosition = yPosition + (CGFloat(i) * 50)
            sprite.position = CGPoint(x: CGFloat(xPosition * 50), y: brickYPosition)
            
            sprite.name = name

            scene.addChild(sprite)
            moveSprite(sprite)
        }
    }

    func moveSprite(_ node: SKSpriteNode) {
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: movementSpeed)
        var moveCount = 0
          let moveAction = SKAction.run {
              moveCount += 1
          }
        
        let sequence = SKAction.sequence([moveLeft, moveAction])

        let completionAction = SKAction.run {
            self.spriteGenerator.moveSprites()
            self.spriteGenerator.finishedRound = true
            self.floorStopped = true
            
            }
        
            node.run(SKAction.sequence([SKAction.repeat(sequence, count: spriteMovementAmount), completionAction]), withKey: "moveAction")
    }
    
    func reloadGround(){
        floorStopped = false
        for timer in activeTimers {
            timer.invalidate()
        }
        activeTimers.removeAll()
        let customSprites = scene.children.compactMap { $0 as? CustomSprite }
        
        let sprites = scene.children.compactMap { $0 as? SKSpriteNode }
        
        let movement = mainXPOS - waypointSprite.position.x + 75
        
        var furthestXPosition = 0
        for sprite in sprites {
            sprite.position.x += movement
            furthestXPosition = Int(sprite.position.x) > furthestXPosition ? Int(sprite.position.x) : furthestXPosition
        }
        
        spriteMovementAmount = (furthestXPosition - Int(width)) / 50
                
        if let closestSprite = customSprites.filter({ waypointSprite.position.x - $0.position.x > 0 })
            .min(by: { (waypointSprite.position.x - $0.position.x) < (waypointSprite.position.x - $1.position.x) }) {
            
            spriteGenerator.monsterSprite?.position.y = closestSprite.baseYPosition + 86
        }
      
        spriteGenerator.monsterSprite?.position.x = monsterXPOS
        spriteGenerator.playerSprite?.position.x = mainXPOS
        spriteGenerator.playerSprite?.position.y = waypointSprite.position.y + 6
        
        spriteGenerator.playerSprite?.run(spriteGenerator.walkingAnimation("player"), withKey: "walkingAnimation")
        spriteGenerator.monsterSprite?.run(spriteGenerator.walkingAnimation("monster"), withKey: "walkingAnimation")
        
        for sprite in sprites{
            if ![spriteGenerator.playerSprite, spriteGenerator.monsterSprite].contains(sprite) {
                moveSprite(sprite)
            }
        }
        
        for sprite in customSprites {
            if wayPointPassed && sprite.position.x > waypointSprite.position.x{
                sprite.position.y = height - 79
                addGestureRecognizers(to: sprite)
                sprite.swipedDown = false
                spriteTimer(sprite)
            }
        }
        
        startTimer()
        
    }
    
    func createBackground() {
        let backgroundImage = SKSpriteNode(imageNamed: "background.jpg")
        backgroundImage.size = CGSize(width: width, height: height)
        backgroundImage.position = CGPoint(x: width/2, y: height/2)
        scene.addChild(backgroundImage)
    }
}

