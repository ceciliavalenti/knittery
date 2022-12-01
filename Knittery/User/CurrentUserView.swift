//
//  CurrentUserView.swift
//  Knittery
//
//  Created by Nick on 2022-11-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CurrentUserView: View {
    @ObservedObject var sessionData: SessionData
    @State private var isConfirmingLogout = false
    
    var body: some View {
        if let user = sessionData.currentUser {
            Menu {
                if let name = user.username {
                    Text("Signed in as \(name)")
                }
                Button (role: .destructive, action: {
                    isConfirmingLogout = true
                }) {
                    Text("Log out")
                }
            } label: {
                if let image = sessionData.profilePicture {
                    makeProfileBadge(Image(uiImage: image))
                } else if let photo = user.photoURL {
                    Group {
                        AsyncImage(url: photo, content: { image in
                            makeProfileBadge(image)
                        }, placeholder: {
                            makeProfileBadge(Image(systemName: "person.crop.circle.fill"))
                                .foregroundColor(.KnitteryColor.darkBlueTranslucent)
                        })
                    }
                } else {
                    makeProfileBadge(Image(systemName: "person.crop.circle.fill"))
                        .foregroundColor(.KnitteryColor.darkBlueTranslucent)
                }
            }
            .alert(
                "Are you sure you want to sign out?",
                isPresented: $isConfirmingLogout
            ) {
                Button("Sign Out", role: .destructive) {
                    sessionData.signOut()
                }
                Button("Cancel", role: .cancel) {
                    isConfirmingLogout = false
                }
            }
        }
    }
}

func makeProfileBadge(_ image: Image) -> some View {
    image
        .resizable()
        .scaledToFit()
        .frame(width: 32, height: 32)
        .clipShape(Circle())
        .overlay(Circle()
            .stroke(Color.KnitteryColor.darkBlue, lineWidth: 1))
}


struct CurrentUserView_Previews: PreviewProvider {
    @State static var sessionData = SessionData()
    static var previews: some View {
        CurrentUserView(sessionData: sessionData)
    }
}
