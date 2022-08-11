//
//  ContentView.swift
//  Edutainment
//
//  Created by Kyle Warren on 8/8/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameState = false
    
    // Selected table to practice
    @State private var timesTable = 0
    // Number of questions selected
    @State private var questionCountSet = 5
    @State private var answer = 0
    @State private var questionNumber = 0
    
    @State private var questionText = ""
    @State private var correct = 0
    @State private var incorrect = 0
    // Array of questions to be asked
    @State private var questions = [Int]()
    
    @State private var placeholder = "Please start game!"
    // Property wrapper to determine if answer box should be receiving text input from user
    @FocusState private var amountIsFocused: Bool
    
    let questionCount = [5, 10, 20]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(stops : [
                    .init(color: Color(red: 0.9, green: 0.8, blue: 0.7), location: 0.6),
                    .init(color: Color(red: 0.23, green: 0.80, blue: 0.76), location: 0.6)
                ],center: .bottom, startRadius:  400, endRadius: 600)
                .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    Text("Lets Multiply!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    VStack(spacing: 15) {
                        VStack {
                            Text("Choose your trial!")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Form {
                                Section {
                                    Picker("Times Tables", selection: $timesTable) {
                                        ForEach(2..<13) {
                                            Text("\($0)")
                                        }
                                    }
                                    
                                } header: {
                                    Text("Times Table")
                                        .font(.subheadline)
                                }
                                
                                Section {
                                    Picker("How Many Questions Do You Want?", selection: $questionCountSet) {
                                        ForEach(questionCount, id: \.self) {
                                            Text("\($0)")
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    
                                    Text(questionText)
                                } header: {
                                    Text("How Many Questions Do You Want?")
                                }
                                
                                Section {
                                    gameState ? TextField("", value: $answer, formatter: NumberFormatter(),
                                                          onCommit: { saveAnswer() }).focused($amountIsFocused) : TextField("", text: $placeholder)
                                        .focused($amountIsFocused)
                                    
                                    gameState ? Button("Submit!") { saveAnswer() }.frame(maxWidth: .infinity, alignment: .center).animation(.default, value: 1) :
                                    Button("Start!") { startQuestions() }.frame(maxWidth: .infinity, alignment: .center).animation(.default, value: 0.6)
                                    
                                    gameState ? Text("Correct: \(correct), Incorrect: \(incorrect)") : Text("")
                                }
                                .keyboardType(.numberPad)
                                
                            }
                            .opacity(0.65)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                // ToolbarItemGroup lets us place one or more buttons in specific location & this is where we get to specify we
                // want a keyboard toolbar - toolbar that is attached to keyboard so it will auto appear / disappear w keyboard
                ToolbarItemGroup(placement: .keyboard) {
                    // Flexible space by default - wherever spacer placed will auto push other views to one side. By placing first
                    // in toolbar will cause button to be pushed to the right
                    Spacer()
                    // Button view used here displays some tappable text I.E 'Done'. Also need to provide it with some code
                    // to run when pressed - sets amountIsFocused to false so that keyboard dismisses
                    
                    Button("Done") {
                        // Closure running when buttom is tapped
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    
    func startQuestions() {
        for _ in 0..<questionCountSet {
            questions.append(Int.random(in: 2...12))
        }
        
        questionNumber = 0
        correct = 0
        incorrect = 0
        
        gameState.toggle()
        nextQuestion()
    }
    
    func nextQuestion() {
        if questionNumber > questionCountSet - 1 {
            gameState.toggle()
            return
        }
        questionText = ("Qeuestion \(questionNumber + 1): What is \(timesTable + 2) * \(questions[questionNumber])?")
    }
    
    func saveAnswer() {
//        gameState = false
        
        if answer == timesTable + 2 * questions[questionNumber] {
            correct += 1
        } else {
            incorrect += 1
        }
        
        questionNumber += 1
        answer = 0
        nextQuestion()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

