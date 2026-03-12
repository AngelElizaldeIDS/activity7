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

-- Roles
INSERT INTO Roles (Name) VALUES
('Administrative'),
('Teacher'),
('Student');
GO

-- Groups
INSERT INTO Groups (Name) VALUES
('Beginner'),
('Intermediate'),
('Advanced');
GO

-- Robotics Kits
INSERT INTO RoboticsKits (Name) VALUES
('StarterKit'),
('Educational Robotics Kit'),
('Kit5');
GO

-- Users required by the activity
INSERT INTO Users (Name, Email, Password, RoleId, GroupId) VALUES
('Admon', 'admon@robotics.com', 'Adm@2022', 1, NULL),
('Tecmilenio', 'tecmilenio@robotics.com', 'Adm@2022', 2, NULL),
('Student', 'student@robotics.com', 'Adm@2022', 3, 1);
GO

-- 100 fake courses
DECLARE @i INT = 1;

WHILE @i <= 100
BEGIN
    INSERT INTO Courses (CourseKey, Title, Cover, Content, DidacticMaterial, RoboticsKitId)
    VALUES (
        'ROB' + RIGHT('000' + CAST(@i AS NVARCHAR(3)), 3),
        'Robotics Course ' + CAST(@i AS NVARCHAR(10)),
        'course' + CAST(@i AS NVARCHAR(10)) + '.jpg',
        'This is the content for robotics course ' + CAST(@i AS NVARCHAR(10)) + '.',
        'Didactic material for robotics course ' + CAST(@i AS NVARCHAR(10)) + '.',
        CASE 
            WHEN @i % 3 = 1 THEN 1
            WHEN @i % 3 = 2 THEN 2
            ELSE 3
        END
    );

    SET @i = @i + 1;
END;
GO

-- Assign courses to groups
DECLARE @courseId INT = 1;

WHILE @courseId <= 100
BEGIN
    INSERT INTO CourseGroups (CourseId, GroupId)
    VALUES (
        @courseId,
        CASE
            WHEN @courseId BETWEEN 1 AND 34 THEN 1
            WHEN @courseId BETWEEN 35 AND 67 THEN 2
            ELSE 3
        END
    );

    SET @courseId = @courseId + 1;
END;
GO