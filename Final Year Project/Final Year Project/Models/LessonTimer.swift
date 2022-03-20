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
    private var wasPaused: Bool
    
    
    init() {
        self.numberOfSlides = 0
        self.slideDuration = 0.0
        self.isFinished = false
        self.progress = 0.0
        self.publisher = Timer.publish(every: 0.01, on: .main, in: .default)
        self.wasPaused = false
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
                if self.wasPaused {
                    self.reset()
                }
            })
    }
    
    func pause(duration: Double) {
        wasPaused = true
        cancellable?.cancel()
        publisher = Timer.publish(every: duration, on: .main, in: .default)
        start(numberOfSlides: numberOfSlides, slideDuration: slideDuration)
    }
    
    func reset() {
        self.wasPaused = false
        self.publisher = Timer.publish(every: 0.01, on: .main, in: .default)
        start(numberOfSlides: numberOfSlides, slideDuration: slideDuration)
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
