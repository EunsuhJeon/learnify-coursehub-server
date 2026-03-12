# Learnify CourseHub API

Learnify CourseHub API is a backend REST API developed in PHP for managing an online course platform. The API allows users to register, authenticate, browse courses, enroll in courses, and manage a shopping cart.

The project follows a simple MVC structure and uses PHP with PDO for database interaction and MySQL as the database engine.

This API is designed to support a front end course platform where students can explore available courses, enroll in them, and manage their learning journey.

---

# Project Structure

The project is organized into several folders to separate responsibilities.


Explanation of the main folders:

config contains database configuration and connection setup.

controller contains the API controllers that process requests and interact with the database.

helpers contains utility functions for authentication, input sanitization, and JSON responses.

models contains a base model that can be extended to interact with database tables.

database contains the SQL schema used to create the project database.

index.php acts as the entry point and router for the API.

---

# Technologies Used

PHP  
MySQL  
PDO for database connection  
REST API architecture  
Session based authentication

---

# Installation

Follow these steps to run the project locally.

1. Clone the repository
git clone https://github.com/your-repository/learnify-coursehub-server.git


2. Move the project to your local server directory

Example for AMPPS:
/Applications/AMPPS/www/projects/

3. Create the database

Open phpMyAdmin and create a new database:
learnify_db

4. Import the database schema

Import the file:
database/schema.sql


This will create all required tables including:

users  
courses  
instructors  
enrollments  
cart_items  
reviews

5. Configure database connection

Open the file:
src/config/webconfig.php

6. Start your local server

Run AMPPS or your preferred PHP server.

Then access the API:
http://localhost/projects/learnify-coursehub-server


---

# API Endpoints

## Register User

POST /register

Registers a new user account.

## Login

POST /login

Authenticates a user.

If successful the API returns a session token and user information.

---

## Logout

POST /logout

Logs out the authenticated user and destroys the session.

---

## List Courses

GET /courses

Returns a paginated list of courses.

Optional query parameters:

search  
page

Example:
/courses?search=react&page=1


---

## Get Course Details

GET /courses/{id}

Returns detailed information about a specific course.

Example:
/courses/1


---

## Get User Enrolled Courses

GET /me/courses

Returns all courses where the authenticated user is enrolled.

Authentication required.

---

## Enroll in Course

POST /enrollments

Enrolls the authenticated user in a course.

Request body example:
    {
    "course_id": 3
    }


Returns success if the enrollment was created.

---

## Get User Cart

GET /me/cart

Returns all items currently in the user's shopping cart.

Authentication required.

---

## Add Course to Cart

POST /me/cart

Adds a course to the user's shopping cart.


---

## Remove Course From Cart

DELETE /me/cart/{id}

Removes an item from the user's cart.

Example:
DELETE /me/cart/2


---

# Authentication

The API uses session based authentication.

After login or registration a session is created and the session ID is returned as a token.

Protected routes require an active session.

The helper file `auth.php` provides helper functions such as:

requireAuth()  
currentUserId()  
isLoggedIn()  
isAdmin()

These functions ensure secure access control to protected endpoints.

---

# Error Handling

All API responses follow a consistent JSON format.

    {
    Successful response example:
    "success": true,
    "data": {},
    "message": "Operation completed."
    }


Error response example:
    {
    "success": false,
    "error": "Invalid email or password."
    }


HTTP status codes are used to indicate errors such as:

400 Bad request  
401 Unauthorized  
403 Forbidden  
404 Not found  
409 Conflict  
422 Validation error

---

# Testing the API

You can test the API using tools such as:

Postman  
Insomnia  
cURL

Recommended testing flow:

1. Register a new user
2. Login
3. Browse courses
4. View course details
5. Enroll in a course
6. View enrolled courses
7. Add course to cart
8. View cart
9. Remove item from cart
10. Logout

---

# Security Considerations

Input sanitization is handled using helper functions.

Passwords are securely stored using:
password_hash()

Password verification is handled using:
password_verify()

Sessions are regenerated after registration to prevent session hijacking.

Prepared statements are used to prevent SQL injection.

---

# Future Improvements

Possible future improvements include:

Token based authentication with JWT  
Course reviews and ratings endpoints  
Payment system integration  
Admin dashboard endpoints  
Pagination improvements  
Automated API tests

---

# License

This project was developed for educational purposes as part of a web development course.
