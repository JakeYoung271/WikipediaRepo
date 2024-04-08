//
//  HardCodedVals.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/7/24.
//

import Foundation

let indicesByCat = [("Mathematics", 0), ("Famous_People", 121), ("Politicians", 284), ("Activists", 407), ("Mathematicians", 466), ("Philosophers", 506), ("Artists", 625), ("Actors", 737), ("Singers", 887), ("Playwrights", 1003), ("Physics", 1079), ("Medicine", 1143), ("Chemistry", 1217), ("Ethics_&_Morality", 1280), ("Philosophy", 1372), ("Political_Science", 1498), ("Economics", 1594), ("Finished", 1602)]
let allRatings = [1250, 1750, 1250, 1250, 1000, 1500, 1000, 1500, 1500, 1250, 1500, 1250, 1000, 1000, 1250, 1500, 1000, 1000, 1500, 1250, 1750, 1750, 1750, 1500, 1750, 1250, 1250, 1500, 1250, 1250, 1500, 1500, 1000, 1500, 1000, 1750, 1750, 1250, 1500, 1500, 1750, 1750, 1750, 1000, 1000, 1000, 1500, 1000, 1500, 1250, 1500, 1250, 1750, 1500, 1500, 1500, 1250, 2000, 1500, 1250, 1250, 1750, 1500, 1750, 1750, 1750, 1500, 1500, 2000, 2000, 1750, 1750, 1500, 1500, 2000, 1250, 1500, 1250, 2000, 1500, 1250, 1500, 1750, 2000, 1750, 1500, 1750, 2000, 1500, 2000, 2000, 2000, 1750, 1500, 1250, 1500, 1500, 2000, 1750, 1250, 2000, 2000, 2000, 2000, 2000, 2000, 1750, 1750, 2000, 1750, 1500, 2000, 1750, 2000, 2000, 1750, 1500, 1250, 1500, 1000, 1500, 2000, 1500, 1000, 1750, 1500, 1250, 1250, 1000, 1000, 1750, 1500, 1250, 1250, 1000, 1500, 1000, 2000, 1750, 1750, 1500, 1750, 1250, 1750, 1750, 1250, 1750, 1000, 1500, 1500, 1750, 1500, 1000, 1500, 2000, 1250, 1250, 1250, 2000, 1500, 1500, 1750, 1500, 1250, 1750, 1250, 1500, 1750, 1750, 1750, 1750, 1500, 1750, 1500, 1750, 1500, 1750, 1750, 2000, 1500, 1500, 1000, 1250, 1500, 1000, 1750, 1250, 1750, 1250, 1250, 1750, 1500, 1500, 1000, 1500, 1750, 1000, 1250, 1750, 1500, 1500, 1750, 1750, 1500, 1750, 1500, 1250, 2000, 1500, 1500, 1750, 1250, 1750, 1250, 1750, 1500, 1250, 1250, 1000, 1000, 1250, 1500, 1750, 1250, 1250, 1750, 1250, 1250, 1250, 1250, 1750, 1500, 1250, 1250, 1250, 1250, 1750, 1000, 1250, 1500, 1000, 1000, 1250, 1750, 1500, 1500, 1750, 1250, 2000, 1750, 1250, 1750, 1500, 1250, 1000, 1000, 1500, 1500, 1750, 1250, 1250, 1500, 1250, 1250, 1500, 1750, 2000, 1500, 1250, 1750, 1500, 1250, 1750, 1250, 1000, 1500, 1250, 1250, 1750, 1750, 1500, 1750, 1750, 1250, 1750, 1000, 1250, 1250, 1250, 1250, 1250, 1500, 1000, 1500, 1250, 1000, 1750, 1000, 1500, 1000, 1500, 1250, 1750, 1500, 1500, 1750, 1250, 1750, 1500, 1500, 1000, 1250, 1750, 1000, 1250, 1250, 1250, 1000, 1250, 1000, 1500, 1250, 1000, 1250, 1500, 1750, 1500, 1250, 1750, 1250, 1250, 1250, 1000, 1000, 1500, 1750, 1500, 1250, 1750, 1000, 1000, 1750, 1500, 1250, 1500, 1500, 1250, 1500, 1750, 1750, 1500, 1250, 1250, 1250, 1250, 1250, 1750, 1250, 1750, 1750, 1500, 1750, 1750, 1500, 1750, 1250, 1750, 1500, 2000, 1500, 1250, 1000, 1250, 1250, 1000, 1250, 1250, 1500, 1500, 1250, 1750, 1500, 1750, 1750, 1250, 1750, 1750, 2000, 1750, 1500, 1750, 1000, 1500, 1250, 2000, 1750, 1000, 1750, 1500, 1250, 1250, 1250, 1500, 1500, 2000, 1000, 1250, 1750, 1250, 1000, 1250, 1250, 1500, 1750, 1500, 1000, 1500, 1750, 1250, 1500, 1500, 1500, 1500, 1500, 1750, 1500, 1500, 1750, 1500, 1500, 1750, 1250, 1500, 1500, 1500, 1250, 1250, 1250, 1250, 1750, 1750, 1750, 1500, 2000, 1750, 1000, 1250, 1750, 1500, 1500, 1750, 1250, 1500, 1750, 1750, 1750, 2000, 1750, 1500, 1750, 1500, 1500, 2000, 1750, 1750, 1500, 1250, 1000, 1250, 1250, 1250, 1750, 1500, 1500, 1750, 1750, 2000, 1250, 1250, 1000, 1750, 1500, 1750, 1750, 1750, 1750, 1500, 1500, 1750, 1750, 2000, 1750, 1750, 1250, 1250, 1750, 1750, 1750, 1250, 1750, 1500, 1500, 1750, 1750, 1750, 1500, 1500, 1000, 1250, 1750, 2000, 1250, 1250, 1000, 1250, 1000, 1250, 1750, 1750, 1750, 1250, 1500, 1500, 1750, 1250, 1250, 1500, 1750, 1250, 1000, 1750, 1000, 1250, 1750, 1500, 1500, 1750, 1500, 1500, 1500, 1250, 1750, 1750, 2000, 1750, 1750, 1500, 2000, 1250, 1500, 1750, 1750, 1500, 1500, 2000, 1750, 1750, 1250, 1500, 1750, 1500, 1750, 1500, 1250, 2000, 1750, 1750, 2000, 1750, 1750, 2000, 1500, 1500, 1250, 1500, 1750, 1500, 1500, 1750, 1250, 1000, 1500, 1750, 2000, 1250, 2000, 1500, 2000, 1750, 1500, 1750, 1500, 1250, 1750, 1750, 1250, 1500, 1500, 1500, 1000, 1250, 1750, 1500, 1750, 1750, 1500, 1750, 1250, 1500, 1750, 2000, 1750, 1500, 2000, 1750, 1500, 1750, 1750, 1250, 1750, 2000, 1750, 1750, 1500, 1500, 1250, 1000, 1250, 1000, 1000, 1500, 1000, 1500, 1750, 1250, 1000, 1250, 1500, 1250, 1250, 1000, 1250, 1000, 1500, 1750, 1000, 1750, 1250, 1250, 1500, 1250, 1250, 1000, 1000, 1250, 1500, 1000, 1250, 1500, 1000, 1250, 1250, 1000, 1750, 1250, 1750, 1250, 1250, 1750, 2000, 1500, 1500, 1250, 1750, 1500, 1500, 1750, 1250, 1750, 1500, 1750, 2000, 1250, 1750, 1750, 1250, 1500, 2000, 1500, 1500, 2000, 1750, 1500, 2000, 1750, 1500, 1750, 1750, 1750, 1500, 1500, 1500, 1500, 1250, 1500, 1500, 1500, 1500, 1500, 1500, 1750, 1750, 1500, 1500, 1500, 1750, 1750, 1500, 1750, 1250, 1750, 1250, 1000, 1750, 1750, 1500, 1250, 1250, 1000, 1250, 1750, 2000, 1750, 1750, 1750, 1500, 1750, 1500, 1250, 1250, 1500, 1750, 1000, 1750, 2000, 1250, 1750, 1250, 1750, 1750, 1750, 1500, 1500, 1500, 1750, 2000, 1750, 1500, 1500, 1750, 1500, 1500, 1500, 1750, 1500, 1250, 1000, 1750, 1500, 1500, 1500, 1250, 1500, 1250, 1500, 1500, 1500, 1750, 1500, 1750, 1500, 1750, 1250, 1750, 1750, 1250, 1250, 1250, 1000, 1500, 1000, 1500, 1500, 1500, 1500, 1750, 2000, 1000, 1250, 1750, 1750, 1750, 1750, 2000, 1750, 2000, 1750, 1000, 1750, 1500, 1750, 1750, 2000, 1750, 1750, 1500, 1500, 1750, 1250, 1000, 1000, 1500, 1500, 1500, 1750, 1750, 1500, 1750, 2000, 1750, 1750, 1000, 1750, 1750, 1500, 1750, 1750, 1500, 1250, 1500, 1500, 1750, 1500, 1500, 1750, 1500, 1500, 1500, 1500, 1250, 1750, 1500, 1000, 1000, 2000, 1500, 1250, 1500, 1500, 1000, 1750, 1750, 1000, 1250, 1500, 1500, 1000, 1750, 1000, 1250, 1750, 1500, 1000, 1000, 1250, 1250, 1000, 1250, 1000, 1500, 1250, 1000, 1500, 1500, 1000, 1500, 1000, 1500, 1500, 1750, 1750, 1500, 1000, 1500, 1500, 1250, 1250, 1000, 1750, 1500, 1750, 1500, 1250, 1750, 1000, 1250, 1250, 1500, 1500, 1750, 1000, 1250, 1000, 1750, 1500, 2000, 1500, 1750, 1500, 1750, 1500, 1750, 1000, 1000, 1000, 1250, 1250, 1500, 1000, 1000, 1500, 1500, 1000, 1750, 2000, 1000, 1750, 1500, 1500, 1750, 2000, 1750, 1750, 2000, 2000, 1250, 1500, 1500, 1000, 1500, 1250, 1000, 1500, 1500, 1000, 1250, 1000, 1000, 1750, 1250, 1000, 1500, 1000, 1000, 1500, 1500, 1250, 1000, 1500, 1000, 2000, 1250, 1250, 1250, 2000, 1750, 1250, 1000, 1250, 1500, 1750, 1000, 1750, 1500, 1000, 1500, 1000, 1500, 1000, 1500, 1000, 1750, 1750, 1000, 1750, 1500, 1500, 1250, 1500, 1250, 1500, 1000, 1000, 1500, 1750, 1250, 1250, 1500, 1500, 1750, 1500, 1500, 1250, 1750, 1500, 1750, 1750, 1750, 2000, 1750, 1000, 1250, 1000, 2000, 1250, 1500, 1500, 1250, 1000, 1500, 1500, 1750, 1000, 2000, 1750, 1500, 1750, 1750, 1750, 1500, 1500, 1750, 1750, 1500, 1750, 1500, 1500, 1750, 1500, 1750, 1750, 1500, 1500, 1500, 1500, 1750, 1750, 1750, 1250, 1500, 1750, 1750, 1750, 1500, 1750, 1500, 1750, 2000, 1750, 1750, 1000, 1500, 1250, 1500, 1750, 1500, 2000, 1500, 1500, 1000, 1000, 1000, 1250, 1500, 1250, 1500, 1250, 1500, 1750, 1000, 2000, 1750, 1250, 1000, 1500, 1250, 1500, 1500, 1250, 1000, 1250, 1750, 1250, 1000, 1500, 1500, 1000, 1500, 1500, 1500, 2000, 1750, 2000, 1750, 1500, 1500, 2000, 2000, 1750, 1250, 1000, 2000, 1750, 1750, 1500, 1750, 1000, 1500, 1250, 1250, 1000, 1250, 1500, 1000, 1250, 1750, 1500, 1250, 1500, 1500, 1000, 2000, 2000, 1000, 1250, 1250, 1500, 1250, 1000, 1750, 1750, 1500, 1500, 1250, 1250, 1500, 1500, 1250, 1000, 1250, 1500, 1000, 2000, 1750, 1000, 1500, 1250, 1250, 1250, 1000, 1250, 1000, 1250, 1500, 1250, 1500, 1250, 1500, 1250, 1250, 1250, 1750, 1750, 1500, 1000, 1000, 1250, 1250, 1250, 1000, 1250, 1500, 1000, 1500, 1000, 1250, 1250, 1000, 1000, 1750, 1250, 1750, 1750, 1250, 1500, 1500, 1500, 1750, 1500, 1250, 1250, 1000, 1250, 1000, 1250, 1250, 1000, 1250, 1250, 1000, 1250, 1250, 1000, 1500, 1500, 1250, 1000, 1250, 1500, 1250, 1750, 1500, 1500, 1000, 1250, 1000, 1000, 1000, 1750, 1000, 1750, 2000, 1250, 1250, 1500, 1500, 1250, 2000, 1500, 1500, 1000, 1000, 1500, 1750, 1500, 1500, 1000, 1750, 1250, 1500, 1250, 1250, 1500, 1750, 1250, 1750, 2000, 2000, 1500, 1250, 1250, 1750, 1000, 2000, 1500, 1750, 1500, 1000, 1750, 1250, 1500, 1250, 1250, 1000, 1750, 1500, 1750, 1500, 1250, 1500, 1500, 1000, 2000, 1250, 1750, 1250, 1500, 1500, 1250, 1000, 1250, 1250, 1500, 1750, 1250, 2000, 2000, 1750, 1500, 1250, 1250, 1250, 1000, 1250, 1000, 1250, 1250, 2000, 1500, 1500, 1750, 1250, 1250, 1500, 1250, 1500, 1500, 1750, 1500, 1250, 1000, 1250, 1250, 1500, 1750, 1750, 1250, 1500, 1500, 1250, 1500, 1500, 1750, 1500, 1500, 1500, 2000, 1750, 1500, 1000, 1750, 1500, 1250, 1250, 1250, 1250, 1500, 1250, 1250, 2000, 1000, 1250, 1500, 1000, 1500, 1500, 1250, 1250, 1250, 2000, 1500, 1500, 1250, 1250, 1500, 1500, 1500, 1250, 1250, 2000, 1250, 1500, 1500, 1250, 1750, 1500, 1500, 1500, 1750, 1000, 1750, 1500, 1250, 1500, 1500, 1750, 1250, 1750, 1500, 1500, 1500, 1250, 1250, 1250, 1250, 1750, 1750, 2000, 1750, 2000, 1750, 2000, 1750, 2000, 1500, 1750, 1750, 1500, 1750, 1750, 1750, 2000, 1500, 1750, 1750, 1250, 1250, 1500, 1500, 1500, 1500, 1250, 1250, 1500, 1500, 1750, 1500, 1500, 1500, 1500, 1500, 1250, 1500, 1750, 1500, 1500, 1500, 1000, 1250, 1750, 1500, 1250, 2000, 1750, 1500, 2000, 1750, 1750, 1500, 1750, 1250, 2000, 2000, 1750, 1250, 1500, 1250, 2000, 1000, 1500, 1750, 1250, 2000, 1500, 2000, 1750, 1250, 1000, 2000, 1750, 1750, 1500, 1500, 1750, 1500, 1750, 1500, 1750, 1750, 1250, 1500, 1250, 1750, 2000, 1500, 1500, 2000, 1500, 1250, 1000, 1000, 1000, 1000, 1000, 1250, 1500, 1500, 1250, 1250, 1250, 1250, 1000, 1000, 1500, 1250, 1000, 1250, 1250, 1500, 1250, 1250, 1000, 1250, 1500, 1250, 1500, 1000, 1000, 1250, 1500, 1750, 1000, 1250, 1500, 1000, 1250, 1250, 1250, 2000, 1000, 1250, 1750, 1250, 1250, 1000, 1500, 1250, 1250, 1500, 1250, 1250, 1500, 1500, 1750, 1250, 1500, 1500, 1500, 1250, 1000, 1250, 1250, 1250, 1500, 1000, 1000, 1250, 1250, 2000, 1000, 1750, 1250, 1250, 1500, 1500, 1750, 1500, 1000, 1750, 2000, 1750, 1000, 1250, 1750, 1500, 1250, 1500, 1250, 1250, 1250, 1750, 1250, 1000, 1000, 1000, 1250, 1000, 1250, 1250, 1500, 1500, 2000, 1000]
