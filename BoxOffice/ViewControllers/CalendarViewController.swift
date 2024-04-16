//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Yejin Hong on 4/16/24.
//

import UIKit

class CalendarViewController: UIViewController {
    var calendarView = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendarView()
        setUI()
    }
    
    func configureCalendarView() {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        calendarView = UICalendarView()
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
