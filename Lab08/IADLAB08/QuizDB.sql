CREATE DATABASE QuizDataBase
USE QuizDataBase

-- users + role (simple)
CREATE TABLE Users_t (
    UserID int identity primary key,
    Username varchar(50),
    Password varchar(50),
    Role varchar(20) -- Admin / Teacher / Student
)

-- subject (by teacher)
CREATE TABLE Subjects_t (
    SubjectID int identity primary key,
    SubjectName varchar(100)
    
)

-- questions 
CREATE TABLE Questions_t (
    QuestionID int identity primary key,
    SubjectID int,
    QuestionText varchar(500),
    OptionA varchar(200),
    OptionB varchar(200),
    OptionC varchar(200),
    OptionD varchar(200),
    Correct char(1),
    Difficulty int
)

-- quiz
CREATE TABLE Quiz_t (
    QuizID int identity primary key,
    SubjectID int,
    Title varchar(100),
    TotalQ int,
    TotalTime int,
    StartTime datetime,
    EndTime datetime,
    ShuffleQ bit,
    ShuffleOpt bit,
    AttemptOnce bit,
    Review bit,
    NegativeMark bit
)

-- quiz questions
CREATE TABLE QuizQuestions_t (
    ID int identity primary key,
    QuizID int,
    QuestionID int
)

-- student answers
CREATE TABLE Answers_t (
    ID int identity primary key,
    StudentID int,
    QuizID int,
    QuestionID int,
    Correct char(1),
    StudentAns char(1),
    Marks int
)

-- result
CREATE TABLE Result_t (
    ResultID int identity primary key,
    StudentID int,
    QuizID int,
    Obtained int,
    Total int
)

Insert into Users_t (Username,Password,Role)
Values
('admin','admin345','Admin'),
('teacher1','teacher345','Teacher'),
('student1','student345','Student')

select * from Users_t
select * from Subjects_t
select * from Result_t
select * from Answers_t
select * from Result_t
select * from Questions_t
select * from Quiz_t
select * from QuizQuestions_t


