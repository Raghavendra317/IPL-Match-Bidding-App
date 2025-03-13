# 🏏 IPL Match Bidding App – Data Insights & Analysis  
![IPL Logo](https://github.com/nikkvd/IPL-2024/blob/main/Images/IPL%20Logo.jpg?raw=true)
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

### 🏆 1. Show the percentage of wins of each bidder in descending order  
```sql
SELECT b.BidderId, bd.Bidder_name, 
       (SUM(CASE WHEN bd.BidStatus = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Win_Percentage
FROM IPL_Bidding_Details bd
JOIN IPL_Bidder_Details b ON bd.BidderId = b.BidderId
GROUP BY b.BidderId, bd.Bidder_name
ORDER BY Win_Percentage DESC;
```

*****

### 🏟️ 2. Display the number of matches conducted at each stadium
```sql
SELECT s.Stadium_name, s.City, COUNT(m.MatchId) AS Total_Matches
FROM IPL_Stadium s
JOIN IPL_Match_Schedule m ON s.StadiumId = m.StadiumId
GROUP BY s.Stadium_name, s.City
ORDER BY Total_Matches DESC;
```
----

### 🏅 3. Find the percentage of wins by a team that has won the toss in a given stadium
```sql
SELECT m.StadiumId, s.Stadium_name, 
       (SUM(CASE WHEN m.TossWinner = m.MatchWinner THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Toss_Win_Percentage
FROM IPL_Match m
JOIN IPL_Stadium s ON m.StadiumId = s.StadiumId
WHERE s.Stadium_name = 'M. Chinnaswamy Stadium' -- Change stadium name as needed
GROUP BY m.StadiumId, s.Stadium_name;
```

----


### 📈 4. Show the total bids along with the bid team and team name
```sql
SELECT bd.BidTeam, t.Team_name, COUNT(*) AS Total_Bids
FROM IPL_Bidding_Details bd
JOIN IPL_Team t ON bd.BidTeam = t.TeamId
GROUP BY bd.BidTeam, t.Team_name
ORDER BY Total_Bids DESC;
```

----


### 🏆 5. Show the team ID who won the match as per win details
```sql
SELECT MatchId, MatchWinner AS Winning_Team_ID
FROM IPL_Match
WHERE WinDetails IS NOT NULL;
```

----


### 📊 6. Display total matches played, won, and lost by each team
```sql
SELECT t.Team_name, 
       COUNT(m.MatchId) AS Matches_Played,
       SUM(CASE WHEN m.MatchWinner = t.TeamId THEN 1 ELSE 0 END) AS Matches_Won,
       SUM(CASE WHEN m.MatchWinner != t.TeamId THEN 1 ELSE 0 END) AS Matches_Lost
FROM IPL_Team t
JOIN IPL_Match m ON t.TeamId IN (m.TeamId1, m.TeamId2)
GROUP BY t.Team_name;
```

----


### 🎯 7. Display bowlers for the Mumbai Indians team
```sql
SELECT p.Player_name 
FROM IPL_Player p
JOIN IPL_Team_Players tp ON p.PlayerId = tp.PlayerId
JOIN IPL_Team t ON tp.TeamId = t.TeamId
WHERE t.Team_name = 'Mumbai Indians' AND tp.Player_role = 'Bowler';
```

----


### 🔥 8. Count all-rounders in each team and list teams with more than 4 all-rounders
```sql
SELECT t.Team_name, COUNT(*) AS All_Rounders_Count
FROM IPL_Team t
JOIN IPL_Team_Players tp ON t.TeamId = tp.TeamId
WHERE tp.Player_role = 'All-Rounder'
GROUP BY t.Team_name
HAVING COUNT(*) > 4
ORDER BY All_Rounders_Count DESC;
```

----


### 🏆 9. Total bidder points for those who bid on CSK when they won in M. Chinnaswamy Stadium (Year-wise)
```sql
SELECT bd.BidStatus, YEAR(bd.BidDate) AS Bidding_Year, SUM(bp.Total_points) AS Total_Bidder_Points
FROM IPL_Bidding_Details bd
JOIN IPL_Bidder_Points bp ON bd.BidderId = bp.BidderId
JOIN IPL_Match m ON bd.BidTeam = m.MatchWinner
JOIN IPL_Stadium s ON m.StadiumId = s.StadiumId
JOIN IPL_Team t ON bd.BidTeam = t.TeamId
WHERE t.Team_name = 'Chennai Super Kings' AND s.Stadium_name = 'M. Chinnaswamy Stadium'
GROUP BY bd.BidStatus, YEAR(bd.BidDate)
ORDER BY Total_Bidder_Points DESC;
```

----


### 🎯 10. Extract top 5 bowlers & all-rounders with highest wickets (without using JOINs)
```sql
SELECT Team_name, Player_name, Player_role 
FROM IPL_Player 
WHERE Player_role IN ('Bowler', 'All-Rounder') 
ORDER BY CAST(SUBSTRING_INDEX(performance_dtls, ' ', 1) AS UNSIGNED) DESC
LIMIT 5;
```

----


### 🏏 11. Show the percentage of toss wins for each bidder in descending order
```sql
SELECT bd.BidderId, bd.Bidder_name, 
       (SUM(CASE WHEN m.TossWinner = bd.BidTeam THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Toss_Win_Percentage
FROM IPL_Bidding_Details bd
JOIN IPL_Match m ON bd.BidTeam = m.TossWinner
GROUP BY bd.BidderId, bd.Bidder_name
ORDER BY Toss_Win_Percentage DESC;
```

----


### 📅 12. Find the IPL season with the longest duration
```sql
SELECT TournamentId, Tournament_name, DATEDIFF(To_date, From_date) AS Duration
FROM IPL_Tournament
ORDER BY Duration DESC
LIMIT 1;
```

----


### 📅 13. Calculate total points month-wise for 2017 bid year (Using Joins)
```sql
SELECT b.BidderId, b.Bidder_name, YEAR(bd.BidDate) AS Bid_Year, MONTH(bd.BidDate) AS Bid_Month, SUM(bp.Total_points) AS Total_Points
FROM IPL_Bidding_Details bd
JOIN IPL_Bidder_Details b ON bd.BidderId = b.BidderId
JOIN IPL_Bidder_Points bp ON b.BidderId = bp.BidderId
WHERE YEAR(bd.BidDate) = 2017
GROUP BY b.BidderId, b.Bidder_name, YEAR(bd.BidDate), MONTH(bd.BidDate)
ORDER BY Total_Points DESC, Bid_Month ASC;
```

---


### 📅 14. Top 3 and Bottom 3 bidders based on total bidding points for 2018
```sql
(SELECT BidderId, Bidder_name, Total_points
 FROM IPL_Bidder_Points
 WHERE YEAR(BidDate) = 2018
 ORDER BY Total_points DESC
 LIMIT 3)
UNION
(SELECT BidderId, Bidder_name, Total_points
 FROM IPL_Bidder_Points
 WHERE YEAR(BidDate) = 2018
 ORDER BY Total_points ASC
 LIMIT 3);
 ```

----


## 🏅 Conclusion
This repository provides deep insights into IPL bidding trends and match statistics using advanced SQL queries. Feel free to contribute or enhance the project!




