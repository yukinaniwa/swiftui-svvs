//
//  ContentView.swift
//  swiftui-svvs
//
//  Created by yuki naniwa on 2025/03/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundColor(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
