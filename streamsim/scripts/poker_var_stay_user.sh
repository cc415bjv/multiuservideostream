#!/usr/bin/env bash
# Run from directory ABOVE scripts

OUT_FILE="data/poker_var_stay_user.out"
IN_FILE="scripts/poker_var_stay_user.json"
SCRIPT=scripts/meansd.py
RND=$RANDOM
TMPJSONFILE="/tmp/poker_var_stay_$RND.json"
TMPCOSTFILE="/tmp/poker_var_stay_cost_$RND.out"
TMPDAYFILE="/tmp/poker_var_stay_day_$RND.out"
TMPSESSFILE="/tmp/poker_var_stay_sess_$RND.out"
TMPQOSFILE="/tmp/poker_var_stay_qos_$RND.out"
rm -f $OUT_FILE
for users in "1000" "2000" "5000" "10000"; do
    sed -e "s/XXXXXX/$users/g" $IN_FILE | sed -e "s%DAYTMPFILE%$TMPDAYFILE%g" | sed -e "s%COSTTMPFILE%$TMPCOSTFILE%g" | sed -e "s%QOSTMPFILE%$TMPQOSFILE%g" | sed -e "s%SESSTMPFILE%$TMPSESSFILE%g"> $TMPJSONFILE
    src/streamsim.py $TMPJSONFILE
    echo -n $users "" >> $OUT_FILE
    cat $TMPCOSTFILE | $SCRIPT | tr -d '\n' >> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPQOSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPSESSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo >> $OUT_FILE
rm -f $TMPJSONFILE $TMPCOSTFILE $TMPDAYFILE $TMPQOSFILE    
done