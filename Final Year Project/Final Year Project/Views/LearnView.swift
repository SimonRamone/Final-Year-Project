//
//  LearnView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct LearnView: View {
    @Binding var lessons: [Lesson]
    var body: some View {
        ScrollView {
            HStack {
                Text("Lessons")
                    .font(.largeTitle)
                    .padding(.leading)
                Spacer()
            }
            
            ForEach($lessons) { $lesson in
                ZStack{
                    Image(lesson.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                        
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text(lesson.subtitle)
                                    .font(.headline)
                                Text(lesson.title)
                                    .font(.largeTitle)
                            }
                            .padding()
                            .foregroundColor(Color.white)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .cornerRadius(20)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            }
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LearnView(lessons: .constant(Lesson.sampleData))
        }
    }
}
