import Foundation
import PlaygroundSupport

enum TestStatus {
    case Pass
    case Fail
}

enum Errors: Error {
    case NoData
    case Failed
}

func getData() -> [Int] {
    let file = playgroundSharedDataDirectory.appendingPathComponent("advent-2019/01/data.txt")
    
    var fileContents: String?
    do{
        fileContents = try String(contentsOf: file)
    } catch(let error) {
        print("There was an error getting data: \(error)")
    }


    guard let dataStr = fileContents else {
        print(Errors.NoData)
        return []
    }


    let rawData = dataStr.split(separator: "\n")
    return rawData.map { str in
        return Int(str)!
    }
}

func computeFuelRemaining(value: Int) -> Int {
    // Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.
    return Int((Float(value) / 3.0).rounded(.down) - 2.0)
}

func computeFuelRequirements(value: Int) -> Int {
    var tmp = computeFuelRemaining(value: value)
    var residual : [Int] = []
    residual.append(tmp)
    
    while tmp >= 0 {
        let r = computeFuelRemaining(value: tmp)
        tmp = r
        
        if r >= 0 {
            residual.append(r)
        }
        
    }
    
    return residual.reduce(0, +)
}

func testComputeFuelRemaining(input: Int, expectedOutput: Int) -> TestStatus {
    let predicted = computeFuelRemaining(value: input)
    if predicted != expectedOutput {
        return TestStatus.Fail
    }
    
    return TestStatus.Pass
}

func testFuelRequirements(input: Int, expectedOutput: Int) -> TestStatus {
    let predicted = computeFuelRequirements(value: input)
    if predicted != expectedOutput {
        return TestStatus.Fail
    }
    
    return TestStatus.Pass
}

// Part 1
testComputeFuelRemaining(input: 12, expectedOutput: 2)
testComputeFuelRemaining(input: 14, expectedOutput: 2)
testComputeFuelRemaining(input: 1969, expectedOutput: 654)
testComputeFuelRemaining(input: 100756, expectedOutput: 33583)

// Part 2
testFuelRequirements(input: 100756, expectedOutput: 50346)
testFuelRequirements(input: 14, expectedOutput: 2)
testFuelRequirements(input: 1969, expectedOutput: 966)

let data = getData()

// Part 1
let computedFuel = data.map { computeFuelRemaining(value: $0) }
computedFuel.reduce(0, +)

// Part 2
let computedAllModulesFuelRequirements = data.map { computeFuelRequirements(value: $0)}
computedAllModulesFuelRequirements.reduce(0, +)
