//
//  ViewController.swift
//  passTheData
//
//  Created by Jason Yang on 1/25/24.
//

import UIKit
/*
// delegate 패턴  (sender → receiver)

// 데이터를 보내는 class에서 프로토콜 정의
protocol DataDelegate: AnyObject {
    func sendData(data: String)
}


class SenderViewController: UIViewController {
    
    // 델리게이트 프로퍼티
    weak var delegate: DataDelegate?
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter data"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Data", for: .normal)
        button.addTarget(self, action: #selector(sendDataButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // UI 요소 추가
        view.addSubview(textField)
        view.addSubview(sendButton)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
        ])
    }
    
    // 데이터를 보내는 곳
    @objc private func sendDataButtonTapped() {
        if let dataToSend = textField.text {
            // 두 번째 View Controller로 이동
            let receiverVC = ReceiverViewController()
            self.delegate = receiverVC
            present(receiverVC, animated: true)
            delegate?.sendData(data: dataToSend)
            
        }
    }
}
 */
/*
 // 1. NotificationCenter 활용 ( sender < - > receiver)
 class SenderViewController: UIViewController {
 
 private let textField: UITextField = {
 let textField = UITextField()
 textField.borderStyle = .roundedRect
 textField.placeholder = "Enter data"
 textField.translatesAutoresizingMaskIntoConstraints = false
 return textField
 }()
 
 private let sendButton: UIButton = {
 let button = UIButton(type: .system)
 button.setTitle("Send Data", for: .normal)
 button.addTarget(self, action: #selector(sendDataButtonTapped), for: .touchUpInside)
 button.translatesAutoresizingMaskIntoConstraints = false
 return button
 }()
 
 override func viewDidLoad() {
 super.viewDidLoad()
 setupUI()
 }
 
 private func setupUI() {
 view.backgroundColor = .white
 
 // UI 요소 추가
 view.addSubview(textField)
 view.addSubview(sendButton)
 
 // 레이아웃 설정
 NSLayoutConstraint.activate([
 textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
 sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
 ])
 }
 
 @objc private func sendDataButtonTapped() {
 if let dataToSend = textField.text {
 // 두 번째 View Controller로 이동, 실행순서가 중요하다. ReceiverViewController가 present 된 후 NotificationCenter을 사용해서 post하면 데이터를 옮길 수 있다.
 let receiverVC = ReceiverViewController()
 present(receiverVC, animated: true)
 let yourData = YourData(name: dataToSend, age: 0)
 NotificationCenter.default.post(name: NSNotification.Name("YourNotificationName"), object: nil, userInfo: ["key": yourData])
 
 }
 }
 }
 */
/*
 // Delegate 패턴 사용 (receiver → sender)
class SenderViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter data"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Data", for: .normal)
        button.addTarget(self, action: #selector(sendDataButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // UI 요소 추가
        view.addSubview(textField)
        view.addSubview(sendButton)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func sendDataButtonTapped() {
        if let dataToSend = textField.text {
            // 두 번째 View Controller로 이동
            let receiverVC = ReceiverViewController()
            receiverVC.delegate = self
            present(receiverVC, animated: true)
        }
    }
}

extension SenderViewController: DataDelegate {
    func sendData(data: String) {
        textField.text = data
    }
}

 */
class SenderViewController: UIViewController {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter data"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Data", for: .normal)
        button.addTarget(self, action: #selector(sendDataButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // UI 요소 추가
        view.addSubview(textField)
        view.addSubview(sendButton)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func sendDataButtonTapped() {
        if let dataToSend = textField.text {
            // 두 번째 View Controller로 이동
            let receiverVC = ReceiverViewController()
            receiverVC.completionHandler = { [weak self] text in
                self?.textField.text = text
                
            }
            present(receiverVC, animated: true)
        }
    }
}

