#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
GREEN1='\033[1;32m'
YELLOW='\033[1;33m'
YELLOW1='\033[0;33m'
NC='\033[0m' # No Color

#title
echo -ne "\033]0;IP Extractor\007"

#form
echo "======================"
echo -e "${YELLOW}Select extract format${NC}"
echo "======================"
echo -e "${GREEN}1) IP${NC}"
echo -e "${GREEN}2) IP:Port${NC}"

#input
while true; do
  read -p ":" format

  if ! echo "$format" | grep -qE '^[0-9]+$'; then
    echo -e "${RED}Error: Input is not a number!${NC}"
    continue
  fi

  if [ "$format" -eq 1 ] || [ "$format" -eq 2 ]; then
    break
  else
    echo -e "${RED}Error: please enter 1 or 2 only${NC}"
  fi
done

#process
if [ "$format" -eq 1 ] ; then
  read -p "Enter your IP file path: " target
  if [[ ! -f "$target" ]]; then
      echo -e "${RED}File not found!${NC}"
      exit 1
  fi

  echo -e "${YELLOW1}Processing file...${NC}"
  awk 'NR > 2{print $4}' "$target" > extracted-ip.txt
  sleep 2
  echo -e "${GREEN1}done! Output saved to >>> extracted-ip.txt${NC}"
  exit 0
elif [ "$format" -eq 2 ] ; then 
  read -p "Enter your IP file path: " target
  if [[ ! -f "$target" ]]; then
        echo -e "${RED}File not found!${NC}"
        exit 1
  fi

  echo -e "${YELLOW1}Processing file...${NC}"
  awk 'NR > 2 {split($7,port,"/"); print $4":"port[1]}' "$target" > extracted-ip:port.txt
  sleep 2
  echo -e "${GREEN1}done! Output saved to >>> extracted-ip:port.txt${NC}"
  exit 0
fi
echo -ne "\033]0;Terminal\007"
exit 0
