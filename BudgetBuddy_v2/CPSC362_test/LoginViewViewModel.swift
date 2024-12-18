//
//  LoginViewViewModel.swift
//  CPSC362_test
//
//

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject{
    @Published var email:String=""
    @Published var password:String=""
    @Published var isError:Bool=false
    @Published var message:String=""
    
    init(){}
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle the error (e.g., display an error message)
                self.isError=true
                self.message=error.localizedDescription
                print("Error signing in: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                // User signed in successfully
                print("User signed in: \(user.uid)")
            }
        }
    }
}
