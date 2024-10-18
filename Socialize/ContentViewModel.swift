//
//  ContentViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 27/08/24.
//

import Foundation
import Firebase
import Combine
import FirebaseAuth

@MainActor
class ContentViewModel:ObservableObject{
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser : user?
    init() {
        setupSubscribers()
    }
    @MainActor
    func setupSubscribers(){
        service.$userSession.sink {userSession in
            self.userSession = userSession
        }
        .store(in: &cancellables)
        service.$currentUser.sink {currentUser in
            self.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
