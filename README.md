# 🏏 IPL Match Bidding App – Data Insights & Analysis  
![IPL Logo](https://github.com/Raghavendra317/IPL-Match-Bidding-App/blob/main/IPL%20Match%20Bidding%20App.webp)
## 📌 Project Overview  
The **IPL Match Bidding App** is a data-driven system designed to analyze **bidding patterns, match statistics, and team performances** using SQL. This project builds a **relational database** to track **bids, match outcomes, and user performance**, enabling insights into **bidding trends, win probabilities, and team strategies**.

---

## 🚀 Features  
✅ **Database Design:** Well-structured **relational schema** ensuring **data integrity** and efficiency  
✅ **SQL Querying:** Advanced **Joins, CTEs, Window Functions, Subqueries** for analytics  
✅ **Match & Bidding Analysis:** Win probabilities, bidder success rates, and team performance evaluation  
✅ **Data Integrity & Optimization:** Implemented **Indexes, Constraints, and Query Optimization** for enhanced performance  

---

## 📊 Database Schema  

The database consists of the following **normalized tables**:  
- **IPL_User** – Stores bidder and admin details  
- **IPL_Stadium** – Contains stadium names, cities, and capacities  
- **IPL_Team & IPL_Player** – Stores teams and player performance details  
- **IPL_Match & IPL_Match_Schedule** – Tracks match schedules, winners, and statistics  
- **IPL_Bidding_Details** – Captures user bids with timestamps and statuses  
- **IPL_Bidder_Points** – Records bidding performance and rankings  
- **IPL_Team_Standings** – Maintains tournament standings for each team  

---

## 🛠️ ER Diagram
![ER Diagram](https://github.com/Raghavendra317/IPL-Match-Bidding-App/blob/main/ER%20Diagram.png)

## 📌 Key SQL Queries & Insights  

### 🏆 **Bidding & Performance Analysis**  
- **Calculate the win percentage** of each bidder (ranked from highest to lowest)  
- **Track total bids per team** and identify top teams receiving maximum bids  
- **Analyze bidder success rates** and identify patterns in betting behavior  

### 📊 **Match & Toss Impact Analysis**  
- Find **stadium-wise win probabilities** based on toss decisions  
- Identify **teams winning most matches after winning the toss**  
- Extract **top-performing teams and players** based on match outcomes  

### 📈 **Player & Team Insights**  
- List **top 5 all-rounders and bowlers** with highest wickets  
- Calculate **total points for teams across seasons** and **rank teams**  
- Determine **season duration and longest IPL season**  

---

## 🛠️ Technologies Used  
✅ **Database:** MySQL  
✅ **SQL Techniques:** **DDL, DML, DQL, Joins, Subqueries, CTEs, Window Functions, Views, Indexing, Query Optimization**  
✅ **Data Visualization:** Power BI / Tableau (for insights presentation)  

---


# 🏏 IPL Match Bidding App – SQL Queries & Analysis  

## 📌 Overview  
This repository contains a comprehensive SQL-based analysis of **IPL Match Bidding System**. The project focuses on **bidding trends, match statistics, and team performances**. Below is a list of **analytical questions** along with their respective **SQL queries** to extract meaningful insights.

---

## 📊 Sample SQL Queries & Analysis  

---


### 🏆 1. Show the percentage of wins of each bidder in the order of highest to lowest percentage.
```sql
SELECT bd.BidderId, bd.Bidder_name, 
       (SUM(CASE WHEN b.BidStatus = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Win_Percentage
FROM IPL_Bidder_Details bd
JOIN IPL_Bidding_Details b ON bd.BidderId = b.BidderId
GROUP BY bd.BidderId, bd.Bidder_name
ORDER BY Win_Percentage DESC;
```

---

### 🏟️ 2. Display the number of matches conducted at each stadium with the stadium name and city.
```sql
SELECT s.Stadium_name, s.City, COUNT(m.MatchId) AS Total_Matches
FROM IPL_Stadium s
JOIN IPL_Match_Schedule ms ON s.StadiumId = ms.StadiumId
JOIN IPL_Match m ON ms.MatchId = m.MatchId
GROUP BY s.Stadium_name, s.City;
```

---

### 🎲 3. In a given stadium, what is the percentage of wins by a team that has won the toss?
```sql
SELECT m.TossWinner, COUNT(*) AS Total_Toss_Wins,
       (SUM(CASE WHEN m.TossWinner = m.MatchWinner THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Win_Percentage
FROM IPL_Match m
GROUP BY m.TossWinner;
```

---

### 🎰 4. Show the total bids along with the bid team and team name.
```sql
SELECT b.BidTeam, t.Team_name, COUNT(*) AS Total_Bids
FROM IPL_Bidding_Details b
JOIN IPL_Team t ON b.BidTeam = t.TeamId
GROUP BY b.BidTeam, t.Team_name;
```

---

### 🏅 5. Show the team ID who won the match as per the win details.
```sql
SELECT MatchId, MatchWinner AS Winning_Team_ID
FROM IPL_Match;
```

---

### 📊 6. Display the total matches played, total matches won, and total matches lost by the team along with its team name.
```sql
SELECT t.Team_name, 
       ts.Matches_played, ts.Matches_won, ts.Matches_lost
FROM IPL_Team_Standings ts
JOIN IPL_Team t ON ts.TeamId = t.TeamId;
```

---

### 🎯 7. Display the bowlers for the Mumbai Indians team.
```sql
SELECT p.Player_name, tp.Player_role 
FROM IPL_Player p
JOIN IPL_Team_Players tp ON p.PlayerId = tp.PlayerId
JOIN IPL_Team t ON tp.TeamId = t.TeamId
WHERE t.Team_name = 'Mumbai Indians' AND tp.Player_role = 'Bowler';
```

---

### 🌟 8. How many all-rounders are there in each team, display the teams with more than 4 all-rounders in descending order.
```sql
SELECT t.Team_name, COUNT(*) AS AllRounder_Count
FROM IPL_Team_Players tp
JOIN IPL_Team t ON tp.TeamId = t.TeamId
WHERE tp.Player_role = 'All-Rounder'
GROUP BY t.Team_name
HAVING COUNT(*) > 4
ORDER BY AllRounder_Count DESC;
```

---

### 📢 9. Total bidders' points for each bidding status of those bidders who bid on CSK when they won the match in M. Chinnaswamy Stadium bidding year-wise.
```sql
SELECT b.BidStatus, YEAR(b.BidDate) AS Bid_Year, SUM(bp.Total_points) AS Total_Bidder_Points
FROM IPL_Bidding_Details b
JOIN IPL_Bidder_Points bp ON b.BidderId = bp.BidderId
JOIN IPL_Match m ON b.ScheduleId = m.MatchId
JOIN IPL_Stadium s ON m.MatchId = s.StadiumId
WHERE b.BidTeam = (SELECT TeamId FROM IPL_Team WHERE Team_name = 'Chennai Super Kings')
AND m.MatchWinner = b.BidTeam AND s.Stadium_name = 'M. Chinnaswamy Stadium'
GROUP BY b.BidStatus, YEAR(b.BidDate)
ORDER BY Total_Bidder_Points DESC;
```

---

### 🔥 10. Extract the Bowlers and All-Rounders that are in the 5 highest number of wickets.
```sql
SELECT Player_name, Player_role, Performance_dtls
FROM IPL_Player
WHERE Player_role IN ('Bowler', 'All-Rounder')
AND Performance_dtls LIKE '%wickets%'
ORDER BY CAST(SUBSTRING_INDEX(Performance_dtls, ' wickets', 1) AS UNSIGNED) DESC
LIMIT 5;
```

---

### 🏆 11. Show the percentage of toss wins of each bidder in descending order.
```sql
SELECT bd.BidderId, bd.Bidder_name, 
       (SUM(CASE WHEN m.TossWinner = b.BidTeam THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Toss_Win_Percentage
FROM IPL_Bidder_Details bd
JOIN IPL_Bidding_Details b ON bd.BidderId = b.BidderId
JOIN IPL_Match m ON b.ScheduleId = m.MatchId
GROUP BY bd.BidderId, bd.Bidder_name
ORDER BY Toss_Win_Percentage DESC;
```

---

### 🏆 12. Find the IPL season with the maximum duration.
```sql
SELECT TournamentId, Tournament_name, DATEDIFF(To_date, From_date) AS Duration
FROM IPL_Tournament
ORDER BY Duration DESC
LIMIT 1;
```

---

### 📆 13. Calculate total points month-wise for 2017 bid year.
```sql
SELECT BidderId, Bidder_name, YEAR(BidDate) AS Year, MONTH(BidDate) AS Month, SUM(Total_points) AS Total_Points
FROM IPL_Bidder_Points
WHERE YEAR(BidDate) = 2017
GROUP BY BidderId, Bidder_name, YEAR(BidDate), MONTH(BidDate)
ORDER BY Total_Points DESC, Month ASC;
```

---

### 🔄 14. Rewrite query 13 using subqueries.
```sql
SELECT * FROM (
    SELECT BidderId, Bidder_name, YEAR(BidDate) AS Year, MONTH(BidDate) AS Month, SUM(Total_points) AS Total_Points
    FROM IPL_Bidder_Points
    WHERE YEAR(BidDate) = 2017
    GROUP BY BidderId, Bidder_name, YEAR(BidDate), MONTH(BidDate)
) AS SubQuery
ORDER BY Total_Points DESC, Month ASC;
```

---

### 🏆 15. Get the top 3 and bottom 3 bidders based on total bidding points for 2018.
```sql
(SELECT BidderId, Bidder_name, Total_points FROM IPL_Bidder_Points WHERE YEAR(BidDate) = 2018 ORDER BY Total_points DESC LIMIT 3)
UNION
(SELECT BidderId, Bidder_name, Total_points FROM IPL_Bidder_Points WHERE YEAR(BidDate) = 2018 ORDER BY Total_points ASC LIMIT 3);
```

---

### 🎓 16. Create tables for student details and backup with a trigger.
```sql
CREATE TRIGGER student_backup BEFORE INSERT ON Student_details
FOR EACH ROW INSERT INTO Student_details_backup VALUES (NEW.Student_id, NEW.Student_name, NEW.mail_id, NEW.mobile_no);
```

----

## 🏅 Conclusion
This repository provides deep insights into IPL bidding trends and match statistics using advanced SQL queries. Feel free to contribute or enhance the project!




