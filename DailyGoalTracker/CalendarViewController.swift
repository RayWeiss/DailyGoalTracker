//
//  CalendarViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//
//  This code is based on the JTAppleCalendar testApplicationCalendar example
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

class CalendarViewController: UIViewController, HasMainMenuProtocol, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    var mainMenuVC: MainMenuViewController?
    
    // Storyboard outlets
    @IBOutlet weak var progressCalendar: JTAppleCalendarView!
    @IBOutlet var nameOfMonth: UILabel!
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
    let borderWidth = 1 // default is 2
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Always scoll to "today"
        progressCalendar.scrollToDate((mainMenuVC?.todayDate)!)
        
        // Set Key colors
        badPreformanceLabel.backgroundColor = darkBadColor
        mediocrePredormanceLabel.backgroundColor = darkMediocreColor
        goodPreformanceLabel.backgroundColor = darkGoodColor
    }
    
    @IBAction func previousMonth(_ sender: UIButton) {
        self.progressCalendar.scrollToSegment(.previous)
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        self.progressCalendar.scrollToSegment(.next)
    }
    
    // From here down are the required delegate / datasource methods
    //
    // Modified JTAppleCalendar Method
    // sets swift "calendar" configuation options
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        myFormatter.dateFormat = myDateFormat
        myFormatter.timeZone = myCalendar.timeZone
        myFormatter.locale = myCalendar.locale
        
        return ConfigurationParameters(startDate: myFormatter.date(from: beginingOfTime)!,
                                                 endDate: myFormatter.date(from: endOfTime)!,
                                                 numberOfRows: numberOfWeeksToShow,
                                                 calendar: myCalendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: true)
    }
    
    // Modified JTAppleCalendar Method
    // Returns configured "day" cells for calendar display
    public func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        // Get a cell
        let modifiedCell = calendar.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        
        // Set date text
        modifiedCell.dayLabel.text = cellState.text
        
        // Handle progress color / background color
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
        
        // Handle borders
        modifiedCell.layer.borderColor = borderColor.cgColor
        modifiedCell.layer.borderWidth = CGFloat(borderWidth)
        
        // Handle day text
        modifiedCell.dayLabel.font = UIFont(name: fontName, size: fontSize)
        if cellState.dateBelongsTo == .thisMonth {
            modifiedCell.dayLabel.textColor = thisMonthDayTextColor
        } else {
            modifiedCell.dayLabel.textColor = otherMonthDayTextColor
        }
        if myCalendar.isDate(cellState.date, inSameDayAs: (mainMenuVC?.todayDate)!) {
            modifiedCell.dayLabel.textColor = todayTextColor
        }
        
        return modifiedCell
    }
    
    // Standard JTAppleCalendar Method
    // Handles scrolling
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = myCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        let year = myCalendar.component(.year, from: startDate)
        nameOfMonth.text = monthName + " " + String(year)
    }
    
}
