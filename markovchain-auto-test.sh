#!/bin/bash

test_failed=false
TIMEOUT_SECONDS=30

# ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
MAGENTA='\033[1;35m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

UNCHECKED="${WHITE}▢${RESET}"
CHECKED="${GREEN}▣${RESET}"


INPUT_FILE="the_great_gatsby.txt"
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}Error: Input file $INPUT_FILE not found${RESET}"
    exit 1
fi

list_all() {
    echo -e "${CYAN}Test Cases for Markov Chain Program${RESET}\n"

    printf "${BOLD}${BLUE}%-5s %-60s${RESET}\n" "No." "Command"
    printf "${BOLD}${BLUE}%-5s %-60s${RESET}\n" "----" "------------------------------------------------------------"

    printf "${YELLOW}%-5s${RESET} %s\n"  "1."  "./markovchain"
    printf "${YELLOW}%-5s${RESET} %s\n"  "2."  "cat $INPUT_FILE | ./markovchain"
    printf "${YELLOW}%-5s${RESET} %s\n"  "3."  "cat $INPUT_FILE | ./markovchain -w 10000 | wc -w"
    printf "${YELLOW}%-5s${RESET} %s\n"  "4."  "cat $INPUT_FILE | ./markovchain -w 0"
    printf "${YELLOW}%-5s${RESET} %s\n"  "5."  "cat $INPUT_FILE | ./markovchain -w 10001"
    printf "${YELLOW}%-5s${RESET} %s\n"  "6."  "cat $INPUT_FILE | ./markovchain -l 0"
    printf "${YELLOW}%-5s${RESET} %s\n"  "7."  "cat $INPUT_FILE | ./markovchain -l 6"
    printf "${YELLOW}%-5s${RESET} %s\n"  "8."  "cat $INPUT_FILE | ./markovchain -l 2"
    printf "${YELLOW}%-5s${RESET} %s\n"  "9."  "cat $INPUT_FILE | ./markovchain -p \"NOT FOUND PREFIX\""
    printf "${YELLOW}%-5s${RESET} %s\n" "10." "cat $INPUT_FILE | ./markovchain -p \"Chapter 3\""
    printf "${YELLOW}%-5s${RESET} %s\n" "11." "cat $INPUT_FILE | ./markovchain -p \"Chapter\""
    printf "${YELLOW}%-5s${RESET} %s\n" "12." "echo \"Ha ha he he\" | ./markovchain"
    printf "${YELLOW}%-5s${RESET} %s\n" "13." "echo \"Ha ha he he\" | ./markovchain -w 4"
    printf "${YELLOW}%-5s${RESET} %s\n" "14." "echo \"Ha ha he he\" | ./markovchain -w 3"
    printf "${YELLOW}%-5s${RESET} %s\n" "15." "echo \"Ha ha he he\" | ./markovchain -w 1"
    printf "${YELLOW}%-5s${RESET} %s\n" "16." "echo \"Ha ha he he\" | ./markovchain -l 3"
    printf "${YELLOW}%-5s${RESET} %s\n" "17." "echo \"Ha ha he he\" | ./markovchain -l 4"
    printf "${YELLOW}%-5s${RESET} %s\n" "18." "echo \"Ha ha he he\" | ./markovchain -l 2"
    printf "${YELLOW}%-5s${RESET} %s\n" "19." "echo \"Ha\" | ./markovchain"
    printf "${YELLOW}%-5s${RESET} %s\n" "20." "echo \"\" | ./markovchain"
    printf "${YELLOW}%-5s${RESET} %s\n" "21." "echo \"Ha ha he he\" | ./markovchain -p \"he he\""
    printf "${YELLOW}%-5s${RESET} %s\n" "22." "echo \"Ha ha he he\" | ./markovchain -p \"ha he\""
    printf "${YELLOW}%-5s${RESET} %s\n" "23." "echo \"Ha ha he he\" | ./markovchain -p \"ha he\" -l 2"
    printf "${YELLOW}%-5s${RESET} %s\n" "24." "echo \"Ha ha he he\" | ./markovchain -p \"he\" -l 2"
}

print_help() {
    echo -e "${CYAN}Usage: $0 [option]${RESET}"
    echo
    echo -e "${MAGENTA}Options:${RESET}"
    echo -e "  ${YELLOW}empty arg${RESET}        Run all test cases"
    echo -e "  ${YELLOW}list${RESET}       List all test cases"
    echo -e "  ${YELLOW}help${RESET}       Show this help message"
    echo -e "  ${YELLOW}questions${RESET}   Show questions"
}

