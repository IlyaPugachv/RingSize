import UIKit

class RingVC: UIViewController {
    
    private let infoCircle: UIImageView = {
           let imageView = UIImageView()
           let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
           let infoCircleImage = UIImage(systemName: "info.circle", withConfiguration: configuration)
           imageView.image = infoCircleImage
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
    
    private let ringSize: UILabel = {
        let label = UILabel()
        label.text = "Ring Size"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Match the Ring to the Circle"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gearCircle: UIImageView = {
           let imageView = UIImageView()
           let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
           let gearCircleImage = UIImage(systemName: "gearshape", withConfiguration: configuration)
           imageView.image = gearCircleImage
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(ringSize)
        view.addSubview(textLabel)
        view.addSubview(infoCircle)
        view.addSubview(gearCircle)
        
        NSLayoutConstraint.activate([
            ringSize.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            ringSize.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            infoCircle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            infoCircle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            gearCircle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            gearCircle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

}
