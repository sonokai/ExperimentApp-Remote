//
//  StatsTable.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import Foundation

struct StatsTable{
    
    static func twoSampleTTest(array1: [Int], array2: [Int]) -> Double{
        //make sure both arrays aren't empty
        if(array1.count == 0 || array2.count == 0){
            return 0.5
        }
        //calculate averages
        let average1 = StatsTable.getAverageOfArray(array: array1)
        let average2 = StatsTable.getAverageOfArray(array: array2)
        //calculate standard deviations
        let standardDeviation1 = StatsTable.getStandardDeviationOfArray(array: array1)
        let standardDeviation2 = StatsTable.getStandardDeviationOfArray(array: array2)
        //calculate the test statistic.
        let t = (average1 - average2)/sqrt(standardDeviation1*standardDeviation1/Double(array1.count) + standardDeviation2*standardDeviation2/Double(array2.count))
        //calculate the df
        let dfDouble = welchSatterthwaiteEquation(s1: standardDeviation1, n1: Double(array1.count), s2: standardDeviation2, n2: Double(array2.count))
        let dfRounded = round(dfDouble)
        let df = Int(dfRounded)
        
        print("t: \(t), df: \(df)")
        
        //return the confidence associated with the t and df
        return getPValue(tValue: t, df: df)
    }
    
    //calculates df given the standard deviation and n of two different samples
    static func welchSatterthwaiteEquation(s1: Double, n1: Double, s2: Double, n2: Double) -> Double{
        if(n1 <= 1 || n2 <= 1){
            return 0
        }
        let topHalf = (s1*s1/n1 + s2*s2/n2) * (s1*s1/n1 + s2*s2/n2)
        let bottomLeft = (s1*s1/n1) * (s1*s1/n1) / (n1-1)
        let bottomRight = (s2*s2/n2) * (s2*s2/n2) / (n2-1)
        return topHalf/(bottomLeft + bottomRight)
    }
    
