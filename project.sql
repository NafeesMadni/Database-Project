CREATE DATABASE IF NOT EXISTS MovieStreamingService;

USE MovieStreamingService;

CREATE TABLE IF NOT EXISTS User (
     UserId INT PRIMARY KEY AUTO_INCREMENT,
     UserName VARCHAR(15) NOT NULL,
     Password VARCHAR(15) NOT NULL,
     Email VARCHAR(15) UNIQUE NOT NULL
);

ALTER TABLE User MODIFY Email VARCHAR(30);

INSERT INTO User (UserName, Password, Email) VALUES 
     ('Tauseef', 'pass22', 'tauseef@gmail.com'),
     ('Nafees Madni', 'pass00', 'nafees@gmail.com'),
     ('Naveed Azhar', 'pass11',  'naveed@gmail.com');

CREATE TABLE IF NOT EXISTS Movie (
     MovieId INT PRIMARY KEY AUTO_INCREMENT,
     Title VARCHAR(20) UNIQUE NOT NULL
);

INSERT INTO 
Movie (Title) VALUES
     ('Stranger Things'),
     ('Harry Potter'),
     ('All of us are dead'),
     ('Peaky Blinders');

CREATE TABLE IF NOT EXISTS Genre (
     GenreId INT PRIMARY KEY AUTO_INCREMENT,
     GenreName VARCHAR(15) NOT NULL
);

INSERT INTO
Genre (GenreName) VALUES
     ('Horror'),
     ('Science Fiction'),
     ('Mystery'),
     ('School Story'),
     ('Adventure'),
     ('Crime Fiction');

CREATE TABLE IF NOT EXISTS MovieGenre (
     MovieId INT,
     GenreId INT,
     FOREIGN KEY (MovieId) REFERENCES Movie(MovieId),
     FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
);

INSERT INTO
MovieGenre (MovieId, GenreId) VALUES
     (1, 1),
     (1, 2),
     (2, 1),
     (3, 1),
     (3, 4),
     (4, 6);

SELECT m.Title as Movie_Name, g.GenreName as Genre 
FROM MovieGenre mg
	JOIN Movie m ON mg.MovieID = m.MovieId
	JOIN Genre g ON mg.GenreID = g.GenreID;

CREATE TABLE IF NOT EXISTS Actor (
     ActorId INT PRIMARY KEY AUTO_INCREMENT,
     Name VARCHAR(15) NOT NULL,
     DOB DATE NOT NULL,
     GENDER ENUM('MALE', 'FEMALE') DEFAULT 'MALE'
);


ALTER TABLE Actor MODIFY Name VARCHAR(30);

INSERT INTO
Actor (name, DOB, GENDER) VALUES
     ('Daniel Radcliffe', '1989-7-23', 'MALE'),
     ('finn wolfhard', '2002-12-23', 'MALE'),
     ('Cillian Murphy', '1976-5-25', 'MALE');



CREATE TABLE IF NOT EXISTS MovieActor (
     MovieId INT,
     ActorId INT,
     FOREIGN KEY (MovieId) REFERENCES Movie(MovieId),
     FOREIGN KEY (ActorId) REFERENCES Actor(ActorId)
);

INSERT INTO
MovieActor (MovieId, ActorId) VALUES
     (1, 2),
     (2, 1),
     (4, 3);

SELECT m.Title as Movie_Name, a.Name as Actor_Name 
FROM MovieActor ma
	JOIN Movie m ON ma.MovieID = m.MovieId
	JOIN Actor a ON ma.ActorID = a.ActorID;


CREATE TABLE IF NOT EXISTS Rating (
     RatingId INT PRIMARY KEY AUTO_INCREMENT,
     UserId INT,
     MovieId INT,
     RatingScore DECIMAL (2, 1) CHECK ( RatingScore >= 0.0 OR RatingScore <= 5.0),
     FOREIGN KEY (MovieId) REFERENCES Movie(MovieId),
     FOREIGN KEY (UserId) REFERENCES User(UserId)
);

INSERT INTO
Rating (UserId, MovieId, RatingScore) VALUES
     (1, 2, 4.9),
     (2, 1, 4.2),
     (3, 4, 3.9);

SELECT m.Title as Movie_Name, u.UserName as User_Name , RatingScore
FROM Rating r
	JOIN Movie m ON r.MovieID = m.MovieId
	JOIN User u ON r.UserID = u.UserId;

CREATE TABLE IF NOT EXISTS Streaming (
     StreamingId INT PRIMARY KEY AUTO_INCREMENT,
     StreamingPlatform VARCHAR(25) NOT NULL
);

INSERT INTO
Streaming (StreamingPlatform) VALUES
     ('Amazon Prime'),
     ('Netflix'),
     ('Disney  plus');


CREATE TABLE IF NOT EXISTS StreamingAvailability (
     StreamingId INT,
     MovieId INT,
     AvailabilityStatus ENUM ( 'Available', 'Not Available', 'Coming Soon') ,
     FOREIGN KEY (StreamingId) REFERENCES Streaming(StreamingId),
     FOREIGN KEY (MovieId) REFERENCES Movie(MovieId)
);

INSERT INTO
StreamingAvailability (MovieId, StreamingId, AvailabilityStatus) VALUES
     (1, 2, 'Available'),
     (2, 1, 'Not Available'),
     (3, 3, 'Coming Soon');


SELECT m.Title AS Movie_Name, s.StreamingPlatform AS Platform_Name , sa.AvailabilityStatus AS Status
FROM StreamingAvailability sa
	JOIN Movie m ON sa.MovieID = m.MovieId
	JOIN Streaming s ON sa.StreamingID = s.StreamingId;