#!/usr/bin/env bash
# Run from directory ABOVE toccscripts

OUT_FILE="toccdata/poker_half_ndynamic.out"
IN_FILE="toccscripts/poker_half_ndynamic.json"
SCRIPT=toccscripts/meansd.py
RND=$RANDOM
TMPJSONFILE="/tmp/poker_half_$RND.json"
TMPCOSTFILE="/tmp/poker_half_cost_$RND.out"
TMPDAYFILE="/tmp/poker_half_day_$RND.out"
TMPSESSFILE="/tmp/poker_half_sess_$RND.out"
TMPQOSFILE="/tmp/poker_half_qos_$RND.out"
rm -f $OUT_FILE
for servers in `seq 10`; do
    sed -e "s/XXXXXX/$servers/g" $IN_FILE | sed -e "s%DAYTMPFILE%$TMPDAYFILE%g" | sed -e "s%COSTTMPFILE%$TMPCOSTFILE%g" | sed -e "s%QOSTMPFILE%$TMPQOSFILE%g" | sed -e "s%SESSTMPFILE%$TMPSESSFILE%g"> $TMPJSONFILE
    src/streamsim.py $TMPJSONFILE
    echo -n $servers "" >> $OUT_FILE
    cat $TMPCOSTFILE | $SCRIPT | tr -d '\n' >> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPQOSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPSESSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo >> $OUT_FILE
rm -f $TMPJSONFILE $TMPCOSTFILE $TMPDAYFILE $TMPQOSFILE    
done

OUT_FILE="toccdata/poker_half_nstatic.out"
IN_FILE="toccscripts/poker_half_nstatic.json"
rm -f $OUT_FILE
for servers in `seq 10`; do
    sed -e "s/XXXXXX/$servers/g" $IN_FILE | sed -e "s%DAYTMPFILE%$TMPDAYFILE%g" | sed -e "s%COSTTMPFILE%$TMPCOSTFILE%g" | sed -e "s%QOSTMPFILE%$TMPQOSFILE%g" | sed -e "s%SESSTMPFILE%$TMPSESSFILE%g"> $TMPJSONFILE
    src/streamsim.py $TMPJSONFILE
    echo -n $servers "" >> $OUT_FILE
    cat $TMPCOSTFILE | $SCRIPT | tr -d '\n' >> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPQOSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPSESSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo >> $OUT_FILE
rm -f $TMPJSONFILE $TMPCOSTFILE $TMPDAYFILE $TMPQOSFILE    
done


OUT_FILE="toccdata/poker_half_nrandom.out"
IN_FILE="toccscripts/poker_half_nrandom.json"
rm -f $OUT_FILE
for servers in `seq 10`; do
    sed -e "s/XXXXXX/$servers/g" $IN_FILE | sed -e "s%DAYTMPFILE%$TMPDAYFILE%g" | sed -e "s%COSTTMPFILE%$TMPCOSTFILE%g" | sed -e "s%QOSTMPFILE%$TMPQOSFILE%g" | sed -e "s%SESSTMPFILE%$TMPSESSFILE%g"> $TMPJSONFILE
    src/streamsim.py $TMPJSONFILE
    echo -n $servers "" >> $OUT_FILE
    cat $TMPCOSTFILE | $SCRIPT | tr -d '\n' >> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPQOSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo -n " " >> $OUT_FILE
    cat $TMPSESSFILE | $SCRIPT | tr -d '\n'>> $OUT_FILE
    echo >> $OUT_FILE
rm -f $TMPJSONFILE $TMPCOSTFILE $TMPDAYFILE $TMPQOSFILE    
done

