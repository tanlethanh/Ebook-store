-- Active: 1670753632697@@127.0.0.1@3306@ebook_store

-- drop database if exists ebook_store;

-- create database ebook_store;

ALTER TABLE carts DROP CONSTRAINT carts_ibfk_1 DROP COLUMN user_id;