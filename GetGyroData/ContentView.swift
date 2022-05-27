//
//  ContentView.swift
//  GetGyroData
//
//  Created by Yoddikko on 26/05/22.
//


//MARK: - Remember to change the info.plsit and add Privacy - Motion usage description.

import SwiftUI

public var onGoing = false
var valuesArray: [(Double, Double, Double)] = []

 struct ContentView: View {
    var motion = Motion()
    @State var onGoing = false
    @State var getGyro = true
    @State var getAccel = false
    var body: some View {
        
        if onGoing == false {
            VStack {
                Spacer()
                Text("Start recording gyroscope or accelerometer data.")
                    .padding()
                Spacer()
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding()
                    .foregroundColor(.green)
                    .onTapGesture {
                        if getGyro && !getAccel {
                            motion.startGyros()
                        }
                        if getAccel && !getGyro {
                            motion.startAccelerometer()
                        }
                        if getAccel || getGyro {
                            onGoing.toggle()
                        }
                    }
                
                
                Spacer()
                Toggle("Gyroscope", isOn: Binding(
                    get: { getGyro },
                    set: { _ in
                        withAnimation {
                            getAccel.toggle()
                            getGyro.toggle()
                        }
                    }
                ))

                    .padding()
                Toggle("Accelerometer", isOn: Binding(
                    get: { getAccel },
                    set: { _ in
                        withAnimation {
                            getAccel.toggle()
                            getGyro.toggle()
                        }
                    }
                ))

                    .padding()
                Spacer()
            }
            
        }
        else {
            Image(systemName: "pause.fill")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .padding()
                .foregroundColor(.red)
                .onTapGesture {
                    motion.stop()
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



