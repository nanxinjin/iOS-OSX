import SpriteKit

public class ShapeNodeData {
    let path: NSBezierPath
    let color: NSColor
    var numberOfPoints = 0
    
    init(startPoint: CGPoint, thickness: Double, color: NSColor) {
        self.path = NSBezierPath()
        self.path.lineJoinStyle = .RoundLineJoinStyle
        self.path.lineCapStyle = .RoundLineCapStyle
        self.path.moveToPoint(startPoint)
        self.path.lineWidth = CGFloat(thickness)
        self.color = color
    }
}

public class Pen {
    public static let sharedInstance = Pen()
    public static var delay: Double = 2
    
    public var processing = true {
        didSet {
            if !processing {
                newShapeNode()
            }
        }
    }
    
    public var currentShapeData: ShapeNodeData!
    public var penIsDown = true
    public var speed: useconds_t = 50000
    public var position = CGPoint(x: 160, y: 288)
    public var rotation: CGFloat = CGFloat(M_PI)
    
    var shapeNodes = [ShapeNodeData?]()
    
    public var thickness = 1.0 {
        didSet {
            newShapeNode()
        }
    }
    
    public var color = SKColor.blueColor() {
        didSet {
            newShapeNode()
        }
    }
    
    init() {
        newShapeNode()
    }
    
    public func penDown() {
        if penIsDown { return }
        penIsDown = true
        newShapeNode()
    }
    
    public func penUp() {
        if !penIsDown { return }
        penIsDown = false
    }
    
    public func moveTenSteps() {
        move(10)
    }
    
    public func rotateNintyDegrees() {
        rotate(90)
    }
    
    public func move(steps: Int) {
        let oldPosition = position
        position = position + CGPoint(angle: (rotation + π / 2)) * CGFloat(steps)
        moved(from: oldPosition, to: position)
    }
    
    public func moveTo(x x: Int, y: Int) {
        moveTo(x: Double(x), y: Double(y))
    }
    
    public func moveTo(x x: Double, y: Double) {
        let oldPosition = position
        position = CGPoint(x: x, y: y)
        moved(from: oldPosition, to: position)
    }
    
    public func rotate(degrees: Int) {
        rotate(Double(degrees))
    }
    
    public func rotate(degrees: Double) {
        rotation = rotation + CGFloat(degrees).degreesToRadians()
        let limit = π * 2
        if rotation > limit {
            rotation -= limit
        } else if rotation < -limit {
            rotation += limit
        }
    }
    
    public func setColor(red red: Double, green: Double, blue: Double) {
        color = SKColorWithRGB(Int(red*255), g: Int(green*255), b: Int(blue*255))
    }
    
    public func setColor(nsColor c: NSColor) {
        color = c
    }
    
    public func setThickness(thickness: Double) {
        self.thickness = thickness
    }
    
    func moved(from from: CGPoint, to: CGPoint) {
        if penIsDown {
            currentShapeData.path.lineToPoint(to)
        } else {
            currentShapeData.path.moveToPoint(to)
        }
        currentShapeData.numberOfPoints += 1
        if speed > 0 {
            usleep(speed)
        }
    }
    
    func newShapeNode() {
        currentShapeData = ShapeNodeData(startPoint: position, thickness: thickness, color: color)
        shapeNodes.append(currentShapeData)
    }
    
}