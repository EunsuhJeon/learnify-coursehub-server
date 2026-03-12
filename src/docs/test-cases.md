# Learnify CourseHub API Test Cases

This document describes the test cases used to validate the functionality of the Learnify CourseHub API.  
Each test case verifies a specific API behavior including successful operations, validation rules, and error handling.

---

# 1. User Registration

## TC01 Register user with valid data

Endpoint  
POST /register

Objective  
Verify that a new user can register successfully.

Request body

{
  "first_name": "Bella",
  "last_name": "Marcucci",
  "email": "bella@test.com",
  "password": "password123"
}

Expected result

Status code 201  
Response contains success = true  
Response returns token and user information

---

## TC02 Register user with missing fields

Endpoint  
POST /register

Objective  
Verify validation when required fields are missing.

Request body

{
  "first_name": "Bella",
  "email": "bella@test.com",
  "password": "password123"
}

Expected result

Status code 422  
Response contains validation error

---

## TC03 Register user with invalid email

Endpoint  
POST /register

Objective  
Verify email validation.

Request body

{
  "first_name": "Bella",
  "last_name": "Marcucci",
  "email": "bella-test.com",
  "password": "password123"
}

Expected result

Status code 422  
Error message indicating invalid email

---

## TC04 Register user with short password

Endpoint  
POST /register

Objective  
Verify minimum password length validation.

Request body

{
  "first_name": "Bella",
  "last_name": "Marcucci",
  "email": "bella2@test.com",
  "password": "123"
}

Expected result

Status code 422  
Error message about password length

---

## TC05 Register user with duplicate email

Endpoint  
POST /register

Objective  
Verify that email addresses must be unique.

Precondition  
User with the same email already exists.

Expected result

Status code 409  
Error message "Email already exists"

---

# 2. User Login

## TC06 Login with valid credentials

Endpoint  
POST /login

Objective  
Verify user can authenticate successfully.

Request body

{
  "email": "bella@test.com",
  "password": "password123"
}

Expected result

Status code 200  
Response contains token and user data

---

## TC07 Login with incorrect password

Endpoint  
POST /login

Objective  
Verify login fails when password is incorrect.

Expected result

Status code 401  
Error message "Invalid email or password"

---

## TC08 Login with non existing email

Endpoint  
POST /login

Objective  
Verify login fails if the user does not exist.

Expected result

Status code 401  
Error message "Invalid email or password"

---

## TC09 Login with missing fields

Endpoint  
POST /login

Objective  
Verify validation for incomplete request.

Expected result

Status code 422

---

# 3. Logout

## TC10 Logout authenticated user

Endpoint  
POST /logout

Objective  
Verify user session is destroyed.

Expected result

Status code 200  
Response message "Logout successful"

---

# 4. Courses

## TC11 Get all courses

Endpoint  
GET /courses

Objective  
Verify that the API returns a list of courses.

Expected result

Status code 200  
Response contains list of courses

---

## TC12 Search courses

Endpoint  
GET /courses?search=react

Objective  
Verify search filter functionality.

Expected result

Status code 200  
Courses returned match search keyword

---

## TC13 Pagination

Endpoint  
GET /courses?page=2

Objective  
Verify pagination works correctly.

Expected result

Status code 200  
Response contains page number 2

---

## TC14 Get course details

Endpoint  
GET /courses/1

Objective  
Verify detailed information for a course.

Expected result

Status code 200  
Response contains course information and instructor data

---

## TC15 Course not found

Endpoint  
GET /courses/9999

Objective  
Verify behavior when course does not exist.

Expected result

Status code 404  
Error message "Course not found"

---

# 5. Enrollments

## TC16 Enroll user in course

Endpoint  
POST /enrollments

Objective  
Verify authenticated users can enroll in a course.

Precondition  
User must be logged in.

Request body

{
  "course_id": 1
}

Expected result

Status code 200 or 201  
Enrollment created successfully

---

## TC17 Enroll without authentication

Endpoint  
POST /enrollments

Objective  
Verify endpoint requires authentication.

Expected result

Status code 401

---

## TC18 Enroll in non existing course

Endpoint  
POST /enrollments

Request body

{
  "course_id": 9999
}

Expected result

Status code 404

---

## TC19 Duplicate enrollment

Endpoint  
POST /enrollments

Objective  
Verify that users cannot enroll twice in the same course.

Expected result

Status code 409

---

## TC20 Get enrolled courses

Endpoint  
GET /me/courses

Objective  
Verify the list of courses the user is enrolled in.

Precondition  
User must be logged in.

Expected result

Status code 200  
Response contains enrolled courses

---

# 6. Shopping Cart

## TC21 Add course to cart

Endpoint  
POST /me/cart

Objective  
Verify that authenticated users can add a course to the cart.

Request body

{
  "course_id": 1
}

Expected result

Status code 200 or 201  
Item added to cart

---

## TC22 Add course to cart without login

Endpoint  
POST /me/cart

Expected result

Status code 401

---

## TC23 Add invalid course to cart

Endpoint  
POST /me/cart

Request body

{
  "course_id": 9999
}

Expected result

Status code 404

---

## TC24 Add duplicate cart item

Endpoint  
POST /me/cart

Expected result

Status code 409

---

## TC25 Get cart items

Endpoint  
GET /me/cart

Objective  
Verify the user cart is returned.

Expected result

Status code 200  
Response contains cart items

---

## TC26 Get cart without authentication

Endpoint  
GET /me/cart

Expected result

Status code 401

---

## TC27 Remove cart item

Endpoint  
DELETE /me/cart/{id}

Objective  
Verify user can remove items from cart.

Expected result

Status code 200  
Item removed successfully

---

## TC28 Remove non existing cart item

Endpoint  
DELETE /me/cart/{id}

Expected result

Status code 404

---

# 7. API Root

## TC29 Check API status

Endpoint  
GET /

Objective  
Verify API root endpoint.

Expected result

Status code 200  
Response message "API is running"

---

# 8. Invalid Route

## TC30 Invalid route

Endpoint  
GET /invalid-route

Objective  
Verify router handles unknown routes.

Expected result

Status code 404  
Error message "Route not found"

---

# Integration Test

## TC31 Full user journey

Objective  
Validate the complete API workflow.

Steps

1 Register a new user  
2 Login  
3 Get course list  
4 View course details  
5 Enroll in a course  
6 View enrolled courses  
7 Add course to cart  
8 View cart items  
9 Remove item from cart  
10 Logout

Expected result

All steps return correct responses and database updates correctly.