import Foundation
import SpriteKit

let queue = dispatch_queue_create("Drawing", DISPATCH_QUEUE_SERIAL)
var firstCommand = true

func delay() {
    if Pen.delay == 0.0 { return }
    let delay = UInt32(Pen.delay * Double(USEC_PER_SEC))
    usleep(delay)
}

func delayStart() {
    if !firstCommand { return }
    dispatch_async(queue) { () -> Void in
        usleep(UInt32(2.0 * Double(USEC_PER_SEC)))
    }
    firstCommand = false
}

public func penDown() {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.penDown()
    }
}

public func penUp() {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.penUp()
    }
}

public func moveFifty() {
    move(50)
}

public func move(steps: Int) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.move(steps)
    }
}

public func moveToX(x: Int, y: Int) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.moveTo(x: x, y: y)
    }
}

public func moveTo(x x: Double, y: Double) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.moveTo(x: x, y: y)
    }
}

public func rotateNinety() {
    rotate(90)
}

public func rotate(degrees: Int) {
    rotate(Double(degrees))
}

public func rotate(degrees: Double) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.rotate(degrees)
    }
}

public func setColor(red red: Double, green: Double, blue: Double) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.setColor(red: red, green: green, blue: blue)
    }
}

public func setColor(nsColor c: NSColor) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.setColor(nsColor: c)
    }
}

public func setThickness(thickness: Double) {
    delayStart()
    dispatch_async(queue) { () -> Void in
        delay()
        Pen.sharedInstance.setThickness(thickness)
    }
}
