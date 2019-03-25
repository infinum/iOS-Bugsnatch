//
//  ProductiveViewController.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import UIKit
import WebKit

class ProductiveViewController: UIViewController {

    @IBOutlet weak var webViewContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupWebView()
    }

    static let identifier = "ProductiveViewController"

    static func present() {
        let bugsnatchBundle = Bundle(for: ProductiveViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: bugsnatchBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.keyWindow?.rootViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewController, animated: true)
    }

    // MARK: - Private -

    private func _setupWebView() {
        let exampleBugText = "This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok. This bug is not ok."

        let organizationId = "1-infinum"
        let projectId = 1116
        let boardId = 603
        let url = URL(string: "https://app.productive.io/\(organizationId)/projects/\(projectId)/tasks/boards/\(boardId)/new-task")!

        let scriptSource = """
        var timeout;

        function checkDOMChange() {
            let editorEl = document.querySelector(`.modal-container trix-editor`);

            if (editorEl && editorEl.editor) {
                populateBugText(editorEl.editor);
            } else {
                timeout = setTimeout(checkDOMChange, 200);
            }
        }

        checkDOMChange();

        function populateBugText(editor) {
            editor.insertString(`\(exampleBugText)`);
        }
        """

        print(scriptSource)
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let contentController = WKUserContentController()
        contentController.addUserScript(script)

        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController

        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewContainer.frame.size.height))
        let webView = WKWebView(frame: customFrame, configuration: configuration)
        webView.navigationDelegate = self

        webView.translatesAutoresizingMaskIntoConstraints = false
        webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    // MARK: - IBActions -

    @IBAction func closeButtonActionHandler(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ProductiveViewController: WKNavigationDelegate {}

extension UIViewController {

    // taken from https://gist.github.com/MartinMoizard/6537467
    public func presentViewControllerFromVisibleViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = self as? UINavigationController, let topViewController = navigationController.topViewController {
            topViewController.presentViewControllerFromVisibleViewController(
                viewControllerToPresent: viewControllerToPresent,
                animated: true,
                completion: completion)

        } else if let _presentedViewController = presentedViewController {
            _presentedViewController.presentViewControllerFromVisibleViewController(
                viewControllerToPresent: viewControllerToPresent,
                animated: true,
                completion: completion)

        } else {
            present(viewControllerToPresent, animated: true, completion: completion)
        }
    }
}
