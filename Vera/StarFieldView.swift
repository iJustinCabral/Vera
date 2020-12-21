//
//  StarFieldView.swift
//  Vera
//
//  Created by Justin Cabral on 12/20/20.
//

import SwiftUI
import SpriteKit

struct StarFieldView: View {
    
    var body: some View {
        EmitterView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct EmitterView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let host = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))

        let particlesLayer = CAEmitterLayer()
        particlesLayer.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

        host.layer.addSublayer(particlesLayer)
        host.layer.masksToBounds = true

        particlesLayer.backgroundColor = UIColor(Color.black).cgColor
        particlesLayer.emitterShape = .circle
        particlesLayer.emitterPosition = CGPoint(x: 509.4, y: 707.7)
        particlesLayer.emitterSize = CGSize(width: 1648.0, height: 1112.0)
        particlesLayer.emitterMode = .volume
        particlesLayer.renderMode = .oldestLast



        let image1 = UIImage(systemName: "circlebadge.fill")?.cgImage

        let cell1 = CAEmitterCell()
        cell1.contents = image1
        cell1.name = "Snow"
        cell1.birthRate = 92.0
        cell1.lifetime = 9999999
        cell1.velocity = 0
        cell1.velocityRange = -15.0
        cell1.xAcceleration = 0
        cell1.yAcceleration = 0
        cell1.emissionRange = 360
        cell1.spin = -28.6 * (.pi / 180.0)
        cell1.spinRange = 57.2 * (.pi / 180.0)
        cell1.scale = 0.06
        cell1.scaleRange = 0.15
        cell1.color = UIColor(Color.white).cgColor

        particlesLayer.emitterCells = [cell1]
        return host
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    typealias UIViewType = UIView
}

struct StarFieldView_Previews: PreviewProvider {
    static var previews: some View {
        StarFieldView()
    }
}
