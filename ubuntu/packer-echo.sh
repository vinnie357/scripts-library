#!/bin/bash
echo "---testing echo---"
ONE=${1:-${ONE_ENV:-"0.0.0"}}
TWO=${2:-${TWO_ENV:-"thing2"}}
echo "input1: $ONE"
echo "input2: $TWO"
echo "---echo done---"
