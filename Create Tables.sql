CREATE DATABASE IPL;
USE IPL;

-- Table: IPL_User
CREATE TABLE IPL_User (
    UserId VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(255) NOT NULL,
    User_type VARCHAR(20) CHECK (User_type IN ('Admin', 'Bidder')),
    Remarks VARCHAR(255) DEFAULT NULL
);

-- Table: IPL_Stadium
CREATE TABLE IPL_Stadium (
    StadiumId INT PRIMARY KEY,
    Stadium_name VARCHAR(100) UNIQUE NOT NULL,
    City VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Contact_no VARCHAR(15) UNIQUE NOT NULL
);

-- Table: IPL_Team
CREATE TABLE IPL_Team (
    TeamId INT PRIMARY KEY,
    Team_name VARCHAR(100) UNIQUE NOT NULL,
    Team_city VARCHAR(50) NOT NULL,
    Remarks VARCHAR(50) DEFAULT NULL
);

-- Table: IPL_Player
CREATE TABLE IPL_Player (
    PlayerId INT PRIMARY KEY,
    Player_name VARCHAR(100) UNIQUE NOT NULL,
    Performance_dtls VARCHAR(255),
    Remarks VARCHAR(255) DEFAULT NULL
);

-- Table: IPL_Team_Players (Composite Primary Key)
CREATE TABLE IPL_Team_Players (
    TeamId INT,
    PlayerId INT,
    Player_role VARCHAR(50) NOT NULL CHECK (Player_role IN ('Captain', 'Batsman', 'Bowler', 'WK')),
    Remarks VARCHAR(255),
    PRIMARY KEY (TeamId, PlayerId),
    FOREIGN KEY (TeamId) REFERENCES IPL_Team(TeamId),
    FOREIGN KEY (PlayerId) REFERENCES IPL_Player(PlayerId)
);

-- Table: IPL_Tournament
CREATE TABLE IPL_Tournament (
    TournamentId INT PRIMARY KEY,
    Tournament_name VARCHAR(100) NOT NULL,
    From_date DATE NOT NULL,
    To_date DATE NOT NULL,
    Team_count INT NOT NULL,
    Total_matches INT NOT NULL,
    Remarks VARCHAR(255) DEFAULT NULL
);

-- Table: IPL_Match
CREATE TABLE IPL_Match (
    MatchId INT PRIMARY KEY,
    TeamId1 INT NOT NULL,
    TeamId2 INT NOT NULL,
    TossWinner INT CHECK (TossWinner IN (1, 2)),
    MatchWinner INT CHECK (MatchWinner IN (1, 2)),
    WinDetails VARCHAR(255),
    Remarks VARCHAR(255),
    FOREIGN KEY (TeamId1) REFERENCES IPL_Team(TeamId),
    FOREIGN KEY (TeamId2) REFERENCES IPL_Team(TeamId)
);

-- Table: IPL_Match_Schedule
CREATE TABLE IPL_Match_Schedule (
    ScheduleId INT PRIMARY KEY,
    TournamentId INT,
    MatchId INT,
    Match_type VARCHAR(50) CHECK (Match_type IN ('League', 'Knockout', 'Final')),
    Match_date DATE NOT NULL,
    Start_time TIME NOT NULL,
    StadiumId INT,
    Status VARCHAR(50) CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    Remarks VARCHAR(255),
    FOREIGN KEY (TournamentId) REFERENCES IPL_Tournament(TournamentId),
    FOREIGN KEY (MatchId) REFERENCES IPL_Match(MatchId),
    FOREIGN KEY (StadiumId) REFERENCES IPL_Stadium(StadiumId)
);

-- Table: IPL_Bidder_Details
CREATE TABLE IPL_Bidder_Details (
    BidderId INT PRIMARY KEY,
    UserId VARCHAR(50),
    Bidder_name VARCHAR(100) NOT NULL,
    Contact_no VARCHAR(15) UNIQUE NOT NULL,
    Emailid VARCHAR(100) UNIQUE NOT NULL,
    Remarks VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (UserId) REFERENCES IPL_User(UserId)
);

-- Table: IPL_Bidding_Details (Composite Primary Key)
CREATE TABLE IPL_Bidding_Details (
    BidderId INT,
    ScheduleId INT,
    BidTeam INT CHECK (BidTeam IN (1, 2)),
    BidDate DATETIME,
    BidStatus VARCHAR(50) CHECK (BidStatus IN ('Bid', 'Cancelled', 'Won', 'Lost')),
    PRIMARY KEY (BidderId, ScheduleId, BidTeam, BidDate),
    FOREIGN KEY (BidderId) REFERENCES IPL_Bidder_Details(BidderId),
    FOREIGN KEY (ScheduleId) REFERENCES IPL_Match_Schedule(ScheduleId)
);

-- Table: IPL_Bidder_Points
CREATE TABLE IPL_Bidder_Points (
    BidderId INT PRIMARY KEY,
    TournamentId INT,
    No_of_bids INT DEFAULT 0 NOT NULL,
    No_of_matches INT DEFAULT 0 NOT NULL,
    Total_points INT DEFAULT 0 NOT NULL,
    FOREIGN KEY (BidderId) REFERENCES IPL_Bidder_Details(BidderId),
    FOREIGN KEY (TournamentId) REFERENCES IPL_Tournament(TournamentId)
);

-- Table: IPL_Team_Standings
CREATE TABLE IPL_Team_Standings (
    TeamId INT,
    TournamentId INT,
    Matches_played INT DEFAULT 0 NOT NULL,
    Matches_won INT DEFAULT 0 NOT NULL,
    Matches_lost INT DEFAULT 0 NOT NULL,
    Matches_tied INT DEFAULT 0,
    No_result INT DEFAULT 0,
    Points INT DEFAULT 0 NOT NULL,
    Remarks VARCHAR(255),
    PRIMARY KEY (TeamId, TournamentId),
    FOREIGN KEY (TeamId) REFERENCES IPL_Team(TeamId),
    FOREIGN KEY (TournamentId) REFERENCES IPL_Tournament(TournamentId)
);
