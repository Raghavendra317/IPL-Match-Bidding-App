use ipl;
INSERT INTO IPL_User (UserId, Password, User_type, Remarks) VALUES
('U001', 'pass123', 'Admin', NULL),
('U002', 'pass456', 'Bidder', NULL),
('U003', 'pass789', 'Bidder', NULL),
('U004', 'adminpass', 'Admin', NULL),
('U005', 'bidpass123', 'Bidder', NULL);

INSERT INTO IPL_Stadium (StadiumId, Stadium_name, City, Capacity, Address, Contact_no) VALUES
(1, 'Wankhede Stadium', 'Mumbai', 33000, 'Marine Lines, Mumbai', '9876543210'),
(2, 'Eden Gardens', 'Kolkata', 68000, 'BBD Bagh, Kolkata', '9765432109'),
(3, 'M. Chinnaswamy Stadium', 'Bangalore', 40000, 'MG Road, Bangalore', '9654321098'),
(4, 'Feroz Shah Kotla', 'Delhi', 41800, 'Bahadur Shah Zafar Marg, Delhi', '9543210987'),
(5, 'Rajiv Gandhi International Stadium', 'Hyderabad', 55000, 'Uppal, Hyderabad', '9432109876');

INSERT INTO IPL_Team (TeamId, Team_name, Team_city, Remarks) VALUES
(1, 'Mumbai Indians', 'Mumbai', 'MI'),
(2, 'Chennai Super Kings', 'Chennai', 'CSK'),
(3, 'Royal Challengers Bangalore', 'Bangalore', 'RCB'),
(4, 'Kolkata Knight Riders', 'Kolkata', 'KKR'),
(5, 'Delhi Capitals', 'Delhi', 'DC');

INSERT INTO IPL_Player (PlayerId, Player_name, Performance_dtls, Remarks) VALUES
(1, 'Virat Kohli', 'Top scorer of the season', 'Top performer'),
(2, 'MS Dhoni', 'Best finisher', 'Second best performer'),
(3, 'Rohit Sharma', 'Hitman of IPL', 'Top performer'),
(4, 'Andre Russell', 'Best all-rounder', 'Power hitter'),
(5, 'Shikhar Dhawan', 'Consistent opener', 'Top performer');

INSERT INTO IPL_Team_Players (TeamId, PlayerId, Player_role, Remarks) VALUES
(1, 3, 'Captain', 'Played for MI'),
(2, 2, 'Captain', 'Played for CSK'),
(3, 1, 'Batsman', 'Played for RCB'),
(4, 4, 'All-rounder', 'Played for KKR'),
(5, 5, 'Batsman', 'Played for DC');

INSERT INTO IPL_Tournament (TournamentId, Tournament_name, From_date, To_date, Team_count, Total_matches, Remarks) VALUES
(1, 'IPL 2023', '2023-03-25', '2023-05-28', 10, 74, 'CSK'),
(2, 'IPL 2022', '2022-03-26', '2022-05-29', 10, 74, 'GT'),
(3, 'IPL 2021', '2021-04-09', '2021-10-15', 8, 60, 'CSK'),
(4, 'IPL 2020', '2020-09-19', '2020-11-10', 8, 60, 'MI'),
(5, 'IPL 2019', '2019-03-23', '2019-05-12', 8, 60, 'MI');

select * from ipl_match;
INSERT INTO IPL_Match (MatchId, TeamId1, TeamId2, TossWinner, MatchWinner, WinDetails, Remarks) VALUES
(1, 1, 2, 1, 2, 'CSK won by 5 wickets', NULL),
(2, 3, 4, 1, 1, 'RCB won by 7 runs', NULL),
(3, 2, 5, 2, 2, 'CSK won by 10 wickets', NULL),
(4, 4, 1, 1, 1, 'KKR won by 8 runs', NULL),
(5, 5, 3, 2, 2, 'DC won by 6 wickets', NULL);


INSERT INTO IPL_Match_Schedule (ScheduleId, TournamentId, MatchId, Match_type, Match_date, Start_time, StadiumId, Status, Remarks) VALUES
(1, 1, 1, 'League', '2023-03-25', '19:30:00', 1, 'Scheduled', NULL),
(2, 1, 2, 'League', '2023-03-26', '19:30:00', 3, 'Scheduled', NULL),
(3, 1, 3, 'League', '2023-03-27', '19:30:00', 2, 'Scheduled', NULL),
(4, 1, 4, 'Knockout', '2023-05-23', '19:30:00', 5, 'Scheduled', NULL),
(5, 1, 5, 'Final', '2023-05-28', '19:30:00', 4, 'Scheduled', NULL);

select * from IPL_Bidder_Details;
INSERT INTO IPL_Bidder_Details (BidderId, UserId, Bidder_name, Contact_no, Emailid, Remarks) VALUES
(1, 'U002', 'Ramesh Kumar', '9988776655', 'ramesh@gmail.com', NULL),
(2, 'U003', 'Suresh Gupta', '9876543210', 'suresh@gmail.com', NULL),
(3, 'U005', 'Amit Sharma', '9123456789', 'amit@gmail.com', NULL),
(4, 'U005', 'Rahul Verma', '9234567890', 'rahul@gmail.com', NULL),
(5, 'U003', 'Pankaj Singh', '9345678901', 'pankaj@gmail.com', NULL);

INSERT INTO IPL_Bidding_Details (BidderId, ScheduleId, BidTeam, BidDate, BidStatus) VALUES
(1, 1, 1, '2023-03-25 18:00:00', 'Bid'),
(2, 2, 2, '2023-03-26 18:30:00', 'Bid'),
(3, 3, 1, '2023-03-27 17:45:00', 'Cancelled'),
(4, 4, 2, '2023-05-23 19:00:00', 'Won'),
(5, 5, 1, '2023-05-28 20:00:00', 'Lost');

INSERT INTO IPL_Bidder_Points (BidderId, TournamentId, No_of_bids, No_of_matches, Total_points) VALUES
(1, 1, 10, 8, 50),
(2, 1, 15, 10, 80),
(3, 1, 8, 5, 30),
(4, 1, 20, 15, 100),
(5, 1, 12, 7, 60);


INSERT INTO IPL_Team_Standings (TeamId, TournamentId, Matches_played, Matches_won, Matches_lost, Matches_tied, No_result, Points, Remarks) VALUES
(1, 1, 14, 10, 4, 0, 0, 20, 'Qualifier'),
(2, 1, 14, 9, 5, 0, 0, 18, 'Runner-up'),
(3, 1, 14, 8, 6, 0, 0, 16, NULL),
(4, 1, 14, 7, 7, 0, 0, 14, NULL),
(5, 1, 14, 6, 8, 0, 0, 12, NULL);











