//
//  ProductiveViewController.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import UIKit
import WebKit

public struct ProductiveConfig: TriggerActionConfig {
    var organizationId: String
    var projectId: Int

    public init(organizationId: String, projectId: Int) {
        self.organizationId = organizationId
        self.projectId = projectId
    }
}

class ProductiveViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var webViewContainer: UIView!

    // MARK: - Public properties -

    static let identifier = String(describing: ProductiveViewController.self)
    public var config: ProductiveConfig?

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupWebView()
    }

    static func present(with config: TriggerActionConfig?) {
        let bugsnatchBundle = Bundle(for: ProductiveViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: bugsnatchBundle)

        guard
            let productiveConfig = config as? ProductiveConfig,
            let productiveViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? ProductiveViewController
            else { return }

        productiveViewController.config = productiveConfig
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: productiveViewController, animated: true)
    }

    // MARK: - IBActions -

    @IBAction private func _closeButtonActionHandler() {
        dismiss(animated: true)
    }

    // MARK: - Private methods -

    private func _setupWebView() {
        guard
            let organizationId = config?.organizationId,
            let projectId = config?.projectId,
            let url = URL(string: "https://app.productive.io/\(organizationId)/projects/\(projectId)/tasks/new"),
            let productiveScriptSource = _productiveScriptSource
            else {
                _showSomethingWentWrongAlert()
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

    private func _showRetryAlert(with error: Error) {
        let alertController = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)

        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] (_) in
            self?._setupWebView()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] (_) in
            self?.dismiss(animated: true)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }


    private func _showSomethingWentWrongAlert() {
        let alertController = UIAlertController(title: "Oops", message: "Something went wrong, please contact developers", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            self?.dismiss(animated: true)
        }

        alertController.addAction(okAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in

            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ProductiveViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        _showRetryAlert(with: error)
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
