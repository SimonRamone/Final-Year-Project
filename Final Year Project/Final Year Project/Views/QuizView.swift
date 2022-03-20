//
//  QuizView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 20/03/2022.
//

import SwiftUI

struct QuizView: View {
    @StateObject var lessonTimer: LessonTimer = LessonTimer()
    
    @Binding var isPresentingQuiz: Bool
    @Binding var quiz: Quiz
    @State var isClicked = false
    var body: some View {
        if isPresentingQuiz && !lessonTimer.isFinished {
            ZStack{
                VStack{
                    HStack{
                        ForEach(0..<quiz.questions.count) { i in
                            ProgressView(value: min( max( (CGFloat(lessonTimer.progress) - CGFloat(i)), 0.0) , 1.0) )
                                .progressViewStyle(.linear)
                        }
                    }
                    HStack{
                        ZStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.white)
                            Image(systemName: "leaf.circle.fill")
                                .foregroundColor(.green)
                        }
                        .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(quiz.title)
                                .font(.title2)
                                .foregroundColor(.black)
                            Text(quiz.subtitle)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            isPresentingQuiz = false
                        }, label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                        })
                    }
                    Text("Question \(Int(lessonTimer.progress + 1))")
                        .bold()
                        .font(.largeTitle)
                    Image(quiz.questions[Int(lessonTimer.progress)].image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 30 , height: 250)
                        .cornerRadius(20)
                    Text(quiz.questions[Int(lessonTimer.progress)].prompt)
                        .font(.body)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .foregroundColor(.black)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.bottom)
                    ForEach (quiz.questions[Int(lessonTimer.progress)].answers) { answer in
                        Button(action: {
                            isClicked = true
                            lessonTimer.pause(duration: 1.0)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                isClicked = false
                                if Int(lessonTimer.progress) + 1 >= quiz.questions.count {
                                    isPresentingQuiz = false
                                } else {
                                    lessonTimer.skip(by: 1)
                                }
                            }
                        }, label: {
                            ZStack {
                                Text(answer.text)
                                    .font(.headline)
                                    .frame(width: UIScreen.main.bounds.width - 30 , height: 50)
                                    .foregroundColor(isClicked ? .white : .black)
                                    .background(isClicked && answer.isCorrect ? Color.green : isClicked && !answer.isCorrect ? Color.red : Color.gray.opacity(0.2))
                                    .cornerRadius(25)
                            }
                        })
                            .disabled(isClicked)
                    }
                    Spacer()
                    
                }
                .padding(.horizontal)
            }
            .background(Color.white)
            .onAppear {
                lessonTimer.start(numberOfSlides: quiz.questions.count, slideDuration: 6.0)
            }
            .onDisappear {
                isPresentingQuiz = false
                quiz.isComplete = true
                lessonTimer.cancel()
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(isPresentingQuiz: .constant(true), quiz: .constant(Quiz.sampleQuiz))
    }
}
