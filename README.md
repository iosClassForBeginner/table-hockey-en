# table-hockey-en
A SpriteKit game app
# Code Together: Let's make iPhone app in an hour

<div style="text-align:center;margin-left:25%">
  <img src="https://github.com/iosClassForBeginner/table-hockey-en/blob/master/assets/game.PNG?raw=true" width="50%" height="50%"/>
</div>  

Thank you for visiting our account. We are going to make a map app in an hour. If would you like to study yourself before hands-on, or review what you have learned in the session, please use the following material.

## Meetup
We are providing free hands-on on a monthly basis

https://www.meetup.com/iOS-Development-Meetup-for-Beginner/

## Do you need a tutor?
We also hold face-to-face or group lesson for individual interested in making iOS app themselves

http://ios-class-for-beginner.esy.es/

## Development Environment
  Xcode 8.3.2 / Swift 3

# Full procedure
## 0, Create your project

> 0-1. Open Xcode
> 0-2. Select <sup>Create a new Xcode project</sup> or Go to <code>File</code> → <code>New</code> → <code>Project...</code>  
> 0-3. Select <sup>Game</sup> and then tap <sup>Next</sup>  
> 0-4. Fill <sup>Product name</sup>, select <sup>SpriteKit</sup> then click <sup>Next</sup>  
> 0-5. Select the place for saving your project and then tap <sup>Create</sup>  
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid1.gif?      raw=true" />    </div>
> </details>

## 1, Design your app
#### 🗂 Set up your Scene.

> 1-1. Remove <code>helloLabel</code> from <code>GameScene.sks</code> file.
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid1.gif?      raw=true" />    </div>
> </details>
> 1-2. Set up the puck.
> <ul>
>   <li>Drag and drop a <code>Color Sprite</code> to your Scene.</li>
>   <li>Set its <code>Name</code> to "puck".</li>
>   <li>Fix its position to (0 , 0) and its width and height to 30.</li>
> </ul>
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid1.gif?      raw=true" />    </div>
> </details>
> 1-3. Add the <code>2x</code> puck and player images to your assets and 
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid2.gif?raw=true" /> >     </div>
> </details>
> 1-4. Set pucks <code>Texture</code> to "puck-2x" and lower the opacity for the Scene color for better appearance.
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid5.gif?raw=true" /> >     </div>
> </details>
> 1-5. Change the <code>Body Type</code> to "Bounding circle".
> <ul>
>   <li>Uncheck "Allows rotation"</li>
>   <li>Uncheck "Affected By Gravity"</li>
>   <li>Set "Friction" to 0</li>
>   <li>Set "Restitution" to 0</li>
>   <li>Set "Lin. Damping" to 0</li>
>   <li>Set "Ang. Damping" to 0</li>
>   <li>Set "Category Mask" to 2</li>
>   <li>Set "Collision Mask" to 1</li>
>   <li>Set "Field Mask" to 0</li>
>   <li>Set "Contact Mask" to 1</li>
> </ul>
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid5.gif?raw=true" /> >     </div>
> </details>
> 1-6. Make a bottomPlayer and a topPlayer similar to the puck. Use the video as an example.
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid5.gif?raw=true" /> >     </div>
> </details>
> 1-7. Create 2 nettings with height of 1, Collision Mask of 2 and contact mask of 2 and set category masks to 3, and 4 (for score counting). Place them where you want to count scores.


## 2, Connect UI components to the ViewController
#### 🗂 Main.storyboard → ViewController.swift  
  ★  control + drag in storyboard to create a control segue
  
> 3-1. Connect "MKMapView"
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center">
>     <img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid3.gif?raw=true" />
>   </div>
>  </details>

> 3-2. Connect "UISegmentControl"
> <details>
>   <summary>View Gif</summary>
>   <div style="text-align:center">
>     <img src ="https://github.com/iosClassForBeginner/mapApp/blob/master/vids/vid4.gif?raw=true" />
>   </div>
> </details>


## 2, Add code blocks in GameScene.swift
#### 🗂 GameScene.swift  
> ★ It's preferable to write following code yourself. It will help you to understand code more.

```Swift  
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Define SpriteNodes
    var puck = SKSpriteNode()
    var playerBottom = SKSpriteNode()
    var playerTop = SKSpriteNode()
    var bottomNet = SKSpriteNode()
    var topNet = SKSpriteNode()
    
    // Define Labels
    var topLable = SKLabelNode()
    var bottomLable = SKLabelNode()
    var pucksPhysics = SKPhysicsBody()
    
    var score = [Int]()
    
    override func sceneDidLoad() {
        
        score = [0,0]
        
        // Link up SpriteNodes
        puck = self.childNode(withName: "puck") as! SKSpriteNode
        playerBottom = self.childNode(withName: "playerBottom") as! SKSpriteNode
        playerTop = self.childNode(withName: "playerTop") as! SKSpriteNode
        bottomNet = self.childNode(withName: "bottomNet") as! SKSpriteNode
        topNet = self.childNode(withName: "topNet") as! SKSpriteNode
        
        // Link up Labels
        topLable = self.childNode(withName: "topLable") as! SKLabelNode
        bottomLable = self.childNode(withName: "bottomLable") as! SKLabelNode
        
        // Add directions to the puck as an impulse in movement
        pucksPhysics = puck.physicsBody!
        puck.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20))
        
        // Define the game bounderies
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        // Apply the boundaries
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
    }

    func addScore(playerWhoWon: SKSpriteNode) {
        
        // Reset the puck position and zero its velocity
        puck.physicsBody = nil
        puck.position = CGPoint(x: 0, y: 0)
        puck.physicsBody = pucksPhysics
        
        
        // Add the score for the right player and push the ball in opponents direction
        if playerWhoWon == playerBottom {
            score[0] += 1
            puck.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
        } else if playerWhoWon == playerTop {
            score[1] += 1
            puck.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20))
        }

        // Display the score
        topLable.text = "\(score[1])"
        bottomLable.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            playerBottom.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            playerBottom.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        playerTop.run(SKAction.moveTo(x: puck.position.x, duration: 1))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if(firstBody.categoryBitMask == 2 && secondBody.categoryBitMask == 3 ||
            firstBody.categoryBitMask == 3 && secondBody.categoryBitMask == 2)
        {
            addScore(playerWhoWon: playerTop)
           
        } else if(firstBody.categoryBitMask == 2 && secondBody.categoryBitMask == 4 ||
            firstBody.categoryBitMask == 4 && secondBody.categoryBitMask == 2)
        {
            addScore(playerWhoWon: playerBottom)
        }
    }
    
}

```
