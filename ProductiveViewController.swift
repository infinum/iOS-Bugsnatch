//
//  ProductiveViewController.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import UIKit
import WebKit

class ProductiveViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var webViewContainer: UIView!

    // MARK: - Public properties -

    static let identifier = "ProductiveViewController"

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupWebView()
    }

    static func present() {
        let bugsnatchBundle = Bundle(for: ProductiveViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: bugsnatchBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewController, animated: true)
    }

    // MARK: - IBActions -

    @IBAction func closeButtonActionHandler(_ sender: Any) {
        dismiss(animated: true)
    }

    // MARK: - Private methods -

    private func _setupWebView() {
        let organizationId = "1-infinum"
        let projectId = 1116
        let boardId = 603
        let url = URL(string: "https://app.productive.io/\(organizationId)/projects/\(projectId)/tasks/boards/\(boardId)/new-task")!

        let script = WKUserScript(source: _productiveScriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

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
        webView.embed(in: webViewContainer)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    private var _productiveScriptSource: String {
        return """
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
        editor.insertString(`\(Bugsnatch.shared.debugInfo)`);
        }
        """
    }
}

extension ProductiveViewController: WKNavigationDelegate {}

extension UIViewController {

    // taken from https://gist.github.com/MartinMoizard/6537467
    public func presentViewControllerFromVisibleViewController(
        viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil)
    {
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

fileprivate extension WKWebView {

    func embed(in containerView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(self)
        topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    }
}
