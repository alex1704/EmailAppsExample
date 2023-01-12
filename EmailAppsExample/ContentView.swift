//
//  ContentView.swift
//  EmailAppsExample
//
//  Created by Alex Kostenko on 12.01.2023.
//

import SwiftUI
import EmailApps

struct ContentView: View {
    var body: some View {
        Button("Send") {
            showEmailPicker = true
        }
        .actionSheet(isPresented: $showEmailPicker) {
            .init(title: Text("Send with ..."), buttons: actionButtons())
        }
        .padding()
    }

    @State private var showEmailPicker = false
    @State private var emailApps = [any EmailApp]()
}

extension ContentView {
    private func actionButtons() -> [ActionSheet.Button] {
        EmailApps.supported.compactMap { app in
            guard let url = app.url(email: "example@gmail.com",
                                    subject: "Hello world!",
                                    body: "Here is my letter to you.") else {
                return nil
            }

            return  .default(Text(app.name)) {
                UIApplication.shared.open(url)
            }
        } + [.cancel(Text("Cancel"))]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
