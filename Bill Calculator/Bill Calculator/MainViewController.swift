//
//  MainViewController.swift
//  Bill Calculator
//
//  Created by Нахид Гаджалиев on 14.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var split = 0
    private var percent = 0
    private var result = 0
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [enterLabel, textField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.textColor = .black
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.font = .systemFont(ofSize: 25)
        tf.placeholder = "Enter here"
        
        return tf
    }()
    
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "viewGreenBackground")
        
        return view
    }()
    
    lazy var middleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [selectLabel, buttonsStackView, chooseSplitLabel, stepperStackView])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Select tip"
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [zeroPercentButton, tenPercentButton, twentyPercentButton])
        stack.axis = .horizontal
        stack.spacing = 70
        stack.alignment = .center
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    lazy var zeroPercentButton: UIButton = percentButtonCreator(title: "0%", tag: 0)
    lazy var tenPercentButton: UIButton = percentButtonCreator(title: "10%", tag: 10)
    lazy var twentyPercentButton: UIButton = percentButtonCreator(title: "20%", tag: 20)
    
    lazy var enterLabel: UILabel = labelCreator(title: "Enter bill total")
    lazy var chooseSplitLabel: UILabel = labelCreator(title: "Choose Split")
    lazy var splitCountLabel: UILabel = labelCreator(title: "1")
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperTapped), for: .touchUpInside)
        
        return stepper
    }()
    
    lazy var stepperStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [splitCountLabel, stepper])
        stack.axis = .horizontal
        stack.spacing = 40
        stack.alignment = .center
        stack.distribution = .fill
        
        return stack
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdate()
    }
    
}

//MARK: - ADDING METHODS
extension MainViewController {
    
    private func resultCalculate() -> Double {
        guard let sumString = textField.text else { return 0 }
        guard let sum = Int(sumString) else { return 0 }

        return (Double(sum) + Double(sum) * (Double(percent)) / Double(100)) / Double(split)
    }
    
    private func viewUpdate() {
        view.backgroundColor = .systemBackground
        view.addSubview(topStackView)
        view.addSubview(greenView)
        view.addSubview(middleStackView)
        view.addSubview(calculateButton)
        setupConstraints()
    }
    
    private func buttonIsSelected(sender: UIButton) {
        if sender.isSelected {
            sender.backgroundColor = .systemGreen
            sender.setTitleColor(.white, for: .normal)
        } else {
            sender.backgroundColor = .clear
            sender.setTitleColor(.systemGreen, for: .normal)
        }
    }
    
    private func labelCreator(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        
        return label
    }
    
    private func percentButtonCreator(title: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 27)
        button.addTarget(self, action: #selector(percentChoosed(sender: )), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.tag = tag
        
        return button
    }
    
    private func setupConstraints() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            enterLabel.heightAnchor.constraint(equalToConstant: 35),
            textField.heightAnchor.constraint(equalToConstant: 35),
            
            greenView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 5),
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            middleStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            middleStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            middleStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            selectLabel.leadingAnchor.constraint(equalTo: middleStackView.leadingAnchor, constant: 30),
            chooseSplitLabel.leadingAnchor.constraint(equalTo: middleStackView.leadingAnchor, constant: 30),
            enterLabel.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor, constant: 30),
            
            zeroPercentButton.widthAnchor.constraint(equalToConstant: 60),
            
            calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
}

// MARK: - ADDING OBJC ACTIONS
extension MainViewController {
    
    @objc private func calculateTapped() {
        let vc = ResultViewController()
        vc.modalPresentationStyle = .formSheet
        vc.split = split
        vc.percent = percent
        vc.result = resultCalculate()
        present(vc, animated: true)
    }
    
    @objc private func percentChoosed(sender: UIButton) {
        
        textField.endEditing(true)
        
        zeroPercentButton.isSelected = false
        buttonIsSelected(sender: zeroPercentButton)
        
        tenPercentButton.isSelected = false
        buttonIsSelected(sender: tenPercentButton)
        
        twentyPercentButton.isSelected = false
        buttonIsSelected(sender: twentyPercentButton)
        
        sender.isSelected = true
        buttonIsSelected(sender: sender)
        percent = sender.tag
        
    }
    
    @objc private func stepperTapped() {
        splitCountLabel.text = String(Int(stepper.value))
        split = Int(stepper.value)
    }
}
