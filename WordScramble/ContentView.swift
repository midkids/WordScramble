//
//  ContentView.swift
//  WordScramble
//
//  Created by Myron Snelson on 3/17/26.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Ray"]
    var body: some View {
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
        
        // If your list is entirely dynamic
        // can use this shortcut form of list
        //        List(0..<5) {
        //            Text("Dynamic Row \($0)")
        
        // Dynamic list of array elements
        // Could still mix with static rows (not shown here)
        //
        // \.self tells SwiftUI that the strings themselves
        // are used to make each row in the list unique
        List(people, id: \.self) {
            Text("\($0)")
        }
    }
}

#Preview {
    ContentView()
}
