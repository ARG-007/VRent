//
//  UserManager.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class UserManager: ObservableObject {
    
    private static let userMobilePredicate = NSPredicate(format: "phone == $phone")
    
    static let shared = UserManager()
    
    @Published private(set) var guestMode: Bool = true
    
    
    private(set) var currentUser: User? {
        didSet {
            if currentUser == nil {
                guestMode = true
                setupGuestServices()
            } else {
                guestMode = false
                setupUserServices()
            }
            
            persistUser()
        }
    }
    
    var fullName: String? { currentUser?.name }
    var nickName: String? { currentUser?.nickname }
    var phone: String? { currentUser?.phone }
    
    private let model: Model = Model.shared
    @Published private(set) var favoriteManager: FavoritesManager!
    @Published private(set) var rentalManager: RentalManager!
    @Published private(set) var taxiManager: TaxiManager!
    
    
 
    private init() {
        setup()
    }
    
    private func setup() {
        guard let previousSessionLoggedInUserMobile = UserDefaults.standard.string(forKey: "LoggedInUserMobile"),
              let user = getUserBy(phone: previousSessionLoggedInUserMobile) else {
            currentUser = nil
            return
        }
        
        currentUser = user
    }
    
    private func setupGuestServices() {
        favoriteManager = FavoritesManager(delegate: GuestFavoritesService())
        rentalManager = RentalManager(delegate: GuestRentalService())
        taxiManager = TaxiManager(delegate: GuestTaxiService())
        guestMode = true
    }
    
    private func setupUserServices() {
        guard let currentUser else { return }
        favoriteManager = FavoritesManager(delegate: UserFavoriteService(for: currentUser, on: model))
        rentalManager = RentalManager(delegate: UserRentalService(for: currentUser, on: model))
        taxiManager = TaxiManager(delegate: UserTaxiService(for: currentUser, on: model))
        guestMode = false
        
    }
    
    private func persistUser() {
        UserDefaults.standard.set(currentUser?.phone ?? nil, forKey: "LoggedInUserMobile")
    }
    
    private func getUserBy(phone: String) -> User? {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = UserManager.userMobilePredicate.withSubstitutionVariables(["phone":phone])
        do {
            let user = try model.container.viewContext.fetch(fetchRequest)
            return user.first
        } catch {
            print("Error While Fetching, \(error)")
            return nil
        }
        
    }
    
    @discardableResult
    public func login(phone: String) -> Bool {
        
        guard validatePhone(phone).isValid,
            let user = getUserBy(phone: phone) else {
            return false
        }
        
        currentUser = user
        return true
    }
    
    @discardableResult
    public func signup(fullName: String, nickName: String, phone: String) -> Bool {
        guard validatePhone(phone).isValid,
              validateFullName(fullName).isValid,
              validateNickname(nickName).isValid else {
            return false
        }
        
        let newUser = User(context: model.container.viewContext)
        
        newUser.id = UUID()
        newUser.name = fullName
        newUser.nickname = nickName
        newUser.phone = phone
        newUser.avatar = "YoRHa"
        
        currentUser = newUser
        
        model.save()
        
        return true
    }
    
    @discardableResult
    public func logOut() -> Bool {
        if currentUser == nil {
            print("No User Logged In")
            return false
        } else {
            currentUser = nil
            print("Logging Out")
            return true
        }
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
    
}
