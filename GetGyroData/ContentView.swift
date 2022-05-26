//
//  ContentView.swift
//  GetGyroData
//
//  Created by Yoddikko on 26/05/22.
//


//MARK: - Remember to change the info.plsit and add Privacy - Motion usage description.

import SwiftUI
import CoreMotion

public var onGoing = false

struct ContentView: View {
    var motion = Motion()
    @State var onGoing = false
    var body: some View {
        
        if onGoing == false {
            Image(systemName: "play.fill")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
                .foregroundColor(.green)
                .onTapGesture {
                    motion.startGyros()
                    onGoing.toggle()
                }
            
            
        }
        else {
            Image(systemName: "pause.fill")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
                .foregroundColor(.red)
                .onTapGesture {
                    motion.stopGyros()
                    onGoing.toggle()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



class Motion {
    var motion = CMMotionManager()
    @Published var timer = Timer()
    
    func startGyros() {
        if motion.isGyroAvailable {
            self.motion.gyroUpdateInterval = 0.10
            //          self.motion.startGyroUpdates()
            motion.startGyroUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            self.timer = Timer(fire: Date(), interval: (0.10),
                               repeats: true, block: { (timer) in
                // To change the frequency wich the data is fetched change this interval "0.10" seconds and the one on the top of self.motion.gyroUpdateInterval
                // Get the gyro data.
                if let data = self.motion.gyroData {
                    let x = data.rotationRate.x
                    let y = data.rotationRate.y
                    let z = data.rotationRate.z
                    
                    // Use the gyroscope data in your app.
                    print(data)
                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(timer, forMode: .default)
        }
    }
    
    func stopGyros() {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = Timer()
            
            self.motion.stopGyroUpdates()
        }
    }
}

