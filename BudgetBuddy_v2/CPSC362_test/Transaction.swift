//
//  Transaction.swift
//  CPSC362_test
//


import Foundation
import FirebaseFirestoreSwift

struct Transaction: Codable, Identifiable {
    @DocumentID var id:String?
    var item:String
    var cost:Double
    var type:String
    var datetime:Date
    var uid:String
}
