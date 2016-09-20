/*:
 ![Make School Banner](./swift_banner.png)
 # Create something cool
 
 - experiment: Use everything you learned to draw something awesome! See below for a few more functions you can use to bring your art to life!
 
 ## Drop and lift the pen
 
 - callout(Drop the pen): `penDown()`
 
 - callout(Lift the pen): `penUp()`
 
 - note: The pen starts out down
 
 ## Moving the pen
 
 - callout(Move by a number of steps): `move(steps: Int)`
 
 - callout(Move directly to coordinates): `moveTo(x x: Int, y: Int)`
 
 - note: This is called with labels for both parameters! eg. `moveTo(x x: 10, y: 40)`
 
 - callout(Rotate heading by an angle): `rotate(degrees: Int)`
 
 ## Change the pen
 
 - callout(Set color of pen): `setColor(red red: Double, green: Double, blue: Double)`
 
 - note: This is called with labels for all 3 parameters! Each value should be between 0 and 1. eg. `setColor(red: 0.0, green: 0.0, blue: 0.0)` would change the pen to be black. `setColor(red: 1.0, green: 0.0, blue: 0.0)` would change the pen to be red. 
 
 - callout(Set thickness of pen): `setThickness(thickness: Double)`
 
 */
//: [Previous](@previous)
func drawPolygon(numberOfSides: Int, _ sideLength: Int){
    let angular: Double = Double(180 - 180 * (numberOfSides - 2) / numberOfSides)
    for _ in 1...numberOfSides {
        move(sideLength)
        rotate(angular)
    }
}
penUp()
moveTo(x: 50.0, y: 50.0)
setColor(red: 30.0, green: 0.0, blue: 5.0)
setThickness(3.0)

penDown()
drawPolygon(6, 30)
penUp()

moveTo(x: 100, y: 200)
setColor(red: 32, green: 19, blue: 10)
setThickness(5)
penDown()
drawPolygon(20, 40)
penUp()





















































































//: This is setup code to make the live visualization work!
Pen.delay = 0.1
import XCPlayground
import Foundation
let results = DrawingScene.setup()
XCPlaygroundPage.currentPage.liveView = results
