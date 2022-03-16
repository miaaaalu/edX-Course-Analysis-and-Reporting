# edX Course Analysis and Reporting
In 2012, the Massachusetts Institute of Technology (MIT) and Harvard University launched open online courses on edX, based on the four years data, we can learn about these online courses and the global learners who take them.

## Key findings

**Participants Trending Line**

In the early three years, the participants on edx are continue increasing, however, the number of participants shows a dramatically down in 2016, from 1,560,589 to 696,377. 

**Participants VS Certification**

*Introduction to Computer Science*, as a moust popular course on edX , which enrolled 690,059 learners in total,  with 4,957(9.17%) learners achieved the course ceftification. 

**Age Distribution**

A median edX learner age of 29 years old, max age is 53,  min age is 22. Furthermore, about 64% learnrs age around 25-30, which means most of learns are professional or graduates who are ready to work.

**Gender Distribution**

A two-to-one male-to-female ratio (67% male, 33% percent female). From 2012 to 2016, the male ratio are sightly increasing, and the female ratio are sightly decraesing.

**Edcation Distribution**

The education of most learners are Bachelor's Degree or Higher, average around 72%. From 2012 -2016, the learner qalifications on the rise. 


## Data Source and background: 
https://www.kaggle.com/edx/course-study

## Analysis Design
Courses Analysis 
* Number of total courses  - Subject based distribution 
* Number of participants - Year based distribution
* Number of participants - Courese and Year based distribution   
* The most popular courses on edX            
* Comparison - number of Participants VS number of Certified   


User Characteristics Analysis 
* Avg age distribution - based on course 
* Avg age, Min Age, Max Age
* Percentage of age
* Education distribution - Year based
* Gender distribution
* Gender distribution - Courses based distribution


## Data process and auditing
```
pre-process.ipynb
```
## Data loading and Analysis
```
snowflake.sql
```

## Data Reporting and Insights (Tableau)
![courses-analysis](https://github.com/miaaaalu/edX-Course-Analysis-and-Reporting/blob/master/courses-analysis.png?raw=true)
![learner-analysis](https://github.com/miaaaalu/edX-Course-Analysis-and-Reporting/blob/master/learner-analysis.png?raw=true)