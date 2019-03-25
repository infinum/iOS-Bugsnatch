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
        function checkDOMChange() {
            let editor = document.getElementsByClassName(`trix-editor`)[0];

            if (typeof(editor) != 'undefined' && editor != null) {
                populateBugText(editor);
            } else {
                setTimeout(checkDOMChange, 100);
            }
        }

        checkDOMChange();

        function populateBugText(editor) {
            editor.value = `\(exampleBugText)`;
        }
        """

        print(scriptSource)
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: false)

        let contentController = WKUserContentController()
        contentController.addUserScript(script)

        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController

        let webview = WKWebView(frame: webViewContainer.frame, configuration: configuration)
        webview.navigationDelegate = self
        webViewContainer.addSubview(webview)

        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
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
