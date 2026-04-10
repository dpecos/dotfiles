#!/usr/bin/env bash
#
# Starts Neovim a number of times and measure its startup time until the first
# buffer has been loaded. It persists the measured times and finally calculates
# the average time to get a more accurate value.
#
# Takes no parameter.

MEASUREMENT_COUNT=10
LOG_FILE="./log"
SESSION_FILE="./test.vim"
TIMES_FILE="./times"

function finish() {
  rm -f $LOG_FILE $SESSION_FILE $TIMES_FILE
}

function measure_startup_time() {
  echo "autocmd VimEnter * qall" >$SESSION_FILE
  nvim --headless --startuptime $LOG_FILE -S $SESSION_FILE
  local t
  t=$(grep "NVIM STARTED" $LOG_FILE | awk '{print $1}')
  echo "$t" >>$TIMES_FILE
  echo "Run $1: ${t}ms"
  rm -f $LOG_FILE $SESSION_FILE
}

function calculate_average_time() {
  total_time=$(paste -s -d '+' $TIMES_FILE | bc | awk -F. '{print $1}')
  average_time=$((total_time / MEASUREMENT_COUNT))
  fast_time=$(sort -n $TIMES_FILE | head -n 1)
  slow_time=$(sort -n $TIMES_FILE | tail -n 1)
  standard_deviation=$(awk -v avg=$average_time '{sum+=($1-avg)^2} END {print sqrt(sum/NR)}' $TIMES_FILE)

  echo "Average time: ${average_time}ms"
  echo "Fastest time: ${fast_time}ms"
  echo "Slowest time: ${slow_time}ms"
  echo "Standard Deviation: ${standard_deviation}ms"
}

trap finish EXIT

for i in $(seq 1 $MEASUREMENT_COUNT); do
  measure_startup_time "$i"
done

printf "\n----\n\n"

calculate_average_time
