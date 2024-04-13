//
//  CoreDataModel.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/10/24.
//

import Foundation
import CoreData



class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    var mSeen : SeenList?
    var maxQuestionId = 1602
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "QuestionDatabase")
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init() {
        loadDump0()
        initSeen()
    }
    
    func initSeen() {
        let fr = SeenList.fetchRequest()
        do {
            let fetchResult = try persistentContainer.viewContext.fetch(fr)
            if fetchResult.count==1{
                print("got MSeen Instance, woohoo!")
                mSeen = fetchResult[0]
            }
            else if fetchResult.count == 0 {
                var toSave = SeenList(context: persistentContainer.viewContext)
                print("savedNew seen")
                toSave.allSeen = [[Int]]()
                mSeen = toSave
                do {
                    try persistentContainer.viewContext.save()
                }
                catch{
                    print("failed to save all seen in init seen due to \(error)")
                }
            }
            else {
                print("HOLY HECK TWO MANY SEEN LISTS")
            }
        }
        catch {
            print("failed to get SeenList because errors \(error)")
        }
    }
    
    func getHistory() -> [[Int]]{
        var result = [[Int]]()
        if let unwrapped = mSeen {
            return unwrapped.allSeen!
        }
        return result
    }
    
    func addHistory(toAdd : [Int]){
        if let unwrappedSeen = mSeen {
            (unwrappedSeen.allSeen!).append(toAdd)
            do {
                try persistentContainer.viewContext.save()
            }
            catch {
                print("failed to save in addHistory due to \(error)")
            }
        }
        else {
            print("no history object to write too!")
        }
    }
    
    
    func getCount(){
        
    }
    
    func readJSONFile(forName name: String) -> [String : Any]?{
       do {
          if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                print("JSON: \(json)")
                 return json
             } else {
                print("Given JSON is not a valid dictionary object.")
             }
          }
       } catch {
          print(error)
       }
        return nil//[String : Any]()
    }
    
    func loadDump0(){
        print("loading dump")
        print("checking if already loaded")
        let result = fetchID(id: 1602)
        if result.count != 0{
            print("already loaded dump!!!")
            return
        }
        let filename = "renumberedQs"
        let dump = readJSONFile(forName : filename)
        if let dump = dump {
            let jsonQuestions = dump["qArray"] as! [[String : Any]]
            for dict in jsonQuestions{
                let staticQuestion = QStatic(context: persistentContainer.viewContext)
                staticQuestion.id = dict["id"] as! Int64
                staticQuestion.question = dict["question"] as! String
                staticQuestion.correct = dict["correct"] as! Int64
                staticQuestion.answers = dict["options"] as! [String]
                staticQuestion.category = dict["category"] as! String
                staticQuestion.topic = dict["topic"] as! String
            }
            do {
                try persistentContainer.viewContext.save()
            }
            catch{
                print("loaded JSONS but failed to write them to persistent Container")
            }
        }
        else {
            print("dump returned empty =(")
        }
        
    }
    
    func fetchID(id: Int) -> [QStatic]{
        do{
            let fr = QStatic.fetchRequest()
            fr.predicate = NSPredicate(format: "id == \(id)")
            let returnVal = try persistentContainer.viewContext.fetch(fr)
            return returnVal
        }
        catch{
            print("hit an error running fetchID")
        }
        return [QStatic]()
    }
}
