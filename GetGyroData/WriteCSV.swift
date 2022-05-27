//
//  WriteCSV.swift
//  GetGyroData
//
//  Created by Yoddikko on 27/05/22.
//

import Foundation

func createCSV(from array: [(Double, Double, Double)]) {
       var csvString = "\(" "),\("X"),\("Y"),\("Z")\n\n"
       for element in array {
           csvString = csvString.appending(" ,\(String(describing: element.0)) ,\(String(describing: element.1)) ,\(String(describing: element.2)) \n")
       }

       let fileManager = FileManager.default
       do {
           let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
           let fileURL = path.appendingPathComponent("MotionData.csv")
           try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
           print("csv created")
           
           //To access the data you created see this -> https://stackoverflow.com/questions/38064042/access-files-in-var-mobile-containers-data-application-without-jailbreaking-iph
       } catch {
           print("error creating file")
       }

   }
