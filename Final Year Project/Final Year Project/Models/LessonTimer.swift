//
//  LessonTimer.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 18/03/2022.
//

import Foundation
import Combine

class LessonTimer: ObservableObject {
    
    @Published var progress: Double
    @Published var isFinished: Bool
    private var numberOfSlides: Int
    private var slideDuration: TimeInterval
    private var publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    
    init() {
        self.numberOfSlides = 0
        self.slideDuration = 0.0
        self.isFinished = false
        self.progress = 0.0
        self.publisher = Timer.publish(every: 0.01, on: .main, in: .default)
    }
    
    func start(numberOfSlides: Int, slideDuration: TimeInterval) {
        self.numberOfSlides = numberOfSlides
        self.slideDuration = slideDuration
        self.cancellable = self.publisher
            .autoconnect()
            .sink(receiveValue: {  _ in
                let newProgress = self.progress + (0.01 / self.slideDuration)
                if newProgress >= Double(self.numberOfSlides) {
                    self.isFinished = true
                } else {
                    self.progress = newProgress
                }
            })
    }
    
    func cancel() {
        isFinished = false
        progress = 0.0
        cancellable?.cancel()
    }
    
    func skip(by: Int) {
        progress = max(floor(progress) + Double(by), 0.0)
    }
}
