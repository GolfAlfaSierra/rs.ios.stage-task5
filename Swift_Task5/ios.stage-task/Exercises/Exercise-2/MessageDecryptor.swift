import UIKit

class MessageDecryptor: NSObject {
    
    
    
    
    func decryptMessage(_ message: String) -> String {
        var multiplierNumAccummulator = ""
        var result = ""
        
        var previousStringStack = [""]
        var prefixNumStack = [""]
        
        
        
        
        for ch in message {
            
            if ch.isNumber { // добавляем во временную строку с числами
                multiplierNumAccummulator.append(ch)
                
            } else {
                
                switch ch {
                
                case "[": // начинается блок сообщения, надо передать множитель и последнее состояние строки с результатом
                    
                    if multiplierNumAccummulator == "" {
                        prefixNumStack.append("1")
                    } else {
                        prefixNumStack.append(multiplierNumAccummulator)
                    }
                    
                    previousStringStack.append(result) // стешим текущий result
                    multiplierNumAccummulator = ""
                    result = ""
                    
                case "]": // блок заканчивается, надо получить последний множитель, повторить строку Н раз, соеденить с предыдущей строкой в стаке, и записать в result
                    var repeatedStr = ""
                    let last = prefixNumStack.popLast()
                    
                    
                    if let counter = Int("\(last ?? "1")") {
                        
                        for _ in 0..<counter {
                            repeatedStr.append(result)
                        }
                    }
                    
                    result = "\(previousStringStack.popLast()!)\(repeatedStr)"
                    
                    
                    
                default: // стандартный сценарий, символ строка
                    result.append(ch)
                    
                }
            }
            
        }
        
        return result
    }
}
