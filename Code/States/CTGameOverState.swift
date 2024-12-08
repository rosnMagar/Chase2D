//
//  CTGameOverState.swift
//  Chase2D
//
//  Created by Roshan Thapa Magar on 11/3/24.
//

import GameplayKit

class CTGameOverState: GKState {
    
    let context: CTGameContext
    let scene: CTGameScene
    
    var gamePlayState: CTGamePlayState?
    var restartPressed = false
    
    init(scene: CTGameScene, context: CTGameContext) {
        self.scene = scene
        self.context = context
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        handlePlayerDeath()
        gamePlayState = previousState as? CTGamePlayState
        
//        scene.gameInfo.restartButton.isHidden = false
        restartPressed = false

    }
    
    override func update(deltaTime seconds: TimeInterval) {
        gamePlayState?.handleCameraMovement()
        
        //TODO: we still need restartButton???
//        if (scene.gameInfo.restartButton.tapped && !restartPressed)
//        {
//            resetGame()
//        }
    }
    
    func handlePlayerDeath(){
        
        scene.gameInfo.setGameOver()
        
        if let drivingComponent = scene.playerCarEntity?.component(ofType: CTDrivingComponent.self){
            drivingComponent.drive(driveDir: .none)
        }
        // change cop car speed
        for copCar in scene.copCarEntities {
            if let drivingComponent = copCar.component(ofType: CTDrivingComponent.self) {
                drivingComponent.MOVE_FORCE = 0.00001
            }
            if let steeringComponent = copCar.component(ofType: CTSteeringComponent.self) {
                steeringComponent.STEER_IMPULSE = 0.00001
            }
        }
        for copCar in scene.copTruckEntities {
            if let drivingComponent = copCar.component(ofType: CTDrivingComponent.self) {
                drivingComponent.MOVE_FORCE = 0.0001
            }
            if let steeringComponent = copCar.component(ofType: CTSteeringComponent.self) {
                steeringComponent.STEER_IMPULSE = 0.00001
            }
        }
        for copCar in scene.copTankEntities {
            if let drivingComponent = copCar.component(ofType: CTDrivingComponent.self) {
                drivingComponent.MOVE_FORCE = 0.0001
            }
            if let steeringComponent = copCar.component(ofType: CTSteeringComponent.self) {
                steeringComponent.STEER_IMPULSE = 0.00001
            }
        }
    }
    
    func resetGame() {
        restartPressed = true
       
        context.restartGame()
        context.stateMachine?.enter(CTStartMenuState.self)
    }
    
}
