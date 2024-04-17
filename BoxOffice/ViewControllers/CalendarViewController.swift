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

class CalendarViewController: UIViewController {
    private var calendarView = UICalendarView()
    var selectedDateComponents: DateComponents?
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendarView()
        setUI()
    }
    
    private func configureCalendarView() {
        calendarView = UICalendarView()
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ko_KR")
        
        let selectionDelegate = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionDelegate
        
        if let safeDateComponents = selectedDateComponents {
            selectionDelegate.setSelected(safeDateComponents, animated: true)
        }
        
        if let startDate = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2000, month: 1, day: 1)) {
            calendarView.availableDateRange = DateInterval(start: startDate, end: Date.yesterday)
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let safeDateComponents = dateComponents else {
            return
        }
        
        selectedDateComponents = safeDateComponents
        
        delegate?.updateDate(dateComponents: safeDateComponents)
        dismiss(animated: true)
    }
}
