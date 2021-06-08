//
//  ViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import UIKit
import Combine

class ComicHomeViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
  private var selectedComicHandle: AnyCancellable?
  private var fetchComicsHandle: AnyCancellable?

  private let sectionComicView: SectionComicView

  private var pageController: UIPageViewController
  private var controllers: [UIViewController]
  private var presentingVCIndex = 0 {
    didSet {
      title = controllers[presentingVCIndex].title
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    addChild(pageController)
    view.addSubview(pageController.view)

    let views = ["pageController": pageController.view] as [String: AnyObject]
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))

    controllers = [ComicHomeListViewController(comicType: .New), ComicHomeListViewController(comicType: .Future)]
    pageController.setViewControllers([controllers[0]], direction: .forward, animated: false, completion: nil)
    pageController.dataSource = self
    pageController.delegate = self

    navigationItem.title = controllers.first?.navigationItem.title

    sectionComicView.selectedIndex = controllers
      .map { $0 as? ComicHomeListViewController }
      .filter { $0 != nil }
      .first??.dataSource.comicsTypeDisplayed ?? .New
    navigationItem.titleView = sectionComicView
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    if let index = controllers.firstIndex(of: viewController) {
      if index > 0 {
        return controllers[index - 1]
      } else {
        return nil
      }
    }
    return nil
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let index = controllers.firstIndex(of: viewController) {
      if index < controllers.count - 1 {
        return controllers[index + 1]
      } else {
        return nil
      }
    }
    return nil
  }

  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    guard completed else { return }
    //navigationItem.title = controllers.first { $0 != previousViewControllers.first }?.navigationItem.title
    guard let vc = controllers.first(where: { $0 != previousViewControllers.first }) as? ComicHomeListViewController else {
      return
    }
    sectionComicView.selectedIndex = vc.dataSource.comicsTypeDisplayed
  }

  init() {
    pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    controllers = [UIViewController]()
    sectionComicView = SectionComicView()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
