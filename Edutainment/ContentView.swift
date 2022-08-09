//
//  ContentView.swift
//  Edutainment
//
//  Created by Kyle Warren on 8/8/22.
//

import SwiftUI

struct ContentView: View {
    @State private var timesTable = 0
    @State private var questionCount = 5
    @State private var answer = ""
    
    let questions = [5, 10, 20]
    
    
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
                                    Picker("How Many Questions Do You Want?", selection: $questionCount) {
                                        ForEach(questions, id: \.self) {
                                            Text("\($0)")
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                } header: {
                                    Text("How Many Questions Do You Want?")
                                }
                                
                                Section {
                                    TextField("Enter your answer", text: $answer)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
