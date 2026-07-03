import UIKit
import WebKit
import SwiftUI

class ViewController: UIViewController, WKUIDelegate, UIScrollViewDelegate, WKScriptMessageHandler, WKNavigationDelegate {
    var webView: WKWebView!
    var keyboardHeight: CGFloat = 0
    private var lessonHost: UIViewController?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Keyboard Observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let configuration = WKWebViewConfiguration()

        // Setup Javascript-to-Swift message bridge
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "consoleLog")
        userContentController.add(self, name: "haptic")
        userContentController.add(self, name: "hapticSelection")
        userContentController.add(self, name: "hapticMedium")
        userContentController.add(self, name: "hapticRigid")
        userContentController.add(self, name: "openNativeLesson")

        let consoleOverrideScript = WKUserScript(
            source: """
            (function() {
                var originalLog = console.log;
                var originalError = console.error;
                var originalWarn = console.warn;

                console.log = function() {
                    var args = Array.prototype.slice.call(arguments);
                    window.webkit.messageHandlers.consoleLog.postMessage("LOG: " + args.join(" "));
                    originalLog.apply(console, arguments);
                };
                console.error = function() {
                    var args = Array.prototype.slice.call(arguments);
                    window.webkit.messageHandlers.consoleLog.postMessage("🚨 ERROR: " + args.join(" "));
                    originalError.apply(console, arguments);
                };
                console.warn = function() {
                    var args = Array.prototype.slice.call(arguments);
                    window.webkit.messageHandlers.consoleLog.postMessage("⚠️ WARN: " + args.join(" "));
                    originalWarn.apply(console, arguments);
                };

                window.onerror = function(message, source, lineno, colno, error) {
                    var errStr = message + " at " + source + ":" + lineno + ":" + colno;
                    if (error && error.stack) {
                        errStr += "\\nStack: " + error.stack;
                    }
                    window.webkit.messageHandlers.consoleLog.postMessage("🚨 RUNTIME ERROR: " + errStr);
                    return false;
                };
            })();
            """,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        userContentController.addUserScript(consoleOverrideScript)

        configuration.userContentController = userContentController

        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        self.view.addSubview(webView)

        // Use URL instead of Path for tighter file access security
        if let indexURL = indexHTMLURL() {
            // This explicitly allows the app to read files inside the same folder
            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
        } else {
            NSLog("❌ Xcode still can't find index.html in the bundle!")
            let errorHTML = "<html><body style='background:#111;color:#fff;font-family:-apple-system,HelveticaNeue;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;padding:20px;text-align:center;'><div><h1 style='margin-bottom:12px;'>Missing App Content</h1><p style='font-size:16px;line-height:1.5;'>The app could not load its bundled web content.</p><p style='margin-top:16px;color:#aaa;'>Please add <strong>index.html</strong> to the app target's bundle resources.</p></div></body></html>"
            webView.loadHTMLString(errorHTML, baseURL: nil)
        }
    }

    private func indexHTMLURL() -> URL? {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            return url
        }
        if let resourceURL = Bundle.main.resourceURL?.appendingPathComponent("DermApp/index.html"), FileManager.default.fileExists(atPath: resourceURL.path) {
            return resourceURL
        }
        if let resourceURL = Bundle.main.resourceURL {
            let nestedURL = resourceURL.appendingPathComponent("index.html")
            if FileManager.default.fileExists(atPath: nestedURL.path) {
                return nestedURL
            }
        }
        return nil
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateWebViewFrame()
    }

    func updateWebViewFrame() {
        var frame = self.view.bounds
        frame.size.height = self.view.bounds.height - self.keyboardHeight
        self.webView.frame = frame
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height

            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
            UIView.animate(withDuration: duration) {
                self.updateWebViewFrame()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardHeight = 0
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        UIView.animate(withDuration: duration) {
            self.updateWebViewFrame()
        }
    }

    // MARK: - WKScriptMessageHandler

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "consoleLog", let logString = message.body as? String {
            NSLog("📱 JS Console: %@", logString)
        } else if message.name == "haptic" {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        } else if message.name == "hapticSelection" {
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        } else if message.name == "hapticMedium" {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        } else if message.name == "hapticRigid" {
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        } else if message.name == "openNativeLesson" {
            presentNativeLesson(with: message.body)
        }
    }

    // MARK: - Native lesson bridge

    private func presentNativeLesson(with body: Any) {
        guard JSONSerialization.isValidJSONObject(body),
              let data = try? JSONSerialization.data(withJSONObject: body),
              let lesson = try? JSONDecoder().decode(Lesson.self, from: data) else {
            NSLog("📱 openNativeLesson: could not decode lesson payload")
            return
        }

        let root = LessonView(
            lesson: lesson,
            onClose: { [weak self] in self?.dismissNativeLesson() },
            onComplete: { [weak self] node in self?.completeNativeLesson(node: node) }
        )
        let host = UIHostingController(rootView: root)
        host.modalPresentationStyle = .fullScreen
        host.modalTransitionStyle = .coverVertical  // slides up like the web overlay
        lessonHost = host
        present(host, animated: true)
    }

    private func dismissNativeLesson() {
        lessonHost?.dismiss(animated: true) { [weak self] in self?.lessonHost = nil }
    }

    private func completeNativeLesson(node: Int) {
        // Record progress in the web layer (single source of truth: localStorage),
        // then slide the native lesson away to reveal the refreshed path.
        webView.evaluateJavaScript("window.recordNativeLessonComplete && window.recordNativeLessonComplete(\(node));", completionHandler: nil)
        dismissNativeLesson()
    }

    // MARK: - WKUIDelegate

    // Handle JS alert() inside WKWebView natively
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        })
        self.present(alertController, animated: true, completion: nil)
    }

    // Handle JS confirm() inside WKWebView natively
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(false)
        })
        let isReset = message.lowercased().contains("reset")
        let okActionStyle: UIAlertAction.Style = isReset ? .destructive : .default
        let okTitle = isReset ? "Reset" : "OK"
        alertController.addAction(UIAlertAction(title: okTitle, style: okActionStyle) { _ in
            completionHandler(true)
        })
        self.present(alertController, animated: true, completion: nil)
    }

    // Natively freeze the scrollview offset of WKWebView to prevent keyboard shift jumps
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset = .zero
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("📱 WebView: Finished loading index.html")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("📱 WebView Error: didFailProvisionalNavigation: %@", error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NSLog("📱 WebView Error: didFail: %@", error.localizedDescription)
    }
}
