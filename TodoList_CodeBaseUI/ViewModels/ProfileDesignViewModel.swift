//
//  ProfileDesignViewModel.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 1/31/24.
//

import Foundation

class ProfileDesignViewModel {
    private var userProfile: UserProfile

    var userName: String {
        return userProfile.userName
    }
    
    var userAge: Int {
        return userProfile.userAge
    }

    var bio: String {
        return userProfile.bio
    }

    var link: String {
        return userProfile.link
    }

    var postsCount: String {
        return "\(userProfile.postsCount)"
    }

    var followersCount: String {
        return "\(userProfile.followersCount)"
    }

    var followingCount: String {
        return "\(userProfile.followingCount)"
    }

    init(userProfile: UserProfile) {
        self.userProfile = userProfile
    }
}
