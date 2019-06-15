USE calendar;

CREATE TABLE my_schedule(
    scheduleNumber int primary key auto_increment,
    schedule VARCHAR(20),
    intervalTerm int,
    scheduleStart date,
    scheduleEnd date,
    time varchar(20)
);
CREATE TABLE my_diary(
    date DATE primary key,
    scheduleNumber int,
    foreign key (scheduleNumber) references my_schedule(scheduleNumber)
);

INSERT INTO my_schedule(schedule, intervalTerm,scheduleStart, scheduleEnd,time) VALUES ('장보기',1,'2019-03-09','2019-03-31','오후 2시');

INSERT INTO my_diary SELECT scheduleStart,scheduleNumber FROM my_schedule;

INSERT INTO my_diary
SELECT DATE_ADD((select date from my_diary order by date desc limit 1),interval (select intervalTerm from my_schedule) week ),scheduleNumber
FROM my_schedule
WHERE DATE_ADD((select date from my_diary order by date desc limit 1),interval (select intervalTerm from my_schedule) week )
      between (select date from my_diary order by date desc limit 1) and my_schedule.scheduleEnd
LIMIT 1;

SELECT * FROM my_schedule;
SELECT * FROM my_diary;

SELECT date,schedule,time FROM my_diary INNER JOIN my_schedule ON my_diary.scheduleNumber = my_schedule.scheduleNumber;