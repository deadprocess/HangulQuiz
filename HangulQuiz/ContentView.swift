//
//  ContentView.swift
//  HangulQuiz
//
//  Created by Alex C on 23.03.25.
//
// @State attribute which updates the view (the GUI).
// if your variable is marked with this attribute and the variable changes, the GUI is also updated accordingly.
// let = constant
import SwiftUI

struct HangulCharacter {
    let character: String
    let sounds: String //Simplified 1 sound per character.
}

let quizdata = [
    HangulCharacter(character: "ㅣ", sounds: "i"),
    HangulCharacter(character: "ㅏ", sounds: "a"),
    HangulCharacter(character: "ㅓ", sounds: "eo"),
    HangulCharacter(character: "ㅡ", sounds: "eu"),
    HangulCharacter(character: "ㅗ", sounds: "o"),
    HangulCharacter(character: "ㅜ", sounds: "u"),
    HangulCharacter(character: "ㅇ", sounds: "ng"),
    HangulCharacter(character: "ㄴ", sounds: "n"),
    HangulCharacter(character: "ㅁ", sounds: "m"),
    HangulCharacter(character: "ㅍ", sounds: "p"),
    HangulCharacter(character: "ㅎ", sounds: "h"),
    HangulCharacter(character: "ㅋ", sounds: "k"),
    HangulCharacter(character: "ㄱ", sounds: "g/k"),
    HangulCharacter(character: "ㅂ", sounds: "b/p"),
    HangulCharacter(character: "ㄹ", sounds: "r/l"),
    HangulCharacter(character: "ㅅ", sounds: "s/t"),
    HangulCharacter(character: "ㅈ", sounds: "j/t"),
    HangulCharacter(character: "ㅊ", sounds: "ch/t"),
]


struct ContentView: View { //The GUI as struct..
    @State private var currentCharacter = HangulCharacter(character: "ㅗ", sounds: "o")
    @State private var userGuess = "" //Saves the input
    @State private var feedback = "" //Saves the feedback (correct/incorrect)
    @State private var score = 0    //Saves the score
    @State private var showScore = false //Variable for displaying the score
    @State private var showFeedback = false //Variable for displaying the feedback
    var body: some View {
        VStack(spacing: 20) {
            Text(currentCharacter.character)
                .font(.system(size: 80))  // Larger font

            TextField("How do you pronounce that?", text: $userGuess)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Check") {
                showFeedback = true
                //Check if response is empty
                if userGuess == "" {
                    feedback = "Please provide an answer."
                    return
                }
                //Check if answer is correct
                if userGuess.lowercased() == currentCharacter.sounds.lowercased() {
                    feedback = "🎉 Correct!"
                    score = score + 1
                    currentCharacter = quizdata.randomElement()!  //New character
                    userGuess = ""  //Clear input
                //If answer is incorrect.
                } else {
                    feedback = "❌ Wrong! Please try again."
                    score = max(0, score - 1) //Score never below zero
                }
                
            }
            Button ("Show Score") {
                showFeedback = false
                showScore.toggle()
                
            }
            if showFeedback {
                Text(feedback)  //Show Feedback
                    .foregroundColor(feedback.contains("🎉") ? .green : .red)
            }
            if showScore {
                Text("Score: \(score)")
                    .font(.title)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
