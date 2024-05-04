//
//  MetalGradientView.swift
//  MetalGradient
//
//  Created by Andrew Zheng (github.com/aheze) on 5/4/24.
//  Copyright © 2024 Andrew Zheng. All rights reserved.
//

import MetalKit
import SwiftUI

class MetalGradientView: NSView {
    var metalView = MTKView()

    lazy var renderer: MetalRipplesRenderer? = {
        // Then we create the default device, and configure mtkView with it
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            print("Metal is not supported on this device")
            return nil
        }

        print("My GPU is: \(defaultDevice)")
        metalView.device = defaultDevice

        // Lastly we create an instance of our Renderer object, and set it as the delegate of mtkView
        guard let renderer = MetalRipplesRenderer(metalView: metalView) else {
            print("Renderer failed to initialize")
            return nil
        }

        return renderer
    }()

    init() {
        super.init(frame: .zero)

        addSubview(metalView)
        metalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            metalView.topAnchor.constraint(equalTo: topAnchor),
            metalView.rightAnchor.constraint(equalTo: rightAnchor),
            metalView.bottomAnchor.constraint(equalTo: bottomAnchor),
            metalView.leftAnchor.constraint(equalTo: leftAnchor)
        ])

        metalView.delegate = renderer

        // enable transparency
        metalView.layer?.isOpaque = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MetalGradientViewRepresentable: NSViewRepresentable {
    func makeNSView(context: Context) -> MetalGradientView {
        MetalGradientView()
    }

    func updateNSView(_ nsView: MetalGradientView, context: Context) {}
}
