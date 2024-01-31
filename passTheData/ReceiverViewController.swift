//
//  ReceiverViewController.swift
//  passTheData
//
//  Created by Jason Yang on 1/25/24.
//

import UIKit
/*
// delegate 패턴 (sender → receiver)
// ReceiverViewController
class ReceiverViewController: UIViewController {
    private let receivedDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // UI 요소 추가
        view.addSubview(receivedDataLabel)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            receivedDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            receivedDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ReceiverViewController: DataDelegate {
    // delegate?.sendData(data: dataToSend)으로 보낸 데이터를 받는 델리게이트 메서드
    func sendData(data: String) {
        receivedDataLabel.text = "Received Data: \(data)"
    }
}
*/
/*
 // 1. NotificationCenter 활용 ( sender < - > receiver)
 class ReceiverViewController: UIViewController {
 private let receivedDataLabel: UILabel = {
 let label = UILabel()
 label.textAlignment = .center
 label.translatesAutoresizingMaskIntoConstraints = false
 return label
 }()
 
 override func viewDidLoad() {
 super.viewDidLoad()
 setupUI()
 // 데이터 활용
 //NotificationCenter를 통해 옵져브하고 있는 YourData 타입으로 간주하는 userInfo?["key"] key값을 통한 YourData을 data 프로퍼티에 넣어준다.
 NotificationCenter.default.addObserver(forName: NSNotification.Name("YourNotificationName"), object: nil, queue: nil) { [weak self] notification in
 if let data = notification.userInfo?["key"] as? YourData {
 //ReceiverViewController에 data가 들어오면(옵셔널) 텍스트를 반환한다.
 self?.receivedDataLabel.text = "Received Data: \(data)"
 
 }
 }
 }
 
 private func setupUI() {
 view.backgroundColor = .white
 
 // UI 요소 추가
 view.addSubview(receivedDataLabel)
 
 // 레이아웃 설정
 NSLayoutConstraint.activate([
 receivedDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 receivedDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
 ])
 }
 }
 */
/*
//Delegate 패턴 사용 (receiver → sender)
// 프로토콜 정의
protocol DataDelegate: AnyObject {
    func sendData(data: String)
}

class ReceiverViewController: UIViewController {
    weak var delegate : DataDelegate?
    
    private let receivedDataLabel: UILabel = {
        let label = UILabel()
        label.text = "receivedDataLabel"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
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
        view.addSubview(receivedDataLabel)
        view.addSubview(dismissButton)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            receivedDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            receivedDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.topAnchor.constraint(equalTo: receivedDataLabel.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func dismissButtonTapped() {
        if let data = receivedDataLabel.text {
            delegate?.sendData(data: data)
        }
        self.dismiss(animated: true)
        let senderVC = SenderViewController()
        present(senderVC, animated: true)
    }
}
*/
class ReceiverViewController: UIViewController {
    var completionHandler: ((String) -> ())?
    private let receivedDataLabel: UILabel = {
        let label = UILabel()
        label.text = "임의의 데이터"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
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
        view.addSubview(receivedDataLabel)
        view.addSubview(dismissButton)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            receivedDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            receivedDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.topAnchor.constraint(equalTo: receivedDataLabel.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func dismissButtonTapped() {
        if let data = receivedDataLabel.text {
            completionHandler?(data)
        }
        self.dismiss(animated: true)
    }
}

