#!/usr/bin/env bash
# Run from directory ABOVE toccscripts

OUT_FILE="toccdata/poker_var_user_ndynamic.out"
IN_FILE="toccscripts/poker_var_user_ndynamic.json"
SCRIPT=toccscripts/meansd.py
RND=$RANDOM
TMPJSONFILE="/tmp/poker_var_$RND.json"
TMPCOSTFILE="/tmp/poker_var_cost_$RND.out"
TMPDAYFILE="/tmp/poker_var_day_$RND.out"
TMPSESSFILE="/tmp/poker_var_sess_$RND.out"
TMPQOSFILE="/tmp/poker_var_qos_$RND.out"

rm -f $OUT_FILE
for users in "2500" "5000" "7500" "10000"; do
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

OUT_FILE="toccdata/poker_var_user_nstatic.out"
IN_FILE="toccscripts/poker_var_user_nstatic.json"
rm -f $OUT_FILE
for users in "2500" "5000" "7500" "10000"; do
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

OUT_FILE="toccdata/poker_var_user_nrandom.out"
IN_FILE="toccscripts/poker_var_user_nrandom.json"

rm -f $OUT_FILE
for users in "2500" "5000" "7500" "10000"; do
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
