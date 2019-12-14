import Foundation

enum TestResult {
    case pass
    case fail
}

enum OpCode: Int {
    case add = 1
    case mult = 2
    case term = 99
}

func chunk(data : [Int]) -> [ArraySlice<Int>] {
    var tmp : [ArraySlice<Int>] = []
    
    if data.count % 4 != 0 {
        return tmp
    }
    
    for i in stride(from: 0, to: data.count, by: 4) {
        tmp.append(data[i...i+3])
    }
    
    return tmp
}

func process(input: [Int]) -> [Int] {
    // make a copy of the input, becuase we need something we can change
    var output = input
    
    for i in stride(from: 0, to: input.count, by: 4) {
        let p1 = input[i + 1]
        let p2 = input[i + 2]
        let location = input[i + 3]
        print("values: \(input[i...3]) p1: \(p1) p2: \(p2) location: \(location)")
        switch OpCode(rawValue: input[i]){
        case .add:
            output[location] = input[p1] + input[p2]
        case .mult:
            output[location] = input[p1] * input[p2]
        case .term:
            break
        default:
            print("Given unsupported OpCode RawValue")
        }
    }
    
    
    return output
}


func testLength(one: [Int], two: [Int]) -> TestResult {
    if one.count != two.count {
        return .fail
    }
    return .pass
}


// Part 1


process(input: [1,9,10,3,2,3,11,0,99,30,40,50])
