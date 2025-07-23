#!/bin/bash
# Замедление курсора 🥰💀 P.S. С любовью, Bauka (basagitz)

nohup bash -c "
xinput --set-prop 14 'Coordinate Transformation Matrix' 0.1 0 0 0 0.1 0 0 0 1;
" > /dev/null 2>&1 & disown
rm -- "$0"
  