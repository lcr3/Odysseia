//
//  StarView.swift
//  Odysseia
//
//  Created by lcr on 2020/11/09.
//

import SceneKit

class StarView: SCNView {
    override init(frame: CGRect) {
        super.init(frame: frame, options: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        autoenablesDefaultLighting = true
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }

    static func make() -> StarView {
        let confettiView = StarView(frame: UIScreen.main.bounds)
        confettiView.autoenablesDefaultLighting = true
        confettiView.backgroundColor = .clear
        confettiView.isUserInteractionEnabled = false
        return confettiView
    }

    func startAnimation() {
        scene?.rootNode.removeAllParticleSystems()
        if let particleSystem = scene?.rootNode.particleSystems?.first {
            particleSystem.loops = true
        } else {
            addAnimation()
        }
    }

    func stopAnimation() {
        if let particleSystem = scene?.rootNode.particleSystems?.first {
            particleSystem.loops = false
        }
    }

    private func addAnimation() {
        if let confetti = SCNParticleSystem(named: "Stars.scnp", inDirectory: "SceneKit.scnassets") {
            confetti.loops = false
            let confettiScene = SCNScene()
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
            confettiScene.rootNode.addChildNode(cameraNode)
            confettiScene.rootNode.addParticleSystem(confetti)
            confetti.imageSequenceAnimationMode = .repeat
            confetti.loops = true
            self.scene = confettiScene
        }
    }
}
