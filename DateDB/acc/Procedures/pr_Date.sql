CREATE PROCEDURE [acc].[pr_Date]
	@date DATE = NULL
AS

IF @date IS NULL
BEGIN
SET @date = CAST(CURRENT_TIMESTAMP AS DATE);
END 

IF TRY_CAST(@date AS DATE) IS NOT NULL

BEGIN

DECLARE @y CHAR(4) = DATEPART(YEAR,@date)
DECLARE @m CHAR(2) = RIGHT('00'+CAST(DATEPART(MONTH,@date) AS VARCHAR),2)
DECLARE @d CHAR(2) = RIGHT('00'+CAST(DATEPART(DAY,@date) AS VARCHAR),2)
--DECLARE @datestyle CHAR(10) = [tools].fu_DateStyle(NULL,@y,@m,@d)
--DECLARE @datetime DATETIME = CASE WHEN ISDATE(@datestyle) = 1 THEN @datestyle END

/*
Start Day of Month
*/
DECLARE @startdayofmonthdate DATE = 
CASE WHEN DATEPART(YEAR,@date) = 9999 AND DATEPART(MONTH,@date) = 12 THEN '9999-12-01'
ELSE
CAST(DATEPART(YEAR,@date) AS VARCHAR)+'-'+CAST(DATEPART(MONTH,@date)AS VARCHAR)+'-01' END
DECLARE @startdayofmonthdatekey INT  = [tools].[fu_DateInt] (@startdayofmonthdate)
--DECLARE @startdayofmonthdatestyle VARCHAR(10) = [tools].fu_DateStyle(@startdayofmonthdate,'','','')

/*
End Day of Month
*/
DECLARE @enddayofmonthdate DATE = 
CASE WHEN @startdayofmonthdate = '9999-12-01' THEN '9999-12-31'
ELSE
DATEADD(DAY,-1,DATEADD(MONTH,1,@startdayofmonthdate)) END
DECLARE @enddayofmonthdatekey INT = [tools].[fu_DateInt] (@enddayofmonthdate)
--DECLARE @enddayofmonthdatestyle VARCHAR(10)   = [tools].fu_DateStyle(@enddayofmonthdate,'','','')

/*
Start Day of Quarter
*/
DECLARE @startdayofquarterdate DATE = 
CASE WHEN DATEPART(YEAR,@date) = 9999 AND DATEPART(QUARTER,@date) = 4 THEN '9999-12-01'
ELSE
CAST(DATEPART(YEAR,@date) AS VARCHAR)+'-'+
CASE WHEN DATEPART(QUARTER,@date) = 1 THEN '01'
WHEN DATEPART(QUARTER,@date) = 2 THEN '04'
WHEN DATEPART(QUARTER,@date) = 3 THEN '07'
WHEN DATEPART(QUARTER,@date) = 4 THEN '10'
END+'-01' END
DECLARE @startdayofquarterdatekey INT  = [tools].[fu_DateInt] (@startdayofquarterdate)

/*
End Day of Quarter
*/
DECLARE @enddayofquarterdate DATE = 
CASE WHEN @startdayofmonthdate = '9999-12-01' THEN '9999-12-31'
ELSE
DATEADD(DAY,-1,DATEADD(QUARTER,1,@startdayofquarterdate)) END
DECLARE @enddayofquarterdatekey INT = [tools].[fu_DateInt] (@enddayofquarterdate)


/*
Start Day of Calendar Year
*/
DECLARE @startdayofcalendaryeardate DATE = DATENAME(YEAR, @date)+'-01-01'
DECLARE @startdayofcalendaryeardatekey INT  = [tools].[fu_DateInt] (@startdayofcalendaryeardate)

/*
End Day of Calendar Year
*/
DECLARE @enddayofcalendaryeardate DATE = DATENAME(YEAR, @date)+'-12-31'
DECLARE @enddayofcalendaryeardatekey INT = [tools].[fu_DateInt] (@enddayofcalendaryeardate)

