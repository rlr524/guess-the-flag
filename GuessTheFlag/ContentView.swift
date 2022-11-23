//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rob Ranf on 11/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
                     "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionNumber = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [.gray, .white]),
            //                           startPoint: .top,
            //                           endPoint: .bottom)
            //                .ignoresSafeArea()
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45),
                                         location: 0.3),
                                   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26),
                                         location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5.0)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("New Game", action: reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if questionNumber <= 8 {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
                questionNumber += 1
            } else {
                scoreTitle = "Incorrect. That is the flag of \(countries[number])"
                score -= 1
                questionNumber += 1
            }
        } else {
            gameOver = true
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        questionNumber = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
// struct ContentView: View {
//    var body: some View {
//        VStack {
//            Button("Button 1") {}
//                .buttonStyle(.bordered)
//            Button("Button 2", role: .destructive) {}
//                .buttonStyle(.bordered)
//            Button("Button 3") {}
//                .buttonStyle(.borderedProminent)
//                .tint(.mint)
//            Button("Button 4", role: .destructive) {}
//                .buttonStyle(.borderedProminent)
//            Button("Execute Order 66", role: .destructive, action: executeDelete)
//                .buttonStyle(.borderedProminent)
//            Button {
//                print("Button was tapped")
//            } label: {
//                Text("Tap me!")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(.red)
//            }
//            Button {
//                print("Edit button was tapped")} label: {
//                    Label("Edit", systemImage: "pencil")
//                }
//                .buttonStyle(.bordered)
//        }
//
//        LinearGradient(gradient: Gradient(stops: [
//            .init(color: .white, location: 0.45),
//            .init(color: .black, location: 0.55)
//        ]), startPoint: .top, endPoint: .bottom)
//
//        RadialGradient(gradient: Gradient(colors: [.red, .black]), center: .center, startRadius: 20.0, endRadius: 200)
//
//        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
//    }
//
//    func executeDelete() {
//        print("Now deleting...")
//    }
// }

// struct ContentView: View {
//    @State private var showingAlert = false
//
//    var body: some View {
//        Button("Show Alert") {
//            showingAlert = true
//        }
//        .alert("Important Message", isPresented: $showingAlert) {
//            Button("Delete", role: .destructive) {}
//            Button("Cancel", role: .cancel) {}
//        }
//    }
// }
