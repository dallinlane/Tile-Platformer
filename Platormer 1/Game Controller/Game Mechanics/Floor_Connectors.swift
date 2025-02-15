import UIKit
import SpriteKit

//MARK: - Create Floor Connectors

extension Ground {
    
    func create_Fill_In_Block(_ index: Int) {
        
        let customSprites = scene.children.compactMap { $0 as? CustomSprite }
        
        if index > 10, index < numberOfRectangles - 12, index.isMultiple(of: 5), index != waypointIndex {
            var name = "tile"
            if floorHeight >= height / 1.6  {
                floorHeight -= 50
                currentFloorHeight -= 100
            } else {
                let probability = min(Double(round) * 0.02, 0.9)
                if Double.random(in: 0..<1) > probability || index == waypointIndex + 5{
                    currentFloorHeight -= 50
                } else{
                    floorHeight += 50
                    name = "tile1"
                }
            }
            
            Fill_In_Block_Sprite(xPosition: index, name: name)
            
        } else {
            if index == waypointIndex {
                configureWaypoint(index)
            }
        }
    }

    func Fill_In_Block_Sprite(xPosition: Int, name: String ) {
    
        let texture = SKTexture(imageNamed: name == "tile" ? "ground1" : "stairs")
        let rotation = name == "tile" ? 0.0 : (.pi / 2) * CGFloat(Int.random(in: 0...3))
        
        let sprite = CustomSprite(texture: texture, color: UIColor.clear, baseYPosition: currentFloorHeight - 50, rotation: rotation)

        sprite.position = CGPoint(x: CGFloat(xPosition * 50), y: height - 79)
        
        sprite.name = name
        
        sprite.floorHeight = floorHeight
        spriteTimer(sprite)

        scene.addChild(sprite)
        
        moveSprite(sprite)
        
        addGestureRecognizers(to: sprite)
    }
    
    func addGestureRecognizers(to sprite: SKSpriteNode) {
         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
         swipeLeft.direction = .left
         skView.addGestureRecognizer(swipeLeft)
         
         let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
         swipeRight.direction = .right
         skView.addGestureRecognizer(swipeRight)
         
         let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleTileSwipe(_:)))
         swipeDown.direction = .down
         skView.addGestureRecognizer(swipeDown)
     }

    @objc func handleTileSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let skView = gesture.view as? SKView else { return }
        let location = gesture.location(in: skView)
        let sceneLocation = scene.convertPoint(fromView: location)
        
        if let tile = scene.nodes(at: sceneLocation).first(where: { $0.name != "ground" }) as? CustomSprite {
            let rotationAngle: CGFloat = .pi / 2
            
            switch gesture.direction {
            case .left, .right:
                if tile.name == "tile1" && !tile.swipedDown {
                       let rotationAction = SKAction.rotate(byAngle: gesture.direction == .left ? -rotationAngle : rotationAngle, duration: 0.2)
                       tile.run(rotationAction)
                   }
            case .down:
                tile.run(SKAction.moveTo(y: tile.baseYPosition, duration: 0.2))
                
                tile.swipedDown = true
                

                if tile.name == "tile1" && !tile.isUpright {

                    let seconds = (tile.position.x - mainXPOS - 50) / CGFloat(50 / movementSpeed)
                
                    Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { timer in
                        self.stopSprites(tile)
                    }
                }
                
            default: break
                
            }
        }
    }
    
}

class CustomSprite: SKSpriteNode {
    var baseYPosition: CGFloat
    var swipedDown = false
    var distanceToPlayer = 0.0
    var distanceToMonster = 0.0
    var floorHeight = 0.0
    
    var isUpright : Bool {
            return abs(abs(self.zRotation).truncatingRemainder(dividingBy: .pi * 2) - 0) < 0.0001
    }
    
    init(texture: SKTexture?, color: UIColor, baseYPosition: CGFloat, rotation: CGFloat) {
        self.baseYPosition = baseYPosition

        super.init(texture: texture, color: color, size: CGSize(width: 50, height: 50))
        
        self.position = CGPoint(x: self.position.x, y: baseYPosition)
        self.zRotation = rotation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
}
