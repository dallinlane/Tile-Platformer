
import UIKit
import SpriteKit

extension Ground {
    
    func startTimer() {
        scoreTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        if !floorStopped {
            tilesPassed += 1
            
            self.updateScore(Int(tilesPassed / 5) + 1)
         
        } else {
            scoreTimer?.invalidate()
        }
    }
    
    func spriteTimer(_ sprite: CustomSprite){
        sprite.distanceToPlayer = (sprite.position.x - mainXPOS) / CGFloat(50 / movementSpeed) - movementSpeed
        sprite.distanceToMonster = (sprite.position.x - monsterXPOS) / CGFloat(50 / movementSpeed) - movementSpeed
        
        let duration = self.movementSpeed * 1.5
  
        var playerTimer = Timer.scheduledTimer(withTimeInterval: sprite.distanceToPlayer, repeats: false) { timer in
            if !self.floorStopped{
                let spriteGen = self.spriteGenerator
                
                if sprite.swipedDown && sprite.isUpright{
                    
                    spriteGen.playerSprite?.run(spriteGen.climbingAnimation(speed: duration, asscent: sprite.floorHeight - 44))
                    
                    self.updateScore(sprite.name == "tile1" ? 100 : 50)
            
                    self.tilesPassed += 1
                    
                } else {
                    self.skView.gestureRecognizers?.forEach { self.skView.removeGestureRecognizer($0) }
                  
                    spriteGen.playerSprite?.run(spriteGen.climbingAnimation(speed: duration, asscent: sprite.baseYPosition + 6))
                    
                    Timer.scheduledTimer(withTimeInterval: self.movementSpeed, repeats: false) { timer in
                        
                        self.stopSprites(sprite)
                    
                    }
                }
            }
        }
        
        var monsterTimer = Timer.scheduledTimer(withTimeInterval: sprite.distanceToMonster, repeats: false) { timer in
            if !self.floorStopped {
                self.spriteGenerator.monsterSprite?.run(self.spriteGenerator.climbingAnimation(speed: duration, asscent: sprite.floorHeight - 15))
            }
        }
        
        activeTimers.append(playerTimer)
        activeTimers.append(monsterTimer)

    }
    
    func stopSprites(_ sprite: CustomSprite) {
        
        guard let playerSprite = spriteGenerator.playerSprite,
              let monsterSprite = spriteGenerator.monsterSprite else {
            return
        }
        
        spriteGenerator.stopSprite(playerSprite)
        spriteGenerator.moveToPlayer(movementSpeed: self.movementSpeed)
        
        for node in self.scene.children {
            if let sprite = node as? SKSpriteNode {
                sprite.removeAction(forKey: "moveAction")
            }
        }
        self.floorStopped = true
    }
}

