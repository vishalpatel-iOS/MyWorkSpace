//
//  webView.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    enum WorkState: String {
        case initial
        case done
        case working
        case errorOccurred
    }

    @Binding var url: String
    @Binding var workState: WorkState

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch self.workState {
        case .initial:
            if let url = URL(string: self.url) {
                uiView.load(URLRequest(url: url))
            }
        default:
            break
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
          self.parent.workState = .working
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.workState = .errorOccurred
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.workState = .done
        }

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