questions() {
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════════════════${RESET}"
  echo -e "${BOLD}${WHITE}                   Markov Chain Program Evaluation${RESET}"
  echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════════════════${RESET}"

  echo -e "\n${BOLD}${WHITE}## Program functionality\n${RESET}"

  echo -e "${CYAN}### The program prints generated text according to the Markov Chain algorithm.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program uses default settings: prefix length of 2 words, suffix length of 1 word, starting with the first N words of the text, and maximum of 100 words.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program prints an error message and stops generating text upon encountering an error.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program limits the generated text to the specified number of words.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program prints an error message if the specified number is negative or greater than 10,000.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program generates text starting with the specified prefix if it is present in the original text.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program prints an error message if the specified prefix is not present in the original text.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program generates text using the specified prefix length.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### The program prints usage information when requested.${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "\n${BOLD}${WHITE}\n## Project presentation and code defense\n${RESET}"

  echo -e "${CYAN}### Can the team clearly explain their code, logic, and design choices during the presentation?${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### Can the team effectively answer questions about their code and the decisions they made?${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "${CYAN}### Can the team restore the code if you delete part of it?${RESET}"
  echo -e "  - $UNCHECKED Yes"
  echo -e "  - $UNCHECKED No"

  echo -e "\n${BOLD}${WHITE}\n## Detailed feedback\n${RESET}"

  echo -e "${BLUE}### What was great? What did you like the most about the program and the team performance?${RESET}"
  echo -e "  "

  echo -e "${BLUE}### What could be better? How those improvements could positively impact the outcome?${RESET}"
  echo -e "  "
}

if [[ "$1" == "list" || "$1" == "list-all" || "$1" == "--list" || "$1" == "--list-all" || "$1" == "-l" || "$1" == "--list" || "$1" == "l" ]]; then
    list_all
    exit 0
fi

