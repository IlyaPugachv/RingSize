import UIKit

final class PopUpVC: UIViewController {
    
    private var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(nil, action: #selector(closePopVC), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
      
    }
    
    
    
    private func setupViews() {
        view.backgroundColor = .white
        
    }
    
    private func setupConstrains() {
        view.addSubview(cancelBtn)
        
        NSLayoutConstraint.activate([
            cancelBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func closePopVC() {
        dismiss(animated: true, completion: nil)
    }
}


