//
//  SteeringComponent.swift
//  Chase2D
//
//  Created by Roshan Thapa Magar on 11/11/24.
//

import GameplayKit
import SpriteKit

class CTSteeringComponent: GKComponent {
    
    let carNode: DriveableNode
    var STEER_IMPULSE = 0.04
    var DRIFT_FORCE:CGFloat = 0.04
    var DRIFT_VELOCITY_THRESHOLD: CGFloat = 6
    
    var angle = 0.0
    var lastTime = 0.0
    var lastTimeSet = false
    
    init(carNode: DriveableNode) {
        self.carNode = carNode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func steer(moveDirection: CGFloat) {
        guard let physicsBody = self.carNode.physicsBody else { return }

        // Get current velocity and speed
        let velocity = physicsBody.velocity
        let speed = sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy)


        // Apply torque to simulate steering and drifting
        let torque = moveDirection * STEER_IMPULSE * -1.5 * min(max(speed, 0), 1)
        physicsBody.applyAngularImpulse(torque)
        
    }

    // Helper: Dot product for velocity calculation
    func dotProduct(_ vector1: CGVector, _ vector2: CGVector) -> CGFloat {
        return vector1.dx * vector2.dx + vector1.dy * vector2.dy
    }
    
}
