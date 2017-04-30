using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DateAPI.Models
{
    public class Date
    {
        public int DateKey { get; set; }
        public int DayOfWeekNo;
        public string DayOfWeekName;
        public string DayOfWeekAbbreviation;
        public int DayOfMonthNo;
        public bool IsWeekDay;
        public string WeekDayDescription;
        public string MonthOfYearName;
        public string MonthOfYearAbbreviation;
        public string MonthName;
        public string MonthAbbreviation;
        public string QuarterOfYearName;
        public string QuarterName;
        public int CalendarWeekOfYearNo;
        public int CalendarWeekNo;
        public int CalendarMonthOfYearNo;
        public int CalendarMonthNo;
        public int CalendarQuarterOfYearNo;
        public int CalendarQuarterNo;
        public int CalendarYear;
        public int DateOffset;
        public int MonthOffset;
        public int QuarterOffset;
        public int CalendarYearOffset;
        public string StartDayOfMonthDate;
        public int StartDayOfMonthDateKey;
        public string EndDayOfMonthDate;
        public int EndDayOfMonthDateKey;
        public string StartDayOfQuarterDate;
        public int StartDayOfQuarterDateKey;
        public string EndDayOfQuarterDate;
        public int EndDayOfQuarterDateKey;
        public string StartDayOfCalendarYearDate;
        public int StartDayOfCalendarYearDateKey;
        public string EndDayOfCalendarYearDate;
        public int EndDayOfCalendarYearDateKey;
        public int DaysInMonth;
        public int DaysInCalendarYear;
    }
}