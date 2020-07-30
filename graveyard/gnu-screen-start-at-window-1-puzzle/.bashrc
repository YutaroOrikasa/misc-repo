
# screen window number fixing
# Ajusting that window number starts at 1.
if [ -n "$STY" ];then
    case "$WINDOW" in
        0)
            screen -X number 1
            export WINDOW=1
            ;;
        1)
            # '*' means created window.
            # case 1
            # screen |0 |1*|
            # arrange:
            # screen |1 |2*|

            # case 2
            # screen |1*|2 |
            # NO arrange:
            # screen |1*|2 |

            # Unbelievablely, these screen commands can handle both cases!
            screen -X eval 'select 2' 'number 0' 'number 2'
            
            # Proof:
            # '*' means selected.
            #                       case 1              case 2
            #                      |0  A|1   |2  |      |0   |1   |2  C|
            # 
            # window 1 created:    |0  A|*1 B|2  |      |0   |*1 B|2  C|
            #    select 2          |0  A|*1 B|2  |      |0   | 1 B|*2 C|
            # in case 1,
            # nothing were changed.
            #
            #    number 0          |*0 B|1  A|2   |     |0* C| 1 B|2   |
            #    number 2          |0   |1  A|*2 B|     |0   | 1 B|2* C|

            # But this way is better, not puzzle.
#             sh <<'EOF' && screen -X eval 'number 0' 'number 2'
# trap 'exit 0' USR1
# trap 'exit 1' USR2
# screen -p 0 -X exec kill -usr1 $$
# screen -p 2 -X exec kill -usr2 $$
# sleep 1 &
# wait
# exit 2
# EOF
    esac
fi
