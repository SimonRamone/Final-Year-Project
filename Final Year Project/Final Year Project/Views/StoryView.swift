//
//  LessonView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 13/03/2022.
//

import SwiftUI

struct StoryView: View {
    private let achievementReporter: AchievementReporter = AchievementReporter()
    @StateObject var lessonTimer: LessonTimer = LessonTimer()
    
    @State var i = 0
    @State var image: String?
    @State var text: String?
    @Binding var isPresentingStory: Bool
    @Binding var story: Story
    @Binding var user: User
    
    @Binding var isPresentingInfoPopUp: Bool
    @Binding var popUpMessage: String
    var body: some View {
        if isPresentingStory && !lessonTimer.isFinished {
            ZStack{
                VStack{
                    HStack{
                        ForEach(0..<story.slides.count, id: \.self) { i in
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
                            Text(story.title)
                                .font(.title2)
                                .foregroundColor(.white)
                            Text(story.subtitle)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {
                            isPresentingStory = false
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
                    Spacer()
                    Text(story.slides[Int(lessonTimer.progress)].caption)
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
                        if Int(lessonTimer.progress) + 1 >= story.slides.count {
                            isPresentingStory = false
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
                ZStack{
                    Color.black.edgesIgnoringSafeArea(.all)
                    Image(story.slides[Int(lessonTimer.progress)].image)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(alignment: .center)
                }
            )
            .onAppear {
                lessonTimer.set(numberOfSlides: story.slides.count, slideDuration: 6.0)
                lessonTimer.start()
            }
            .onDisappear {
                isPresentingStory = false
                lessonTimer.reset()
                
                if !(user.hasCompleted[story.title] ?? false) {
                    story.isCompleted = true
                    user.hasCompleted[story.title] = true
                    achievementReporter.reportAchievement(identifier: "badge_1")
                    for item in story.unlocks {
                        user.hasUnlocked[item] = true
                    }
                    popUpMessage = "You just unlocked a badge!"
                    isPresentingInfoPopUp = true
                }
            }
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

