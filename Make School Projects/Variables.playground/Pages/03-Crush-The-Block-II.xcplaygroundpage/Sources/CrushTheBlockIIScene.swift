//
//  CrushTheBlockIIScene.swift
//  L01-Variables
//
//  Created by Dion Larson.
//  Copyright © 2016 Make School. All rights reserved.
//


import SpriteKit

let blockCategory: UInt32 = 1 << 1

public class CrushTheBlockIIScene: SKScene, SKPhysicsContactDelegate {
    
    public var crusherVelocity = 0
    public var crusher: SKNode?
    var crushee: SKNode?
    var crushedAnimation: SKNode?
    var animation: SKSpriteNode?
    var instructions: SKLabelNode?
    
    override public func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        
        crusher = childNodeWithName("crusher")
        crusher?.physicsBody?.contactTestBitMask = blockCategory
        
        crusher?.physicsBody?.applyImpulse(CGVectorMake(CGFloat(crusherVelocity), 0.0))
        
        crushee = childNodeWithName("crushee")
        crushee?.physicsBody?.contactTestBitMask = blockCategory
        
        crushedAnimation = childNodeWithName("crushedAnimation")
        animation = SKSpriteNode(fileNamed: "crushed.sks")!
        
        instructions = childNodeWithName("instructions") as? SKLabelNode
    }
    
    public func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.contactTestBitMask == blockCategory && contact.bodyB.contactTestBitMask == blockCategory  && instructions?.text != "Success!" {
            crushee?.removeFromParent()
            
            if let animation = animation {
                let child = animation.childNodeWithName("animation")!
                child.removeFromParent()
                crushedAnimation?.addChild(child)
            }
            
            instructions?.text = "Success!"
        }
    }
    
    public class func setup(crusherVelocity: Int) -> SKView {
        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        sceneView.wantsLayer = true
        let scene = CrushTheBlockIIScene(fileNamed: "CrushTheBlockIIScene")!
        scene.scaleMode = .AspectFill
        
        scene.crusherVelocity = crusherVelocity
        
        sceneView.presentScene(scene)
        return sceneView
    }
}