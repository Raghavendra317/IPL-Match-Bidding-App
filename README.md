# 🏏 IPL Match Bidding App – Data Insights & Analysis  

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

## 📊 SQL Queries & Analysis  

### 🏆 1. Show the percentage of wins of each bidder in descending order  
```sql
SELECT b.BidderId, bd.Bidder_name, 
       (SUM(CASE WHEN bd.BidStatus = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Win_Percentage
FROM IPL_Bidding_Details bd
JOIN IPL_Bidder_Details b ON bd.BidderId = b.BidderId
GROUP BY b.BidderId, bd.Bidder_name
ORDER BY Win_Percentage DESC;






