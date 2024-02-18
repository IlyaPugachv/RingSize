import UIKit

final class RingVC: UIViewController {
    
    private var circleLayer: CAShapeLayer?
    
    //MARK: - LAZY CLOSURE
    
    lazy var infoCircle: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var ringSize: UILabel = {
        let label = UILabel()
        label.text = "Ring Size"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Match the Ring to the Circle"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var gearCircle: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 12.04
        slider.maximumValue = 23.42
        slider.minimumTrackTintColor = .orange
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var plusBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var minusBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var sizeCircle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "17.73\nmm"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIView = {
        let image = UIView()
        image.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
        image.layer.cornerRadius = 18
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.3
        image.layer.shadowOffset = CGSize(width: 2, height: 2)
        image.layer.shadowRadius = 4
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var unitsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("AU/GB", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor.brown.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var defineRingBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Define the Ring Size", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.backgroundColor = UIColor.systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        slider.value = 17.73
        sliderValueChanged(slider)
    }
    
    //MARK: - PRIVATE FUNC
    
    private func setupUI() {
        setupSubviews()
        setupConstraint()
        setupGestureSlider()
        vsStackSliderValue()
        vsStackRingSize()
    }
    
    private func setupSubviews() {
        let subviews = [unitsBtn, ringSize, textLabel, infoCircle, gearCircle, imageView, slider, plusBtn, minusBtn, sizeCircle, unitsBtn, defineRingBtn]
        subviews.forEach { view.addSubview($0) }
      
        createCircle(radius: 40)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            sizeCircle.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 145),
            sizeCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 194),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: slider.topAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            unitsBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 110),
            unitsBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            unitsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
        ])
        
        NSLayoutConstraint.activate([
            defineRingBtn.topAnchor.constraint(equalTo: unitsBtn.bottomAnchor, constant: 35),
            defineRingBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            defineRingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    private func setupGestureSlider() {
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func vsStackRingSize() {
        let buttonsStack = UIStackView(arrangedSubviews: [infoCircle, ringSize, gearCircle])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 10
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            
            buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            ringSize.centerYAnchor.constraint(equalTo: buttonsStack.centerYAnchor),
            
            infoCircle.widthAnchor.constraint(equalTo: infoCircle.heightAnchor),
            gearCircle.widthAnchor.constraint(equalTo: gearCircle.heightAnchor),
        ])
    }
    
    private func vsStackSliderValue() {
        let buttonsStack = UIStackView(arrangedSubviews: [minusBtn, slider, plusBtn])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 10
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55)
        ])
    }
    
    private func createSegment(startAngle: CGFloat, endAngle: CGFloat, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: view.bounds.midY-90),
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
        segmentLayer.strokeColor = UIColor.black.cgColor
        segmentLayer.fillColor = UIColor.clear.cgColor
        
        self.view.layer.addSublayer(segmentLayer)
        circleLayer = segmentLayer
    }
    
    private func removeCircle() {
        guard let circleLayer = circleLayer else { return }
        circleLayer.removeFromSuperlayer()
    }
    
    private func roundedRadius(value: CGFloat) {
        let radiusLabel = sizeCircle
        let roundedRadius = String(format: "%.2f", slider.value)
        radiusLabel.text = "\(roundedRadius) \nmm"
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
        roundedRadius(value: radius)
    }
}

