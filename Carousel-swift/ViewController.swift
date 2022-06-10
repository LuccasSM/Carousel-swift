//
//  ViewController.swift
//  Carousel-swift
//
//  Created by Luccas Santana Marinho on 09/06/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.addTarget(self, action: #selector(pageControlDidChage), for: .valueChanged)
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
    }
    
    @objc func pageControlDidChage(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * self.view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 0, y: self.view.frame.size.height - 100, width: self.view.frame.size.width, height: 70)
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .link
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        return pageControl
    }()
    
    private let scrollView = UIScrollView()
    
    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: self.view.frame.width * 5, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        let colors: [UIColor] = [
            .systemOrange,
            .systemGreen,
            .systemRed,
            .systemCyan,
            .systemPurple
        ]
        
        for x in 0..<5 {
            let page = UIView(frame: CGRect(x: CGFloat(x) * self.view.frame.size.width + 30, y: UIScreen.main.bounds.height / 3, width: self.view.frame.size.width - 60, height: 300))
            page.backgroundColor = colors[x]
            scrollView.addSubview(page)
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}
