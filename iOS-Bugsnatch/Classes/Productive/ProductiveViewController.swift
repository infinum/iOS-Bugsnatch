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

    static let identifier = String(describing: ProductiveViewController.self)

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

    @IBAction private func _closeButtonActionHandler() {
        dismiss(animated: true)
    }

    // MARK: - Private methods -

    private func _setupWebView() {
        let organizationId = "1-infinum"
        let projectId = 1116

        guard
            let url = URL(string: "https://app.productive.io/\(organizationId)/projects/\(projectId)/tasks/new"),
            let productiveScriptSource = _productiveScriptSource
        else {
            // TODO: - show some message -
            return
        }

        let script = WKUserScript(source: productiveScriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let contentController = WKUserContentController()
        contentController.addUserScript(script)

        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController

        let customFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 0.0, height: webViewContainer.frame.size.height))
        let webView = WKWebView(frame: customFrame, configuration: configuration)

        webView.navigationDelegate = self
        webView.embed(in: webViewContainer)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    private var _productiveScriptSource: String? {
        guard let filepath = Bundle(for: type(of: self)).path(forResource: "productiveScript", ofType: "js") else { return nil }

        do {
            let productiveScript = try String(contentsOfFile: filepath)
            return String(format: productiveScript, Bugsnatch.shared.debugInfo)
        } catch {
            return nil
        }
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
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: containerView.topAnchor),
            rightAnchor.constraint(equalTo: containerView.rightAnchor),
            leftAnchor.constraint(equalTo: containerView.leftAnchor),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
}
