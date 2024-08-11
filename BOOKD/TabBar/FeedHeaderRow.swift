//
//  FeedHeaderRow.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//


import SwiftUI

struct FeedHeaderRow<Trailing: View>: View {
    var text: String
    var size: CGFloat
    var padding: Bool = true
    var vPadding: CGFloat = 16
    var trailing: Trailing

    init(
        text: String,
        size: CGFloat,
        padding: Bool = true,
        vPadding: CGFloat = 16,
        @ViewBuilder trailing: () -> Trailing = { EmptyView() as! Trailing }
    ) {
        self.text = text
        self.size = size
        self.padding = padding
        self.vPadding = vPadding
        self.trailing = trailing()
    }

    var body: some View {
        HStack {
            Text(text.uppercased())
                .font(.custom("InterTight-ExtraBold", size: size))
            Spacer()
            trailing
        }
        .padding(.horizontal)
        .padding(padding ? vPadding : 0)
    }
}



