//
//  LearnView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 01/02/2022.
//

import SwiftUI

struct LearnView: View {
    @Binding var lessons: [Lesson]
    @Binding var isPresentingLesson: Bool
    @Binding var lessonView: Lesson
    var body: some View {
        NavigationView{
            ScrollView {
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
                    .onTapGesture {
                        isPresentingLesson = true
                        lessonView = lesson
                    }
                }
            }
            .onAppear(){
                if lessons.isEmpty {
                    do {
                        lessons = try JSONDecoder().decode([Lesson].self, from: NSDataAsset(name: "lessons-data", bundle: Bundle.main)!.data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .navigationTitle("Learn")
        }
    }
}

//struct LearnView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            LearnView(lessons: .constant(Lesson.sampleData))
//        }
//    }
//}
