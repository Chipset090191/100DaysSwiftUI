//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Михаил Тихомиров on 08.03.2023.
//

import SwiftUI

// That extension for custom modifier (Title) I`ve done.
extension View {
    func titleFont()-> some View{
        modifier(Title())
    }
}

// Custom modifier I created for title
struct Title:ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title.bold())
    }
}

struct FlagImage:View {
    
    var Array_countries:String
    
    var body: some View{
        Image(Array_countries)
            .renderingMode(.original) // that`s for rendering real color of flag despite the mode of screen
            .clipShape(Capsule())
            .shadow(radius: 5)
    }

}

// for animation

extension View {
    func rotation(amount:Double)-> some View{
        withAnimation{
            modifier(RotateModifier(amount: amount))
        }
    }
}

struct RotateModifier: ViewModifier {
    
    let amount:Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(amount), axis: (x: 0, y: 1, z: 0))
    }
    
}



struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = " "
    @State private var scoreTitleAlert = " "
    @State private var score = 0
    @State private var countOfquestions = 0
    @State private var finalAlert = false
    @State private var animationAmount = 0.0
    @State private var tapped = false
    // for animation challenge
    @State private var isCorrect = false
    @State private var selectedNumber = 0
    @State private var opacity = true
    @State private var isFadeOutOpacity = false

    
    
    
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red:0.36, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text ("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text (countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            
                    }
                    
                        ForEach(0..<3) {number in
                            
                            Button {
                                if !tapped {
                                    withAnimation(.interpolatingSpring(stiffness: 7, damping: 3)){
                                        flagTapped(number)
                                        tapped = true
                                    }
                                }
                            }

                            label: {
                                
                                    FlagImage(Array_countries: countries[number])
                            }
                            .rotation3DEffect(.degrees(isCorrect && selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
//                            .opacity(!isCorrect || selectedNumber == number ? 1 : 0.25)
//
                            .opacity(isFadeOutOpacity && selectedNumber != number ? 0.25 : 1)
                            
                            .scaleEffect(isFadeOutOpacity && selectedNumber != number ? 0.50 : 1)
                            
                        }
                    
                    HStack{
                        Text ("\(scoreTitle)")
                            .font(.title2.italic().bold())
                            .foregroundColor(isCorrect ? .green : .red)
                            
                    }
    
                }
                //-------------------------------Creating the frame of our VStack`s flags
                .frame(maxWidth: .infinity) // frame of our rectangle
                .padding(.vertical, 20)
                .background(.regularMaterial)  // shous upn our rectangle
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                //-------------------------------Finish creating the frame
                
                Button ("Ok"){
                    if tapped {
                        askQuestion()
                        animationAmount -= 1
                        tapped = false
                    }
                }
                .frame(width: 100, height: 100)
                .background(isCorrect ? .green : .red)
                .foregroundColor(.black)
                .clipShape(Circle())
                .font(.title2.bold())
                .scaleEffect(animationAmount)
                .animation(.default, value:animationAmount)
                
                
                
                Spacer() // these spacers allow to put Score at the bottom
                Spacer()
                
                
                
                Text("Score: \(score)")
// That`s a new one. Use my custom modifier. Just only one line instead of two lines of code
                    .titleFont()
                
// That`s old code!
//                    .foregroundColor(.white)
//                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding()
        }
        
        .alert(scoreTitleAlert, isPresented:$showingScore) {
                Button ("New Game") {
                    askQuestion()
                    score = 0
                    countOfquestions = 0
                }
        } message: {
            Text ("Your score is \(score)!")
        }
        
        
    }
    
    func flagTapped(_ number:Int) {
        countOfquestions += 1
        
        
        
        selectedNumber = number
       
            
        
        
            if number == correctAnswer {
                if countOfquestions < 8 {
                    scoreTitle = "That`s Correct!"
                    score += 1
                    isCorrect = true
                    isFadeOutOpacity = true
                    animationAmount += 1
                    
                }else {
                    scoreTitleAlert = """
                                 The FINAL was right. Good game!
                                 Click "New Game" to start again!
                                 """
                    score += 1
                    showingScore = true
                    
                }
            }else if countOfquestions < 8 {
                scoreTitle = "Wrong. This is \(countries[number]) flag!"
                animationAmount += 1
            }else {
                scoreTitleAlert = """
                             The FINAL was wrong. it was \(countries[number]).
                             Click "New Game" to start again!
                             """
                showingScore = true
            }
                
            
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isCorrect = false
        isFadeOutOpacity = false
        scoreTitle = " "
        
    }
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
