import SwiftUI

struct ContentView: View {
    // List of words for the game
    @State private var words = ["swift", "xcode", "apple", "developer", "programming", "scramble", "puzzle", "game"]
    
    // Variables to keep track of the current game state
    @State private var currentWord = ""
    @State private var scrambledWord = ""
    @State private var userInput = ""
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Scrambled Word Game")
                .font(.largeTitle)
                .padding()
            
            // Display the scrambled word
            Text(scrambledWord)
                .font(.title)
                .padding()
            
            // Input text field for user guesses
            TextField("Enter your guess", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    checkAnswer()
                }
            
            // Display the score
            Text("Score: \(score)")
                .font(.title2)
                .padding()
            
            // Button to check the answer
            Button("Submit") {
                checkAnswer()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            // Button to skip the current word
            Button("Skip") {
                nextWord()
            }
            .padding()
            .buttonStyle(.bordered)
        }
        .padding()
        .onAppear(perform: startGame)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Result"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                nextWord()
            }))
        }
    }
    
    // Function to start the game
    func startGame() {
        nextWord()
    }
    
    // Function to get the next word and scramble it
    func nextWord() {
        if let newWord = words.randomElement() {
            currentWord = newWord
            scrambledWord = String(newWord.shuffled())
            userInput = ""
        }
    }
    
    // Function to check the user's answer
    func checkAnswer() {
        if userInput.lowercased() == currentWord {
            score += 10
            alertMessage = "Correct! +10 points"
        } else {
            score -= 5
            alertMessage = "Wrong! -5 points. The correct word was \(currentWord)"
        }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
