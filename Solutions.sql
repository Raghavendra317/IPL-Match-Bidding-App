-- 1. Show the percentage of wins of each bidder in the order of highest to lowest percentage.
SELECT 
    bd.BidderId,
    bd.Bidder_name,
    COUNT(CASE WHEN b.BidStatus = 'Won' THEN 1 END) * 100.0 / COUNT(*) AS Win_Percentage
FROM IPL_Bidder_Details bd
JOIN IPL_Bidding_Details b ON bd.BidderId = b.BidderId
GROUP BY bd.BidderId, bd.Bidder_name
ORDER BY Win_Percentage DESC;

-- 2. Display the number of matches conducted at each stadium with the stadium name and city.
SELECT 
    s.Stadium_name,
    s.City,
    COUNT(ms.MatchId) AS Total_Matches
FROM IPL_Stadium s
JOIN IPL_Match_Schedule ms ON s.StadiumId = ms.StadiumId
GROUP BY s.Stadium_name, s.City;

-- 3. In a given stadium, what is the percentage of wins by a team that has won the toss?
SELECT 
    s.Stadium_name,
    COUNT(CASE WHEN m.TossWinner = m.MatchWinner THEN 1 END) * 100.0 / COUNT(*) AS Toss_Win_Percentage
FROM IPL_Match m
JOIN IPL_Match_Schedule ms ON m.MatchId = ms.MatchId
JOIN IPL_Stadium s ON ms.StadiumId = s.StadiumId
WHERE s.Stadium_name = 'Given_Stadium_Name' -- Replace with the actual stadium name
GROUP BY s.Stadium_name;

-- 4. Show the total bids along with the bid team and team name.
SELECT 
    bd.BidTeam,
    t.Team_name,
    COUNT(*) AS Total_Bids
FROM IPL_Bidding_Details bd
JOIN IPL_Team t ON bd.BidTeam = t.TeamId
GROUP BY bd.BidTeam, t.Team_name;

-- 5. Show the team ID who won the match as per the win details.
SELECT 
    MatchId,
    MatchWinner AS Winning_TeamId
FROM IPL_Match
WHERE MatchWinner IS NOT NULL;

-- 6. Display the total matches played, total matches won and total matches lost by the team along with its team name.
SELECT 
    ts.TeamId,
    t.Team_name,
    ts.Matches_played,
    ts.Matches_won,
    ts.Matches_lost
FROM IPL_Team_Standings ts
JOIN IPL_Team t ON ts.TeamId = t.TeamId;

-- 7. Display the bowlers for the Mumbai Indians team.
SELECT 
    p.PlayerId,
    p.Player_name
FROM IPL_Team_Players tp
JOIN IPL_Player p ON tp.PlayerId = p.PlayerId
JOIN IPL_Team t ON tp.TeamId = t.TeamId
WHERE t.Team_name = 'Mumbai Indians' AND tp.Player_role = 'Bowler';

-- 8. How many all-rounders are there in each team? Display the teams with more than 4 all-rounders in descending order.
SELECT 
    t.TeamId,
    t.Team_name,
    COUNT(tp.PlayerId) AS All_Rounders_Count
FROM IPL_Team_Players tp
JOIN IPL_Team t ON tp.TeamId = t.TeamId
WHERE tp.Player_role = 'All-rounder'
GROUP BY t.TeamId, t.Team_name
HAVING COUNT(tp.PlayerId) > 4
ORDER BY All_Rounders_Count DESC;

-- 9. Get the total bidders' points for each bidding status of those bidders who bid on CSK when they won the match in M. Chinnaswamy Stadium, bidding year-wise.
SELECT 
    bd.BidStatus,
    YEAR(bd.BidDate) AS Bidding_Year,
    SUM(bp.Total_points) AS Total_Bidders_Points
FROM IPL_Bidding_Details bd
JOIN IPL_Match_Schedule ms ON bd.ScheduleId = ms.ScheduleId
JOIN IPL_Stadium s ON ms.StadiumId = s.StadiumId
JOIN IPL_Match m ON ms.MatchId = m.MatchId
JOIN IPL_Bidder_Points bp ON bd.BidderId = bp.BidderId
JOIN IPL_Team t ON m.MatchWinner = t.TeamId
WHERE t.Team_name = 'Chennai Super Kings' 
AND s.Stadium_name = 'M. Chinnaswamy Stadium'
GROUP BY bd.BidStatus, YEAR(bd.BidDate)
ORDER BY Total_Bidders_Points DESC;

-- 10. Extract the Bowlers and All-Rounders that are in the 5 highest number of wickets.
SELECT 
    t.Team_name, 
    p.Player_name, 
    tp.Player_role
FROM IPL_Player p
JOIN IPL_Team_Players tp ON p.PlayerId = tp.PlayerId
JOIN IPL_Team t ON tp.TeamId = t.TeamId
WHERE tp.Player_role IN ('Bowler', 'All-rounder')
AND CAST(SUBSTRING_INDEX(p.Performance_dtls, ' wickets', 1) AS UNSIGNED) >= 
    (SELECT MIN(CAST(SUBSTRING_INDEX(Performance_dtls, ' wickets', 1) AS UNSIGNED)) 
     FROM (SELECT DISTINCT CAST(SUBSTRING_INDEX(Performance_dtls, ' wickets', 1) AS UNSIGNED) AS Wickets 
           FROM IPL_Player 
           WHERE Player_role IN ('Bowler', 'All-rounder') 
           ORDER BY Wickets DESC 
           LIMIT 5) AS Subquery)
ORDER BY CAST(SUBSTRING_INDEX(p.Performance_dtls, ' wickets', 1) AS UNSIGNED) DESC;


