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
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
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
            .navigationTitle(rootWord)
            // onSubmit has to be given a function that:
            // - accepts no parameters
            // - returns nothing
            // our function addNewWord meets these criteria
            .onSubmit {
                addNewWord()
            }
        }
    }
        
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // Make sure answer has at least one character
        guard answer.count > 0 else { return }
        
        // more validation to come
        
        // causes the answer to be listed
        // at the top of the list
        withAnimation() {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}

