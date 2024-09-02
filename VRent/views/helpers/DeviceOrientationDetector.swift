//
//  DeviceOrientationDetector.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI
import Combine


// For Orientation Checks
class DeviceOrientationDetector: ObservableObject {
    static let shared = DeviceOrientationDetector()
    
    @Published private(set) var current: UIDeviceOrientation = .unknown
    
    private var cancallables: Set<AnyCancellable> = []
    
    private init() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene else { return }
        
        let orientation = sceneDelegate.interfaceOrientation
        
        current = switch(orientation) {
            case .portrait: .portrait
            case .landscapeRight: .landscapeRight
            case .landscapeLeft: .landscapeLeft
            case .portraitUpsideDown: .portraitUpsideDown
            case .unknown: .unknown
            @unknown default:
                    .unknown
        }
        
        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .sink() { [weak self] _ in
                self?.current = UIDevice.current.orientation
            }
            .store(in: &cancallables)
    }
}

@propertyWrapper struct Orientation: DynamicProperty {
    @StateObject private var orientationDetector: DeviceOrientationDetector = .shared
    
    var wrappedValue: UIDeviceOrientation {
        orientationDetector.current
    }
}



#Preview {
    @State var orientation = UIDeviceOrientation.unknown

    return Group {
        if orientation.isPortrait {
            Text("Portrait")
        } else if orientation.isLandscape {
            Text("Landscape")
        } else if orientation.isFlat {
            Text("Flat")
        } else {
            Text("Unknown")
        }
    }
    
}
