//
//  BestFitLine.swift
//  ExperimentApp
//
//  Created by Bell Chen on 5/2/24.
//

import SwiftUI
import Charts

let data: [Dataa] = [ Dataa(x: 0,y:5),
                      Dataa(x: 0,y: 15),
                      
]

struct Dataa: Identifiable{
    var x: Double
    var y: Double
    let id: UUID
    init(id: UUID = UUID(), x: Double, y: Double){
        self.id = id
        self.x = x
        self.y = y
    }
}
struct BestFitLine: View {
    
    var body: some View {
        VStack{
            Chart(){
                
                ForEach(data){ entry in
                    PointMark(x: .value("x", entry.x), y: .value("y",entry.y))
                }
                let (point1, point2) = getPoints(data: data)
                LineMark(x:  .value("x", point1.x), y: .value("y",point1.y))
                LineMark(x:  .value("x", point2.x), y: .value("y",point2.y))
            }.frame(width: 300, height: 300)
        }
    }
}

//returns m, and b, where y = mx + b given a data set.
func calculateLineOfBestFit(data: [Dataa]) -> (Double, Double){
    //calculate A A* first
    var r1c1: Double = 0
    for entry in data{
        r1c1 += entry.x * entry.x
    }
    var r1c2: Double = 0
    for entry in data{
        r1c2 += entry.x
    }
    let r2c1 = r1c2
    let r2c2 = Double(data.count)
    
    //calculate determinant
    let det: Double = Double(r1c1) * Double(r2c2) - Double((r1c2*r2c1))
    //calculate inverse (A A*)
    let inv_r2c2 = Double(r1c1)/det
    let inv_r1c1 = Double(r2c2)/det
    let inv_r1c2 = Double(-r1c2)/det
    let inv_r2c1 = Double(-r2c1)/det
    
    //Calculate A* y
    var top: Double = 0
    var bottom: Double = 0
    for entry in data{
        top += (Double)(entry.x * entry.y)
        bottom += (Double)(entry.y)
    }
    
    //Calculate (A A*)A* y
    let final_top = inv_r1c1 * top + inv_r1c2 * bottom
    let final_bottom = inv_r2c1 * top + inv_r2c2 * bottom
    
    print("m = \(final_top), b = \(final_bottom)")
    return (final_top, final_bottom)
}
func getPoints(data: [Dataa]) -> (Dataa, Dataa){
    let min_data = data.min(by:{ $0.x < $1.x})
    let min_x = min_data?.x ?? 0
    let max_data = data.max(by:{ $0.x < $1.x })
    let max_x = max_data?.x ?? 0
    
    let (m,b) = calculateLineOfBestFit(data: data)
    let dataPoint1 = Dataa(x: min_x , y:m*min_x+b)
    let dataPoint2 = Dataa(x: max_x, y:m*max_x+b)
    print("point1:  \(min_x ), \(m*min_x+b)" )
    return (dataPoint1, dataPoint2)
}


struct BestFitLine_Previews: PreviewProvider {
    static var previews: some View {
        BestFitLine()
    }
}
