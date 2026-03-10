CREATE DATABASE activity7;
GO

USE activity7;
GO

CREATE TABLE Roles (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE Groups (
    GroupId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE RoboticsKits (
    RoboticsKitId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    RoleId INT NOT NULL,
    GroupId INT NULL,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    CONSTRAINT FK_Users_Groups FOREIGN KEY (GroupId) REFERENCES Groups(GroupId)
);
GO

CREATE TABLE Courses (
    CourseId INT IDENTITY(1,1) PRIMARY KEY,
    CourseKey NVARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(200) NOT NULL,
    Cover NVARCHAR(255) NULL,
    Content NVARCHAR(MAX) NULL,
    DidacticMaterial NVARCHAR(MAX) NULL,
    RoboticsKitId INT NOT NULL,
    CONSTRAINT FK_Courses_RoboticsKits FOREIGN KEY (RoboticsKitId) REFERENCES RoboticsKits(RoboticsKitId)
);
GO

CREATE TABLE CourseGroups (
    CourseGroupId INT IDENTITY(1,1) PRIMARY KEY,
    CourseId INT NOT NULL,
    GroupId INT NOT NULL,
    CONSTRAINT FK_CourseGroups_Courses FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
    CONSTRAINT FK_CourseGroups_Groups FOREIGN KEY (GroupId) REFERENCES Groups(GroupId)
);
GO

INSERT INTO Roles (Name) VALUES
('Student'),
('Teacher'),
('Administrator');
GO

INSERT INTO Groups (Name) VALUES
('Beginner'),
('Intermediate'),
('Advanced');
GO

INSERT INTO RoboticsKits (Name) VALUES
('StarterKit'),
('Educational Robotics Kit'),
('Kit5');
GO

INSERT INTO Courses (CourseKey, Title, Cover, Content, DidacticMaterial, RoboticsKitId) VALUES
('Rob101', 'Introduction to Robotics', 'rob101.jpg', 'Basic concepts of robotics.', 'Starter guide and first practices.', 1),
('Rob102', 'Introduction to Automation', 'rob102.jpg', 'Automation fundamentals.', 'Automation worksheets and exercises.', 1),
('Rob103', 'Programming for Robotics', 'rob103.jpg', 'Programming logic for robots.', 'Programming examples and practices.', 2),
('Rob104', 'Characteristics of a Robot', 'rob104.jpg', 'Main parts and features of robots.', 'Identification guide and activities.', 3);
GO

INSERT INTO Users (Name, Email, Password, RoleId, GroupId) VALUES
('Angel Student', 'angel@student.com', '123456', 1, 1),
('Maria Teacher', 'maria@teacher.com', '123456', 2, NULL),
('Luis Admin', 'luis@admin.com', '123456', 3, NULL);
GO

INSERT INTO CourseGroups (CourseId, GroupId) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);
GO