SELECT
[DateKey] = [tools].[fu_DateInt] (@date)
,[DayOfWeekNo] = CASE WHEN DATEPART(WEEKDAY,@date ) BETWEEN 2 AND 7 
THEN DATEPART(WEEKDAY,@date )-1 ELSE 7 END 
,[DayOfWeekName] = DATENAME(WEEKDAY,@date)
,[DayOfWeekAbbreviation] = LEFT(DATENAME(WEEKDAY,@date ),3)
,[DayOfMonthNo] = DATEPART(DAY,@date) 
,[IsWeekDay]  = CASE WHEN DATENAME(WEEKDAY,@date ) LIKE 'S%' THEN 0 ELSE 1 END 
,[WeekdayDescription] = CASE WHEN DATENAME(WEEKDAY,@date ) LIKE 'S%' THEN 'Weekend'ELSE 'Weekday' END 
,[MonthOfYearName] = DATENAME(MONTH,@date)
,[MonthOfYearAbbreviation] = LEFT(DATENAME(MONTH,@date),3)
,[MonthName] = DATENAME(MONTH,@date)+' '+DATENAME(YEAR,@date)
,[MonthAbbreviation] = LEFT(DATENAME(MONTH,@date),3)+' '+DATENAME(YEAR,@date)
,[QuarterOfYearName] =  CASE WHEN DATENAME(QUARTER, @date) = 1 THEN 'Jan-Mar' WHEN DATENAME(QUARTER, @date) = 2 THEN 'Apr-Jun' WHEN DATENAME(QUARTER, @date) = 3 THEN 'Jul-Sep' ELSE 'Oct-Dec' END 
,[QuarterName] = CASE WHEN DATENAME(QUARTER, @date) = 1 THEN 'Jan-Mar '+DATENAME(YEAR,@date) WHEN DATENAME(QUARTER, @date) = 2 THEN 'Apr-Jun '+DATENAME(YEAR,@date) WHEN DATENAME(QUARTER, @date) = 3 THEN 'Jul-Sep '+DATENAME(YEAR,@date)  ELSE 'Oct-Dec '+DATENAME(YEAR,@date) END
,[CalendarWeekOfYearNo] = DATEPART(WEEK, @date) 
,[CalendarWeekNo] = CAST(DATENAME(YEAR, @date)+RIGHT('00'+DATENAME(WEEK, @date),2) AS INT)
,[CalendarMonthOfYearNo] = DATEPART(MONTH,@date) 
,[CalendarMonthNo] = CAST(DATENAME(YEAR, @date)+RIGHT('00'+CAST(DATEPART(MONTH,@date) AS VARCHAR),2) AS INT)
,[CalendarQuarterOfYearNo] = DATEPART(QUARTER,@date)
,[CalendarQuarterNo] = CAST(DATENAME(YEAR,@date)+DATENAME(QUARTER,@date) AS SMALLINT)
,[CalendarYear] = DATEPART(YEAR,@date)
,[DateOffset] = DATEDIFF(DAY,GETDATE(),@date)
,[MonthOffset]= DATEDIFF(MONTH,GETDATE(),@date)
,[QuarterOffset]= DATEDIFF(QUARTER,GETDATE(),@date)
,[CalendarYearOffset]= DATEDIFF(YEAR,GETDATE(),@date)
	,[StartDayofMonthDate]  = @startdayofmonthdate
	,[StartDayofMonthDateKey] = @startdayofmonthdatekey
	,[EndDayofMonthDate]  = @enddayofmonthdate
	,[EndDayofMonthDateKey] = @enddayofmonthdatekey
	
	,[StartDayofQuarterDate]  = @startdayofQuarterdate
	,[StartDayofQuarterDateKey] = @startdayofQuarterdatekey
	,[EndDayofQuarterDate]  = @enddayofQuarterdate
	,[EndDayofQuarterDateKey] = @enddayofQuarterdatekey
	
	,[StartDayofCalendarYearDate]  = @startdayofcalendaryeardate
	,[StartDayofCalendarYearDateKey] = @startdayofcalendaryeardatekey
	,[EndDayofCalendarYearDate]  = @enddayofcalendaryeardate
	,[EndDayofCalendarYearDateKey] = @enddayofcalendaryeardatekey
	
	,[DaysInMonth] = DATEDIFF(DAY,@startdayofmonthdate, DATEADD(MONTH,1,@startdayofmonthdate))
	,[DaysInCalendarYear] = DATEDIFF(DAY,@startdayofcalendaryeardate, DATEADD(YEAR,1,@startdayofcalendaryeardate))

END