//
//  CMMotionManager.swift
//  GetGyroData
//
//  Created by Yoddikko on 27/05/22.
//

import Foundation
import CoreMotion

class Motion {
    var motion = CMMotionManager()
    @Published var timer = Timer()
    var count = 0
    
    func startAccelerometer() {
        if motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 0.10
            motion.startAccelerometerUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            self.timer = Timer(fire: Date(), interval: (0.10),
                               repeats: true, block: { (timer) in
                // To change the frequency wich the data is fetched change this interval "0.10" seconds and the one on the top of self.motion.gyroUpdateInterval
                // Get the gyro data.
                if let data = self.motion.accelerometerData {
                    let acceleration = data.acceleration
                    
                    // Use the gyroscope data in your app.
                    print("accelerometer data : \(data)")
                    let accelTuple = (acceleration.x, acceleration.y, acceleration.z)
                    valuesArray.append(accelTuple)
                    self.count += 1
                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(timer, forMode: .default)
        }

        
    }
    
    
    func startGyros() {
        if motion.isGyroAvailable {
            
            self.motion.gyroUpdateInterval = 0.10
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
                    print("gyroscope data : \(data)")
                    
                    
                    let gyroTuple = (x, y, z)
                    valuesArray.append(gyroTuple)
                    self.count += 1

                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(timer, forMode: .default)
        }
    }
    
        
    
    
    func stop() {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = Timer()
            
            self.motion.stopAccelerometerUpdates()
            self.motion.stopGyroUpdates()
            createCSV(from: valuesArray)
            
        }
    }
}

