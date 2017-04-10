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
    var testCalendar = Calendar.current
    var generateInDates: InDateCellGeneration = .forAllMonths
    var generateOutDates: OutDateCellGeneration = .tillEndOfGrid
    var prePostVisibility: ((CellState, CellView?)->())?
    var hasStrictBoundaries = true
    let firstDayOfWeek: DaysOfWeek = .sunday
    let disabledColor = UIColor.lightGray
    let enabledColor = UIColor.blue
    let dateCellSize: CGFloat? = nil
    var monthSize: MonthSize? = nil
    var prepostHiddenValue = false
    
    let red = UIColor.red
    let yellow = UIColor.yellow
    let green = UIColor.green
    let blue = UIColor.blue
    
    // ffa1a0 - red, ffffa0 - yellow, a0ffa0 - green, a0bfff - blue
    let badColor = UIColor(colorWithHexValue: 0xffa1a0)
    let mediocreColor = UIColor(colorWithHexValue: 0xffffa0)
    let goodColor = UIColor(colorWithHexValue: 0xa0ffa0)
    let todayColor = UIColor(colorWithHexValue: 0xa0bfff)

    
    let white = UIColor.white
    let black = UIColor.black
    let gray = UIColor.gray    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.scrollToDate(NSDate() as Date)
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
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = testCalendar.component(.year, from: startDate)
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
    }
    
    
    @IBAction func testFunc(_ sender: UIButton) {
        mainMenuVC?.ProgressHistory[1362566470642084800] = .bad
        calendarView.reloadData()
    }
    
    @IBAction func testFunc2(_ sender: UIButton) {
        mainMenuVC?.goalList.append(("Go to bed at 10:00 pm",false))
    }
}

// MARK : JTAppleCalendarDelegate
extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = testCalendar.timeZone
        formatter.locale = testCalendar.locale
        
        
        let startDate = formatter.date(from: "2000 01 01")!
        let endDate = formatter.date(from: "2068 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: testCalendar,
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
                myCustomCell.backgroundColor = badColor

            case .mediocre:
                myCustomCell.backgroundColor = mediocreColor

            case .good:
                myCustomCell.backgroundColor = goodColor
            }
        } else {
            myCustomCell.backgroundColor = white
        }
        
        if testCalendar.isDateInToday(date) {
            myCustomCell.backgroundColor = todayColor
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

    func sizeOfDecorationView(indexPath: IndexPath) -> CGRect {
        let stride = calendarView.frame.width * CGFloat(indexPath.section)
        return CGRect(x: stride + 5, y: 5, width: calendarView.frame.width - 10, height: calendarView.frame.height - 10)
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return monthSize
    }
}

