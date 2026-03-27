//
//  ContentView.swift
//  WordScramble
//
//  Created by Myron Snelson on 3/17/26.
//
//  Introducing List
//  Bundle URLs
//  Working with Strings

import SwiftUI

struct ContentView: View {
//    let people = ["Finn", "Leia", "Luke", "Ray"]
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        // This is all learning code
        /*
         List {
         // static rows
         //            Text("Hello World!")
         //            Text("Hello World!")
         //            Text("Hello World!")
         // dynamic rows
         //            ForEach(0..<5) {
         //                Text("Dynamic Row \($0)")
         //            }
         // mixed static and dynamic rowsπ
         Section("Section 1") {
         Text("Static row 1")
         Text("Static row 2")
         }
         Section("Section 2") {
         ForEach(0..<5) {
         Text("Dynamic Row \($0)")
         }
         }
         Section("Section 3") {
         Text("Static row 3")
         Text("Static row 4")
         }
         }
         .listStyle(.grouped)
         */
        
        // This is all learning code too
        /*
         
         // If your list is entirely dynamic
         // can use this shortcut form of list
         //        List(0..<5) {
         //            Text("Dynamic Row \($0)")
         
         // Dynamic list of array elements
         // \.self tells SwiftUI that the strings themselves
         // are used to make each row in the list unique
         // If no static rows inside List
         // just use shortcut version of List
         List(people, id: \.self) {
         Text("\($0)")
         }
         
         // Can still mix with static rows
         List {
         Text("Static row 1")
         ForEach(people, id: \.self) {
         Text("\($0)")
         }
         Text("Static row 2")
         }
         }
         func testBundles() {
         // the returned fileURL is only for the use of Swift
         // its content is not recognizeable by user
         if let fileURL = Bundle.main.url(forResource: "TestData", withExtension: "txt") {
         // we found the file in our bundle
         print("File exists at: \(fileURL.path)")
         if let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) {
         // we loaded the file into a String
         // now we can process the String in any way we want
         print("File Contents: \(fileContents)")
         }
         }
         }
         
         func testStrings() {
         let input = "a b c"
         let letters = input.components(separatedBy: " ")
         let input2 = """
         a
         b
         c
         """
         let lines = input2.components(separatedBy: .newlines)
         // this statement returns an optional because there could be
         // no elements in the array lines
         let line = lines.randomElement()
         let trimmed = line?.trimmingCharacters(in: .whitespacesAndNewlines)
         
         // Will do spellchecking using UITextChecker class
         // The UI prefix tells us it comes from UIKit
         // which is written in Objective C making its API different
         }
         
         func testStrings2() {
         let word = "swift"
         let checker = UITextChecker()
         // spell check the entire string
         // must use utf16 to bridge to Objective C strings
         let range = NSRange(location: 0, length: word.utf16.count)
         // wrap = false means do not wrap around to beginning of text
         // "en" means use an English dictionary
         // will return where the misspelled word is found
         let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
         // returns Bool true if not misspellings found
         // returns Bool false if a misspellins is found
         let allGood = misspelledRange.location == NSNotFound
         */
        
        // Project 5
        NavigationStack() {
            Section {
                Text("Root Word: \(rootWord)")
                    .fontWeight(.bold)
                Text("Score: \(score)")
            }
            
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .focused($isTextFieldFocused)
                }
                Section {
                    ForEach(usedWords, id: \.self) {
                        word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle("Word Scramble")
            
            .toolbar {
                Button("Reset", action: startGame)
                    .foregroundColor(.blue)
            }
            
            // onSubmit has to be given a function that:
            // - accepts no parameters
            // - returns nothing
            // our function addNewWord meets these criteria
            .onSubmit(addNewWord)
            
            // onAppear runs when this view is first shown
            .onAppear(perform: startGame)
            .onAppear { isTextFieldFocused = true }
            // show alert on error of some type
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
        
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure answer has at least one character
        guard answer.count > 0 else { return }
        
        // Answer must have at least three characters
        guard answer.count >= 3 else {
            wordError(title: "Word must have at least three characters", message: "Think big!")
            return
        }
        
        // Make sure word not already submitted
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more orginal!")
            return
        }
        
        // Make sure submitted word can be spelled from the letters in the root word
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Must be able to spell this word from \(rootWord)!")
            return
        }
        
        //
        guard isReal(word: answer) else {
            wordError(title: "Word not in dictionary", message: "You cannot make up words!  ")
            return
        }
        
        // causes the answer to be listed
        // at the top of the list
        // with Animation causes the words to slide into position
        withAnimation() {
            usedWords.insert(answer, at: 0)
            score = score + (answer.count * usedWords.count)
        }
        newWord = ""
        isTextFieldFocused = true
    }
    
    func startGame() {
        score = 0
        newWord = ""
        isTextFieldFocused = true
        usedWords.removeAll()
        // get start.txt file
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // if it was found, turn into a string
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                // separate words into an array
                let allWords = startWords.components(separatedBy: "\n")
                // pick a random word from the array
                // use nil coalescing in case array is empty
                // default to "silkworm" if the array is empty
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        // if we get to here, something caused the start file not to be loaded
        // into an array
        // we will trigger a fatal crash and report a message back
        fatalError("Could not load start.text file from bundle")
    }
    
    // check to see if word had already been submitted (used)
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // make sure the submitted word can be spelled from the
    // letters in the root word
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    // check to make sure submitted word is a real word
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}

