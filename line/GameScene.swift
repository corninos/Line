//
//  GameScene.swift
//  line
//
//  Created by Corninos on 23/12/16.
//  Copyright © 2016 Corninos. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var dito: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity =  CGVector(dx: 0, dy: -9.81)//.zero //CGVector(dx: 0, dy: -2)
        self.name = "Main Scene"
        self.backgroundColor = #colorLiteral(red: 0.254901975393295, green: 0.274509817361832, blue: 0.301960796117783, alpha: 1.0)
        self.size = Screen.size
        // print(Screen.size)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody!.categoryBitMask = Bitmask.screen
        
        
        var splinePoints = [CGPoint(x: 0, y: 500),
                            CGPoint(x: 100, y: 400),
                            CGPoint(x: 200, y: 200),
                            CGPoint(x: 300, y: 10)]
        var splinePoints2 = [CGPoint(x: 300, y: 500),
                             CGPoint(x: 200, y: 400)]

        var ground = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0.75
        ground.physicsBody?.isDynamic = false
        
        self.addChild(ground)
         ground = SKShapeNode(splinePoints: &splinePoints2,
                                 count: splinePoints2.count)
        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0.75
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)

    }
    
    override func update(_ currentTime: TimeInterval) {
        //spawnSand(location: CGPoint(x: self.size.width / 2, y: 700),color: UIColor.black, gravity: true, name:"nero")
        //self.enumerateChildNodes(withName: "giallo") { granello, _ in
         //   if granello.physicsBody!.velocity.dy > 0.2 {
         //       granello.physicsBody!.velocity = CGVector(dx: 0, dy: granello.physicsBody!.velocity.dy * 1.1)}
         //   }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            spawnSand(location: touch.location(in: self), color: UIColor.yellow, gravity: false, name:"giallo")
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count > 1 {
            spawnArrow(location: touches.first!.location(in: self), color: UIColor.red, gravity: false, name: "freccia")
        }
    }
    
    func spawnSand(location: CGPoint, color: UIColor, gravity: Bool, name: String) {
        let quadrato  = SKSpriteNode(color: color, size: CGSize(width: 10, height: 10 ))
        quadrato.position = location
        // Physics
        quadrato.physicsBody = SKPhysicsBody(rectangleOf: quadrato.size)
        quadrato.physicsBody!.categoryBitMask = Bitmask.squares
        quadrato.physicsBody!.linearDamping = 0
        quadrato.physicsBody!.angularDamping = 0
        quadrato.physicsBody!.restitution = 0.5
        quadrato.physicsBody!.friction = 0.1
        quadrato.physicsBody!.allowsRotation = true
        if gravity == false{
            quadrato.physicsBody!.affectedByGravity = true
            quadrato.physicsBody!.velocity = CGVector(dx: 0, dy: 0.2)
        }
        quadrato.name = name
        self.addChild(quadrato)
    }
    
    func spawnArrow(location: CGPoint, color: UIColor, gravity: Bool, name: String){
        var points = [CGPoint(x: 10, y: 20),
                     CGPoint(x: 40, y: 20),
                     CGPoint(x: 30, y: 30),
                     CGPoint(x: 40, y: 20),
                     CGPoint(x: 30, y: 10),
                     CGPoint(x: 40, y: 20),
                     CGPoint(x: 25, y: 20),]
                     //CGPoint(x: 50, y: 10)]
        let arrow = SKShapeNode(points: &points,
                                          count: points.count)
        arrow.lineWidth = 1
        arrow.strokeColor = color
        //arrow.glowWidth = 0.5
        arrow.position = location
        arrow.name = name
       // arrow.run(SKAction.rotate(toAngle: 500, duration: 10, shortestUnitArc: false))   //Physics
//        arrow.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//    arrow.physicsBody!.categoryBitMask = Bitmask.squares
//        arrow.physicsBody!.linearDamping = 0
//        arrow.physicsBody!.angularDamping = 0
//        arrow.physicsBody!.restitution = 0.5
//        arrow.physicsBody!.friction = 0.1
//        arrow.physicsBody!.allowsRotation = true
        
        self.addChild(arrow)

            }
  }