if [[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" || "$1" == "h" ]]; then
    print_help
    exit 0
fi

if [[ "$1" == "questions" || "$1" == "--questions" || "$1" == "questions" || "$1" == "-q" || "$1" == "--questions" || "$1" == "q" ]]; then
    questions
    exit 0
fi

print_pass() {
    echo -e "[${GREEN}PASS${RESET}] $1"
}

print_fail() {
    echo -e "[${RED}FAIL${RESET}] $1"
}

print_crit_fail() {
    echo -e "[${MAGENTA}CRIT_FAIL${RESET}] $1"
}

print_timeout() {
    echo -e "[${YELLOW}TIMEOUT${RESET}] $1"
}

# Verifies command output and exit status with flexible matching
verify_output() {
    local expected_output_pattern="$1"
    local actual_output="$2"
    local expected_status="$3"
    local actual_status="$4"
    local test_case="$5"
    local timeout_occurred="$6"

    if [ "$timeout_occurred" = "true" ]; then
        print_timeout "Test case $test_case: Command timed out after ${TIMEOUT_SECONDS} seconds"
        test_failed=true
        return 1
    fi

    if [[ "$actual_output" == *"panic"* ]] || [ "$actual_status" -eq 2 ]; then
        print_crit_fail "Test case $test_case: Program panicked or critical failure (exit status 2)"
        echo -e "${YELLOW}Output:${RESET} $actual_output"
        test_failed=true
        return 1
    fi

    if [ "$expected_status" -eq 1 ]; then
        if [ "$actual_status" -ne 0 ] && [ "$actual_status" -ne 1 ]; then
            print_fail "Test case $test_case: Expected exit status ~0/1 (error), got $actual_status"
            echo -e "${YELLOW}Output:${RESET} $actual_output"
            test_failed=true
            return 1
        fi
    elif [ "$actual_status" -ne "$expected_status" ]; then
        print_fail "Test case $test_case: Expected exit status $expected_status, got $actual_status"
        echo -e "${YELLOW}Output:${RESET} $actual_output"
        test_failed=true
        return 1
    fi

    if [ -n "$expected_output_pattern" ]; then
        if echo "$actual_output" | grep -Ei "$expected_output_pattern" > /dev/null; then
            print_pass "Test case $test_case: Output matches expected pattern"
        else
            print_fail "Test case $test_case: Output doesn't match expected pattern"
            echo -e "${YELLOW}Expected pattern:${RESET} $expected_output_pattern"
            echo -e "${YELLOW}Actual:${RESET} $actual_output"
            test_failed=true
            return 1
        fi
    else
        print_pass "Test case $test_case: Command executed successfully"
    fi
}



# Runs a command with timeout and captures output/exit status
run_command() {
    local cmd="$1"
    local input="$2"
    local output_file=$(mktemp)
    local status_file=$(mktemp)
    local timeout_occurred=false

    if [ -n "$input" ]; then
        echo "$input" | timeout --signal=SIGTERM $TIMEOUT_SECONDS bash -c "$cmd" > "$output_file" 2>&1
    else
        timeout --signal=SIGTERM $TIMEOUT_SECONDS bash -c "$cmd" > "$output_file" 2>&1
    fi

    local exit_status=$?
    if [ $exit_status -eq 124 ]; then
        timeout_occurred=true
    fi
    echo $exit_status > "$status_file"

    cat "$output_file"
    echo "__EXIT_STATUS__$(cat "$status_file")__TIMEOUT__$timeout_occurred"
    rm "$output_file" "$status_file"
}

# Test cases
test_case_1() {
    local test_case="1"
    local cmd="./markovchain"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "no input" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_2() {
    local test_case="2"
    local cmd="cat $INPUT_FILE | ./markovchain"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Chapter" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_3() {
    local test_case="3"
    local cmd="cat $INPUT_FILE | ./markovchain -w 10000 | wc -w"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "[0-9]+" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_4() {
    local test_case="4"
    local cmd="cat $INPUT_FILE | ./markovchain -w 0"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "([a-zA-Z].*){5,}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_5() {
    local test_case="5"
    local cmd="cat $INPUT_FILE | ./markovchain -w 10001"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "([a-zA-Z].*){5,}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_6() {
    local test_case="6"
    local cmd="cat $INPUT_FILE | ./markovchain -l 0"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "([a-zA-Z].*){5,}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_7() {
    local test_case="7"
    local cmd="cat $INPUT_FILE | ./markovchain -l 6"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "([a-zA-Z].*){5,}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_8() {
    local test_case="8"
    local cmd="cat $INPUT_FILE | ./markovchain -l 2"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Chapter 1" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_9() {
    local test_case="9"
    local cmd="cat $INPUT_FILE | ./markovchain -p \"NOT FOUND PREFIX\""
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')

    verify_output "([a-zA-Z].*?){5}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}


test_case_10() {
    local test_case="10"
    local cmd="cat $INPUT_FILE | ./markovchain -p \"Chapter 3\""
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Chapter 3" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_11() {
    local test_case="11"
    local cmd="cat $INPUT_FILE | ./markovchain -p \"Chapter\""
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "([a-zA-Z].*){5,}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_12() {
    local test_case="12"
    local cmd="./markovchain"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha ha he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_13() {
    local test_case="13"
    local cmd="./markovchain -w 4"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha ha he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_14() {
    local test_case="14"
    local cmd="./markovchain -w 3"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha ha he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_15() {
    local test_case="15"
    local cmd="./markovchain -w 1"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_16() {
    local test_case="16"
    local cmd="./markovchain -l 3"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha ha he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_17() {
    local test_case="17"
    local cmd="./markovchain -l 4"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha ha he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_18() {
    local test_case="18"
    local cmd="./markovchain -l 2"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "Ha ha he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_19() {
    local test_case="19"
    local cmd="./markovchain"
    local result=$(run_command "$cmd" "Ha")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "input text is too short" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_20() {
    local test_case="20"
    local cmd="./markovchain"
    local result=$(run_command "$cmd" "")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "no input" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_21() {
    local test_case="21"
    local cmd="./markovchain -p \"he he\""
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "([a-zA-Z].*?){5}" "$actual_output" 1 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_22() {
    local test_case="22"
    local cmd="./markovchain -p \"ha he\""
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "ha he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_23() {
    local test_case="23"
    local cmd="./markovchain -p \"ha he\" -l 2"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "ha he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_24() {
    local test_case="24"
    local cmd="./markovchain -p \"he\" -l 2"
    local result=$(run_command "$cmd" "Ha ha he he")
    local actual_output=$(echo "$result" | sed -n '/__EXIT_STATUS__/q;p')
    local exit_status=$(echo "$result" | grep -oP '__EXIT_STATUS__\K\d+')
    local timeout_occurred=$(echo "$result" | grep -oP '__TIMEOUT__\K\w+')
    verify_output "he he" "$actual_output" 0 "$exit_status" "$test_case" "$timeout_occurred"
}

test_case_25() {

    result=$(gofmt -l .)

    if [ -n "$result" ]; then
        print_fail "GoFmt check failed. Files need formatting fixes."

        echo -e "${YELLOW}Files with formatting issues:${RESET}"
        echo "$result"

        echo "Auto-fixing formatting errors with gofmt..."
        gofmt -w . 

        print_fail "Test case failed due to GoFmt issues."
    else
        print_pass "GoFmt check passed. All files are properly formatted."
    fi
}

echo -e "${CYAN}Running Markov Chain Tests${RESET}"
echo

for i in {1..25}; do
    test_case_$i
done

echo
echo -e "\n\e[1m\e[34m+-------------------------------------------+\e[0m"
echo -e "\e[1m\e[34m|       The tool was made by mromanul.      |\e[0m"
echo -e "\e[1m\e[34m+-------------------------------------------+\e[0m\n"
if [ "$test_failed" = false ]; then
    echo -e "${GREEN}Unbelievable! All tests passed successfully!${RESET}"
    exit 0
else
    echo -e "${RED}Some tests failed  |  To display all test cases, run \033[1m\033[32m./example.sh list\033[0m${RESET}"
    exit 1
fi
