//
//  GameScene.swift
//  table hockey
//
//  Created by Sam on 2017-09-12.
//  Copyright © 2017 Sam. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Define SpriteNodes
    var puck = SKSpriteNode()
    var playerBottom = SKSpriteNode()
    var playerTop = SKSpriteNode()
    
    // Define Labels
    var topLable = SKLabelNode()
    var bottomLable = SKLabelNode()
    
    var score = [Int]()
    
    override func sceneDidLoad() {
        
        score = [0,0]
        
        // Link up SpriteNodes
        puck = self.childNode(withName: "puck") as! SKSpriteNode
        playerBottom = self.childNode(withName: "playerBottom") as! SKSpriteNode
        playerTop = self.childNode(withName: "playerTop") as! SKSpriteNode
        
        // Link up Labels
        topLable = self.childNode(withName: "topLable") as! SKLabelNode
        bottomLable = self.childNode(withName: "bottomLable") as! SKLabelNode
        
        // Add directions to the puck as an impulse in movement
        puck.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        
        // Define the game bounderies
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        // Apply the boundaries
        self.physicsBody = border
    }

    func addScore(playerWhoWon: SKSpriteNode) {
        
        // Reset the puck position and zero its velocity
        puck.position = CGPoint(x: 0, y: 0)
        puck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        // Add the score for the right player and push the ball in opponents direction
        if playerWhoWon == playerBottom {
            score[0] += 1
            puck.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        } else if playerWhoWon == playerTop {
            score[1] += 1
            puck.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
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
        
        playerTop.run(SKAction.moveTo(x: puck.position.x, duration: 0.2))
        
        if puck.position.y <= playerBottom.position.y - 70 {
            addScore(playerWhoWon: playerTop)
        }
        else if puck.position.y >= playerTop.position.y + 70 {
            addScore(playerWhoWon: playerBottom)
        }
    }
}
