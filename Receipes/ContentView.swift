//
//  ContentView.swift
//  Receipes
//
//  Created by Amosse Edouard on 07/05/2026.
//

import SwiftUI

struct MyReceipes : View {
    var body: some View {
        List() {
            ForEach(MockData.sample) { receipe in
                Text(receipe.title)
            }
        }
    }
}
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

#Preview {
    MyReceipes()
}
