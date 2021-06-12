import Foundation

class StockMaximize {
    
    func countProfit(prices: [Int]) -> Int {
        let len = prices.count
        
        if len < 1 {
            return 0
        }
        
        var total = 0
        var stocksToBuy = [Int]()
        
        var counter = 0
        
        
        while true {
           
            
            let current = prices[counter]
            var next = -1
            
            stocksToBuy.append(current)
            
            if counter+1 <= prices.count-1 {
                next = prices[counter+1]
            }
            
            if current < stocksToBuy.last! || counter == prices.endIndex-1 ||  next < current {
                total += calcSub(arr: stocksToBuy)
                stocksToBuy.removeAll()
            }
            
            
            if counter == prices.endIndex-1 {break}
            counter+=1
            
            
        }
        
        
        if total < 0 {
            return 0
        }
        
        
        
        return total
        
    }
    
    private func calcSub(arr: [Int]) -> Int {
        var sum = 0
        let maxVal = arr[arr.count-1]
        for price in arr {
            if maxVal == price {break}
            sum += maxVal - price
        }
        
        return sum
    }
}
