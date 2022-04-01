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
    @Binding var story: Story
    @Binding var quiz: Quiz
    @Binding var user: User
    var body: some View {
        NavigationView{
            ScrollView {
                ForEach($lessons) { $lesson in
                    VStack {
                        ZStack{
                            Image(lesson.story.coverImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                            
                            VStack{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(lesson.story.subtitle)
                                            .font(.headline)
                                        Text(lesson.story.title)
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
                            story = lesson.story
                    }
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.teal.opacity(0.3))
                                .frame(width: UIScreen.main.bounds.width - 30 , height: 70)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(lesson.quiz.title)
                                        .font(.headline)
                                    Text(!(user.hasCompleted[lesson.quiz.title] ?? false) ? "Not Complete" : "Score: \(user.quizScores[lesson.quiz.title] ?? 0)")
                                        .font(.subheadline)
                                }
                                Spacer()
                                Button(action: {
                                    quiz = lesson.quiz
                                    isPresentingQuiz.toggle()
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
                //if lessons.isEmpty {
                    do {
                        lessons = try JSONDecoder().decode([Lesson].self, from: NSDataAsset(name: "lessons-data", bundle: Bundle.main)!.data)
                    } catch {
                        print(error.localizedDescription)
                    }
                //}
            }
            .navigationTitle("Learn")
        }
    }
}

//struct LearnView_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnView(lessons: .constant([Lesson.sampleData]), isPresentingLesson: .constant(false), isPresentingQuiz: .constant(false), lessonView: .constant(Lesson.sampleData))
//    }
//}
