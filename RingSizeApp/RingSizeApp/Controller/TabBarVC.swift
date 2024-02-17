import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = RingVC()
        let vc2 = RulerVC()
        let vc3 = ArticlesVC()
        let vc4 = ResultsVC()
    
        vc1.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Ring", image: UIImage(systemName: "suit.diamond"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Ruler", image: UIImage(systemName: "pencil.and.ruler"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Articles", image: UIImage(systemName: "wallet.pass"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Results", image: UIImage(systemName: "pin"), tag: 4)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}
