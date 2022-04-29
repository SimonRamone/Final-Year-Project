//
//  QuizView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 20/03/2022.
//

import SwiftUI

struct QuizView: View {
    @StateObject var lessonTimer: LessonTimer = LessonTimer()
    @StateObject var quizScorer: QuizScorer = QuizScorer()
    
    @Binding var isPresentingQuiz: Bool
    @Binding var quiz: Quiz
    @Binding var user: User
    @State var isClicked = false
    @State var isCorrect = false
    var body: some View {
        if isPresentingQuiz && !lessonTimer.isFinished {
            ZStack{
                VStack {
                    VStack {
                        HStack {
                            ForEach(0..<quiz.questions.count, id: \.self) { i in
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
                        }
                        Text("Question \(Int(lessonTimer.progress + 1))")
                            .bold()
                            .font(.title)
                        Image(quiz.questions[Int(lessonTimer.progress)].image)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: UIScreen.main.bounds.width - 30, maxWidth: UIScreen.main.bounds.width - 30, maxHeight: UIScreen.main.bounds.height/4)
                            .cornerRadius(20)
                        Text(.init(quiz.questions[Int(lessonTimer.progress)].prompt))
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                            .padding()
                            .frame(minWidth: UIScreen.main.bounds.width - 30, maxWidth: UIScreen.main.bounds.width - 30, maxHeight: 150)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    ForEach (quiz.questions[Int(lessonTimer.progress)].answers) { answer in
                        Button(action: {
                            if answer.isCorrect {
                                isCorrect = true
                            }
                            isClicked = true
                            lessonTimer.stop()
                            if answer.isCorrect {
                                quizScorer.addPoints(points: Int(1500/quiz.questions.count), factor: (1.1-lessonTimer.progress.truncatingRemainder(dividingBy: 1)))
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                isCorrect = false
                                isClicked = false
                                if Int(lessonTimer.progress) + 1 >= quiz.questions.count {
                                    isPresentingQuiz = false
                                } else {
                                    lessonTimer.skip(by: 1)
                                    lessonTimer.start()
                                    quizScorer.questionScore = 0
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
                VStack{
                    Spacer()
                    if isClicked {
                        VStack{
                            if isCorrect {
                                Text("Correct!")
                                    .bold()
                            } else {
                                Text("Incorrect!")
                                    .bold()
                            }
                            Text("\(quizScorer.questionScore) points")
                                .bold()
                        }
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 10, x: 0, y: 0)
                        .padding(.bottom)
                    }
                }
            }
            .background(Color.white)
            .onAppear {
                lessonTimer.set(numberOfSlides: quiz.questions.count, slideDuration: 10.0)
                lessonTimer.start()
            }
            .onDisappear {
                isPresentingQuiz = false
                quiz.isCompleted = true
                lessonTimer.reset()
                quizScorer.finaliseScore(maxScore: 1000)
                user.hasCompleted[quiz.title] = true
                user.quizScores[quiz.title] = quizScorer.totalScore
                quizScorer.reset()
            }
        }
    }
}
