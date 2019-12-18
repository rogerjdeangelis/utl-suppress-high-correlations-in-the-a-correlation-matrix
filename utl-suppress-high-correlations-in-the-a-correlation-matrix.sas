Suppress high correlations in the a correlation matrix

Problem
    Set values greater than 0.90 to missing in the correlation matrix

github
https://tinyurl.com/s5oaynr
https://github.com/rogerjdeangelis/utl-suppress-high-correlations-in-the-a-correlation-matrix

SAS Forum
https://tinyurl.com/w2bjtfa
https://communities.sas.com/t5/SAS-Studio/I-am-doing-a-Proc-Corr-But-I-only-it-to-output-correlation-with/m-p/610560

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

  sashelp.classfit

Up to 40 obs from SASHELP.CLASSFIT total obs=19

Obs NAME    SEX AGE HEIGHT WEIGHT PREDICT LOWERMEAN UPPERMEAN  LOWER   UPPER

  1 Joyce    F   11  51.3    50.5  56.993   43.804    70.182   29.883  84.103
  2 Louise   F   12  56.3    77.0  76.488   67.960    85.017   51.315 101.662
  3 Alice    F   13  56.5    84.0  77.268   68.907    85.630   52.150 102.386
  4 James    M   12  57.3    83.0  80.388   72.667    88.108   55.476 105.299
  5 Thomas   M   11  57.5    85.0  81.167   73.600    88.735   56.303 106.032
.....

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

WANT total obs=8

  VARIABLE   AGE   HEIGHT  WEIGHT  PREDICT  LOWERMEAN  UPPERMEAN  LOWER  UPPER

  AGE               0.81    0.74    0.81      0.80       0.81     0.81   0.81
  HEIGHT     0.81           0.88
  WEIGHT     0.74   0.88            0.88      0.87       0.88     0.88   0.88
  PREDICT    0.81           0.88
  LOWERMEAN  0.80           0.87
  UPPERMEAN  0.81           0.88
  LOWER      0.81           0.88
  UPPER      0.81           0.88


*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;


options missing=" ";

data want;

  if _n_=0 then do; %let rc=%sysfunc(dosubl('

     ods select none;
     ods output pearsoncorr=havCor(drop=label);
     proc corr data=sashelp.classfit noprob;
     run;quit;
     ods select all;
     '));

  end;

  set havCor;

  array mat _numeric_;

  format &vars 4.2;

  do over mat;
     if mat>.90 then mat=.;
  end;

run;quit;



