//
//  DBService.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 29.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DBService {
  // MARK: -Properties
  static let shared: DBService = DBService()
  private var db: Firestore
  private var currentUID: String {
    return Auth.auth().currentUser!.uid
  }
  
  // MARK: -Methods
  private init() {
    self.db = Firestore.firestore()
    let settings = db.settings
    settings.areTimestampsInSnapshotsEnabled = true
    self.db.settings = settings
  }
  
  func createUser(data: [String : Any], completion: @escaping (Error?) -> Void) {
    db.collection("users").document(currentUID).setData(data, completion: { error in
      if let error = error {
        print("[DBService Error]: ", error.localizedDescription)
        completion(error)
      } else {
        completion(nil)
      }
    })
  }
  
  func updateUsername(username: String, completion: @escaping (Error?) -> Void) {
    let data = ["username" : username]
    db.collection("users").document(currentUID).setData(data, merge: true, completion: { error in
      if let error = error {
        print("[DBService Error]: ", error.localizedDescription)
        completion(error)
      } else {
        completion(nil)
      }
    })
  }
  
  func fetchLeaderboard(completion: @escaping ([LeaderboardModel]?, Error?) -> Void) {
    var userRecords: [LeaderboardModel] = []
    
    db.collection("users")
      .order(by: "total_score", descending: true)
      .order(by: "timestamp", descending: false)
      .limit(to: 5)
      .getDocuments { (snapshot, error) in
        if let error = error {
          print("[DBService Error]: ", error.localizedDescription)
          completion(nil, error)
        } else {
          guard let documents = snapshot?.documents else { return }
          
          for document in documents {
            do {
              let data = try JSONSerialization.data(withJSONObject: document.data(), options: [])
              
              let newUserRecord = try JSONDecoder().decode(LeaderboardModel.self, from: data)
              userRecords.append(newUserRecord)
              
            } catch let err {
              print("[DBService Error]: ", err.localizedDescription)
              completion(nil, err)
            }
          }
          completion(userRecords, nil)
        }
    }
  }
  
  func addQuestion(data: [String : Any], completion: @escaping (Error?) -> Void) {
    db.collection("questions").addDocument(data: data) { error in
      if let error = error {
        print(error.localizedDescription)
        completion(error)
      } else {
        completion(nil)
      }
    }
  }
  
  func getQuestions(completion: @escaping ([QuizModel]?, Error?) -> Void) {
    db.collection("questions")
      .order(by: "random_factor")
      .whereField("random_factor", isGreaterThan: UInt32.random(in: 0...UInt32.max - 1))
      .limit(to: 10)
      .getDocuments { (querySnapshot, error) in
        if let error = error {
          print("[DBService Error]: ", error.localizedDescription)
          completion(nil, error)
        } else {
          guard let querySnapshot = querySnapshot else { return }
          let documents = querySnapshot.documents
          var quizModels: [QuizModel] = []
          
          for document in documents {
            do {
              let data = try JSONSerialization.data(withJSONObject: document.data(), options: [])
              let newQuestionModel = try JSONDecoder().decode(QuestionModel.self, from: data)
              quizModels.append(newQuestionModel.extractQuizModel())
            } catch let err {
              print("[DBService Error]: ", err.localizedDescription)
              completion(nil, err)
            }
          }
          completion(quizModels, nil)
        }
    }
  }
  
  func updateScore(correctAnswers: Int, completion: @escaping (Error?) -> Void) {
    let ref = db.collection("users").document(currentUID)
    ref.getDocument { (document, error) in
      if let error = error {
        print("[DBService Error]: ", error.localizedDescription)
        completion(error)
      } else {
        guard let documentDict = document?.data() else { return }
        
        var data: [String : Any] = [:]
        
        if var value = documentDict["total_score"] as? Int {
          value += correctAnswers
          data["total_score"] = value
        } else {
          data["total_score"] = correctAnswers
        }
        
        ref.setData(data, merge: true)
        completion(nil)
      }
    }
  }
  
}
