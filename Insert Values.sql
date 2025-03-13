use ipl;

-- Insert values into IPL_User
INSERT INTO IPL_User (UserId, Password, User_type, Remarks) VALUES
('admin1', 'pass123', 'Admin', 'Main administrator'),
('bidder1', 'pass234', 'Bidder', 'Frequent bidder'),
('bidder2', 'pass345', 'Bidder', 'New bidder'),
('admin2', 'pass456', 'Admin', 'Secondary administrator'),
('bidder3', 'pass567', 'Bidder', 'Occasional bidder');

-- Insert values into IPL_Stadium
INSERT INTO IPL_Stadium (StadiumId, Stadium_name, City, Capacity, Address, Contact_no) VALUES
(1, 'Wankhede Stadium', 'Mumbai', 33000, 'Churchgate, Mumbai', '9876543210'),
(2, 'Chinnaswamy Stadium', 'Bangalore', 40000, 'MG Road, Bangalore', '9876543211'),
(3, 'Eden Gardens', 'Kolkata', 68000, 'BBD Bagh, Kolkata', '9876543212'),
(4, 'Arun Jaitley Stadium', 'Delhi', 41000, 'Bahadur Shah Zafar Marg, Delhi', '9876543213'),
(5, 'M. A. Chidambaram Stadium', 'Chennai', 50000, 'Chepauk, Chennai', '9876543214');

-- Insert values into IPL_Team
INSERT INTO IPL_Team (TeamId, Team_name, Team_city, Remarks) VALUES
(1, 'Mumbai Indians', 'Mumbai', '5-time champion'),
(2, 'Chennai Super Kings', 'Chennai', 'Strong team'),
(3, 'Royal Challengers Bangalore', 'Bangalore', 'Looking for first title'),
(4, 'Kolkata Knight Riders', 'Kolkata', '2-time champion'),
(5, 'Delhi Capitals', 'Delhi', 'Young squad');

-- Insert values into IPL_Player
INSERT INTO IPL_Player (PlayerId, Player_name, Performance_dtls, Remarks) VALUES
(1, 'Virat Kohli', 'Batsman, highest IPL run scorer', 'Consistent performer'),
(2, 'MS Dhoni', 'Wicketkeeper, Best finisher', 'Great leader'),
(3, 'Rohit Sharma', 'Batsman, 5 IPL titles', 'Hitman of IPL'),
(4, 'Jasprit Bumrah', 'Bowler, Best pacer', 'Yorker specialist'),
(5, 'Andre Russell', 'All-rounder, Hard hitter', 'Powerful finisher');

-- Insert values into IPL_Team_Players
INSERT INTO IPL_Team_Players (TeamId, PlayerId, Player_role, Remarks) VALUES
(1, 3, 'Captain', 'Leading Mumbai Indians'),
(2, 2, 'Captain', 'Captain cool of CSK'),
(3, 1, 'Captain', 'Leading RCB'),
(4, 5, 'Batsman', 'Star player for KKR'),
(5, 4, 'Bowler', 'Fast bowler for DC');

-- Insert values into IPL_Tournament
INSERT INTO IPL_Tournament (TournamentId, Tournament_name, From_date, To_date, Team_count, Total_matches, Remarks) VALUES
(1, 'IPL 2023', '2023-03-20', '2023-05-30', 10, 74, 'Completed'),
(2, 'IPL 2022', '2022-03-26', '2022-05-29', 10, 74, 'Completed'),
(3, 'IPL 2021', '2021-04-09', '2021-10-15', 8, 60, 'Covid delayed'),
(4, 'IPL 2020', '2020-09-19', '2020-11-10', 8, 60, 'Covid special edition'),
(5, 'IPL 2019', '2019-03-23', '2019-05-12', 8, 60, 'Normal season');

-- Insert values into IPL_Match
INSERT INTO IPL_Match (MatchId, TeamId1, TeamId2, TossWinner, MatchWinner, WinDetails, Remarks) VALUES
(1, 1, 2, 1, 1, 'MI won by 5 wickets', 'Exciting match'),
(2, 3, 4, 3, 4, 'KKR won by 7 runs', 'Close contest'),
(3, 5, 1, 5, 1, 'MI won by 10 wickets', 'One-sided game'),
(4, 2, 3, 2, 2, 'CSK won by 6 wickets', 'CSK dominated'),
(5, 4, 5, 4, 5, 'DC won in Super Over', 'Thriller match');

-- Insert values into IPL_Match_Schedule
INSERT INTO IPL_Match_Schedule (ScheduleId, TournamentId, MatchId, Match_type, Match_date, Start_time, StadiumId, Status, Remarks) VALUES
(1, 1, 1, 'League', '2023-03-25', '19:30:00', 1, 'Completed', 'Opening match'),
(2, 1, 2, 'League', '2023-03-26', '15:30:00', 2, 'Completed', 'Day game'),
(3, 1, 3, 'League', '2023-03-27', '19:30:00', 3, 'Completed', 'Night game'),
(4, 1, 4, 'League', '2023-03-28', '15:30:00', 4, 'Completed', 'Exciting match'),
(5, 1, 5, 'Final', '2023-05-29', '19:30:00', 5, 'Scheduled', 'Final match');

-- Insert values into IPL_Bidder_Details
INSERT INTO IPL_Bidder_Details (BidderId, UserId, Bidder_name, Contact_no, Emailid, Remarks) VALUES
(1, 'bidder1', 'Rajesh', '9876543220', 'rajesh@mail.com', 'Regular bidder'),
(2, 'bidder2', 'Suresh', '9876543221', 'suresh@mail.com', 'Occasional bidder'),
(3, 'bidder3', 'Ankit', '9876543222', 'ankit@mail.com', 'New bidder'),
(4, 'bidder1', 'Rahul', '9876543223', 'rahul@mail.com', 'High roller'),
(5, 'bidder2', 'Vikas', '9876543224', 'vikas@mail.com', 'Strategic bidder');

-- Insert values into IPL_Bidding_Details
INSERT INTO IPL_Bidding_Details (BidderId, ScheduleId, BidTeam, BidDate, BidStatus) VALUES
(1, 1, 1, '2023-03-25 18:00:00', 'Won'),
(2, 2, 3, '2023-03-26 14:00:00', 'Lost'),
(3, 3, 1, '2023-03-27 18:30:00', 'Bid'),
(4, 4, 2, '2023-03-28 14:30:00', 'Cancelled'),
(5, 5, 5, '2023-05-29 17:00:00', 'Scheduled');

-- Insert values into IPL_Bidder_Points
INSERT INTO IPL_Bidder_Points (BidderId, TournamentId, No_of_bids, No_of_matches, Total_points) VALUES
(1, 1, 10, 5, 50),
(2, 1, 7, 3, 30),
(3, 1, 5, 2, 20),
(4, 1, 15, 8, 70),
(5, 1, 9, 4, 40);

-- Insert values into IPL_Team_Standings
INSERT INTO IPL_Team_Standings (TeamId, TournamentId, Matches_played, Matches_won, Matches_lost, Matches_tied, No_result, Points, Remarks) VALUES
(1, 1, 14, 9, 5, 0, 0, 18, 'Qualified'),
(2, 1, 14, 8, 6, 0, 0, 16, 'Qualified'),
(3, 1, 14, 6, 8, 0, 0, 12, 'Eliminated'),
(4, 1, 14, 7, 7, 0, 0, 14, 'Eliminated'),
(5, 1, 14, 10, 4, 0, 0, 20, 'Top team');



