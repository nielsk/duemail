duemail
=======

Two scripts to mail reminders to yourself for due tasks in your todo.txt

Since I couldn't really figure out, how I can make the mailer variable, I created one script for msmtp and one if you use mutt for msmtp.

When you run the scripts, they will parse your todo.txt and will
* when you have tasks due for today send you a mail with your due tasks for today and the due tasks in 7 days
* when you have no tasks due for today, send you a mail with your due tasks for tomorrow and the due tasks in 7 days
* when you have no tasks due for today or tomorrow, send you a mail with due tasks in 7 days
* when you have nothing due, send you a simple mail that tells you that you have nothing due and you know the cronjob/script still works

For making the script to work, you have to configure:
* TOMAIL with the address where the tasks shall be sent
* TODOTXT with the location of your todo.txt
* if you use msmtp, then you also need to configure FROMMAIL with the address which will be in the FROM-part of the mail-header

I use the script in the cron-job to get a notification in the morning and in the evening.