-- 11. Show the percentage of toss wins of each bidder and display the results in descending order.
SELECT 
    bd.BidderId,
    bd.BidStatus,
    (COUNT(CASE WHEN m.TossWinner = bd.BidTeam THEN 1 END) / COUNT(*) * 100) AS Toss_Win_Percentage
FROM IPL_Bidding_Details bd
JOIN IPL_Match_Schedule ms ON bd.ScheduleId = ms.ScheduleId
JOIN IPL_Match m ON ms.MatchId = m.MatchId
GROUP BY bd.BidderId, bd.BidStatus
ORDER BY Toss_Win_Percentage DESC;

-- 12. Find the IPL season with the longest duration.
SELECT 
    TournamentId, 
    Tournament_name, 
    DATEDIFF(To_date, From_date) AS Duration
FROM IPL_Tournament
WHERE DATEDIFF(To_date, From_date) = (SELECT MAX(DATEDIFF(To_date, From_date)) FROM IPL_Tournament);

-- 13. Query to calculate total points month-wise for the 2017 bid year using joins
SELECT 
    b.BidderId, 
    b.Bidder_name, 
    YEAR(bd.BidDate) AS Bid_Year, 
    MONTH(bd.BidDate) AS Bid_Month, 
    SUM(bp.Total_points) AS Total_Points
FROM IPL_Bidding_Details bd
JOIN IPL_Bidder_Details b ON bd.BidderId = b.BidderId
JOIN IPL_Bidder_Points bp ON b.BidderId = bp.BidderId
WHERE YEAR(bd.BidDate) = 2017
GROUP BY b.BidderId, b.Bidder_name, Bid_Year, Bid_Month
ORDER BY Total_Points DESC, Bid_Month ASC;

-- 14. Query to calculate total points month-wise for the 2017 bid year using subqueries-- 
SELECT 
    BidderId, 
    Bidder_name, 
    Bid_Year, 
    Bid_Month, 
    Total_Points
FROM (
    SELECT 
        bd.BidderId, 
        (SELECT b.Bidder_name FROM IPL_Bidder_Details b WHERE b.BidderId = bd.BidderId) AS Bidder_name,
        YEAR(bd.BidDate) AS Bid_Year, 
        MONTH(bd.BidDate) AS Bid_Month, 
        (SELECT SUM(bp.Total_points) 
         FROM IPL_Bidder_Points bp 
         WHERE bp.BidderId = bd.BidderId) AS Total_Points
    FROM IPL_Bidding_Details bd
    WHERE YEAR(bd.BidDate) = 2017
    GROUP BY bd.BidderId, Bid_Year, Bid_Month
) AS Subquery
ORDER BY Total_Points DESC, Bid_Month ASC;

-- 15. Query to get the top 3 and bottom 3 bidders based on total bidding points for 2018

WITH RankedBidders AS (
    SELECT 
        bp.BidderId, 
        b.Bidder_name, 
        bp.Total_points,
        RANK() OVER (ORDER BY bp.Total_points DESC) AS High_Rank,
        RANK() OVER (ORDER BY bp.Total_points ASC) AS Low_Rank
    FROM IPL_Bidder_Points bp
    JOIN IPL_Bidder_Details b ON bp.BidderId = b.BidderId
    WHERE bp.TournamentId IN (SELECT TournamentId FROM IPL_Tournament WHERE YEAR(From_date) = 2018)
)
SELECT 
    BidderId, 
    Total_points,
    CASE WHEN High_Rank <= 3 THEN Bidder_name END AS Highest_3_Bidders,
    CASE WHEN Low_Rank <= 3 THEN Bidder_name END AS Lowest_3_Bidders
FROM RankedBidders
WHERE High_Rank <= 3 OR Low_Rank <= 3;

-- 16.	Create two tables called Student_details and Student_details_backup. (Additional Question - Self Study is required)
/*
Solution: Implementing a Trigger for Automatic Backup in MySQL
We will create two tables:

Student_details – The main table where student details are stored and updated.
Student_details_backup – A backup table to store the old details before any update.
*/
-- Step 1: Create the Student_details Table
CREATE TABLE Student_details (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    mail_id VARCHAR(100) UNIQUE NOT NULL,
    mobile_no VARCHAR(15) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
/*student_id – Primary key with auto-increment.
mail_id & mobile_no – Unique constraints to prevent duplicates.
created_at – Timestamp for record creation.
updated_at – Updates automatically when a record is modified.
*/

-- Step 2: Create the Student_details_backup Table
CREATE TABLE Student_details_backup (
    backup_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    mail_id VARCHAR(100) NOT NULL,
    mobile_no VARCHAR(15) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Student_details(student_id)
);


-- Step 3: Create the Trigger to Insert into Backup Table

DELIMITER $$

CREATE TRIGGER before_student_update
BEFORE UPDATE ON Student_details
FOR EACH ROW
BEGIN
    INSERT INTO Student_details_backup (student_id, student_name, mail_id, mobile_no, modified_at)
    VALUES (OLD.student_id, OLD.student_name, OLD.mail_id, OLD.mobile_no, NOW());
END $$

DELIMITER ;
/*
Trigger Name: before_student_update
Trigger Type: BEFORE UPDATE → Runs before modifying Student_details.
Purpose: It stores old data into Student_details_backup before the update happens.
*/

-- Step 4: Testing the Trigger
-- Inserting a Student Record
INSERT INTO Student_details (student_name, mail_id, mobile_no) 
VALUES ('Raghavendra S', 'raghav@gmail.com', '9876543210');

-- Updating the Mobile Number
UPDATE Student_details 
SET mobile_no = '9123456789' 
WHERE student_id = 1;

-- Checking the Backup Table
SELECT * FROM Student_details_backup;
-- The old details will be stored in Student_details_backup.