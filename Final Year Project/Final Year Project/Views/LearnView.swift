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
    @Binding var isPresentingQuiz: Bool
    @Binding var lessonView: Lesson
    var body: some View {
        NavigationView{
            ScrollView {
                ForEach($lessons) { $lesson in
                    VStack {
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
                        .onTapGesture {
                            isPresentingLesson = true
                            lessonView = lesson
                    }
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.teal.opacity(0.3))
                                .frame(width: UIScreen.main.bounds.width - 30 , height: 70)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("First Quiz")
                                        .font(.headline)
                                    Text("Not Complete")
                                        .font(.subheadline)
                                }
                                Spacer()
                                Button(action: {
                                    isPresentingQuiz = true
                                }, label: {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        Image(systemName: "play.circle.fill")
                                            .font(.system(size: 40.0))
                                            .foregroundColor(.teal)
                                    }
                                })
                            }
                            .padding()
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
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
//            LearnView(lessons: .constant(Lesson.lessons), isPresentingLesson: .constant(false), lessonView: .constant(Lesson.sampleData))
//    }
//}
