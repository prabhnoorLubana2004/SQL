-- Lab manipulating DATA
set echo ON
spool c:/cprg250s/labmanipulatingdata.txt
delete ghc_expertise;
delete ghc_faculty;
delete ghc_course;
delete ghc_department;

-- Question 1
insert into ghc_department (dept_no, dept_name)
values (100, 'Astrophysics');

-- Question 2
insert into ghc_faculty (faculty_id, surname, firstname, date_hired, is_active, dept_no)
values (1001, 'Faulkner', 'Danny','01-jan-22', 1, 100);

-- Question 3
insert into ghc_course (Course_code, Course_title, credits)
values ('APHY202', 'The Solar System', 5);
insert into ghc_course (Course_code, Course_title, credits)
values ('APHY203', 'Nebula', 5);
insert into ghc_course (Course_code, Course_title, credits)
values ('APHY204', 'Global Clusters', 5);

-- Question 4

 -- update existing data
 update ghc_course
 SET course_code = 'APHY302'
 WHERE course_code = 'APHY203';
 

-- Question 5
-- remove courses that danny teaches from expertise TABLE
-- remove danny from the faculty TABLE
DELETE FROM ghc_expertise
 WHERE faculty_id = 1001 ;
DELETE FROM ghc_faculty 
WHERE faculty_id = 1001;
COMMIT;


spool OFF



