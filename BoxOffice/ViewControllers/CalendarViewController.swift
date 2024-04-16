//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Yejin Hong on 4/16/24.
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
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        calendarView = UICalendarView()
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
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
