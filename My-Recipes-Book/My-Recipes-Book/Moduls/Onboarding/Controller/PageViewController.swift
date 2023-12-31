//
//  PageViewController.swift
//  My-Recipes-Book
//
//  Created by Артур  Арсланов on 01.09.2023.
//

import UIKit

class PageViewController: UIPageViewController {
    
    // MARK: - Variable
    
    var cooks = [CooksHelper]()
    let firstPageImage = UIImage(named: "cookPage1")
    let secondPageImage = UIImage(named: "cookPage2")
    let thirdPageImage = UIImage(named: "cookPage3")
    
    var nextIndex = 0
    
    var text1 = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstPage = CooksHelper(name: "Recipes from all over the World ", image: firstPageImage!,buttonText: "Continue", subButton: "Skip")
        let secondPage = CooksHelper(name: "Recipes with each every detali", image: secondPageImage!,buttonText: "Continue", subButton: "Skip")
        let thirdPage = CooksHelper(name: "Cook it now or save it for later", image: thirdPageImage!, buttonText: "Start Cooking", subButton: "")
        
        cooks.append(firstPage)
        cooks.append(secondPage)
        cooks.append(thirdPage)
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - create vc
    
    lazy var arrayCookVC: [CookViewController] = {
        var cooksVC = [CookViewController]()
        for cook in cooks {
            cooksVC.append(CookViewController(cookWith: cook))
        }
        return cooksVC
    }()

    // MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        self.view.backgroundColor = .clear
        self.dataSource = self
        self.delegate = self
        
        setViewControllers([arrayCookVC[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func goToNextPage() {
        guard let currentViewController = viewControllers?.first as? CookViewController,
            let currentIndex = arrayCookVC.firstIndex(of: currentViewController) else {
                return
        }

        nextIndex = currentIndex + 1
        if nextIndex < arrayCookVC.count && nextIndex != 3 {
            setViewControllers([arrayCookVC[nextIndex]], direction: .forward, animated: true, completion: nil)
        } else if nextIndex == 3 {
            guard let skipVC = viewControllers?.first as? CookViewController else {return}
            skipVC.skipButtonPressed()
        }
    }
}


// MARK: - extension
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CookViewController else {return nil}
        if let index = arrayCookVC.firstIndex(of: viewController){
            if index > 0 {
                return arrayCookVC[index - 1]
            }
            
        }
        return nil
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CookViewController else {return nil}
        if let index = arrayCookVC.firstIndex(of: viewController) {
            if index < cooks.count - 1 {
                return arrayCookVC[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cooks.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return nextIndex
    }
    
}


