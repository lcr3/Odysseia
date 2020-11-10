//
//  ConfettiView.swift
//  Odysseia
//
//  Created by lcr on 2020/11/09.
//

import SceneKit

class ConfettiView: SCNView {
    static func make() -> ConfettiView {
        let confettiView = ConfettiView(frame: UIScreen.main.bounds)
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
        if let confetti = SCNParticleSystem(named: "Confetti.scnp", inDirectory: "SceneKit.scnassets") {
            confetti.loops = false
            let confettiScene = SCNScene()
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            cameraNode.position = SCNVector3(x: 0, y: -6, z: 10)
            confettiScene.rootNode.addChildNode(cameraNode)
            confettiScene.rootNode.addParticleSystem(confetti)
            confetti.imageSequenceAnimationMode = .repeat
            confetti.loops = true
            self.scene = confettiScene
        }
    }
}
