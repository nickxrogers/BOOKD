//
//  SearchField.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI
import Foundation
import Combine

struct SearchField: View {
    @State var searchText = ""
    @FocusState var isTextFieldFocused: Bool
    @Binding var searchFieldTopPadding: CGFloat // Add this line
    @Binding var searchFieldHPadding: CGFloat // Add this line
    @Binding var topPadding: CGFloat
    @State var prompt: String
    @State var promptSize: CGFloat

    var body: some View {
        HStack {
            TextField("", text: $searchText, prompt: Text(prompt.uppercased()).font(.custom("InterTight-Regular", size: promptSize)))
                .focused($isTextFieldFocused)
            Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
        }.padding(.horizontal).padding(.vertical, topPadding).background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding(.bottom)
            .padding(.horizontal, searchFieldHPadding)
            .padding(.top, searchFieldTopPadding) // Modify this line
            .shadow(color: Color.black.opacity(0.20), radius: 8)
    }
}
