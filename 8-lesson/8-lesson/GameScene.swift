//
//  GameScene.swift
//  8-lesson
//
//  Created by Denis Dmitriev on 08.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var gameOverView = UIView()
    
    var score = 0
    
    var scoreLabel = UILabel()
    
    override func didMove(to view: SKView) {
        //в момент запуска сцены
        backgroundColor = SKColor.black
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        self.physicsWorld.contactDelegate = self
        
        //Кнопка налево
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        //Кнопка направо
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX-75, y: view.scene!.frame.minY+30)
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        self.addChild(clockwiseButton)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        
        scoreLabel = UILabel(frame: CGRect(x: view.frame.minX+30, y: view.frame.minY+30, width: 100, height: 40))
        scoreLabel.textColor = .gray
        scoreLabel.text = ""
        view.addSubview(scoreLabel)
    }
    
    //Добавление яблока
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //срабатывает когда пользователь прикоснулся к экрану
        for touch in touches {
            let touchLoaction  = touch.location(in: self)
            guard let touchnode = self.atPoint(touchLoaction) as? SKShapeNode, touchnode.name == "counterClockwiseButton" || touchnode.name == "clockwiseButton" else { return }
            touchnode.fillColor = .darkGray
            
            if touchnode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchnode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
        
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //пользователь отпустил экран
        for touch in touches {
            let touchLoaction  = touch.location(in: self)
            guard let touchnode = self.atPoint(touchLoaction) as? SKShapeNode, touchnode.name == "counterClockwiseButton" || touchnode.name == "clockwiseButton" else { return }
            touchnode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //пауза игры
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // обновление сцены при прогрессе
        snake!.move()
        score = snake!.body.count
        scoreLabel.text = "Score \(score-1)"
    }
    
    //MARK: - Домашнее задание
    
    func restart() {
        
        gameOverView = UIView(frame: CGRect(x: view!.bounds.midX-100, y: view!.bounds.midY-50, width: 200, height: 150))
        gameOverView.backgroundColor = UIColor.gray
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        textLabel.text = "Game Over Score \(score-1)"
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 2
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.center = CGPoint(x: gameOverView.bounds.midX, y: gameOverView.bounds.minY+textLabel.frame.height)
        
        let restartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        restartButton.center = CGPoint(x: gameOverView.bounds.midX, y: gameOverView.bounds.maxY-restartButton.frame.height)
        restartButton.setTitle("Restart", for: .normal)
        restartButton.tintColor = UIColor.systemBlue
        restartButton.backgroundColor = .darkGray
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        
        gameOverView.addSubview(textLabel)
        gameOverView.addSubview(restartButton)
        view!.addSubview(gameOverView)
        gameOverView.isHidden = true
    }
    
    @objc func restartGame() {
        print("restart action")
        gameOverView.removeFromSuperview()
        self.didMove(to: view!)
        score = 0
    }
    
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bodyes - CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.EdgeBody:
            //домашнее задание
            print("Game over")
            restart()
            scoreLabel.removeFromSuperview()
            self.removeAllChildren()
            gameOverView.isHidden = false
            break
        default:
            break
        }
    }
}
