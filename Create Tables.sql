create database ipl;
use ipl;

CREATE TABLE IPL_User (
    UserId VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(255) NOT NULL,
    User_type VARCHAR(20) NOT NULL CHECK (User_type IN ('Admin', 'Bidder')),
    Remarks VARCHAR(255)
);

CREATE TABLE IPL_Stadium (
    StadiumId INT PRIMARY KEY,
    Stadium_name VARCHAR(100) UNIQUE NOT NULL,
    City VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Contact_no VARCHAR(15) NOT NULL
);

CREATE TABLE IPL_Team (
    TeamId INT PRIMARY KEY,
    Team_name VARCHAR(100) UNIQUE NOT NULL,
    Team_city VARCHAR(50) NOT NULL,
    Remarks VARCHAR(50) -- Short form of the team name
);

CREATE TABLE IPL_Player (
    PlayerId INT PRIMARY KEY,
    Player_name VARCHAR(100) UNIQUE NOT NULL,
    Performance_dtls VARCHAR(255),
    Remarks VARCHAR(255)
);

CREATE TABLE IPL_Team_Players (
    TeamId INT,
    PlayerId INT,
    Player_role VARCHAR(50) NOT NULL,
    Remarks VARCHAR(255),
    PRIMARY KEY (TeamId, PlayerId),
    FOREIGN KEY (TeamId) REFERENCES IPL_Team(TeamId),
    FOREIGN KEY (PlayerId) REFERENCES IPL_Player(PlayerId)
);

CREATE TABLE IPL_Tournament (
    TournamentId INT PRIMARY KEY,
    Tournament_name VARCHAR(100) NOT NULL,
    From_date DATE NOT NULL,
    To_date DATE NOT NULL,
    Team_count INT NOT NULL,
    Total_matches INT NOT NULL,
    Remarks VARCHAR(255) -- Champion team of the season
);

CREATE TABLE IPL_Match (
    MatchId INT PRIMARY KEY,
    TeamId1 INT NOT NULL,
    TeamId2 INT NOT NULL,
    TossWinner INT NOT NULL CHECK (TossWinner IN (1, 2)),
    MatchWinner INT CHECK (MatchWinner IN (1, 2)),
    WinDetails VARCHAR(255),
    Remarks VARCHAR(255),
    FOREIGN KEY (TeamId1) REFERENCES IPL_Team(TeamId),
    FOREIGN KEY (TeamId2) REFERENCES IPL_Team(TeamId)
);

CREATE TABLE IPL_Match_Schedule (
    ScheduleId INT PRIMARY KEY,
    TournamentId INT NOT NULL,
    MatchId INT NOT NULL,
    Match_type VARCHAR(50) NOT NULL CHECK (Match_type IN ('League', 'Knockout', 'Final')),
    Match_date DATE NOT NULL,
    Start_time TIME NOT NULL,
    StadiumId INT NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    Remarks VARCHAR(255),
    FOREIGN KEY (TournamentId) REFERENCES IPL_Tournament(TournamentId),
    FOREIGN KEY (MatchId) REFERENCES IPL_Match(MatchId),
    FOREIGN KEY (StadiumId) REFERENCES IPL_Stadium(StadiumId)
);

CREATE TABLE IPL_Bidder_Details (
    BidderId INT PRIMARY KEY,
    UserId VARCHAR(50) NOT NULL,
    Bidder_name VARCHAR(100) NOT NULL,
    Contact_no VARCHAR(15) NOT NULL,
    Emailid VARCHAR(100) NOT NULL UNIQUE,
    Remarks VARCHAR(255),
    FOREIGN KEY (UserId) REFERENCES IPL_User(UserId)
);

CREATE TABLE IPL_Bidding_Details (
    BidderId INT,
    ScheduleId INT,
    BidTeam INT CHECK (BidTeam IN (1, 2)),
    BidDate DATETIME,
    BidStatus VARCHAR(50) NOT NULL CHECK (BidStatus IN ('Bid', 'Cancelled', 'Won', 'Lost')),
    PRIMARY KEY (BidderId, ScheduleId, BidTeam, BidDate),
    FOREIGN KEY (BidderId) REFERENCES IPL_Bidder_Details(BidderId),
    FOREIGN KEY (ScheduleId) REFERENCES IPL_Match_Schedule(ScheduleId)
);

CREATE TABLE IPL_Bidder_Points (
    BidderId INT PRIMARY KEY,
    TournamentId INT NOT NULL,
    No_of_bids INT NOT NULL DEFAULT 0,
    No_of_matches INT NOT NULL DEFAULT 0,
    Total_points INT NOT NULL DEFAULT 0,
    FOREIGN KEY (BidderId) REFERENCES IPL_Bidder_Details(BidderId),
    FOREIGN KEY (TournamentId) REFERENCES IPL_Tournament(TournamentId)
);

CREATE TABLE IPL_Team_Standings (
    TeamId INT,
    TournamentId INT,
    Matches_played INT NOT NULL DEFAULT 0,
    Matches_won INT NOT NULL DEFAULT 0,
    Matches_lost INT NOT NULL DEFAULT 0,
    Matches_tied INT DEFAULT 0,
    No_result INT DEFAULT 0,
    Points INT NOT NULL DEFAULT 0,
    Remarks VARCHAR(255),
    PRIMARY KEY (TeamId, TournamentId),
    FOREIGN KEY (TeamId) REFERENCES IPL_Team(TeamId),
    FOREIGN KEY (TournamentId) REFERENCES IPL_Tournament(TournamentId)
);
