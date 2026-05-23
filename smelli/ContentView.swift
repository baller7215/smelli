//
//  ContentView.swift
//  smelli
//
//  Created by Leonardo Siu on 5/22/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Hi, there")
            Label("Leo", systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
            Link("View Our Terms of Service",
                  destination: URL(string: "https://www.example.com/TOS.html")!)
                .padding(10)
                .background(Color.black.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
