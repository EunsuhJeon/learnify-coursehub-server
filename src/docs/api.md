# CourseHub API Documentation

## Auth

### POST /register
**Body:** `{ first_name, last_name, email, password }`
**Response:** `{ token, user: { user_id, first_name, last_name, email, role } }`

### POST /login
**Body:** `{ email, password }`
**Response:** `{ token, user: { user_id, first_name, last_name, email, role } }`

### POST /logout
**Response:** `{ message: "Logout successful" }`

---

## Courses

### GET /courses
**Query:** `?search=js&page=1`
**Response:** `{ courses: [{ id, title, description, price, instructor_name, level, theme, duration }], page, per_page, count }`

### GET /courses/:id
**Response:** `{ course_id, title, description, price, instructor_name, instructor_title, instructor_rating, bio, level, theme, duration }`

---

## Enrollments

### GET /me/courses
**Auth required**
**Response:** `[{ id, title, progress }]`

### POST /enrollments
**Auth required**
**Body:** `{ courseId }`
**Response:** `{ message: "Enrolled successfully" }`

---

## Cart

### GET /me/cart
**Auth required**
**Response:** `[{ cart_id, courseId, title, price }]`

### POST /me/cart
**Auth required**
**Body:** `{ courseId }`
**Response:** `{ message: "Added to cart" }`

### DELETE /me/cart/:id
**Auth required**
**Response:** `{ message: "Removed from cart" }`

---

## Reviews

### POST /courses/:id/reviews
**Auth required**
**Body:** `{ rating (1-5), comment }`
**Response:** `{ message: "Review submitted" }`