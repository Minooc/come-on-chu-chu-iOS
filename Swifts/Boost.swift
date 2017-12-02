import SpriteKit

class Boost: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var obstacleAnimation = [SKTexture]()
    private var animateObstacleAction = SKAction()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.anchorPoint = CGPoint(x: 0.5, y:0.5)
        self.size.width = 1337
        self.size.height = 750
        self.position = CGPoint(x: 0, y: 0)
        self.zPosition = 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initializePlayerAndAnimations(atlasName: String, prefix: String, timePerFrame: TimeInterval) {
        
        // retrieve pieces of player image from Player.atltas
        textureAtlas = SKTextureAtlas(named: atlasName)
        
        // store images to array
        for i in 1...textureAtlas.textureNames.count {
            let name = "\(prefix)\(i)"
            obstacleAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateObstacleAction = SKAction.animate(with: obstacleAnimation, timePerFrame: timePerFrame, resize: true, restore: false)
        
        
    }
    
    func animateObject(atlasName : String, prefix: String, timePerFrame: TimeInterval) {
        initializePlayerAndAnimations(atlasName: atlasName, prefix: prefix, timePerFrame: timePerFrame)
        self.run(SKAction.repeatForever(animateObstacleAction), withKey: "Animate")
    }
    
    func stopAnimation() {
        self.removeAllActions()
    }
    
}


