//
//  PatternResultsView.swift
//  Knittery
//
//  Created by Nick on 2022-10-31.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternResultsView: View {
    @StateObject var patternResultsViewModel = PatternResultsViewModel()
    @Binding var path: [SearchViewModel.NavDestination]
    @EnvironmentObject var sessionData: SessionData
    
    @State var hasLoaded = false
    
    let query: String?
    
    init(_ query: String?, path: Binding<[SearchViewModel.NavDestination]>) {
        self._path = path
        // TODO: the following line fails (sets nil) if query is a state variable and I don't know why
        self.query = query
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.KnitteryColor.darkBlue)]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
    }
    
    var body: some View {
        VStack {
            ScrollView (showsIndicators: false) {
                LazyVStack {
                    ForEach (patternResultsViewModel.patternResults, id: \.id) { result in
                        NavigationLink(destination: PatternDetailsView(result.id).environmentObject(sessionData)) {
                            KnitteryPatternRow(pattern: result)
                        }
                    }
                }
                .navigationTitle("Pattern Search")
                .toolbar(.visible, for: .navigationBar)
                .toolbar {
                    NavigationToolbar(sessionData: sessionData)
                }
            }
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
        .onAppear() {
            if !hasLoaded {
                patternResultsViewModel.performSearch(query: query)
                hasLoaded = true
            }
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    @State static var path: [SearchViewModel.NavDestination] = []
    
    static var previews: some View {
        PatternResultsView(nil, path: $path)
            .environmentObject(SessionData())
    }
}
