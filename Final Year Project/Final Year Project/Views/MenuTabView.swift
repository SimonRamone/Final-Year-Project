//
//  ContentView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 31/01/2022.
//

import SwiftUI
import GameKit

struct MenuTabView: View {
    @Binding var lessons: [Lesson]
    @Binding var badges: [Badge]
    @Binding var user: User
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingInfoPopUp: Bool = false
    @State private var popUpMessage: String = ""
    
    @State private var isPresentingStory: Bool = false
    @State private var story: Story = Story()
    
    @State private var isPresentingQuiz: Bool = false
    @State private var quiz: Quiz = Quiz()
    
    @State private var isPresentingLoadingView: Bool = false
    
    let saveAction: ()->Void
    
    let localPlayer = GKLocalPlayer.local
        func authenticateUser() {
            localPlayer.authenticateHandler = { vc, error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                GKAccessPoint.shared.isActive = false
            }
            GKAccessPoint.shared.isActive = false
        }
    
    var body: some View {
            ZStack{
             
                    TabView {
                        HomeView(isPresentingInfoPopUp: $isPresentingInfoPopUp, isPresentingLoadingView: $isPresentingLoadingView, popUpMessage: $popUpMessage, user: $user)
                                .tabItem {
                                    Image(systemName: "house.fill")
                                    Text("Home")
                                }
                            TrackView()
                                .tabItem {
                                    Image(systemName: "leaf.fill")
                                    Text("Track")
                                }
                        LearnView(lessons: $lessons, isPresentingLesson: $isPresentingStory, isPresentingQuiz: $isPresentingQuiz, story: $story, quiz: $quiz, user: $user)
                                .tabItem {
                                    Image(systemName: "book")
                                    Text("Learn")
                                }
                        AwardsView(badges: $badges, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage, user: $user)
                                .tabItem {
                                Image(systemName: "crown.fill")
                                    Text("Awards")
                                }
                    }
               .disabled(isPresentingStory)
               // .blur(radius: isPresentingInfoPopUp ? 10 : .nan)
                //if isPresentingInfoPopUp { VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial)).ignoresSafeArea(.all)}
                PopUpView(isPresented: $isPresentingInfoPopUp, title: "", message: popUpMessage, buttonText: "Got it!")
                    .shadow(color: .gray, radius: 10, x: 0, y: 0)
                
                StoryView(isPresentingStory: $isPresentingStory, story: $story, user: $user, isPresentingInfoPopUp: $isPresentingInfoPopUp, popUpMessage: $popUpMessage)
                
                QuizView(isPresentingQuiz: $isPresentingQuiz, quiz: $quiz, user: $user)
                
                if isPresentingLoadingView {
                    ZStack{
                        Rectangle()
                            .fill(.white)
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    .background(Color.white)
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                }
            }
                .onAppear(){
                    authenticateUser()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                        }

    }
}

//var gcEnabled = Bool() // Check if the user has Game Center enabled
//var gcDefaultLeaderBoard = String() // Check the default leaderboardID
//
//func authenticateUser() {
//    let localPlayer: GKLocalPlayer = GKLocalPlayer.local
//
//    localPlayer.authenticateHandler = {(ViewController, error) -> Void in
//        if ((ViewController) != nil) {
//            // Show game center login if player is not logged in
//            self.present(ViewController!, animated: true, completion: nil)
//        }
//        else if (localPlayer.isAuthenticated) {
//
//            // Player is already authenticated and logged in
//            self.gcEnabled = true
//
//            // Get the default leaderboard ID
//            localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
//                if error != nil {
//                    print(error!)
//                }
//                else {
//                    self.gcDefaultLeaderBoard = leaderboardIdentifer!
//                }
//             })
//        }
//        else {
//            // Game center is not enabled on the user's device
//            self.gcEnabled = false
//            print("Local player could not be authenticated!")
//            print(error!)
//        }
//    }
//}
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            MenuTabView(lessons: .constant(Lesson.lessons), badges: .constant(Badge.sampleData), carbonFootprint: .constant(CarbonFootprint.defaultCarbonFootprint), saveAction: {})
//        }
//    }

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
