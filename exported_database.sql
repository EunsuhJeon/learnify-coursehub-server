-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 12, 2026 at 03:37 AM
-- Server version: 8.0.45
-- PHP Version: 8.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `learnify_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `action` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `entity` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `entity_id` int UNSIGNED DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `entity`, `entity_id`, `timestamp`) VALUES
(1, 2, 'CREATE', 'reviews', 35, '2026-03-11 18:24:36');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `added_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_id`, `user_id`, `course_id`, `added_at`) VALUES
(1, 1, 106, '2026-03-10 20:47:04'),
(2, 2, 107, '2026-03-10 20:47:04'),
(3, 3, 108, '2026-03-10 20:47:04'),
(4, 4, 109, '2026-03-10 20:47:04'),
(5, 5, 110, '2026-03-10 20:47:04'),
(6, 6, 111, '2026-03-10 20:47:04'),
(7, 7, 112, '2026-03-10 20:47:04'),
(8, 8, 113, '2026-03-10 20:47:04'),
(9, 9, 114, '2026-03-10 20:47:04'),
(10, 10, 115, '2026-03-10 20:47:04'),
(11, 11, 116, '2026-03-10 20:47:04'),
(12, 12, 117, '2026-03-10 20:47:04'),
(13, 13, 118, '2026-03-10 20:47:04'),
(14, 14, 119, '2026-03-10 20:47:04'),
(15, 15, 120, '2026-03-10 20:47:04'),
(16, 16, 121, '2026-03-10 20:47:04'),
(17, 17, 122, '2026-03-10 20:47:04'),
(18, 18, 123, '2026-03-10 20:47:04'),
(19, 19, 124, '2026-03-10 20:47:04'),
(20, 20, 125, '2026-03-10 20:47:04'),
(21, 21, 126, '2026-03-10 20:47:04'),
(22, 22, 127, '2026-03-10 20:47:04'),
(23, 23, 128, '2026-03-10 20:47:04'),
(24, 24, 129, '2026-03-10 20:47:04'),
(25, 25, 130, '2026-03-10 20:47:04'),
(26, 26, 131, '2026-03-10 20:47:04'),
(27, 27, 132, '2026-03-10 20:47:04'),
(28, 28, 133, '2026-03-10 20:47:04'),
(29, 29, 134, '2026-03-10 20:47:04'),
(30, 30, 105, '2026-03-10 20:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `instructor_id` int UNSIGNED NOT NULL,
  `level` enum('beginner','intermediate','advanced') COLLATE utf8mb4_general_ci DEFAULT 'beginner',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `theme` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `duration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `title`, `description`, `instructor_id`, `level`, `price`, `created_at`, `theme`, `duration`) VALUES
