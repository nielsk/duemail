#!/bin/bash
LANG=en_US.UTF-8
TOMAIL=foo@bar.org
TODOTXT=$HOME/todo/todo.txt 
TODOTXTDIR=$HOME/todo
DAT=`date '+%Y-%m-%d'`
DATDUE=due:`echo $DAT`
DATTOM=`date -d "+1 days" +%Y-%m-%d`
DATDUETOM=due:`echo $DATTOM`
DAT7DAYS=`date -d "+7 days" +%Y-%m-%d`
DATDUE7DAYS=due:`echo $DAT7DAYS`
DUETASKS=`grep $DATDUE $TODOTXT | grep -v \^x`
TODONO=`grep $DATDUE $TODOTXT | grep -v \^x | wc -l`
DUETASKSTOM=`grep $DATDUETOM $TODOTXT | grep -v \^x`
TODONOTOM=`grep $DATDUETOM $TODOTXT | grep -v \^x | wc -l`
DUETASKS7DAYS=`grep $DATDUE7DAYS $TODOTXT | grep -v 'x\ '`
TODONO7DAYS=`grep $DATDUE7DAYS $TODOTXT | grep -v 'x\ ' | wc -l`
FILE="$TODOTXTDIR/duemail.txt"

if [[ "$TODONO" != 1 ]]
  then TASKS=tasks
  else TASKS=task
fi

if [[ "$TODONOTOM" != 1 ]]
  then TASKSTOM=tasks
  else TASKSTOM=task
fi

if [[ "$TODONO7DAYS" != 1 ]]
  then TASKS7DAYS=tasks
  else TASKS7DAYS=task
fi

tasks_due_today()
{
  /bin/cat <<EOM >$FILE
$DUETASKS

You have $TODONO7DAYS $TASKS7DAYS due in 7 days.
$DUETASKS7DAYS
EOM
  mutt -s "You have $TODONO $TASKS due today" $TOMAIL < $FILE
}

notasks_due_today()
{
  /bin/cat <<EOM >$FILE
$DUETASKSTOM

You have $TODONO7DAYS $TASKS7DAYS due in 7 days.
$DUETASKS7DAYS
EOM
  mutt -s "You have $TODONOTOM $TASKSTOM due tomorrow" $TOMAIL < $FILE
}

tasks_due_7days()
{
  /bin/cat <<EOM >$FILE
$DUETASKS7DAYS
EOM
  mutt -s "You have $TODONO7DAYS $TASKS7DAYS due in a week" $TOMAIL < $FILE

}

tasks_due_none()
{
  /bin/cat <<EOM >$FILE
Hooray! \o/
EOM
  mutt -s "Nothing due" $TOMAIL < $FILE
}


if [[ "$TODONO" > 0 ]]
  then tasks_due_today
elif [[ "$TODONO" < 1 && "$TODONOTOM" > 0 ]]
  then notasks_due_today
elif [[ "$TODONO" < 1 && "$TODONOTOM" < 1 && "$TODONO7DAYS" > 0 ]]
  then tasks_due_7days
else
  tasks_due_none
fi
