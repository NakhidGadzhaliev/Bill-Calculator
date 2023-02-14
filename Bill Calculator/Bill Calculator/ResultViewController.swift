//
//  ResultViewController.swift
//  Bill Calculator
//
//  Created by Нахид Гаджалиев on 14.02.2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    var split = 0
    var percent = 0
    var result: Double = 0.0
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalLabel, resultLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        
        return stack
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total per person"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "\(result)"
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Split between \(split) people, \n with \(percent)% tip."
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    lazy var recalculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recalculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUpdate()
    }
    
    @objc private func dismissButton() {
        dismiss(animated: true)
    }
    
    private func viewUpdate() {
        view.backgroundColor = UIColor(named: "viewGreenBackground")
        view.addSubview(whiteView)
        view.addSubview(stackView)
        view.addSubview(descriptionLabel)
        view.addSubview(recalculateButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        recalculateButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recalculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            recalculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -50),
        ])
    }

}
