//
//  CrushTheBlockIScene.swift
//  L01-Variables
//
//  Created by Dion Larson.
//  Copyright © 2016 Make School. All rights reserved.
//


import SpriteKit

let blockCategory: UInt32 = 1 << 1

public class CrushTheBlockIScene: SKScene, SKPhysicsContactDelegate {
    
    public var crusherPosition = 0
    public var crusher: SKNode?
    var crushee: SKNode?
    var crushedAnimation: SKNode?
    var instructions: SKLabelNode?
    var animation: SKSpriteNode?
    
    override public func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        
        crusher = childNodeWithName("crusher")
        crusher?.physicsBody?.contactTestBitMask = blockCategory
        
        crusher?.position = CGPoint(x: CGFloat(crusherPosition), y: 480)
        
        crushee = childNodeWithName("crushee")
        crushee?.physicsBody?.contactTestBitMask = blockCategory
        
        crushedAnimation = childNodeWithName("crushedAnimation")
        animation = SKSpriteNode(fileNamed: "crushed.sks")!
        
        instructions = childNodeWithName("instructions") as? SKLabelNode
    }
    
    public func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.contactTestBitMask == blockCategory && contact.bodyB.contactTestBitMask == blockCategory && instructions?.text != "Success!" {
            crushee?.removeFromParent()
            
            if let animation = animation {
                let child = animation.childNodeWithName("animation")!
                child.removeFromParent()
                crushedAnimation?.addChild(child)
            }
            
            instructions?.text = "Success!"
        }
    }
    
    public class func setup(crusherPosition: Int) -> SKView {
        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        sceneView.wantsLayer = true
        let scene = CrushTheBlockIScene(fileNamed: "CrushTheBlockIScene")!
        scene.scaleMode = .AspectFill
        
        scene.crusherPosition = crusherPosition
        
        sceneView.presentScene(scene)
        return sceneView
    }
}