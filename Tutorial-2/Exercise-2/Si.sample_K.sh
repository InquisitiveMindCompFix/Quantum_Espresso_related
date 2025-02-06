#!/bin/sh

NAME="k-points"
echo " ---------------------------------------------------------------------------------"
echo " |                                                                               |"
echo " |  Please wait calculation is going on at SRMIST-COMET Server. Thank You!!! :)  |"
echo " |                                                                               |"
echo " ---------------------------------------------------------------------------------"

for K in  4 5 6 7 8
do
cat > ${NAME}_${K}.in << EOF

&CONTROL
  		calculation = 'scf' ,
  		     outdir = './' ,
  		     prefix = 'SCF' ,
  		 pseudo_dir = '/home/enigma/DataSets/upf_files' ,
  		  verbosity = 'low' ,  ! You can use high also to get more informations in the output file.
	      etot_conv_thr = 1.0D-4 ,
/

&SYSTEM
  		      ibrav = 2 ,
                  celldm(1) = 10.2623466921 ,
  		        nat = 2 ,
  		       ntyp = 1 ,
  		    ecutwfc = 35 ,
                    ecutrho = 140 ,
  		occupations = 'smearing' ,
                   smearing = 'fermi-dirac' ,
                    degauss = 3.6d-3 ,
/

&ELECTRONS
  		   conv_thr = 1d-6 ,
		mixing_mode = 'plain' ,
  		mixing_beta = 0.7d0 ,
	    diagonalization = 'david' ,
/

ATOMIC_SPECIES
  Si 28.085500d0 Si.pbe-n-kjpaw_psl.0.1.UPF

ATOMIC_POSITIONS {crystal}
  Si   0.00   0.00   0.00
  Si   0.25   0.25   0.25

K_POINTS {automatic}
  $K $K $K 1 1 1
EOF

pw.x < ${NAME}_${K}.in > ${NAME}_${K}.out

done
