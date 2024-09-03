//
//  UserService.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI


class UserService: ObservableObject {
    
    static let shared = UserService()
    
    private let model = Model.shared
    
    @Published private(set) var isInGuestMode: Bool = true
    @Published private(set) var currentUser: User? = nil {
        didSet {
            isInGuestMode = (currentUser == nil)
        }
    }
    
    private init() {}
    
    var nickname: String? {
        currentUser?.nickname
    }
    
    var fullName: String? {
        currentUser?.name
    }
    
    
    var phone: String? {
        currentUser?.phone
    }
    
    
    func validateNickname(_ nickname: String) -> FieldState {
        return .valid
    }
    
    func validateFullName(_ name: String) -> FieldState {
        if(name.isEmpty) {
            return .invalid("Fullname Cannot Be Empty")
        }
        
        do {
            if(name.contains(try Regex("[^A-Za-z0-9., ']"))) {
                return .invalid("Fullname Cannot Contain Special Characters")
            }
            
            if(name.contains(try Regex("[0-9]"))) {
                return .invalid("Fullname cannot contain Numbers")
            }
        } catch { }
        
        
        return .valid
    }
    
    func validatePhone(_ phone: String) -> FieldState {
        do {
            if(phone.contains(try Regex("[^0-9]"))) {
                return .invalid("Non-Digits are Entered")
            }
            
            if(phone.count != 10) {
                return .invalid("Phone Numbers Should Have 10 Digits")
            }
        } catch {}
        
        return .valid
    }
    
    func setNickname(_ newNickName: String?) -> Bool {
        if let newNickName,
           let currentUser {
            currentUser.nickname = newNickName
            
            return true
        }
        
        return false
    }
    
    func setFullname(_ newFullName: String?) -> Bool {
        if let newFullName,
           let currentUser {
            currentUser.name = newFullName
            
            return true
        }
        
        return false
    }
    
    func login(phone: String) -> Bool {
        if let user = checkIfUserExists(phone: phone){
            currentUser = user
            return true
        }
        
        return false
    }
    
    @discardableResult
    func signUp(name: String, phone: String, nickname: String) -> Bool {
        if let _ = checkIfUserExists(phone: phone) {
            return false
        }
        
        let newUser = User(id: model.users.count, name: name, nickname: nickname, preferedTheme: "", phone: phone, profilePic: "")
        model.users.append(newUser)
        
        // Create all collections associated to user
        model.rentalBookings.updateValue([], forKey: newUser)
        model.taxiBookings.updateValue([], forKey: newUser)
        model.favorites.updateValue([], forKey: newUser)
        
        currentUser = newUser
        
        return true
    }
    
    func logOut() -> Bool {
        if currentUser == nil {
            return false
        } else {
            currentUser = nil
            return true
        }
    }
    
    private func checkIfUserExists(phone: String) -> User? {
        model.users.first { phone == $0.phone }
    }
    
    
}

@propertyWrapper struct GuestMode: DynamicProperty {
    
    @ObservedObject var userService: UserService = .shared
    
    var wrappedValue: Bool {
        userService.isInGuestMode
    }
    
}


@propertyWrapper struct CurrentUser: DynamicProperty {
    @ObservedObject var userService: UserService = .shared
    
    var wrappedValue: User? {
        userService.currentUser
    }
}
