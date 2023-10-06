//
//  FireStoreManager.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FireStoreManager: ObservableObject {
    private var questions: [Question] = []
    @Published var selectedQuestion: Question? = nil
    
    func fetchQuestions() {
        let dataBase = Firestore.firestore()
        
        let collections = dataBase.collection("Questions")
        
        collections.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self?.getQuestions(to: snapshot.documents) { questions in
                self?.questions = questions
                Thread.sleep(until: .now + 0.5)
                self?.selectedQuestion = questions.randomElement()
            }
        }
    }
    
    private func getQuestions(
        to documents: [QueryDocumentSnapshot],
        with completionHandler: @escaping ([Question]) -> Void
    ) {
        var questions = [Question]()
        
        for document in documents {
            guard let question = try? document.data(as: Question.self) else {
                continue
            }
            questions.append(question)
        }
        
        completionHandler(questions)
    }
}
