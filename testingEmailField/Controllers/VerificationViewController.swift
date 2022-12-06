//
//  ViewController.swift
//  testingEmailField
//
//  Created by Apple on 20.03.2022.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private let statusLabel = StatusLabel()
    private let mailTextField = MailTextField()
    private let verificationButton = VerificationButton()
    private let collectionView = MailsCollectionView(frame: .zero,
                                                     collectionViewLayout: UICollectionViewFlowLayout())
    
    private let verificationModel = VerificationModel()
    
    private lazy var stackView = UIStackView(arrangedSubViews: [mailTextField, verificationButton, collectionView],
                                        axis: .vertical,
                                        spacing: 20)
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
    }

    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        verificationButton.addTarget(self,
                                     action: #selector(verificationButtonTapped),
                                     for: .touchUpInside)
    }
    
    @objc private func verificationButtonTapped() {
        guard let mail = mailTextField.text else { return }
        NetworkDataFetch.shared.fetchMail(verifiableMail: mail) { result, error in
            
            if error == nil {
                guard let result = result else { return }
                if result.success {
                    print("good")
                    guard let didYouMeanError = result.did_you_mean else {
                        Alerts.showResultAlert(vc: self,
                                               message: "Mail status: \(result.result) \n \(result.reasonDescription)")
                        return
                    }
                    Alerts.showErrorAlert(vc: self,
                                          message: "Did you mean: \(didYouMeanError)") { [ weak self] in
                        guard let self = self else { return }
                        self.mailTextField.text = didYouMeanError
                    }
                    print("chane email")
                }
            } else {
                guard let errorDescriprion = error?.localizedDescription else { return }
                Alerts.showResultAlert(vc: self, message: errorDescriprion)            }
        }
        print("Button Tap")
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.selectMailDelegate = self
        mailTextField.textFieldDelegate = self
    }
}
//MARK: - UICollectionViewDataSource

extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filtredMailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell.idMailCell.rawValue, for: indexPath) as? MailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let mailLabelText = verificationModel.filtredMailArray[indexPath.item]
        cell.cellConfigure(mailLabelText: mailLabelText)
        return cell
    }
}


//MARK: - SelectProposedMailProtocol

extension VerificationViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {
        guard let text = mailTextField.text else { return }
        verificationModel.getMailName(text: text)
        let domainMail = verificationModel.filtredMailArray[indexPath.item]
        let mailFullname = verificationModel.nameMail + domainMail
        mailTextField.text = mailFullname
        statusLabel.isValid = mailFullname.isValid()
        verificationButton.isValid = mailFullname.isValid()
        verificationModel.filtredMailArray = []
        collectionView.reloadData()
    }
}

//MARK: - ActionsMailTextFieldProtocol

extension VerificationViewController: ActionsMailTextFieldProtocol {
    func typingText(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFiltredMails(text: text)
        collectionView.reloadData()
    }
    
    func cleanOutTextField() {
        statusLabel.setDefaultSetting()
        verificationButton.setDefaultSetting()
        verificationModel.filtredMailArray = []
        collectionView.reloadData()
    }
    
    
    
    
}

//MARK: - SetConstrains

extension VerificationViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

