//
//  ProductiveViewController.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 25/03/2019.
//

import UIKit
import WebKit

final class ProductiveViewController: UIViewController {

    // MARK: - Public properties -

    static let identifier = String(describing: ProductiveViewController.self)

    // MARK: - Private properties -

    private var _config: ProductiveConfig
    private var webViewContainerView: UIView = UIView()

    // MARK: - Lifecycle -

    init(with config: ProductiveConfig) {
        self._config = config
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupLayout()
        _setupWebView()
    }

    static func present(with config: TriggerActionConfig?) {
        guard let productiveConfig = config as? ProductiveConfig else { return }

        let productiveViewController = ProductiveViewController(with: productiveConfig)
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: productiveViewController, animated: true)
    }

    // MARK: - Private methods -

    private func _setupLayout() {
        view.backgroundColor = .white

        let closeButton = UIButton()
        closeButton.setTitle(_config.localization.closeButton, for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        closeButton.addTarget(self, action: #selector(_doneButtonActionHandler), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeTopAnchor),
            closeButton.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 16),
        ])

        webViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webViewContainerView)
        NSLayoutConstraint.activate([
            webViewContainerView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            webViewContainerView.rightAnchor.constraint(equalTo: view.safeRightAnchor),
            webViewContainerView.leftAnchor.constraint(equalTo: view.safeLeftAnchor),
            webViewContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func _setupWebView() {
        guard
            let url = URL(string: "https://app.productive.io/\(_config.organizationId)/projects/\(_config.projectId)/tasks/new"),
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

        let customFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 0.0, height: webViewContainerView.frame.size.height))
        let webView = FullScreenWKWebView(frame: customFrame, configuration: configuration)

        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        webView.embed(in: webViewContainerView)
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
        let alertController = UIAlertController(
            title: _config.localization.retryAlert.title,
            message: _config.localization.retryAlert.description ?? error.localizedDescription,
            preferredStyle: .alert)

        let retryAction = UIAlertAction(title: _config.localization.retryAlert.retry, style: .default) { [weak self] (_) in
            self?._setupWebView()
        }
        let cancelAction = UIAlertAction(title: _config.localization.retryAlert.cancel, style: .cancel) { [weak self] (_) in
            self?.dismiss(animated: true)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }

    private func _showSomethingWentWrongAlert() {
        let alertController = UIAlertController(
            title: _config.localization.somethingWentWrongAlert.title,
            message: _config.localization.somethingWentWrongAlert.description,
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: _config.localization.somethingWentWrongAlert.ok, style: .default) { [weak self] (_) in
            self?.dismiss(animated: true)
        }

        alertController.addAction(okAction)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }

    @objc private func _doneButtonActionHandler() {
        dismiss(animated: true)
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
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

fileprivate class FullScreenWKWebView: WKWebView {

    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
