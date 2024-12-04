//
//  CTCopNode.swift
//  Chase2D
//
//  Created by Roshan Thapa Magar on 12/3/24.
//

import SpriteKit

class CTCopNode: SKSpriteNode, EnemyNode {
    
    init(imageName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageName)
        texture.filteringMode = .nearest
        super.init(texture: texture, color: .clear, size: size)
        enablePhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder not set")
    }
    
    func enablePhysics() {
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2.0)
       
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 5 // Adjust for realistic movement
        physicsBody?.friction = 0
        physicsBody?.restitution = 1 // Controls bounciness
        physicsBody?.angularDamping = 1 // Dampen rotational movement
        physicsBody?.linearDamping = 1 // Dampen forward movement slightly
        physicsBody?.categoryBitMask = CTPhysicsCategory.cop
        physicsBody?.collisionBitMask = CTPhysicsCategory.car | CTPhysicsCategory.building | CTPhysicsCategory.ped | CTPhysicsCategory.copCar | CTPhysicsCategory.copTank | CTPhysicsCategory.copTruck | CTPhysicsCategory.cop
        physicsBody?.contactTestBitMask = CTPhysicsCategory.car | CTPhysicsCategory.building | CTPhysicsCategory.ped | CTPhysicsCategory.copCar | CTPhysicsCategory.copTank | CTPhysicsCategory.copTruck | CTPhysicsCategory.cop
        
        
    }
    
}

