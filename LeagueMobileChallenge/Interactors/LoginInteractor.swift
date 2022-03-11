//
//  LoginInteractor.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Combine

protocol LoginStatus: AnyObject {
    func loginStatus(success: Bool)
}

class LoginInteractor {
    
    var interactorDelegate: InteractorDelegate?
    var subscribers = Set<AnyCancellable>()
    weak var loginStatus: LoginStatus?
    
    func fecthApiKey() {

        interactorDelegate?.fetchAPIKey().sink(receiveCompletion: { completion in
        }, receiveValue: { [weak self] apiKey in
            Defaults.apiKey = apiKey.key.toBase64()
            print("API KEY", apiKey.key)
            self?.loginStatus?.loginStatus(success: true)
        }).store(in: &subscribers)
    }
}
