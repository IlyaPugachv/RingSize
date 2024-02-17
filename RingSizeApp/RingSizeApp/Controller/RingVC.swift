import UIKit

class RingVC: UIViewController {
    private var circleLayer: CAShapeLayer?
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
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 12.04
        slider.maximumValue = 23.42
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let plusBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let minusBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupVStack()
        createCircle(radius: 40)
        
    }
    
    private func setup() {
        view.addSubview(ringSize)
        view.addSubview(textLabel)
        view.addSubview(infoCircle)
        view.addSubview(gearCircle)
        view.addSubview(slider)
        view.addSubview(plusBtn)
        view.addSubview(minusBtn)
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
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
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 350),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
        ])
    }
    
    private func setupVStack() {
        let buttonsStack = UIStackView(arrangedSubviews: [minusBtn, slider, plusBtn])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 10
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 400),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65)
        ])
    }
    
    private func createSegment(startAngle: CGFloat, endAngle: CGFloat, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: view.bounds.midY),
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        return circlePath
    }
    
    private func createCircle(radius: CGFloat) {
        let segmentPath = createSegment(startAngle: 0, endAngle: 360, radius: radius)
        let segmentLayer = CAShapeLayer()
        segmentLayer.path = segmentPath.cgPath
        segmentLayer.lineWidth = 3
        segmentLayer.strokeColor = UIColor.gray.cgColor
        segmentLayer.fillColor = UIColor.clear.cgColor
        
        self.view.layer.addSublayer(segmentLayer)
        circleLayer = segmentLayer
    }
    
    private func removeCircle() {
        if let circleLayer = circleLayer {
            circleLayer.removeFromSuperlayer()
        }
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let minValue: CGFloat = 12.04
        let maxValue: CGFloat = 23.42
        let currentValue = CGFloat(sender.value)
        
        let range = maxValue - minValue
        let ratio = (currentValue - minValue) / range
        
        let minRadius: CGFloat = 40
        
        let maxRadius: CGFloat = 80
        
        let radius = min(maxRadius, max(minRadius, minRadius + ratio * (maxRadius - minRadius)))
        
        removeCircle()
        createCircle(radius: radius)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
