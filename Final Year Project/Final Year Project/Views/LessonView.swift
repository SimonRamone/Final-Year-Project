//
//  LessonView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 13/03/2022.
//

import SwiftUI

struct LessonView: View {
    @StateObject var lessonTimer: LessonTimer = LessonTimer()
    
    @State var i = 0
    @State var lessonImage: String?
    @State var lessonText: String?
    @Binding var isPresentingLesson: Bool
    @Binding var lesson: Lesson
    var body: some View {
        if isPresentingLesson && !lessonTimer.isFinished {
            ZStack{
                VStack{
                    HStack{
                        ForEach(0..<lesson.slides.count) { i in
                            ProgressView(value: min( max( (CGFloat(lessonTimer.progress) - CGFloat(i)), 0.0) , 1.0) )
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.white))
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
                            Text(lesson.title)
                                .font(.title2)
                                .foregroundColor(.white)
                            Text(lesson.subtitle)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {
                            isPresentingLesson = false
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
                            .clipShape(Circle())
                    }
                    Spacer()
                    Text(lesson.slides[Int(lessonTimer.progress)].caption)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(15)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                HStack{
                    Button(action: {
                        lessonTimer.skip(by: -1)
                    }, label: {
                        Rectangle()
                            .foregroundColor(.clear)
                    })
                        .padding(.trailing)
                    Spacer()
                    Button(action: {
                        if Int(lessonTimer.progress) + 1 >= lesson.slides.count {
                            isPresentingLesson = false
                        } else {
                            lessonTimer.skip(by: 1)
                        }
                    }, label: {
                        Rectangle()
                            .foregroundColor(.clear)
                    })
                        .padding(.leading)
                }
                .padding(.top, 60)
            }
            .background(
                Image(lesson.slides[Int(lessonTimer.progress)].image)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(alignment: .center)
            )
            .onAppear {
                lessonTimer.start(numberOfSlides: lesson.slides.count, slideDuration: 6.0)
            }
            .onDisappear {
                isPresentingLesson = false
                lessonTimer.cancel()
            }
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(isPresentingLesson: .constant(true), lesson: .constant(Lesson.sampleData))
    }
}

