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
    var loadedIds : Set<Int>
    var recommendations : [Int]
    var listsFilled : Bool
    
    private init() {
        //return to initialize ratings properly
        ratings = [1200,1200,1200]
        cIds = [[(Int,Int)](),[(Int,Int)](),[(Int,Int)]()]
        loadedIds = Set<Int>()
        recommendations = [Int]()
        listsFilled = false
    }
    func setup() async {
        setupLists()
        await fillRecs()
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
        if listsFilled { return }
        for i in 0..<indicesByCat.count-1
        {
            var counter = indicesByCat[i].1
            let index = generalCat(cat: indicesByCat[i].0)
            print("beginning to parse indicesByCat")
            while counter < indicesByCat[i+1].1
            {
                if qData.pub.getSeen(id:counter) == -1
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
        print(cIds[0][0])
        print(cIds[0][100])
        print(cIds[1][0])
        listsFilled = true
    }
    
    func fillRecs() async {
        print("running fill Recs")
        if recommendations.count < 3
        {
            print("getting more questions")
            var toLoad = [Int]()
            for i in 0...9{
                var rInd = Int.random(in:0...2)
                if cIds[rInd].count==0
                {
                    print("in fillRecs() list of \(rInd) is empty!!!")
                    rInd += 1
                    rInd %= 3
                }
                if cIds[rInd].count==0
                {
                    print("in fillRecs() list of \(rInd) is empty!!!")
                    rInd += 1
                    rInd %= 3
                }
                if cIds[rInd].count==0
                {
                    print("All recommendations lists empty! Aur Naur, CLEO!")
                }
                toLoad.append(cIds[rInd][0].0)
                recommendations.append(cIds[rInd][0].0)
                cIds[rInd].remove(at: 0)
            }
            await qData.pub.loadIn(ids: toLoad)
        }
        print("finished fillRecs")
    }
    
    func recommend() ->Int {
        if recommendations.isEmpty{
            return -1
        }
        var result = recommendations[0]
        recommendations.remove(at: 0)
        return result
    }
}
