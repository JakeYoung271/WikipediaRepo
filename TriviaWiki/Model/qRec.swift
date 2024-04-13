//
//  qRec.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/7/24.
//

import Foundation

class qRec {
    static let pub = qRec()
    let genCats = ["Science", "Humanities", "Arts and Culture"]
    var cIds : [[(Int,Int)]]
    var ratings: [Int]
    var seen : Set<Int>
    
    private init() {
        //return to initialize ratings properly
        ratings = [1000,1000,1000]
        cIds = [[(Int,Int)](),[(Int,Int)](),[(Int,Int)]()]
        seen = Set<Int>()
        setupLists()
        setupSeen()
    }
    
    func setupSeen(){
        var arrSeen = CoreDataStack.shared.getHistory()
        for i in arrSeen{
            seen.insert(i[0])
        }
    }
    
    func seeProblem(id : Int, chosen : Int){
        seen.insert(id)
        CoreDataStack.shared.addHistory(toAdd: [id, chosen])
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
    
    private func setupLists() {
        for i in 0..<indicesByCat.count-1
        {
            var counter = indicesByCat[i].1
            let index = generalCat(cat: indicesByCat[i].0)
            print("beginning to parse indicesByCat")
            while counter < indicesByCat[i+1].1
            {
                //if qData.pub.getSeen(id:counter) == -1
                if !seen.contains(counter)
                {
                    cIds[index].append((counter,allRatings[counter]))
                }
                counter += 1
            }

        }
        print("Sorting lists in qRec.setupLists")
        cIds[0].sort(by: {$0.1 < $1.1})
        cIds[1].sort(by: {$0.1 < $1.1})
        cIds[2].sort(by: {$0.1 < $1.1})
        print("lists filled and sorted!")
        print(cIds[0].count)
        print(cIds[1].count)
        print(cIds[2].count)
    }
    
    func getBestInCat(catIndex : Int) -> Int{
        var result = -1
        let rating = ratings[catIndex]
        //basic binary search
        var a = 0
        var b = cIds[catIndex].count-1
        var target = 0
        var targetRating = ratings[catIndex]
        while a < b{
            //print("a is \(a) and b is \(b)")
            target  = (a + b) / 2
            var val =  cIds[catIndex][target].1
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
            var candInd = -5 + target + i
            if candInd > 0 && candInd < cIds[catIndex].count {
                score -= abs(targetRating - cIds[catIndex][candInd].1)
                //sets a penalty for more played questions: preferentially recommends less seen questions
                let timesPlayed = allResponses[cIds[catIndex][candInd].0].reduce(0, +)
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
        return result
    }
    
    func recommend() ->Int {
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
    
    
    //implement this function
    func updateRating(){
        //return here!!!
    }
    
    //implement this function
    func updateServer(){
        //implement this function!!!
    }
}
