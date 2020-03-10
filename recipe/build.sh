#!/bin/bash

# ------------------- Tempo part
cd $SRC_DIR/tempo

# Write a README
rdme='clock/README'
echo "tempo clock file directory v$PKG_VERSION" > $rdme
echo >> $rdme
echo 'Clock files from tempo git version: ' >> $rdme
git log --pretty=format:'%H %cD' >> $rdme
echo >> $rdme
echo 'ut1.dat updated directly from IERS C04 series' >> $rdme

# Update ut1.dat
cd util/ut1
./get_ut1_new
./make_ut1 > ../../clock/ut1.dat

# Install everything
cd $SRC_DIR/tempo
tempodir=$PREFIX/share/tempo
mkdir -p $tempodir
cp -a clock $tempodir

# ------------------- Tempo2 part
cd $SRC_DIR/tempo2

# Write a README
rdme='T2runtime/clock/README'
echo "tempo2 clock file directory v$PKG_VERSION" > $rdme
echo >> $rdme
echo 'Clock files from tempo2 git version: ' >> $rdme
git log --pretty=format:'%H %cD' >> $rdme
echo >> $rdme
echo 'ut1.dat updated directly from IERS C04 series' >> $rdme

# Update EOP
cd T2runtime/earth
#wget -N https://hpiers.obspm.fr/iers/eop/eopc04/eopc04_IAU2000.62-now
#wget https://datacenter.iers.org/data/latestVersion/224_EOP_C04_14.62-NOW.IAU2000A224.txt
#mv 224_EOP_C04_14.62-NOW.IAU2000A224.txt eopc04_IAU2000.62-now
cp $SRC_DIR/tempo/util/ut1/224_EOP_C04_14.62-NOW.IAU2000A224.txt eopc04_IAU2000.62-now
cd $SRC_DIR/tempo2

# Get ut1.dat from tempo
cp -a -f $SRC_DIR/tempo/clock/ut1.dat T2runtime/clock/

# Install everything
tempodir=$PREFIX/share/tempo2
mkdir -p $tempodir
cp -a T2runtime/clock $tempodir/
cp -a T2runtime/earth $tempodir/
