//
//  CTPedCarEntity.swift
//  Chase2D
//
//  Created by Roshan Thapa Magar on 11/11/24.
//
import GameplayKit
import SpriteKit

class CTPedCarEntity: GKEntity {
    let carNode: SKSpriteNode
    let CHECKPOINT_RADIUS_SQUARED = 500.0
    
    var gameInfo:CTGameInfo?
    var currentTarget: CGPoint = CGPoint(x: 100, y: 50)
    var checkPointsList: [SKNode] = []
    var currentTargetIndex = 0
    
    init(carNode: SKSpriteNode) {
        self.carNode = carNode
        super.init()
    }
    
    func prepareComponents(){
        let drivingComponent = CTDrivingComponent(carNode: carNode)
        drivingComponent.MOVE_FORCE =  gameInfo?.pedSpeed ?? 800
        
        let steeringComponent = CTSteeringComponent(carNode: carNode)
        steeringComponent.STEER_IMPULSE = 0.04
        steeringComponent.DRIFT_FORCE = 0.01
        steeringComponent.DRIFT_VELOCITY_THRESHOLD = 10
            
        addComponent(drivingComponent)
        addComponent(steeringComponent)
        addComponent(CTSelfDrivingComponent(carNode: carNode))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // change currentTarget if the pedCar reaches the checkpoint
    func updateCurrentTarget(){
        if calculateSquareDistance(pointA: self.carNode.position, pointB: currentTarget) < CHECKPOINT_RADIUS_SQUARED && checkPointsList.count != 0{
            currentTargetIndex += 1
            
            currentTargetIndex = currentTargetIndex % (checkPointsList.count - 1)
            currentTarget = checkPointsList[currentTargetIndex].position
            
            // debug
            let sq = SKShapeNode(rect: CGRect(x: currentTarget.x, y: currentTarget.y, width: 1, height: 1))
            sq.fillColor = .red
            self.carNode.scene?.addChild(sq)
            
        }
        
    }
    
    func calculateSquareDistance(pointA: CGPoint, pointB: CGPoint) -> CGFloat{
        return pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2)
    }
    
}
