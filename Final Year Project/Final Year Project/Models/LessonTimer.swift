//
//  LessonTimer.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 18/03/2022.
//

import Foundation
import Combine

class LessonTimer: ObservableObject {
    
    @Published var progress: Double = 0.0
    @Published var isFinished: Bool = false
    private(set) var numberOfSlides: Int = 0
    private(set) var slideDuration: TimeInterval = 0.0
    private var publisher: Timer.TimerPublisher = Timer.publish(every: 0.01, on: .main, in: .default)
    private var cancellable: Cancellable?
    
    func set(numberOfSlides: Int, slideDuration: TimeInterval) {
        self.numberOfSlides = numberOfSlides
        self.slideDuration = slideDuration
    }
    
    func start() {
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
    
    func stop() {
        cancellable?.cancel()
    }
    
    func reset() {
        isFinished = false
        progress = 0.0
        cancellable?.cancel()
    }
    
    func skip(by: Int) {
        progress = max(floor(progress) + Double(by), 0.0)
    }
}
