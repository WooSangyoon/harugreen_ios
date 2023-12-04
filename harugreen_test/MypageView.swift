//
//  MypageView.swift
//  harugreen_test
//
//  Created by WooSY on 2023/11/10.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                        .frame(width: 40)
                    Circle()
                        .frame(width: 90, height: 90)
                    Text("우상윤")
                        .font(.system(size: 24, weight: .regular))
                    Spacer()
                }
                Text("최근 활동")
                    .padding(.leading, 50)
                    .padding(.top, 10)
                HStack{
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 320, height: 90)
                            .cornerRadius(15)
                        Text("일기 작성")
                    }
                        
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MypageView()
}
