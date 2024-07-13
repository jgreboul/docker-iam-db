-- 
-- DDL of a lite Information and Access Management database
-- 
-- Author: Jean-Gael Reboul
-- Email: jgreboul@gmail.com
--
-- LinkedIn: https://www.linkedin.com/in/jgreboul
-- Youtube: https://www.youtube.com/user/jgreboul
--
-- 

-- Create database
CREATE DATABASE IF NOT EXISTS iamDB;
USE iamDB;

-- Create User table
CREATE TABLE IF NOT EXISTS User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    passwordHash BINARY(64) NOT NULL,
    passwordSalt BINARY(32) NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    archived BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create User Metadata table
CREATE TABLE IF NOT EXISTS UserMetadata (
    refid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value JSON NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (refid, name),
    FOREIGN KEY (refid) REFERENCES User(id) ON DELETE CASCADE
);

-- Create UserGroup table
CREATE TABLE IF NOT EXISTS UserGroup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    archived BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create UserGroup Metadata table
CREATE TABLE IF NOT EXISTS UserGroupMetadata (
    refid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value JSON NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (refid, name),	
    FOREIGN KEY (refid) REFERENCES UserGroup(id) ON DELETE CASCADE
);

-- Create User_UserGroup junction table
CREATE TABLE IF NOT EXISTS User_UserGroup (
    userId INT NOT NULL,
    userGroupId INT NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (userId, userGroupId),
    FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (userGroupId) REFERENCES UserGroup(id) ON DELETE CASCADE
);

-- Create Application table
CREATE TABLE IF NOT EXISTS Application (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    archived BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create Application Metadata table
CREATE TABLE IF NOT EXISTS ApplicationMetadata (
    refid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value JSON NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (refid, name),	
    FOREIGN KEY (refid) REFERENCES Application(id) ON DELETE CASCADE
);

-- Create Feature table
CREATE TABLE IF NOT EXISTS Feature (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    applicationId INT NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (applicationId) REFERENCES Application(id) ON DELETE CASCADE
);

-- Create Feature Metadata table
CREATE TABLE IF NOT EXISTS FeatureMetadata (
    refid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value JSON NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (refid, name),	
    FOREIGN KEY (refid) REFERENCES Feature(id) ON DELETE CASCADE
);

-- Create Role table
CREATE TABLE IF NOT EXISTS Role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    featureId INT NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (featureId) REFERENCES Feature(id) ON DELETE CASCADE
);

-- Create Role Metadata table
CREATE TABLE IF NOT EXISTS RoleMetadata (
    refid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value JSON NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (refid, name),		
    FOREIGN KEY (refid) REFERENCES Role(id) ON DELETE CASCADE
);

-- Create User_Role junction table
CREATE TABLE IF NOT EXISTS User_Role (
    userId INT NOT NULL,
    roleId INT NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (userId, roleId),
    FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (roleId) REFERENCES Role(id) ON DELETE CASCADE
);

-- Create UserGroup_Role junction table
CREATE TABLE IF NOT EXISTS UserGroup_Role (
    userGroupId INT NOT NULL,
    roleId INT NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (userGroupId, roleId),
    FOREIGN KEY (userGroupId) REFERENCES UserGroup(id) ON DELETE CASCADE,
    FOREIGN KEY (roleId) REFERENCES Role(id) ON DELETE CASCADE
);

-- Create Permission table
CREATE TABLE IF NOT EXISTS Permission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    archived BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create Permission Metadata table
CREATE TABLE IF NOT EXISTS PermissionMetadata (
    refid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value JSON NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (refid, name),		
    FOREIGN KEY (refid) REFERENCES Permission(id) ON DELETE CASCADE
);

-- Create the Role_Permission junction table
CREATE TABLE IF NOT EXISTS Role_Permission (
    roleId INT NOT NULL,
    permissionId INT NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (roleId, permissionId),
    FOREIGN KEY (roleId) REFERENCES Role(id) ON DELETE CASCADE,
    FOREIGN KEY (permissionId) REFERENCES Permission(id) ON DELETE CASCADE
);

-- Create AuditLog table
CREATE TABLE IF NOT EXISTS AuditLog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid INT NOT NULL,
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    action VARCHAR(100) NOT NULL,
    description VARCHAR(1000),
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (userid) REFERENCES User(id) ON DELETE CASCADE
);