(105, 'React Fundamentals', 'Learn the basics of React, components and hooks.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Tech', 6),
(106, 'Advanced JavaScript', 'Deep dive into closures, async/await, and patterns.', 2, 'advanced', 69.99, '2026-03-04 20:20:30', 'Tech', 8),
(107, 'Web Design Basics', 'HTML, CSS, and responsive design fundamentals.', 4, 'beginner', 39.99, '2026-03-04 20:20:30', 'Design', 5),
(108, 'Node.js Essentials', 'Build backend services with Express and Node.js.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Tech', 7),
(109, 'TypeScript in Practice', 'Strong typing, interfaces, and real-world TS projects.', 2, 'intermediate', 59.99, '2026-03-04 20:20:30', 'Tech', 6),
(110, 'Python for Data Analysis', 'Analyze datasets using Pandas and NumPy.', 3, 'beginner', 59.99, '2026-03-04 20:20:30', 'Data', 9),
(111, 'UI/UX Design Principles', 'Design usable and beautiful digital experiences.', 4, 'beginner', 44.99, '2026-03-04 20:20:30', 'Design', 4),
(112, 'Docker & Containers', 'Package and deploy apps using Docker.', 2, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Tech', 5),
(113, 'REST APIs with Express', 'Create scalable RESTful APIs from scratch.', 2, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Tech', 6),
(114, 'AWS Cloud Foundations', 'Understand core AWS services and architecture.', 1, 'beginner', 64.99, '2026-03-04 20:20:30', 'Tech', 7),
(115, 'Next.js for Production', 'Build fast React apps with SSR and routing.', 2, 'advanced', 69.99, '2026-03-04 20:20:30', 'Tech', 6),
(116, 'SQL for Developers', 'Master queries, joins, and indexes.', 3, 'beginner', 39.99, '2026-03-04 20:20:30', 'Data', 5),
(117, 'GraphQL Essentials', 'Flexible APIs with Apollo and GraphQL.', 2, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Tech', 4),
(118, 'Cybersecurity Basics', 'Protect systems and networks from attacks.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Tech', 6),
(119, 'Machine Learning Intro', 'Supervised models and evaluation techniques.', 3, 'intermediate', 64.99, '2026-03-04 20:20:30', 'Data', 8),
(120, 'Kubernetes Fundamentals', 'Container orchestration and scaling.', 2, 'advanced', 69.99, '2026-03-04 20:20:30', 'Tech', 7),
(121, 'Mobile Apps with React Native', 'Build cross-platform apps for iOS and Android.', 2, 'intermediate', 59.99, '2026-03-04 20:20:30', 'Tech', 6),
(122, 'DevOps Foundations', 'CI/CD pipelines and automation workflows.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Tech', 5),
(123, 'Figma for Designers', 'Prototyping and collaboration for UI teams.', 4, 'beginner', 39.99, '2026-03-04 20:20:30', 'Design', 3),
(124, 'Clean Code Practices', 'Write maintainable and readable software.', 2, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Tech', 4),
(125, 'Blockchain Fundamentals', 'Distributed ledgers and smart contracts.', 2, 'beginner', 59.99, '2026-03-04 20:20:30', 'Tech', 6),
(126, 'C# for Web Development', 'Build web apps using ASP.NET Core.', 2, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Tech', 7),
(127, 'iOS Development with Swift', 'Create native apps for Apple devices.', 2, 'advanced', 74.99, '2026-03-04 20:20:30', 'Tech', 9),
(128, 'Android with Kotlin', 'Modern Android app development techniques.', 2, 'intermediate', 64.99, '2026-03-04 20:20:30', 'Tech', 8),
(129, 'Power BI Analytics', 'Build dashboards and business insights.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Business', 5),
(130, 'Excel for Professionals', 'Advanced formulas, pivot tables and automation.', 1, 'beginner', 44.99, '2026-03-04 20:20:30', 'Business', 4),
(131, 'NoSQL with MongoDB', 'Document databases and schema design.', 3, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Data', 6),
(132, 'Linux Command Line', 'Shell scripting and system navigation.', 1, 'beginner', 39.99, '2026-03-04 20:20:30', 'Tech', 3),
(133, 'Ethical Hacking Intro', 'Pen testing concepts and methodologies.', 2, 'advanced', 69.99, '2026-03-04 20:20:30', 'Tech', 7),
(134, 'Data Visualization with D3', 'Create interactive charts for the web.', 3, 'advanced', 64.99, '2026-03-04 20:20:30', 'Data', 6),
(135, 'Project Management Agile', 'Scrum, Kanban and delivery strategies.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Business', 4),
(136, 'Product Design Sprint', 'Validate ideas quickly using workshops.', 4, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Product', 5),
(137, 'SEO Fundamentals', 'Optimize websites for search engines.', 4, 'beginner', 39.99, '2026-03-04 20:20:30', 'Marketing', 3),
(138, 'Marketing Analytics', 'Track campaigns and ROI with data.', 4, 'intermediate', 49.99, '2026-03-04 20:20:30', 'Marketing', 4),
(139, 'Game Development Basics', 'Core loops and engines for indie games.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Tech', 6),
(140, 'Unity for Developers', '3D game creation with Unity engine.', 2, 'advanced', 74.99, '2026-03-04 20:20:30', 'Tech', 9),
(141, 'AI Prompt Engineering', 'Craft better prompts for large language models.', 1, 'beginner', 29.99, '2026-03-04 20:20:30', 'Tech', 2),
(142, 'Natural Language Processing', 'Text analysis and transformers basics.', 3, 'advanced', 69.99, '2026-03-04 20:20:30', 'Data', 8),
(143, 'Big Data with Spark', 'Distributed processing and analytics.', 3, 'advanced', 64.99, '2026-03-04 20:20:30', 'Data', 7),
(144, 'Web Accessibility', 'Build inclusive apps following WCAG.', 4, 'beginner', 39.99, '2026-03-04 20:20:30', 'Design', 3),
(145, 'Go for Backend Services', 'Fast APIs using Go and microservices.', 2, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Tech', 6),
(146, 'Rust Fundamentals', 'Memory-safe systems programming.', 2, 'advanced', 64.99, '2026-03-04 20:20:30', 'Tech', 7),
(147, 'Digital Marketing Foundations', 'Learn core concepts of online advertising, funnels and growth.', 4, 'beginner', 44.99, '2026-03-04 20:20:30', 'Marketing', 4),
(148, 'Content Strategy & Branding', 'Create content plans and brand voice for social platforms.', 4, 'intermediate', 49.99, '2026-03-04 20:20:30', 'Marketing', 5),
(149, 'Paid Ads Mastery', 'Run high-converting campaigns on Google and Meta platforms.', 4, 'advanced', 59.99, '2026-03-04 20:20:30', 'Marketing', 6),
(150, 'Email Marketing Automation', 'Build sequences and funnels with automation tools.', 4, 'intermediate', 49.99, '2026-03-04 20:20:30', 'Marketing', 4),
(151, 'Social Media Growth Playbook', 'Grow audiences and engagement organically.', 4, 'beginner', 39.99, '2026-03-04 20:20:30', 'Marketing', 3),
(152, 'Startup Fundamentals', 'Validate ideas, build MVPs and launch products.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Business', 5),
(153, 'Business Strategy Essentials', 'Competitive analysis and market positioning.', 1, 'intermediate', 59.99, '2026-03-04 20:20:30', 'Business', 6),
(154, 'Finance for Entrepreneurs', 'Cash flow, pricing models and budgeting basics.', 1, 'intermediate', 54.99, '2026-03-04 20:20:30', 'Business', 5),
(155, 'Leadership & Team Management', 'Build strong teams and effective communication.', 1, 'beginner', 49.99, '2026-03-04 20:20:30', 'Business', 4),
(156, 'Operations & Scaling', 'Systems, processes and growth frameworks.', 1, 'advanced', 59.99, '2026-03-04 20:20:30', 'Business', 6);

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `progress` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `enrolled_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `user_id`, `course_id`, `progress`, `enrolled_at`) VALUES
(31, 1, 105, 20, '2026-03-10 20:47:04'),
(32, 2, 106, 50, '2026-03-10 20:47:04'),
(33, 3, 107, 100, '2026-03-10 20:47:04'),
(34, 4, 108, 70, '2026-03-10 20:47:04'),
(35, 5, 109, 30, '2026-03-10 20:47:04'),
(36, 6, 110, 10, '2026-03-10 20:47:04'),
(37, 7, 111, 0, '2026-03-10 20:47:04'),
(38, 8, 112, 60, '2026-03-10 20:47:04'),
(39, 9, 113, 90, '2026-03-10 20:47:04'),
(40, 10, 114, 40, '2026-03-10 20:47:04'),
(41, 11, 115, 25, '2026-03-10 20:47:04'),
(42, 12, 116, 50, '2026-03-10 20:47:04'),
(43, 13, 117, 70, '2026-03-10 20:47:04'),
(44, 14, 118, 20, '2026-03-10 20:47:04'),
(45, 15, 119, 80, '2026-03-10 20:47:04'),
(46, 16, 120, 0, '2026-03-10 20:47:04'),
(47, 17, 121, 30, '2026-03-10 20:47:04'),
(48, 18, 122, 60, '2026-03-10 20:47:04'),
(49, 19, 123, 90, '2026-03-10 20:47:04'),
(50, 20, 124, 40, '2026-03-10 20:47:04'),
(51, 21, 125, 10, '2026-03-10 20:47:04'),
(52, 22, 126, 50, '2026-03-10 20:47:04'),
(53, 23, 127, 70, '2026-03-10 20:47:04'),
(54, 24, 128, 80, '2026-03-10 20:47:04'),
(55, 25, 129, 60, '2026-03-10 20:47:04'),
(56, 26, 130, 0, '2026-03-10 20:47:04'),
(57, 27, 131, 20, '2026-03-10 20:47:04'),
(58, 28, 132, 30, '2026-03-10 20:47:04'),
(59, 29, 133, 50, '2026-03-10 20:47:04'),
(60, 30, 134, 100, '2026-03-10 20:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE `instructors` (
  `instructor_id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `students_count` int DEFAULT NULL,
  `courses_count` int DEFAULT NULL,
  `instructor_rating` decimal(2,1) DEFAULT NULL,
  `bio` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`instructor_id`, `name`, `title`, `students_count`, `courses_count`, `instructor_rating`, `bio`) VALUES
(1, 'Dr. Sarah Johnson', 'Full-Stack Developer & Tech Educator', 524891, 12, 4.9, 'Dr. Sarah Johnson is a passionate educator with over 15 years of experience in web development and computer science. She has worked with major tech companies and has taught over 500,000 students worldwide.'),
(2, 'Alex Chen', 'Senior Software Engineer & Instructor', 312000, 8, 4.8, 'Alex has built production systems at scale and loves teaching practical skills. Focus on clean code and real-world projects.'),
(3, 'Maria Garcia', 'Data Scientist & ML Educator', 198000, 6, 4.9, 'Maria specializes in data analysis and machine learning. Former research lead with a passion for making complex topics accessible.'),
(4, 'James Wilson', 'Design Lead & UX Instructor', 156000, 5, 4.7, 'James has led design teams at startups and enterprises. Expert in UI/UX, design systems, and user research.'),
(5, 'Dr. Kim', 'Web Dev', 100, 5, 4.5, 'Dr. Kim is a seasoned web developer with over 10 years of experience in building scalable websites and web applications. He specializes in backend development and modern JavaScript frameworks.'),
(6, 'Dr. Lee', 'Data Science', 120, 6, 4.8, 'Dr. Lee has a PhD in Data Science and has worked on numerous AI projects. She is passionate about machine learning and data analytics, helping students understand complex concepts through practical examples.'),
(7, 'Dr. Park', 'Frontend', 80, 4, 4.2, 'Dr. Park is a frontend specialist who loves creating interactive and user-friendly web interfaces. She has extensive experience in React, Vue, and Angular.'),
(8, 'Dr. Choi', 'Fullstack', 90, 5, 4.7, 'Dr. Choi is a fullstack engineer skilled in both backend and frontend technologies. He enjoys teaching students how to integrate APIs and build complete applications from scratch.'),
(9, 'Dr. Jung', 'Backend', 70, 3, 4.6, 'Dr. Jung focuses on server-side development, database optimization, and building robust APIs. He has trained many students to become professional backend developers.'),
(10, 'Dr. Han', 'Mobile Dev', 60, 3, 4.3, 'Dr. Han is an expert in mobile application development for both Android and iOS platforms. He teaches practical app development and design principles.'),
(11, 'Dr. Seo', 'Cybersecurity', 50, 2, 4.9, 'Dr. Seo specializes in web security and ethical hacking. He provides students with hands-on experience in securing applications against cyber threats.'),
(12, 'Dr. Shin', 'AI', 110, 5, 4.4, 'Dr. Shin is an AI researcher with expertise in deep learning and neural networks. His courses cover both theory and practical AI applications.'),
(13, 'Dr. Moon', 'DevOps', 55, 2, 4.5, 'Dr. Moon is a DevOps engineer who teaches CI/CD pipelines, cloud deployment, and efficient infrastructure management.'),
(14, 'Dr. Oh', 'Cloud', 65, 3, 4.2, 'Dr. Oh is a cloud computing specialist familiar with AWS, Azure, and Google Cloud. She guides students through real-world cloud deployment projects.'),
(15, 'Dr. Cho', 'Data Eng', 75, 4, 4.6, 'Dr. Cho is a data engineer with experience in building ETL pipelines and managing big data workflows. He enjoys simplifying complex data processes for students.'),
(16, 'Dr. Ryu', 'Blockchain', 45, 2, 4.1, 'Dr. Ryu focuses on blockchain technology and smart contract development. His courses include hands-on projects to create decentralized apps.'),
(17, 'Dr. Kwon', 'Game Dev', 50, 3, 4.3, 'Dr. Kwon is a game developer experienced with Unity and Unreal Engine. He teaches game design, physics simulation, and interactive storytelling.'),
(18, 'Dr. Lim', 'Python', 95, 5, 4.7, 'Dr. Lim is a Python expert with a background in software engineering and data analysis. His lessons focus on practical projects and problem-solving skills.'),
(19, 'Dr. Chung', 'Java', 85, 4, 4.6, 'Dr. Chung is a Java developer specializing in Spring framework and enterprise applications. He guides students from basics to advanced programming techniques.'),
(20, 'Dr. Jang', 'C++', 40, 2, 4.0, 'Dr. Jang teaches C++ programming with a focus on systems programming, performance optimization, and object-oriented design.'),
(21, 'Dr. Hwang', 'SQL', 60, 3, 4.5, 'Dr. Hwang is a database expert who teaches SQL, database design, and query optimization. His courses include real-world examples and exercises.'),
(22, 'Dr. Kim', 'Ruby', 35, 2, 4.1, 'Dr. Kim is skilled in Ruby and Rails development, helping students create web applications with best practices and clean code.'),
(23, 'Dr. Lee', 'PHP', 90, 5, 4.4, 'Dr. Lee specializes in PHP and Laravel framework. She teaches students how to build secure and maintainable web applications.'),
(24, 'Dr. Park', 'React', 100, 5, 4.8, 'Dr. Park is a frontend engineer with deep knowledge of React. He emphasizes component design, state management, and performance optimization.'),
(25, 'Dr. Choi', 'Node.js', 85, 4, 4.5, 'Dr. Choi is a Node.js developer who teaches server-side JavaScript and building scalable APIs using Express and related technologies.'),
(26, 'Dr. Jung', 'Vue', 50, 3, 4.2, 'Dr. Jung focuses on Vue.js development, creating interactive single-page applications with a clear understanding of reactivity and components.'),
(27, 'Dr. Han', 'Angular', 45, 3, 4.3, 'Dr. Han is an Angular expert teaching TypeScript, component-based architecture, and real-world SPAs.'),
(28, 'Dr. Seo', 'Kotlin', 55, 2, 4.6, 'Dr. Seo is an Android developer using Kotlin. He guides students to build modern Android apps from scratch with clean architecture.'),
(29, 'Dr. Shin', 'Swift', 65, 3, 4.5, 'Dr. Shin is an iOS developer teaching Swift and UIKit/SwiftUI. His lessons include building fully functional iOS apps.'),
(30, 'Dr. Moon', 'Docker', 30, 1, 4.0, 'Dr. Moon teaches containerization and Docker best practices for deploying applications efficiently.'),
(31, 'Dr. Oh', 'Kubernetes', 40, 2, 4.2, 'Dr. Oh specializes in orchestration using Kubernetes, guiding students to manage scalable and resilient cloud applications.'),
(32, 'Dr. Cho', 'AI', 70, 3, 4.7, 'Dr. Cho is an AI engineer with experience in deep learning projects. He helps students understand neural networks and implement AI solutions.'),
(33, 'Dr. Ryu', 'ML', 80, 4, 4.6, 'Dr. Ryu focuses on machine learning projects using Python. His courses cover both theoretical and practical aspects of ML.'),
(34, 'Dr. Kwon', 'DevOps', 50, 2, 4.3, 'Dr. Kwon teaches automation, CI/CD, and cloud infrastructure management to make software delivery faster and safer.'),
(35, 'Dr. Lim', 'Security', 55, 3, 4.5, 'Dr. Lim is a cybersecurity expert guiding students on web security, ethical hacking, and best practices to protect applications.');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `course_id` int UNSIGNED NOT NULL,
  `rating` tinyint UNSIGNED NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `course_id`, `rating`, `comment`, `created_at`) VALUES
(1, 2, 105, 4, '', '2026-03-10 20:27:56'),
(2, 2, 106, 5, 'Amazing lecture', '2026-03-10 20:30:16'),
(3, 1, 105, 5, 'Great course!', '2026-03-10 20:47:04'),
(4, 2, 106, 4, 'Very helpful', '2026-03-10 20:47:04'),
(5, 3, 107, 3, 'Average', '2026-03-10 20:47:04'),
(6, 4, 108, 5, 'Excellent!', '2026-03-10 20:47:04'),
(7, 5, 109, 4, 'Good content', '2026-03-10 20:47:04'),
(8, 6, 110, 2, 'Could be better', '2026-03-10 20:47:04'),
(9, 7, 111, 5, 'Loved it', '2026-03-10 20:47:04'),
(10, 8, 112, 4, 'Well explained', '2026-03-10 20:47:04'),
(11, 9, 113, 3, 'Okay course', '2026-03-10 20:47:04'),
(12, 10, 114, 5, 'Highly recommend', '2026-03-10 20:47:04'),
(13, 11, 115, 4, 'Useful', '2026-03-10 20:47:04'),
(14, 12, 116, 5, 'Amazing', '2026-03-10 20:47:04'),
(15, 13, 117, 3, 'Just fine', '2026-03-10 20:47:04'),
(16, 14, 118, 4, 'Pretty good', '2026-03-10 20:47:04'),
(17, 15, 119, 5, 'Outstanding', '2026-03-10 20:47:04'),
(18, 16, 120, 2, 'Needs improvement', '2026-03-10 20:47:04'),
(19, 17, 121, 4, 'Liked it', '2026-03-10 20:47:04'),
(20, 18, 122, 5, 'Fantastic', '2026-03-10 20:47:04'),
(21, 19, 123, 3, 'Not bad', '2026-03-10 20:47:04'),
(22, 20, 124, 4, 'Good lessons', '2026-03-10 20:47:04'),
(23, 21, 125, 5, 'Very helpful', '2026-03-10 20:47:04'),
(24, 22, 126, 4, 'Nice explanations', '2026-03-10 20:47:04'),
(25, 23, 127, 3, 'Average', '2026-03-10 20:47:04'),
(26, 24, 128, 5, 'Great!', '2026-03-10 20:47:04'),
(27, 25, 129, 4, 'Good course', '2026-03-10 20:47:04'),
(28, 26, 130, 2, 'Okay', '2026-03-10 20:47:04'),
(29, 27, 131, 5, 'Excellent', '2026-03-10 20:47:04'),
(30, 28, 132, 4, 'Well done', '2026-03-10 20:47:04'),
(31, 29, 133, 3, 'Satisfactory', '2026-03-10 20:47:04'),
(32, 30, 134, 5, 'Loved this course', '2026-03-10 20:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int UNSIGNED NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('student','admin') COLLATE utf8mb4_general_ci DEFAULT 'student',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'Emma', 'Johnson', 'emma.johnson@example.com', '$2y$10$eKJtn6DVzg9JHiOPJPEOmeXYX5teD0LzkLElFRy5TVRg5M.oNs5ea', 'student', '2026-03-11 19:46:01'),
(2, 'Liam', 'Williams', 'liam.williams@example.com', '$2y$10$D9A2PJA2JzyRoCsHmLiu6O28wcUwBAA6y/oQJR5oV4qR8Ojc1hdXS', 'student', '2026-03-11 19:46:01'),
(3, 'Olivia', 'Brown', 'olivia.brown@example.com', '$2y$10$pp1CFL0EtqEJB0bNqhu.zONHn4YAFlMKQqOclBB4e7hEZYmH94Ih2', 'student', '2026-03-11 19:46:01'),
(4, 'Noah', 'Jones', 'noah.jones@example.com', '$2y$10$GWm3zu.08KcJ/6n1QfA.Ruz8f/kxyrpduwIk5XFP.EN01nxqMP68C', 'student', '2026-03-11 19:46:01'),
(5, 'Ava', 'Garcia', 'ava.garcia@example.com', '$2y$10$WHT9P.gFpCjXNRs5ZoR0cOHbt6edZENu.7NyYIe2ywwney46aaVp.', 'student', '2026-03-11 19:46:01'),
(6, 'Elijah', 'Martinez', 'elijah.martinez@example.com', '$2y$10$LRWLjO6Ivq4rjZLJYrmqveuqprEozDCn7WdaoAIC581UwPcgpPUzO', 'student', '2026-03-11 19:46:01'),
(7, 'Sophia', 'Rodriguez', 'sophia.rodriguez@example.com', '$2y$10$y1rUuDmWjK4SYrGHhx8.O.wiKqqQ0SDB4buRnySIsVOjS47vgkWYi', 'student', '2026-03-11 19:46:01'),
(8, 'James', 'Lee', 'james.lee@example.com', '$2y$10$9/ks2hdfLnBFut7kagy87uULqheVGQ83j2iBQdKJnlTNBPOjTgXpC', 'student', '2026-03-11 19:46:01'),
(9, 'Isabella', 'Walker', 'isabella.walker@example.com', '$2y$10$f.bDv7XiaAePo.H2QQ1byeAU8OYndZQ7G.6XvqbEWpArVvos9JH6S', 'student', '2026-03-11 19:46:01'),
(10, 'Benjamin', 'Hall', 'benjamin.hall@example.com', '$2y$10$rZq8nbBy87lTeqklTi9GD.JZlMZH7l0B8RzXO78maSMje/d.mDDPS', 'student', '2026-03-11 19:46:01'),
(11, 'Mia', 'Allen', 'mia.allen@example.com', '$2y$10$kab1yMHnt38.UXR47pEBV.G/NlPg37z74Er.5Vb.VV6EakGmrTiRe', 'student', '2026-03-11 19:46:01'),
(12, 'Lucas', 'Young', 'lucas.young@example.com', '$2y$10$nm1FQdG7cbaJlpHh5NbHfOMJV.luoHxrpraDIbcWajSKjLhmwqPmm', 'student', '2026-03-11 19:46:02'),
(13, 'Charlotte', 'Hernandez', 'charlotte.hernandez@example.com', '$2y$10$Vrv4D2X7mDLLTl58FBKagOdpXKGBAPASr0mXJCDXguiSe4VB0S2vO', 'student', '2026-03-11 19:46:02'),
(14, 'Mason', 'King', 'mason.king@example.com', '$2y$10$T96GfC8XAuG7e6/pbW6d4.p42ski364DgLp0ohKnCtXmIdspIEt3G', 'student', '2026-03-11 19:46:02'),
(15, 'Amelia', 'Wright', 'amelia.wright@example.com', '$2y$10$J9lNdTKFc3XfSmLSI/tg7OokAHSGvkAGIa6MKiFPRea5eZjzLx/oa', 'student', '2026-03-11 19:46:02'),
(16, 'Ethan', 'Lopez', 'ethan.lopez@example.com', '$2y$10$9LJbCwPefaT93MNwuh8NfO8VbTcesFGG2Bra/fu7cg2eymbh2lKoC', 'student', '2026-03-11 19:46:02'),
(17, 'Harper', 'Hill', 'harper.hill@example.com', '$2y$10$w7JXqoaqhZcDHmqbiMvca.BMfl76FiTocNjc7zmA2oldBZaSh95/u', 'student', '2026-03-11 19:46:02'),
(18, 'Alexander', 'Scott', 'alexander.scott@example.com', '$2y$10$X53gFNdPcIhQiLk/BJkMxOUf3QKHIg6CQ8/cvyT1qT96l7qqR4TxG', 'student', '2026-03-11 19:46:02'),
(19, 'Evelyn', 'Green', 'evelyn.green@example.com', '$2y$10$kQgwtqvBKIsT00gFbrcnfebVO2/zekyYLctFxZFwSr5OUtvCbE9bu', 'student', '2026-03-11 19:46:02'),
(20, 'Henry', 'Adams', 'henry.adams@example.com', '$2y$10$jzIdP.CI1t49maIi2bllgOpMfVTFd7vifRyCdNley7mY4U5kP7SAK', 'student', '2026-03-11 19:46:02'),
(21, 'Abigail', 'Baker', 'abigail.baker@example.com', '$2y$10$Ef3hcqR.mlNEiLGPQDfN8eLKIwB4nYBpPUTH8uH3WjlSuU2TG0hhe', 'student', '2026-03-11 19:46:02'),
(22, 'Sebastian', 'Nelson', 'sebastian.nelson@example.com', '$2y$10$liyJt.He61UVZMFMCdT/MeIBlo6Ju.F5zMR4D3ovWAJD2yqdDh3hW', 'student', '2026-03-11 19:46:02'),
(23, 'Ella', 'Carter', 'ella.carter@example.com', '$2y$10$dJLc2DdfoqAN8Fq/pfx4VOhjDRrEqJ.tr6e/Bx3a/iu71pvPKMt0W', 'student', '2026-03-11 19:46:02'),
(24, 'Jack', 'Mitchell', 'jack.mitchell@example.com', '$2y$10$cOiAm5lOGLQ78V4zwrT56ud2ABxsmqDNl9qPvHLy7FOdTdo4BF3Au', 'student', '2026-03-11 19:46:02'),
(25, 'Scarlett', 'Perez', 'scarlett.perez@example.com', '$2y$10$USKX15lCBzXTqWVu4CSF7.Nmda8YRRHeyLPqRhJQoAIpiPu7hQcPa', 'student', '2026-03-11 19:46:02'),
(26, 'Owen', 'Roberts', 'owen.roberts@example.com', '$2y$10$T3HO9mifCad8pRDgCYOOaOzJogeal82zq8WO1WcmKNvtdJXPdpoey', 'student', '2026-03-11 19:46:02'),
(27, 'Grace', 'Turner', 'grace.turner@example.com', '$2y$10$tXj0dWw93sFLSoQYh5lNSeaJG65II2P8U4AERhGKenuLi3Q5pYdIK', 'student', '2026-03-11 19:46:03'),
(28, 'Leo', 'Phillips', 'leo.phillips@example.com', '$2y$10$RwqULVvOAYG2xBfMd2K6QuOjQlfZLLb2RYTEUObT1dwsMHuHKk8ve', 'student', '2026-03-11 19:46:03'),
(29, 'Chloe', 'Campbell', 'chloe.campbell@example.com', '$2y$10$E1iaeCq6XHuRIKj9u1tOgOWVy9BfakXqnyl9TIGNcXSn06QzGI8iq', 'student', '2026-03-11 19:46:03'),
(30, 'Daniel', 'Parker', 'daniel.parker@example.com', '$2y$10$PYGNMOU8Xtqf2JD4skacW.qUBcGV0QAONBEinLb/AnZCNb8jQqfJ6', 'student', '2026-03-11 19:46:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_entity` (`entity`,`entity_id`),
  ADD KEY `idx_timestamp` (`timestamp`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `uq_cart_user_course` (`user_id`,`course_id`),
  ADD KEY `fk_cart_course` (`course_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `fk_course_instructor` (`instructor_id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD UNIQUE KEY `uq_user_course` (`user_id`,`course_id`),
  ADD KEY `fk_enroll_course` (`course_id`);

--
-- Indexes for table `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `fk_review_user` (`user_id`),
  ADD KEY `fk_review_course` (`course_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `instructors`
--
ALTER TABLE `instructors`
  MODIFY `instructor_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cart_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_course_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`) ON DELETE RESTRICT;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_enroll_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_enroll_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_review_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
