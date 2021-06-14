import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        let (dWeight, dValue) = prepareSupply(supply: drinks)
        let (fWeight, fValue) = prepareSupply(supply: foods)
        
        let mdrinks = knapSack(maxWeight: maxWeight, weight: dWeight, value: dValue)
        let mfoods = knapSack(maxWeight: maxWeight, weight: fWeight, value: fValue)
        
        
        var maximumDistance = 0
        for i in 0...maxWeight {
            let foodCmb = mfoods[foods.count][i]
            let drinkCmb = mdrinks[drinks.count][maxWeight-i]
            
            if min(foodCmb, drinkCmb) > maximumDistance {
                maximumDistance = min(foodCmb, drinkCmb)
            }
        }
        
        return maximumDistance
    }
    
    func prepareSupply(supply: [Supply]) -> (weight:[Int],value:[Int])  {
        var weight = [Int]()
        var value = [Int]()
        
        for (w,v) in supply {
            weight.append(w)
            value.append(v)
        }
        
        return (weight, value)
        
    }
    
    func knapSack(maxWeight: Int, weight: [Int], value: [Int]) -> [[Int]] {
        
        // найдено на медиуме "towardsdev knapsack-with-dynamic-programming-in-swift-745b79ac64c6"
        let len = weight.count
        var twoDimenArr = Array(repeating: Array(repeating: 0,count: maxWeight+1), count: len+1)
        for x in 0..<len+1 {
            for y in 0..<maxWeight+1 {
                
                if x == 0 || y == 0 {
                    twoDimenArr[x][y] = 0
                    
                } else if weight[x-1]<=y {
                    
                    twoDimenArr[x][y] = max(value[x-1] + twoDimenArr[x-1][y-weight[x-1]],
                                            twoDimenArr[x-1][y])
                } else {
                    twoDimenArr[x][y] = twoDimenArr[x-1][y]
                }
            }
        }
        
        return twoDimenArr
    }
    
}
