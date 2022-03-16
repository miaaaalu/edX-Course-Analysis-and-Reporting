--------------------------------------
-------------Table Creation-----------
--------------------------------------
//create databASe
CREATE OR REPLACE DATABASE Online_Courses_HM;

//create table
CREATE OR REPLACE TABLE ONLINE_COURSE (
          "Institution" VARCHAR(20),
          "Course Number" VARCHAR(30),
          "Launch Date" DATE,
          "Course Title" TEXT,
          "Instructors" TEXT,
          "Course Subject" TEXT,
          "Year" TINYINT,
          "Honor Code Certificates" DOUBLE,
          "Participants(Course Content Accessed)" INTEGER,
          "Audited(> 50% Course Content Accessed)" INTEGER,
          "Certified" INTEGER,
          "% Audited" DECIMAL(4,2),
          "% Certified" DECIMAL(4,2),
          "% Certified of > 50% Course Content Accessed" DECIMAL(4,2),
          "% Played Video" DECIMAL(4,2),
          "% Posted in Forum" DECIMAL(4,2),
          "% Grade Higher Than Zero" DECIMAL(4,2),
          "Total Course Hours (Thousands)" DECIMAL(5,2),
          "Median Hours for Certification" DECIMAL(5,2),
          "Median Age" DECIMAL(3,1),
          "% Male" DECIMAL(4,2),
          "% Female" DECIMAL(4,2),
          "% Bachelor's Degree or Higher" DECIMAL(4,2)
);

--------------------------------------
-------------Data Loading-------------
--------------------------------------
//create a stage
CREATE OR REPLACE STAGE online_course_stage;

//Create a file format 
CREATE OR REPLACE FILE FORMAT online_course_Format
  type = 'CSV'
  TIMESTAMP_FORMAT = 'MM/DD/YEAR'
  skip_header = 1
  field_delimiter = ','
  record_delimiter = '\\n'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"';
  
// connect to snowsql 
snowsql -a ********.ap-southeASt-2 -u MIALU;
  
//upload csv to staging layer (snowsql)
put file:///Users/mia/Desktop/Online-Courses-FROM-Harvard-and-MIT/appendix.csv @online_course_stage

// Load data
COPY INTO public.ONLINE_COURSE 
FROM @online_course_stage/appendix.csv.gz 
        FILE_FORMAT = online_course_Format
        ON_ERROR = 'CONTINUE';

--------------------------------------
-----------Course Analysis------------
--------------------------------------
// 1. Number of total courses  - Subject based distribution
SELECT "Course Subject",
        COUNT("Course Title") AS "Total Courses"
FROM online_course
GROUP BY "Course Subject";

// 2. Number of participants - Course based distribution
SELECT "Course Title",
       SUM("Participants(Course Content Accessed)") AS "Total Participants"
FROM online_course
GROUP BY "Course Title"
ORDER BY "Total Participants" DESC;

// 3. Number of participants - Year based distribution
SELECT YEAR("Launch Date") AS "YEAR",
       SUM("Participants(Course Content Accessed)") AS "Total Participants"
FROM online_course
GROUP BY "YEAR"
ORDER BY "Total Participants" DESC;

// 4. Number of participants - Courese and Year based distribution
SELECT "Course Title",
       YEAR("Launch Date") AS "YEAR",
       SUM("Participants(Course Content Accessed)") AS "Total Participants"
FROM online_course
GROUP BY "Course Title","YEAR"
ORDER BY "Total Participants" DESC;

// 5. Comparison (Courese based distribution) - Total number of Participants, Total number of Certified
SELECT "Course Title",
       SUM("Participants(Course Content Accessed)") AS Participants,
       SUM("Certified") AS total_Certified,
       ROUND(MEDIAN("% Certified"),2) AS "% Certified"
FROM online_course
GROUP BY "Course Title"
ORDER BY total_Certified DESC;

--------------------------------------
-----------User Analysis------------
--------------------------------------
// 6. age distribution (Min Age, Max Age, Avg Age)
SELECT MIN("Median Age") AS "Min Age",
       MAX("Median Age") AS "Max Age",
       ROUND(AVG("Median Age"),2) AS "Avg Age"
FROM online_course;

// 7. age distribution (percentage)
select "Median Age",
        ROUND(COUNT("Median Age")/289*100,2) AS "% Age"
FROM online_course
GROUP BY "Median Age";

// 8. age distribution - Courese based distribution
SELECT "Course Title",
       SUM("Participants(Course Content Accessed)") AS "Total Participants",
       ROUND(AVG("Median Age"),2) AS "Avg Age"
FROM online_course
GROUP BY "Course Title"
ORDER BY "Total Participants" DESC;


// 9. gender distribution - Courses based distribution
SELECT YEAR("Launch Date") AS "YEAR",
        ROUND(MEDIAN("% Male"),2) AS "% Total Male",
        ROUND(MEDIAN("% Female"),2) AS "% Total Female"
FROM online_course
GROUP BY "YEAR";

// 10. Education distribution - Courses based distribution
SELECT YEAR("Launch Date") AS "YEAR",
       ROUND(MEDIAN("% Bachelor's Degree or Higher"),2) AS "Bachelor's Degree or Higher"
FROM online_course
GROUP BY "YEAR";