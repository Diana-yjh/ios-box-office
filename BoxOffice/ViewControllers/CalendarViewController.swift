//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/16/24.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func updateDate(dateComponents: DateComponents)
}

class CalendarViewController: UIViewController, UICalendarSelectionSingleDateDelegate {
    
    var calendarView = UICalendarView()
    var selectedDateComponents: DateComponents?
    weak var delegate: SendDataDelegate?
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let safeDateComponents = dateComponents else {
            return
        }
        
        self.selectedDateComponents = safeDateComponents
        
        self.delegate?.updateDate(dateComponents: safeDateComponents)
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendarView()
        setUI()
    }
    
    func configureCalendarView() {
        calendarView = UICalendarView()
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ko_KR")
        
        let selectionDelegate = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionDelegate
        
        if let safeDateComponents = self.selectedDateComponents {
            selectionDelegate.setSelected(safeDateComponents, animated: true)
        }
        
        if let startDate = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2000, month: 1, day: 1)) {
            calendarView.availableDateRange = DateInterval(start: startDate, end: Date.yesterday)
        }
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
