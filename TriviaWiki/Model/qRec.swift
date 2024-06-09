//
//  qRec.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/7/24.
//

import Foundation

class qRec : ObservableObject {
    
    static let pub = qRec()
    let genCats = ["Science", "Humanities", "Arts and Culture"]
    var cIds : [[(Int,Int)]]
    var mode : String
    
    private init() {
        cIds = [[(Int,Int)](),[(Int,Int)](),[(Int,Int)]()]
        mode = "Random"
        setupLists()
    }
    
    func updateQRec(){
        
    }
    
    func updateMode(newMode : String) -> Bool {
        if newMode != mode {
            mode = newMode
            return true
        }
        return false
    }
    
    func generalCat(cat:String) ->Int{
        let Sci = ["Medicine", "Mathematicians", "Economics", "Chemistry", "Mathematics", "Physics"]
        let Hum = ["Political_Science", "Philosophy", "Ethics_&_Morality", "Activists", "Philosophers"]
        let Art = ["Singers", "Famous_People", "Actors", "Playwrights", "Politicians", "Artists"]
        if Sci.contains(cat){return 0}
        if Hum.contains(cat){return 1}
        if Art.contains(cat){return 2}
        return -1
    }
    
    func setupLists() {
        print("RUNNING qRec::setupLists")
        cIds = [[(Int,Int)](),[(Int,Int)](),[(Int,Int)]()]
        for i in 0..<DataManager.shared.numQuestions{
            let cat = DataManager.shared.getQuestionN(n: i)["category"] as! String
            let rating = DataManager.shared.ratings[i]
            let index = generalCat(cat: cat)
            if !HistoryManager.shared.seen(id: i) {
                cIds[index].append((i, rating))
            }
        }
        cIds[0].sort(by: {$0.1 < $1.1})
        cIds[1].sort(by: {$0.1 < $1.1})
        cIds[2].sort(by: {$0.1 < $1.1})
    }
    
    func getBestInCat(catIndex : Int) -> Int{
        var result = -1
        let targetRating = HistoryManager.shared.ratings[catIndex]
        //basic binary search
        var a = 0
        var b = cIds[catIndex].count-1
        var target = 0
        while a < b{
            //print("a is \(a) and b is \(b)")
            target  = (a + b) / 2
            let val =  cIds[catIndex][target].1
            if val == targetRating {
                a = b
            }
            else if val < targetRating {
                a = target + 1
            }
            else {
                b = target - 1
            }
        }
        var maxScore = -10000
        var maxIndex = 0
        for i in 0...10{
            var score = 0
            let candInd = -5 + target + i
            if candInd > 0 && candInd < cIds[catIndex].count {
                score -= abs(targetRating - cIds[catIndex][candInd].1)
                //sets a penalty for more played questions: preferentially recommends less seen questions
                let timesPlayed = DataManager.shared.timesSeen[cIds[catIndex][candInd].0].reduce(0, +)
                if timesPlayed > 100{
                    score -= 50
                }
                else if timesPlayed > 50{
                    score -= 15
                }
                else if timesPlayed > 10 {
                    score -= 5
                }
                score += Int.random(in: 0...50)
                if score > maxScore{
                    maxScore = score
                    maxIndex = candInd
                }
            }
        }
        result = cIds[catIndex][maxIndex].0
        cIds[catIndex].remove(at:maxIndex)
        print("displaying question: \(result)")
        return result
    }
    
    func recommend() ->Int {
        if mode=="Random" {
            var index = Int.random(in:0...2)
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                index += 1
                index %= 3
            }
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                index += 1
                index %= 3
            }
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                print("they're all empty, holy heck!!!")
                return -1
            }
            return getBestInCat(catIndex: index)
        }
        else {
            var index : Int
            switch (mode){
            case "Science":
                index = 0
            case "Humanities":
                index = 1
            case "Arts and Culture":
                index = 2
            default:
                index = -1
            }
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                Globals.shared.BrowseLoadingText = "You completed all the questions in the category \(genCats[index]), wow! Try playing another category until more questions are added into the database."
                return -1
            }
            return getBestInCat(catIndex: index)
        }
    }
}