    //the table from stats
    static func getPValue(tValue: Double, df: Int) -> Double{
        switch(df){
        case 1:
            switch(tValue){
            case 0.000...1.000: return 0.5
            case 1.000...1.376: return 0.25
            case 1.376...1.963: return 0.20
            case 1.963...3.078: return 0.15
            case 3.078...6.314: return 0.10
            case 6.314...12.71: return 0.05
            case 12.71...31.82: return 0.025
            case 31.82...: return 0.01
            default: return 0.5
            }
        case 2:
            switch(tValue){
            case 0.000...0.816: return 0.5
            case 0.816...1.061: return 0.25
            case 1.061...1.386: return 0.20
            case 1.386...1.886: return 0.15
            case 1.886...2.920: return 0.10
            case 2.920...4.303: return 0.05
            case 4.303...6.965: return 0.025
            case 6.965...: return 0.01
            default: return 0.5
            }
        case 3:
            switch(tValue){
            case 0.000...0.765: return 0.5
            case 0.765...0.978: return 0.25
            case 0.978...1.250: return 0.20
            case 1.250...1.638: return 0.15
            case 1.638...2.353: return 0.10
            case 2.353...3.182: return 0.05
            case 3.182...4.541: return 0.025
            case 4.541...: return 0.01
            default: return 0.5
            }
        case 4:
            switch(tValue){
            case 0.000...0.741: return 0.5
            case 0.741...0.941: return 0.25
            case 0.941...1.190: return 0.20
            case 1.190...1.533: return 0.15
            case 1.533...2.132: return 0.10
            case 2.132...2.776: return 0.05
            case 2.776...3.747: return 0.025
            case 3.747...: return 0.01
            default: return 0.5
            }
        case 5:
            switch(tValue){
            case 0.000...0.727: return 0.5
            case 0.727...0.920: return 0.25
            case 0.920...1.156: return 0.20
            case 1.156...1.476: return 0.15
            case 1.476...2.015: return 0.10
            case 2.015...2.571: return 0.05
            case 2.571...3.365: return 0.025
            case 3.365...: return 0.01
            default: return 0.5
            }
        case 6:
            switch(tValue){
            case 0.000...0.718: return 0.5
            case 0.718...0.906: return 0.25
            case 0.906...1.134: return 0.20
            case 1.134...1.440: return 0.15
            case 1.440...1.943: return 0.10
            case 1.943...2.447: return 0.05
            case 2.447...3.143: return 0.025
            case 3.143...: return 0.01
            default: return 0.5
            }
        case 7:
            switch(tValue){
            case 0.000...0.711: return 0.5
            case 0.711...0.896: return 0.25
            case 0.896...1.119: return 0.20
            case 1.119...1.415: return 0.15
            case 1.415...1.895: return 0.10
            case 1.895...2.365: return 0.05
            case 2.365...2.998: return 0.025
            case 2.998...: return 0.01
            default: return 0.5
            }
        case 8:
            switch(tValue){
            case 0.000...0.706: return 0.5
            case 0.706...0.889: return 0.25
            case 0.889...1.108: return 0.20
            case 1.108...1.397: return 0.15
            case 1.397...1.860: return 0.10
            case 1.860...2.306: return 0.05
            case 2.306...2.896: return 0.025
            case 2.896...: return 0.01
            default: return 0.5
            }
        case 9:
            switch(tValue){
            case 0.000...0.703: return 0.5
            case 0.703...0.883: return 0.25
            case 0.883...1.100: return 0.20
            case 1.100...1.383: return 0.15
            case 1.383...1.833: return 0.10
            case 1.833...2.262: return 0.05
            case 2.262...2.821: return 0.025
            case 2.821...: return 0.01
            default: return 0.5
        }
        case 10:
            switch(tValue){
            case 0.000...0.700: return 0.5
            case 0.700...0.879: return 0.25
            case 0.879...1.093: return 0.20
            case 1.093...1.372: return 0.15
            case 1.372...1.812: return 0.10
            case 1.812...2.228: return 0.05
            case 2.228...2.764: return 0.025
            case 2.764...: return 0.01
            default: return 0.5
        }
        case 11:
            switch(tValue){
            case 0.000...0.697: return 0.5
            case 0.697...0.876: return 0.25
            case 0.876...1.088: return 0.20
            case 1.088...1.363: return 0.15
            case 1.363...1.796: return 0.10
            case 1.796...2.201: return 0.05
            case 2.201...2.718: return 0.025
            case 2.718...: return 0.01
            default: return 0.5
        }
        case 12:
            switch(tValue){
            case 0.000...0.695: return 0.5
            case 0.695...0.873: return 0.25
            case 0.873...1.083: return 0.20
            case 1.083...1.356: return 0.15
            case 1.356...1.782: return 0.10
            case 1.782...2.179: return 0.05
            case 2.179...2.681: return 0.025
            case 2.681...: return 0.01
            default: return 0.5
        }
        case 13:
            switch(tValue){
            case 0.000...0.694: return 0.5
            case 0.694...0.870: return 0.25
            case 0.870...1.079: return 0.20
            case 1.079...1.350: return 0.15
            case 1.350...1.771: return 0.10
            case 1.771...2.160: return 0.05
            case 2.160...2.650: return 0.025
            case 2.650...: return 0.01
            default: return 0.5
        }
        case 14:
            switch(tValue){
            case 0.000...0.692: return 0.5
            case 0.692...0.868: return 0.25
            case 0.868...1.076: return 0.20
            case 1.076...1.345: return 0.15
            case 1.345...1.761: return 0.10
            case 1.761...2.145: return 0.05
            case 2.145...2.624: return 0.025
            case 2.624...: return 0.01
            default: return 0.5
        }
        case 15:
            switch(tValue){
            case 0.000...0.691: return 0.5
            case 0.691...0.866: return 0.25
            case 0.866...1.074: return 0.20
            case 1.074...1.341: return 0.15
            case 1.341...1.753: return 0.10
            case 1.753...2.131: return 0.05
            case 2.131...2.602: return 0.025
            case 2.602...: return 0.01
            default: return 0.5
        }
        case 16:
            switch(tValue){
            case 0.000...0.690: return 0.5
            case 0.690...0.865: return 0.25
            case 0.865...1.071: return 0.20
            case 1.071...1.337: return 0.15
            case 1.337...1.746: return 0.10
            case 1.746...2.120: return 0.05
            case 2.120...2.583: return 0.025
            case 2.583...: return 0.01
            default: return 0.5
        }
        case 17:
            switch(tValue){
            case 0.000...0.689: return 0.5
            case 0.689...0.863: return 0.25
            case 0.863...1.069: return 0.20
            case 1.069...1.333: return 0.15
            case 1.333...1.740: return 0.10
            case 1.740...2.110: return 0.05
            case 2.110...2.567: return 0.025
            case 2.567...: return 0.01
            default: return 0.5
        }
        case 18:
            switch(tValue){
            case 0.000...0.688: return 0.5
            case 0.688...0.862: return 0.25
            case 0.862...1.067: return 0.20
            case 1.067...1.330: return 0.15
            case 1.330...1.734: return 0.10
            case 1.734...2.101: return 0.05
            case 2.101...2.552: return 0.025
            case 2.552...: return 0.01
            default: return 0.5
        }
        case 19:
            switch(tValue){
            case 0.000...0.688: return 0.5
            case 0.688...0.861: return 0.25
            case 0.861...1.066: return 0.20
            case 1.066...1.328: return 0.15
            case 1.328...1.729: return 0.10
            case 1.729...2.093: return 0.05
            case 2.093...2.539: return 0.025
            case 2.539...: return 0.01
            default: return 0.5
        }
        case 20:
            switch(tValue){
            case 0.000...0.687: return 0.5
            case 0.687...0.860: return 0.25
            case 0.860...1.064: return 0.20
            case 1.064...1.325: return 0.15
            case 1.325...1.725: return 0.10
            case 1.725...2.086: return 0.05
            case 2.086...2.528: return 0.025
            case 2.528...: return 0.01
            default: return 0.5
        }
        case 21:
            switch(tValue){
            case 0.000...0.686: return 0.5
            case 0.686...0.859: return 0.25
            case 0.859...1.063: return 0.20
            case 1.063...1.323: return 0.15
            case 1.323...1.721: return 0.10
            case 1.721...2.080: return 0.05
            case 2.080...2.518: return 0.025
            case 2.518...: return 0.01
            default: return 0.5
        }
        case 22:
            switch(tValue){
            case 0.000...0.686: return 0.5
            case 0.686...0.858: return 0.25
            case 0.858...1.061: return 0.20
            case 1.061...1.321: return 0.15
            case 1.321...1.717: return 0.10
            case 1.717...2.074: return 0.05
            case 2.074...2.508: return 0.025
            case 2.508...: return 0.01
            default: return 0.5
        }
        case 23:
            switch(tValue){
            case 0.000...0.685: return 0.5
            case 0.685...0.858: return 0.25
            case 0.858...1.060: return 0.20
            case 1.060...1.319: return 0.15
            case 1.319...1.714: return 0.10
            case 1.714...2.069: return 0.05
            case 2.069...2.500: return 0.025
            case 2.500...: return 0.01
            default: return 0.5
        }
        case 24:
            switch(tValue){
            case 0.000...0.685: return 0.5
            case 0.685...0.857: return 0.25
            case 0.857...1.059: return 0.20
            case 1.059...1.318: return 0.15
            case 1.318...1.711: return 0.10
            case 1.711...2.064: return 0.05
            case 2.064...2.492: return 0.025
            case 2.492...: return 0.01
            default: return 0.5
        }
        case 25:
            switch(tValue){
            case 0.000...0.684: return 0.5
            case 0.684...0.856: return 0.25
            case 0.856...1.058: return 0.20
            case 1.058...1.316: return 0.15
            case 1.316...1.708: return 0.10
            case 1.708...2.060: return 0.05
            case 2.060...2.485: return 0.025
            case 2.485...: return 0.01
            default: return 0.5
        }
        case 26:
            switch(tValue){
            case 0.000...0.684: return 0.5
            case 0.684...0.856: return 0.25
            case 0.856...1.058: return 0.20
            case 1.058...1.315: return 0.15
            case 1.315...1.706: return 0.10
            case 1.706...2.056: return 0.05
            case 2.056...2.479: return 0.025
            case 2.479...: return 0.01
            default: return 0.5
        }
        case 27:
            switch(tValue){
            case 0.000...0.684: return 0.5
            case 0.684...0.855: return 0.25
            case 0.855...1.057: return 0.20
            case 1.057...1.314: return 0.15
            case 1.314...1.703: return 0.10
            case 1.703...2.052: return 0.05
            case 2.052...2.473: return 0.025
            case 2.473...: return 0.01
            default: return 0.5
        }
        case 28:
            switch(tValue){
            case 0.000...0.683: return 0.5
            case 0.683...0.855: return 0.25
            case 0.855...1.056: return 0.20
            case 1.056...1.313: return 0.15
            case 1.313...1.701: return 0.10
            case 1.701...2.048: return 0.05
            case 2.048...2.467: return 0.025
            case 2.467...: return 0.01
            default: return 0.5
        }
        case 29:
            switch(tValue){
            case 0.000...0.683: return 0.5
            case 0.683...0.854: return 0.25
            case 0.854...1.055: return 0.20
            case 1.055...1.311: return 0.15
            case 1.311...1.699: return 0.10
            case 1.699...2.045: return 0.05
            case 2.045...2.462: return 0.025
            case 2.462...: return 0.01
            default: return 0.5
        }
        case 30...40:
            switch(tValue){
            case 0.000...0.683: return 0.5
            case 0.683...0.854: return 0.25
            case 0.854...1.055: return 0.20
            case 1.055...1.310: return 0.15
            case 1.310...1.697: return 0.10
            case 1.697...2.042: return 0.05
            case 2.042...2.457: return 0.025
            case 2.457...: return 0.01
            default: return 0.5
        }
        case 40...60:
            switch(tValue){
            case 0.000...0.681: return 0.5
            case 0.681...0.851: return 0.25
            case 0.851...1.050: return 0.20
            case 1.050...1.303: return 0.15
            case 1.303...1.684: return 0.10
            case 1.684...2.021: return 0.05
            case 2.021...2.423: return 0.025
            case 2.423...: return 0.01
            default: return 0.5
        }
        case 60...80:
            switch(tValue){
            case 0.000...0.679: return 0.5
            case 0.679...0.848: return 0.25
            case 0.848...1.045: return 0.20
            case 1.045...1.296: return 0.15
            case 1.296...1.671: return 0.10
            case 1.671...2.000: return 0.05
            case 2.000...2.390: return 0.025
            case 2.390...: return 0.01
            default: return 0.5
        }
        case 80...100:
            switch(tValue){
            case 0.000...0.678: return 0.5
            case 0.678...0.846: return 0.25
            case 0.846...1.043: return 0.20
            case 1.043...1.292: return 0.15
            case 1.292...1.664: return 0.10
            case 1.664...1.990: return 0.05
            case 1.990...2.374: return 0.025
            case 2.374...: return 0.01
            default: return 0.5
        }
        case 100...:
            switch(tValue){
            case 0.000...0.677: return 0.5
            case 0.677...0.845: return 0.25
            case 0.845...1.042: return 0.20
            case 1.042...1.290: return 0.15
            case 1.290...1.660: return 0.10
            case 1.660...1.984: return 0.05
            case 1.984...2.364: return 0.025
            case 2.364...: return 0.01
            default: return 0.5
        }
        default: return 0.5
        }
    }
    static func getAverageOfArray(array: [Int]) -> Double{
        guard !array.isEmpty else {return 0}
        let sum = array.reduce(0, +)
        return Double(sum) / Double(array.count)
    }
    static func getStandardDeviationOfArray(array: [Int]) -> Double{
        let average = StatsTable.getAverageOfArray(array: array)
        var sum: Double = 0
        for number in array{
            sum = sum + (average - Double(number)) * (average - Double(number))
        }
        return sqrt(sum/Double(array.count))
    }
}
