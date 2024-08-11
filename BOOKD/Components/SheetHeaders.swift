//
//  StocksExample.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/3/24.
//

import SwiftUI
import BottomSheet



struct FeedHeader: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Your Feed".uppercased())
                        .font(.custom("InterTight-ExtraBold", size: 18))
                        
                        
                    Text("From Your Area".uppercased())
                        .font(.custom("InterTight-Light", size: 12))
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                .padding(.top, 10)
                .padding(.bottom, 16)

                Spacer()
            }

            Divider()
             .frame(height: 1)
             .background(Color(UIColor.systemGray6))
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
    }
}

struct RoomControlsHeader: View {
    var body: some View {
        VStack {
            HStack {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Controls".uppercased())
                            .font(.custom("InterTight-ExtraBold", size: 18))
                            .foregroundStyle(.red)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Leave Room")
                            .font(.custom("InterTight-Bold", size: 12))
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.red.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                } .padding(.top, 10)
                    .padding(.bottom, 16)

                Spacer()
            }

            Divider()
             .frame(height: 1)
             .background(Color(UIColor.systemGray6))
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
    }
}

struct StocksExample_Previews: PreviewProvider {
    static var previews: some View {
        FeedHeader()
    }
}



