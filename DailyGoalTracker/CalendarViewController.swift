//
//  CalendarViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//
//  This code has been based on the JTAppleCalendar testApplicationCalendar example
//  https://github.com/patchthecode/JTAppleCalendar/
//
//  Code marked as "Standard JTAppleCalendar" is required for the calendar
//  to function properly
//
//  Code marked as "Modified JTAppleCalendar" is predefined class code that
//  allows configuration of the calendar.  It has been modified to achieve the look
//  and functionality of the calendar for DailyGoalTracker
//

import JTAppleCalendar

class CalendarViewController: UIViewController, HasMainMenuProtocol {
    
    var mainMenuVC: MainMenuViewController?
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet weak var weekViewStack: UIStackView!
    
    @IBOutlet weak var badPreformanceLabel: UILabel!
    @IBOutlet weak var mediocrePredormanceLabel: UILabel!
    @IBOutlet weak var goodPreformanceLabel: UILabel!
    
    // Calendar Configuration
    let numberOfWeeksToShow = 6
    let myFormatter = DateFormatter()
    var myCalendar = Calendar.current
    let fontName = "Helvetica-Bold"
    let fontSize = CGFloat(20.0)
    let myDateFormat = "yyyy MM dd"
    let beginingOfTime = "2000 01 01"
    let endOfTime = "2099 12 31"
    let borderWidth = 0 // default is 2
    
    // Calendar Colors
    let todayBackgroundColor = UIColor.white
    let unmarkedDayBackgroundColor = UIColor.white
    
    let todayTextColor = UIColor.blue
    let thisMonthDayTextColor = UIColor.black
    let otherMonthDayTextColor = UIColor.gray
    
    let borderColor = UIColor.white
    
    // Progress Colors
    let darkBadColor = UIColor(colorWithHexValue: 0xf5aaa3)
    let lightBadColor = UIColor(colorWithHexValue: 0xfad4d1)
    
    let darkMediocreColor = UIColor(colorWithHexValue: 0xfde59b)
    let lightMediocreColor = UIColor(colorWithHexValue: 0xfef2cd)
    
    let darkGoodColor = UIColor(colorWithHexValue: 0x8adba0)
    let lightGoodColor = UIColor(colorWithHexValue: 0xc4edcf)
    
    // Standard JTAppleCalendar
    var prePostVisibility: ((CellState, CellView?)->())?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Always scoll to today
        calendarView.scrollToDate((mainMenuVC?.todayDate)!)

        
        badPreformanceLabel.backgroundColor = darkBadColor
        mediocrePredormanceLabel.backgroundColor = darkMediocreColor
        goodPreformanceLabel.backgroundColor = darkGoodColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Standard JTAppleCalendar Function
    // Handles orientation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let firstDateInfo = calendarView.visibleDates().indates.first {
            calendarView.viewWillTransition(to: size, with: coordinator, focusDateIndexPathAfterRotate: firstDateInfo.indexPath)
        } else {
            let firstDateInfo = calendarView.visibleDates().monthDates.first!
            calendarView.viewWillTransition(to: size, with: coordinator, focusDateIndexPathAfterRotate: firstDateInfo.indexPath)
        }
    }

    @IBAction func prev(_ sender: UIButton) {
        self.calendarView.scrollToSegment(.previous) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        self.calendarView.scrollToSegment(.next) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    // Standard JTAppleCalendar Function
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = myCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        let year = myCalendar.component(.year, from: startDate)
        monthLabel.text = monthName + " " + String(year)
    }
    
    // Modified JTAppleCalendar Function
    // configures custom cells
    func handleCellConfiguration(cell: JTAppleCell?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        prePostVisibility?(cellState, cell as? CellView)
        
        cell?.layer.borderColor = borderColor.cgColor
        cell?.layer.borderWidth = CGFloat(borderWidth)
    }
    
    // Modified JTAppleCalendar Function
    // handles day text color and font
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let modifiedCell = view as? CellView  else {
            return
        }
        modifiedCell.dayLabel.font = UIFont(name: fontName, size: fontSize)
        if cellState.dateBelongsTo == .thisMonth {
            modifiedCell.dayLabel.textColor = thisMonthDayTextColor
        } else {
            modifiedCell.dayLabel.textColor = otherMonthDayTextColor
        }
        if myCalendar.isDate(cellState.date, inSameDayAs: (mainMenuVC?.todayDate)!) {
            modifiedCell.dayLabel.textColor = todayTextColor
        }
        
    }
    
}

// Standard JTAppleCalendar
// This is the delegate
extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    // Modified JTAppleCalendar Function
    // sets swift "calendar" configuation options
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        myFormatter.dateFormat = myDateFormat
        myFormatter.timeZone = myCalendar.timeZone
        myFormatter.locale = myCalendar.locale
        
        let parameters = ConfigurationParameters(startDate: myFormatter.date(from: beginingOfTime)!,
                                                 endDate: myFormatter.date(from: endOfTime)!,
                                                 numberOfRows: numberOfWeeksToShow,
                                                 calendar: myCalendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
    
    // Modified JTAppleCalendar Function
    // returns configured "day" cells for calendar display
    public func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let modifiedCell = calendar.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        
        modifiedCell.dayLabel.text = cellState.text
        
        if let progress = mainMenuVC?.ProgressHistory[date.hashValue] {
            switch progress {
            case .bad:
                if cellState.dateBelongsTo == .thisMonth {
                    modifiedCell.backgroundColor = darkBadColor
                } else {
                    modifiedCell.backgroundColor = lightBadColor
                }
                
            case .mediocre:
                if cellState.dateBelongsTo == .thisMonth {
                    modifiedCell.backgroundColor = darkMediocreColor
                } else {
                    modifiedCell.backgroundColor = lightMediocreColor
                }

            case .good:
                if cellState.dateBelongsTo == .thisMonth {
                    modifiedCell.backgroundColor = darkGoodColor
                } else {
                    modifiedCell.backgroundColor = lightGoodColor
                }
            }
        } else {
            if myCalendar.isDateInToday(date) {
                modifiedCell.backgroundColor = todayBackgroundColor
            } else {
                modifiedCell.backgroundColor = unmarkedDayBackgroundColor
            }
        }
        
        handleCellConfiguration(cell: modifiedCell, cellState: cellState)
        return modifiedCell
    }
    
    // Standard JTAppleCalendar Function
    // loads first month label
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    // Standard JTAppleCalendar Function
    // handles end of month scrolling
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        self.setupViewsOfCalendar(from: calendarView.visibleDates())
    }

}

