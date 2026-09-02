CREATE DATABASE SurveyDataBase
GO
USE SurveyDataBase
GO

-- Users
CREATE TABLE Users_t (
    UserID int identity primary key,
    Username varchar(50),
    Password varchar(50),
    Role varchar(20)    -- Admin / Survey Builder / Surveyor
)

-- Survey
CREATE TABLE Survey_t (
    SurveyID int identity primary key,
    Title varchar(100),
    CreatedBy int,
    IsAnonymous bit default 0
)

-- Questions
CREATE TABLE SurveyQuestions_t (
    QuestionID int identity primary key,
    SurveyID int,
    QuestionText varchar(500),
    QType varchar(20) -- MCQ / TF
)

-- Options (for MCQ only)
CREATE TABLE SurveyOptions_t (
    OptionID int identity primary key,
    QuestionID int,
    OptionText varchar(200)
)

-- Responses
CREATE TABLE SurveyResponse_t (
    ResponseID int identity primary key,
    SurveyID int,
    UserID int NULL
)

-- Answer
CREATE TABLE SurveyAnswers_t (
    AnswerID int identity primary key,
    ResponseID int,
    QuestionID int,
    SelectedAnswer varchar(200)
)

Insert  INto Users_t Values
('admin','admin345','Admin'),
('builder1','builder345','Builder'),
('user1','user345','Surveyor')

select * from Users_t