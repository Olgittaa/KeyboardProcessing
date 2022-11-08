import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var avatar: SKSpriteNode!
    var timer: Timer!
    var x = 0
    var y = 0
    var dx = 0
    var dy = 0
    var left = Key()
    var right = Key()
    var up = Key()
    var down = Key()
    
    override func didMove(to view: SKView) {
        avatar = SKSpriteNode(color: .red, size: CGSize(width: self.size.width/50, height: self.size.width/50))
        addChild(avatar)
        avatar.position = CGPoint(x: x, y: y)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    fileprivate func keysUpdateOnTimerTik() {
        left.tik()
        right.tik()
        up.tik()
        down.tik()
    }
    
    fileprivate func doMove() {
        let step = Int(avatar.size.width) / 2
        if left.status == 1 || left.status == 2 || left.status == 3{
            dx -= step
        }
        if right.status == 1 || right.status == 2 || right.status == 3{
            dx += step
        }
        if up.status == 1 || up.status == 2 || up.status == 3{
            dy += step
        }
        if down.status == 1 || down.status == 2 || down.status == 3{
            dy -= step
        }
    }
    
    @objc func fireTimer() {
        doMove()
        x += dx
        y += dy
        moveAvatar(x: x, y: y)
        keysUpdateOnTimerTik()
        print(left.status)
        dx = 0
        dy = 0
    }
    
    fileprivate func moveAvatar(x: Int, y: Int) {
        avatar.position = CGPoint(x: x, y: y)
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode{
        case 123:
            left.pressed()
        case 124:
            right.pressed()
        case 125:
            down.pressed()
        case 126:
            up.pressed()
        default:
            print(event.keyCode)
        }
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode{
        case 123:
            left.release()
        case 124:
            right.release()
        case 125:
            down.release()
        case 126:
            up.release()
        default:
            print(event.keyCode)
        }
    }
    
    
    
    class Key{
        var status = 0 // 0 - pusteny, 1 - stlaceny, 2 - impulz, 3 - drzany
        
        func tik(){
            if status == 1{
                status = 3
            } else if status == 2{
                status = 0
                // pohyb
            } else if status == 3{
                //pohyb
            }
        }
        
        func pressed(){
            if status == 0{
                status = 1
            } else if status == 2 {
                status = 1
            }
        }
        
        func release(){
            if status == 1{
                status = 2
            } else if status == 3 {
                status = 0
            }
        }
    }
}
