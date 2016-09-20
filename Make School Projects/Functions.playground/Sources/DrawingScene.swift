import SpriteKit
import Foundation

public class DrawingScene: SKScene {
    
    public var pen: Pen!
    var background: SKSpriteNode!
    public var penSprite: SKSpriteNode!
    var lastShapeNode = 0
    
    override public func didMoveToView(view: SKView) {
        penSprite = childNodeWithName("pen") as! SKSpriteNode
        background = childNodeWithName("background") as! SKSpriteNode
        pen = Pen.sharedInstance
    }
    
    public override func update(currentTime: NSTimeInterval) {
        penSprite.position = pen.position
        penSprite.zRotation = pen.rotation
        
        if lastShapeNode < pen.shapeNodes.count || pen.processing {
            pen.newShapeNode()
            let image = NSImage(CGImage: background.texture!.CGImage(), size: self.size)
            image.lockFocus()
            NSGraphicsContext.currentContext()?.shouldAntialias = true
            for i in lastShapeNode..<(pen.shapeNodes.count-1) {
                let data = pen.shapeNodes[i]!
                if data.numberOfPoints > 0 {
                    let path = data.path
                    data.color.set()
                    path.stroke()
                }
                lastShapeNode += 1
                pen.shapeNodes[i] = nil
            }
            image.unlockFocus()
            
            background.texture = SKTexture(image: image)
            
            if !pen.processing {
                pen.shapeNodes = [ShapeNodeData?]()
            }
        }
    }
    
    public class func setup() -> SKView {
        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        sceneView.wantsLayer = true
        let scene = DrawingScene(fileNamed: "DrawingScene")!
        scene.scaleMode = .AspectFill
        sceneView.presentScene(scene)
        return sceneView
    }
}