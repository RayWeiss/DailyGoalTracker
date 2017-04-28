//
//  ViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//
//  Much of this code has been modified from the JTAppleCalendar testApplicationCalendar example
//

import JTAppleCalendar

class CalendarViewController: UIViewController, HasMainMenuProtocol {
    
    var mainMenuVC: MainMenuViewController?
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet weak var weekViewStack: UIStackView!
    
    
    var numberOfRows = 6
    let formatter = DateFormatter()
    var myCalendar = Calendar.current
    var generateInDates: InDateCellGeneration = .forAllMonths
    var generateOutDates: OutDateCellGeneration = .tillEndOfGrid
    var prePostVisibility: ((CellState, CellView?)->())?
    var hasStrictBoundaries = true
    let firstDayOfWeek: DaysOfWeek = .sunday

    
    
    @IBOutlet weak var badPreformanceLabel: UILabel!
    @IBOutlet weak var mediocrePredormanceLabel: UILabel!
    @IBOutlet weak var goodPreformanceLabel: UILabel!
    
    
    // Colors
    let darkBadColor = UIColor(colorWithHexValue: 0xf5aaa3)
    let lightBadColor = UIColor(colorWithHexValue: 0xfad4d1)

    let darkMediocreColor = UIColor(colorWithHexValue: 0xfde59b)
    let lightMediocreColor = UIColor(colorWithHexValue: 0xfef2cd)

    let darkGoodColor = UIColor(colorWithHexValue: 0x8adba0)
    let lightGoodColor = UIColor(colorWithHexValue: 0xc4edcf)

    
    let todayBackgroundColor = UIColor.white
    let todayTextColor = UIColor.blue
    
    let white = UIColor.white
    let black = UIColor.black
    let gray = UIColor.gray
    let orange = UIColor.orange
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Always scoll to today
        calendarView.scrollToDate(NSDate() as Date)
        
        badPreformanceLabel.backgroundColor = darkBadColor
        mediocrePredormanceLabel.backgroundColor = darkMediocreColor
        goodPreformanceLabel.backgroundColor = darkGoodColor
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let firstDateInfo = calendarView.visibleDates().indates.first {
            calendarView.viewWillTransition(to: size, with: coordinator, focusDateIndexPathAfterRotate: firstDateInfo.indexPath)
        } else {
            let firstDateInfo = calendarView.visibleDates().monthDates.first!
            calendarView.viewWillTransition(to: size, with: coordinator, focusDateIndexPathAfterRotate: firstDateInfo.indexPath)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = myCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = myCalendar.component(.year, from: startDate)
        monthLabel.text = monthName + " " + String(year)
    }
    
    func handleCellConfiguration(cell: JTAppleCell?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        prePostVisibility?(cellState, cell as? CellView)
    }
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = black
        } else {
            myCustomCell.dayLabel.textColor = gray
        }
        if myCalendar.isDateInToday(cellState.date) {
            myCustomCell.dayLabel.textColor = todayTextColor
        }
    }
    
}

// MARK : JTAppleCalendarDelegate
extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = myCalendar.timeZone
        formatter.locale = myCalendar.locale
        
        
        let startDate = formatter.date(from: "2000 01 01")!
        let endDate = formatter.date(from: "2068 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: myCalendar,
                                                 generateInDates: generateInDates,
                                                 generateOutDates: generateOutDates,
                                                 firstDayOfWeek: firstDayOfWeek,
                                                 hasStrictBoundaries: hasStrictBoundaries)
        return parameters
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        
        myCustomCell.dayLabel.text = cellState.text
        
        if let progress = mainMenuVC?.ProgressHistory[date.hashValue] {
            switch progress {
            case .bad:
                if cellState.dateBelongsTo == .thisMonth {
                    myCustomCell.backgroundColor = darkBadColor
                } else {
                    myCustomCell.backgroundColor = lightBadColor
                }
                
            case .mediocre:
                if cellState.dateBelongsTo == .thisMonth {
                    myCustomCell.backgroundColor = darkMediocreColor
                } else {
                    myCustomCell.backgroundColor = lightMediocreColor
                }

            case .good:
                if cellState.dateBelongsTo == .thisMonth {
                    myCustomCell.backgroundColor = darkGoodColor
                } else {
                    myCustomCell.backgroundColor = lightGoodColor
                }
            }
        } else {
            if myCalendar.isDateInToday(date) {
                myCustomCell.backgroundColor = todayBackgroundColor
            } else {
                myCustomCell.backgroundColor = white
            }
        }
        

        
        handleCellConfiguration(cell: myCustomCell, cellState: cellState)
        return myCustomCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        self.setupViewsOfCalendar(from: calendarView.visibleDates())
    }

}

