//
//  ContentView.swift
//  Proquint
//
//  Created by Jahn Bertsch
//

import SwiftUI

struct ContentView: View {
    static let minimumWordCount = 5.0
    @State var model = ProquintModel(wordCount: Int(minimumWordCount))
    @State var sliderValue = minimumWordCount
    @State var showingClipboardAlert = false

    var body: some View {
        VStack {
            Text(model.proquint)
                .padding(.bottom)
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
                .onTapGesture {
                    #if os(iOS)
                    UIPasteboard.general.string = model.proquint
                    #elseif os(macOS)
                    NSPasteboard.general.declareTypes([.string], owner: nil)
                    NSPasteboard.general.setString(model.proquint, forType: .string)
                    #endif
                    showingClipboardAlert = true
                }
            Slider(value: $sliderValue, in: Self.minimumWordCount...8, step: 1) { (stillEditing: Bool) in
                model.wordCount = Int(sliderValue)
            }
            Text("Entropy: 2") + Text("\(model.wordCount * 16)")
                .font(.system(.caption))
                .baselineOffset(6.0)
            Button("Generate Password") {
                model.generateProquint()
            }.padding()
            Link("Additional Information", destination: URL(string: "https://arxiv.org/html/0901.4016")!)
        }
        .padding()
        #if os(macOS)
        .frame(minWidth: 500, maxWidth: 500, minHeight: 300, maxHeight: 300)
        #endif
        .alert("Copied to Clipboard", isPresented: $showingClipboardAlert) {
            Button("OK", role: .cancel) {
                showingClipboardAlert = false
            }
        }.onAppear() {
            model.generateProquint()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
