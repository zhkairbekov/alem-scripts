#!/bin/bash


test_failed=false

GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
RESET="\033[0m"
MAGENTA="\033[35m"

print_pass() {
    echo -e "[${GREEN}PASS${RESET}] $1"
}

print_fail() {
    echo -e "[${RED}FAIL${RESET}] $1"
}

check_panic() {
    local output=$1
    local test_case=$2

    if [[ "$output" == *"panic"* ]]; then
        echo -e "[${MAGENTA}CRIT FAIL${RESET}] Test case $test_case: Program panicked."
        echo -e "${YELLOW}Actual output:${RESET} $output"
        test_failed=true
        return 1 
    fi
    return 0  
}

verify_output() {
    local expected=$1
    local actual=$2
    local test_case=$3

    if ! check_panic "$actual" "$test_case"; then
        return 
    fi

    if [[ "$actual" == *"$expected"* ]]; then
        print_pass "Test case $test_case: Output contains the word: $expected."
    else
        print_fail "Test case $test_case: Output did not contain the word: $expected."
        echo -e "${YELLOW}Actual output:${RESET} $actual"
        test_failed=true
    fi
}

list_tests() {
    echo -e "${CYAN}Test Cases for Review${RESET}"
    echo
    echo -e "${YELLOW}1.${RESET} ./creditcard validate \"4400430180300003\""
    echo
    echo -e "${YELLOW}2.${RESET} ./creditcard validate \"4400430180300002\""
    echo
    echo -e "${YELLOW}3.1 / 3.2:${RESET} ./creditcard validate \"4400430180300003\" \"4400430180300011\""
    echo
    echo -e "${YELLOW}4.${RESET} echo \"4400430180300003\" | ./creditcard validate --stdin"
    echo
    echo -e "${YELLOW}5.${RESET} ./creditcard generate \"440043018030****\" | ./creditcard validate --stdin"
    echo
    echo -e "${YELLOW}6.${RESET} ./creditcard validate \"4400430180300002\" \"4400430180300003\" \"\" \"4400430180300011\""
    echo
    echo -e "${YELLOW}7.${RESET} ./creditcard generate --pick \"44004301803\""
    echo
    echo -e "${YELLOW}8.${RESET} ./creditcard generate --pick \"440043018*03****\""
    echo
    echo -e "${YELLOW}9.1 / 9.2 / 9.3:${RESET} ./creditcard generate --pick \"440043018030****\" | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin"
    echo
    echo -e "${YELLOW}10.${RESET} ./creditcard"
    echo
    echo -e "${YELLOW}11.${RESET} echo 440043018030*** | ./creditcard generate --pick --stdin"
    echo
    echo -e "${YELLOW}12.${RESET} ./creditcard validate \"\""
    echo
    echo -e "${YELLOW}13.${RESET} ./creditcard validate \"4400 4301 8030 0003\""
    echo
    echo -e "${YELLOW}14.${RESET} ./creditcard generate \"4400430180300003\""
    echo
    echo -e "${YELLOW}15.${RESET} ./creditcard issue --brands=brands.txt --issuers=issuers.txt --brand=VISA --issuer=\"Kaspi Gold\""
    echo
    echo -e "${YELLOW}16.${RESET} ./creditcard validate \"44004301803\""
    echo
    echo -e "${YELLOW}17.${RESET} ./creditcard generate --pick \"4400430180****\""
    echo
    echo -e "${YELLOW}18.${RESET} ./creditcard generate --pick \"440043018030****\""
    echo
    echo -e "${YELLOW}19.${RESET} ./creditcard generate \"4400430180300003\""
    echo
    echo -e "${YELLOW}20.${RESET} echo \"\" | ./creditcard validate --stdin"
    echo
    echo -e "${YELLOW}21.${RESET} ./creditcard generate --pick \"44004306667"$?"*\""
    echo
    echo -e "${YELLOW}22.${RESET} ./creditcard generate --pick \"44004301803*****\""
    echo
    echo -e "${YELLOW}23.${RESET} ./creditcard generate --pick \"44004301803\" \"44004301803\""
    echo
    echo -e "${YELLOW}24.${RESET} ./creditcard generate --pick \"440*04*30*183*\""
    echo
    echo -e "${YELLOW}25.${RESET} ./creditcard generate --pick \"44004301803*d**\""
    echo
    echo -e "${YELLOW}26.${RESET} ./creditcard generate --pick \"44004301803*****\" | ./creditcard validate --stdin"
    echo
    echo -e "${YELLOW}27.${RESET} ./creditcard generate --pick \"44004301803*** *\""
    echo
    echo -e "${YELLOW}28.${RESET} ./creditcard generate 440043018030**** | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin"
    echo
    echo -e "${YELLOW}29.${RESET} ./creditcard generate --pick \"44004301803\" \"44004301803\" | ./creditcard validate --stdin | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin"
    echo
    echo -e "${YELLOW}30.${RESET} ./creditcard issue information --issuers=issuers.txt --brands=brands.txt --brand=\"VISA\" --issuer=\"Kaspi Gold\" generate 44004400440044**"
    echo
    echo -e "${YELLOW}31.${RESET} ./creditcard issue --brands=\"brands2.txt\" --issuers=\"issuers2.txt\" --brand=Alem --issuer=\"School\""
    echo
    echo -e "${YELLOW}32.${RESET} ./creditcard issue --brands=\"brands2.txt\" --issuers=\"issuers2.txt\" --brand=Alem --issuer=\"School\" // оба файлы пусты"
    echo
    echo -e "${YELLOW}33.${RESET} ./creditcard issue --brands=\"brands2.txt\" --issuers=\"issuers2.txt\" --brand=Alem --issuer=\"School\" // Alem: School:7772332  разные префиксы"
    echo
    echo -e "${YELLOW}34.${RESET} ./creditcard issue --brands=\"brands2.txt\" --issuers=\"issuers2.txt\" --brand=Alem --issuer=\"School\" // Alem:asda School:"
    echo
    echo -e "${YELLOW}35.${RESET} ./creditcard issue --brands=\"brands2.txt\" --issuers=\"issuers2.txt\" --brand=Alem --issuer=\"School\" // School:666666666666666666666666 Alem:666 длина неккоректная"
    echo
    echo -e "${YELLOW}36.${RESET} ./creditcard generate \"4400430180322*\""          // ожидает "44004301803227"
    echo
    echo -e "${YELLOW}37.${RESET} ./creditcard validate \"             44          004301803          0              0003                 \""
    echo 
    echo -e "${YELLOW}38.${RESET} ./creditcard validate 4400430180300003 "
}



if [[ "$1" == "list" ]]; then
    list_tests
    exit 0
fi


# Test case 1
test_validate_single_valid() {
    result=$(./creditcard validate "4400430180300003" 2>&1 || true)
    check_panic "$result" "1"
    verify_output "OK" "$result" "1"
}

# Test case 2
test_validate_single_invalid() {
    result=$(./creditcard validate "4400430180300002" 2>&1 || true)
    exit_status=$?

    check_panic "$result" "2"

    if [ -z "$result" ] || [[ "$result" =~ ^[[:space:]]*$ ]]; then
        print_fail "Test case 2: Expected non-empty output, but got empty or whitespace-only output."
        test_failed=true
        return
    fi

    if [ $exit_status -ne 0 ]; then
        print_fail "Test case 2: Expected exit status 1, but got $exit_status."
        test_failed=true
        return
    fi

    print_pass "Test case 2: Output is non-empty and exit status is 1."
}



# Test case 3.1
test_validate_multiple_31() {
    result=$(./creditcard validate "4400430180300003" "4400430180300011" 2>&1 || true)
    check_panic "$result" "3.1"
    verify_output "OK" "$result" "3.1"
}

# Test case 3.2
test_validate_multiple() {
    result=$(./creditcard validate "4400430180300003" "4400430180300011" 2>&1 || true)
    check_panic "$result" "3.2"
    verify_output "OK" "$result" "3.2"
}

# Test case 4
test_validate_stdin() {
    result=$(echo "4400430180300003" | ./creditcard validate --stdin 2>&1 || true)
    check_panic "$result" "4"
    verify_output "OK" "$result" "4"
}

# Test case 5
test_generate_and_validate_stdin() {
    generated_card=$(./creditcard generate "440043018030****" | ./creditcard validate --stdin 2>&1 || true)
    check_panic "$result" "5"
    verify_output "OK" "$generated_card" "5"
}

# Test case 6
test_invalid_validation_multiple() {
    output=$(./creditcard validate "4400430180300002" "4400430180300003" "" "4400430180300011" 2>&1)
    exit_status=$?

    check_panic "$output" "6"

    if [ $exit_status -eq 0 ]; then
        print_fail "Test case 6: Expected non-zero exit status, got 0"
        test_failed=true
        return
    fi

    
    if $test_failed; then
        return  
    fi

    verify_output "" "$output" "6"
}


# Test case 7
test_invalid_generate_pattern() {
    output=$(./creditcard generate --pick "44004301803" 2>&1)
    exit_status=$?

    check_panic "$output" "7"

    if [ $exit_status -eq 0 ]; then
        print_fail "Test case 7: Expected non-zero exit status, got 0"
        test_failed=true
        return
    fi

   
    if $test_failed; then
        return  
    fi

    verify_output "" "$output" "7"
}


# Test case 8
test_invalid_generate_pattern_asterisks() {
    output=$(./creditcard generate --pick "440043018*03****" 2>&1)
    exit_status=$?

    check_panic "$output" "8"

    if [ $exit_status -eq 0 ]; then
        print_fail "Test case 8: Expected non-zero exit status, got 0"
        test_failed=true
        return
    fi

    
    if $test_failed; then
        return  
    fi

    verify_output "" "$output" "8"
}

# Test case 9.1
test_generate_and_fetch_info_9_1() {
    generated_card_info=$(./creditcard generate --pick "440043018030****" | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin 2>&1 || true)
    check_panic "$generated_card_info"
    verify_output "yes" "$generated_card_info" "9.1"
}

# Test case 9.2
test_generate_and_fetch_info_9_2() {
    generated_card_info=$(./creditcard generate --pick "440043018030****" | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin 2>&1 || true)
    check_panic "$generated_card_info"
    verify_output "VISA" "$generated_card_info" "9.2"
}


# Test case 9.3
test_generate_and_fetch_info() {
    generated_card_info=$(./creditcard generate --pick "440043018030****" | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin 2>&1 || true)
    check_panic "$generated_card_info"
    verify_output "Kaspi Gold" "$generated_card_info" "9.3"
}


# Test case 10
test_no_params() {
    panic_detected="false"  
    output=$(./creditcard 2>&1)
    exit_status=$?

    if [ "$panic_detected" = "false" ]; then
        check_panic "$output" "10"
        if [ $? -eq 1 ]; then
            panic_detected="true" 
        fi
    fi

    if [ "$panic_detected" = "true" ]; then
        return
    fi

    if [ $exit_status -eq 0 ]; then
        if [ ${#output} -ge 20 ]; then
            verify_output "" "$output" "10"
            print_pass "Test case 10: Command succeeded with output longer than 20 characters"
        else
            print_fail "Test case 10: Output is too short (${#output} chars), expected at least 20"
            echo -e "${YELLOW}Actual output:${RESET} $output"
            test_failed=true
        fi
    elif [ $exit_status -ne 0 ]; then
        if [ -n "$output" ]; then
            verify_output "" "$output" "10"
            print_pass "Test case 10: Command failed with non-empty output as expected"
        else
            print_fail "Test case 10: Expected non-empty output for failed command"
            test_failed=true
        fi
    fi
}





# Test case 11
test_random_card_generation() {
    result=$(echo "440043018030***" | ./creditcard generate --pick --stdin 2>&1)
    exit_code=$?

    check_panic "$result" "11" 

    if [ $exit_code -ne 0 ]; then
        verify_output "$result" "$result" "11"
        test_failed=true
        return
    fi

    if ! [[ $result =~ ^[0-9[:space:]]+$ ]]; then
        verify_output "$result" "$result" "11"
        test_failed=true
        return
    fi

    verify_output "$result" "$result" "11"
}


# Test case 12
test_validate_empty_string() {
    result=$(./creditcard validate "" 2>&1)
    exit_code=$?

    check_panic "$result" "12"

    if [ $exit_code -eq 0 ]; then
        verify_output "$result" "$result" "12"
        test_failed=true
        return
    fi

    if [ -z "$result" ]; then
        verify_output "$result" "$result" "12"
        test_failed=true
        return
    fi

    verify_output "$result" "$result" "12"
}


# Test case 13
test_validate_with_spaces() {
    result=$(./creditcard validate "4400 4301 8030 0003" 2>&1 || true)
    check_panic "$result"
    verify_output "OK" "$result" "13"
}

# Test case 14
test_generate_invalid_pattern_no_asterisks() {
    result=$(./creditcard generate "4400430180300003" 2>&1)
    exit_code=$?

    check_panic "$result"

    if [ $exit_code -eq 0 ]; then
        print_fail "Test case 14: Command succeeded unexpectedly."
        test_failed=true
        return
    fi

    if [ -n "$result" ]; then
        print_pass "Test case 14: Invalid pattern without asterisk handled correctly with error output."
    else
        print_fail "Test case 14: No error message output for invalid pattern."
        test_failed=true
    fi
}



# Test case 15
test_generate_random_card_for_brand_issuer() {
    result=$(./creditcard issue --brands=brands.txt --issuers=issuers.txt --brand=VISA --issuer="Kaspi Gold" 2>&1 || true)
    check_panic "$result"
    verify_output "440043" "$result" "15"
}

# Test case 16
test_validate_invalid_format() {
    result=$(./creditcard validate "44004301803" 2>&1)
    exit_status=$?

    check_panic "$result" "16"

    if [ ${#result} -lt 8 ]; then
        print_fail "Test case 16: Output is too short (${#result} chars), expected at least 8."
        echo -e "${YELLOW}Actual output:${RESET} $result"
        test_failed=true
        return
    fi

    if [[ -z "$result" || "$result" =~ ^[[:space:]]*$ ]]; then
        print_fail "Test case 16: Expected non-empty output, but got an empty or whitespace-only output."
        test_failed=true
        return
    fi

    if [ $exit_status -ne 1 ]; then
        print_fail "Test case 16: Expected exit status 1, but got $exit_status."
        test_failed=true
        return
    fi

    print_pass "Test case 16: Output is non-empty and exit status is 1."
}


# Test case 17
test_generate_random_card_with_complex_pattern() {
    result=$(./creditcard generate --pick "4400430180****" 2>&1 || true)
    check_panic "$result" "17"
    verify_output "4400430180" "$result" "17"
}

# Test case 18
test_generate_and_validate_random_card() {
    random_card=$(./creditcard generate --pick "440043018030****" 2>&1 || true)
    
    check_panic "$random_card" "18"
    
    result=$(./creditcard validate "$random_card" 2>&1 || true)
    
    check_panic "$result"
    
    verify_output "OK" "$result" "18"
}


# Test case 19
test_generate_card_without_asterisks() {
    output=$(./creditcard generate "4400430180300003" 2>&1)
    exit_status=$?

    check_panic "$output" "19"

    if [ $exit_status -eq 0 ]; then
        print_fail "Test case 19 failed: Expected non-zero exit status, got 0"
        test_failed=true
        return
    fi

    check_panic "$output" "19"
    if $test_failed; then
        return  
    fi
    verify_output "" "$output" "19"

    if [ -z "$output" ]; then
        print_fail "Test case 19: Output was empty"
        test_failed=true
        return
    fi
}


# Test case 20
test_empty_stdin_validation() {
    result=$(echo "" | ./creditcard validate --stdin 2>&1)
    exit_code=$?

    check_panic "$result" "20"

    if [ $exit_code -eq 0 ]; then
        print_fail "Test case 20: Expected non-zero exit status, but got $exit_code."
        test_failed=true
        return
    fi

    if [ -n "$result" ]; then
        print_pass "Test case 20: Empty input via --stdin failed as expected with some output."
    else
        print_fail "Test case 20: Expected non-empty output, but got none."
        test_failed=true
    fi
}


# Test case 21
test_generate_card_with_pick() {
    output=$(./creditcard generate --pick "44004306667$?*" 2>&1)
    exit_status=$?

    check_panic "$output" "21"

    if [ $exit_status -ne 0 ]; then
        print_fail "Test case 21: Expected exit status 0, got $exit_status"
        test_failed=true
        return
    fi

    if [[ "$output" != "4400430666709" && "$output" != "4400430666717" ]]; then
        print_fail "Test case failed: Expected '4400430666709' or '4400430666717', got '$output'"
        test_failed=true
        return
    fi

    verify_output "$output" "$output" "21"
    
    if $test_failed; then
        return
    fi
}




# Test case 22
test_generate_invalid_pattern() {
    result=$(./creditcard generate --pick "44004301803*****" 2>&1)
    exit_code=$?

    check_panic "$random_card"

    if [ $exit_code -ne 0 ] && [ -n "$result" ]; then
        print_pass "Test case 22: Command failed with expected non-zero status and non-empty output."
    else
        if [ $exit_code -eq 0 ]; then
            print_fail "Test case 22: Command unexpectedly succeeded with zero exit status."
        elif [ -z "$result" ]; then
            print_fail "Test case 22: Command failed but output was unexpectedly empty."
        fi
        test_failed=true
    fi
}



test_gofmt() {

    result=$(gofmt -l .)

    if [ -n "$result" ]; then
        print_fail "GoFmt check failed. Files need formatting fixes."

        echo -e "${YELLOW}Files with formatting issues:${RESET}"
        echo "$result"

        echo "Auto-fixing formatting errors with gofmt..."
        gofmt -w . 

        test_failed=true

        print_fail "Test case failed due to GoFmt issues."
    else
        print_pass "GoFmt check passed. All files are properly formatted."
    fi
}

# Test case 23
test_generate_duplicate_pattern() {
    result=$(./creditcard generate --pick "44004301803" "44004301803" 2>&1)
    exit_code=$?

    check_panic "$result"

    if [ $exit_code -ne 0 ]; then
        if [ -n "$result" ]; then
            print_pass "Test case 23: Command failed as expected with non-zero status and some error output."
        else
            print_fail "Test case 23: Command failed with non-zero status, but output was empty."
            test_failed=true
        fi
    else
        print_fail "Test case 23: Command unexpectedly succeeded with zero exit status."
        test_failed=true
    fi
}





# Test case 24
test_generate_multiple_asterisks() {
    result=$(./creditcard generate --pick "440*04*30*183*" 2>&1)
    exit_code=$?

    check_panic "$random_card"

    if [ $exit_code -ne 0 ]; then
        if [ -n "$result" ]; then
            print_pass "Test case 24: Command failed as expected with non-zero status and some error output."
        else
            print_fail "Test case 24: Command failed with non-zero status, but output was empty."
            test_failed=true
        fi
    else
        print_fail "Test case 24: Command unexpectedly succeeded with zero exit status."
        test_failed=true
    fi
}

 # Test case 25
 test_generate_invalid_character() {
    result=$(./creditcard generate --pick "44004301803*d**" 2>&1)
    exit_code=$?

    check_panic "$random_card"

    if [ $exit_code -ne 0 ]; then
        if [ -n "$result" ]; then
            print_pass "Test case 25: Command failed as expected with non-zero status and some error output."
        else
            print_fail "Test case 25: Command failed with non-zero status, but output was empty."
            test_failed=true
        fi
    else
        print_fail "Test case 25: Command unexpectedly succeeded with zero exit status."
        test_failed=true
    fi
}

 # Test case 26
 test_generate_and_validate() {
    result=$(./creditcard generate --pick "44004301803*****" | ./creditcard validate --stdin 2>&1)
    exit_code=$?

    check_panic "$random_card"

    if [ $exit_code -ne 0 ]; then
        if [ -n "$result" ]; then
            print_pass "Test case 26: Command pipeline failed as expected with non-zero status and some error output."
        else
            print_fail "Test case 26: Command pipeline failed with non-zero status, but output was empty."
            test_failed=true
        fi
    else
        print_fail "Test case 26: Command pipeline unexpectedly succeeded with zero exit status."
        test_failed=true
    fi
}

# Test case 27
test_generate_card_of_fixed_length() {
    result=$(./creditcard generate --pick "44004301803*** *" 2>&1 || true)
    card_length=${#result}

    check_panic "$random_card"

    if [ "$card_length" -ge 15 ] && [[ "$result" =~ ^[0-9]+$ ]]; then
        print_pass "Test case 27: Generated card of expected length: $result"
    else
        print_fail "Test case 27: Expected card length 15 and only digits, but got $card_length"
        echo -e "${YELLOW}Generated card:${RESET} $result"
        test_failed=true
    fi
}


# Test case 28
test_generate_and_fetch_info_valid() {
    result=$(./creditcard generate 440043018030**** | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin 2>&1)
    exit_code=$?

    check_panic "$random_card"

    if [ $exit_code -eq 0 ]; then
    if [ -n "$result" ] && [ ${#result} -ge 100 ]; then
        print_pass "Test case 28: Command succeeded with expected non-empty output and at least 100 characters."
    else
        print_fail "Test case 28: Expected non-empty output with at least 100 characters, but got: $result"
        test_failed=true
    fi
else
    print_fail "Test case 28: Expected exit status 0, but got $exit_code."
    test_failed=true
fi

}



# Test case 29
test_generate_validate_and_fetch_info_invalid() {
    result=$(./creditcard generate --pick "44004301803" "44004301803" | ./creditcard validate --stdin | ./creditcard information --brands=brands.txt --issuers=issuers.txt --stdin 2>&1)
    exit_code=$?

    check_panic "$result"

    if [ $exit_code -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 29: Command chain failed with expected error output and exit status 1."
    else
        print_fail "Test case 29: Expected error output and exit status 1, but got status $exit_code and output: $result."
        test_failed=true
    fi
}


# Test case 30
test_invalid_command_order() {
    result=$(./creditcard issue information --issuers=issuers.txt --brands=brands.txt --brand="VISA" --issuer="Kaspi Gold" generate 44004400440044** 2>&1)
    exit_code=$?

    check_panic "$result"

    if [ $exit_code -ne 0 ] && [ -n "$result" ]; then
        print_pass "Test case 30: Invalid command order handled correctly with error."
    else
        print_fail "Test case 30: Invalid command order did not fail as expected."
        test_failed=true
    fi
}

# Test case 31
test_generate_card_with_custom_brands_and_issuers() {
    local brands_file="brands2.txt"
    local issuers_file="issuers2.txt"

    if [ -f "$brands_file" ]; then
        cp "$brands_file" "$brands_file.bak"
    fi
    if [ -f "$issuers_file" ]; then
        cp "$issuers_file" "$issuers_file.bak"
    fi

    echo "Alem:666" > "$brands_file"
    echo "School:7772332" > "$issuers_file"

    result=$(./creditcard issue --brands="$brands_file" --issuers="$issuers_file" --brand=Alem --issuer="School" 2>&1)
    exit_status=$?

    check_panic "$result" "31"

    if [ "$exit_status" -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 31: Generated card with custom brands and issuers - Error condition met"
    else
        print_fail "Test case 31: Expected exit status 1 and non-empty output, but got exit status $exit_status and output: '$result'"
        test_failed=true
    fi

    if [ -f "$brands_file.bak" ]; then
        mv "$brands_file.bak" "$brands_file"
    fi
    if [ -f "$issuers_file.bak" ]; then
        mv "$issuers_file.bak" "$issuers_file"
    fi
}


# Test case 32
test_generate_card_with_empty_files() {
    touch empty_file.txt empty_file2.txt

    result=$(./creditcard issue --brands=empty_file.txt --issuers=empty_file2.txt --brand=VISA --issuer="Kaspi Gold" 2>&1)
    exit_status=$?
    
    check_panic "$result"

    if [ "$exit_status" -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 32: Generated card with empty files - Error condition met"
    else
        print_fail "Test case 32: Expected exit status 1 and non-empty output, but got exit status $exit_status and output: '$result'"
        test_failed=true
    fi

    rm empty_file.txt empty_file2.txt
}

# Test case 33
test_generate_card_with_custom_brands_and_issuers_empty() {
    local brands_file="brands3.txt"
    local issuers_file="issuers3.txt"

    if [ -f "$brands_file" ]; then
        cp "$brands_file" "$brands_file.bak"
    fi
    if [ -f "$issuers_file" ]; then
        cp "$issuers_file" "$issuers_file.bak"
    fi

    echo "Alem:" > "$brands_file"
    echo "School:7772332" > "$issuers_file"

    result=$(./creditcard issue --brands="$brands_file" --issuers="$issuers_file" --brand=Alem --issuer="School" 2>&1)
    exit_status=$?

    check_panic "$result"

    if [ "$exit_status" -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 32: Generated card with custom brands and issuers - Error condition met"
    else
        print_fail "Test case 32: Expected exit status 1 and non-empty output, but got exit status $exit_status and output: '$result'"
        test_failed=true
    fi

    if [ -f "$brands_file.bak" ]; then
        mv "$brands_file.bak" "$brands_file"
    fi
    if [ -f "$issuers_file.bak" ]; then
        mv "$issuers_file.bak" "$issuers_file"
    fi

     rm -rf brands3.txt issuers3.txt
}


# Test case 33
test_generate_card_with_custom_brands_and_issuers_empty_2() {
    local brands_file="brands4.txt"
    local issuers_file="issuers4.txt"

    if [ -f "$brands_file" ]; then
        cp "$brands_file" "$brands_file.bak"
    fi
    if [ -f "$issuers_file" ]; then
        cp "$issuers_file" "$issuers_file.bak"
    fi

    echo "Alem:" > "$brands_file"
    echo "School:" > "$issuers_file"

    result=$(./creditcard issue --brands="$brands_file" --issuers="$issuers_file" --brand=Alem --issuer="School" 2>&1)
    exit_status=$?

    check_panic "$result"

    if [ "$exit_status" -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 33: Generated card with custom brands and issuers - Error condition met"
    else
        print_fail "Test case 33: Expected exit status 1 and non-empty output, but got exit status $exit_status and output: '$result'"
        test_failed=true
    fi

    if [ -f "$brands_file.bak" ]; then
        mv "$brands_file.bak" "$brands_file"
    fi
    if [ -f "$issuers_file.bak" ]; then
        mv "$issuers_file.bak" "$issuers_file"
    fi

    rm -rf brands4.txt issuers4.txt
}


# Test case 34
test_generate_card_with_custom_brands_and_issuers_with_str() {
    local brands_file="brands5.txt"
    local issuers_file="issuers5.txt"

    if [ -f "$brands_file" ]; then
        cp "$brands_file" "$brands_file.bak"
    fi
    if [ -f "$issuers_file" ]; then
        cp "$issuers_file" "$issuers_file.bak"
    fi

    echo "Alem:asda" > "$brands_file"
    echo "School:" > "$issuers_file"

    result=$(./creditcard issue --brands="$brands_file" --issuers="$issuers_file" --brand=Alem --issuer="School" 2>&1)
    exit_status=$?

    check_panic "$result"

    if [ "$exit_status" -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 34: Generated card with custom brands and issuers - Error condition met"
    else
        print_fail "Test case 34: Expected exit status 1 and non-empty output, but got exit status $exit_status and output: '$result'"
        test_failed=true
    fi

    if [ -f "$brands_file.bak" ]; then
        mv "$brands_file.bak" "$brands_file"
    fi
    if [ -f "$issuers_file.bak" ]; then
        mv "$issuers_file.bak" "$issuers_file"
    fi

    rm -rf brands5.txt issuers5.txt
}


# Test case 35
test_generate_card_with_custom_brands_and_issuers_incorrect_length() {
    local brands_file="brands6.txt"
    local issuers_file="issuers6.txt"
    local timeout_seconds=1

    if [ -f "$brands_file" ]; then
        cp "$brands_file" "$brands_file.bak"
    fi
    if [ -f "$issuers_file" ]; then
        cp "$issuers_file" "$issuers_file.bak"
    fi

    echo "Alem:666" > "$brands_file"
    echo "School:666666666666666666666666" > "$issuers_file" 

    result=$(timeout $timeout_seconds ./creditcard issue --brands="$brands_file" --issuers="$issuers_file" --brand=Alem --issuer="School" 2>&1)
    exit_status=$?

    check_panic "$result" "35"

    if [ $? -eq 124 ]; then
        print_fail "Test case timed out"
        return 1
    fi

    if [ "$exit_status" -eq 1 ] && [ -n "$result" ]; then
        print_pass "Test case 35: Generated card with custom brands and issuers - Error condition met"
    else
        print_fail "Test case 35: Expected exit status 1 and non-empty output, but got exit status $exit_status and output: '$result'"
        test_failed=true
    fi

    if [ -f "$brands_file.bak" ]; then
        mv "$brands_file.bak" "$brands_file"
    fi
    if [ -f "$issuers_file.bak" ]; then
        mv "$issuers_file.bak" "$issuers_file"
    fi

    rm -f "$brands_file" "$issuers_file" 
}


# Test case 36
test_generate_specific_pattern() {
    local expected_output="44004301803227"
    local result
    local exit_status

    result=$(./creditcard generate "4400430180322*" 2>&1)
    exit_status=$?

    if ! check_panic "$result" "Generate specific pattern"; then
        return
    fi

    if [[ $exit_status -ne 0 ]]; then
        print_fail "Test case 36: Generate specific pattern: Expected exit status 0, but got $exit_status."
        test_failed=true
        return
    fi

    if [[ "$result" == "$expected_output" ]]; then
        print_pass "Test case 36: Generate specific pattern: Output matches expected value exactly."
    else
        print_fail "Test case 36: Generate specific pattern: Output does not match expected value."
        echo -e "${YELLOW}Expected:${RESET} $expected_output"
        echo -e "${YELLOW}Actual:${RESET} $result"
        test_failed=true
    fi
}


# Test case 37
test_validate_with_spaces() {
    local result
    local exit_status

    result=$(./creditcard validate "             44          004301803          0              0003                 " 2>&1)
    exit_status=$?

    if ! check_panic "$result" "Validate with spaces"; then
        return
    fi

    if [[ $exit_status -ne 0 ]]; then
        print_fail "Test case 37: Validate with spaces: Expected exit status 0, but got $exit_status."
        test_failed=true
        return
    fi

    verify_output "OK" "$result" "Validate with spaces"
}


# Test case 38
test_validate_with_no_quotes() {
    local result
    local exit_status

    result=$(./creditcard validate 4400430180300003 2>&1)
    exit_status=$?

    if ! check_panic "$result" "38"; then
        return
    fi

    if [[ $exit_status -ne 0 ]]; then
        print_fail "Test case 38: Validate with empty quotes: Expected exit status 0, but got $exit_status."
        test_failed=true
        return
    fi

    verify_output "OK" "$result" "38"
}


# Test case 39
test_incorrect_value_of_flags() {
    result=$(./creditcard issue --brands=issuers.txt --issuers=brands.txt --brand="Kaspi Gold" --issuer="VISA" 2>&1)
    exit_status=$?

    if ! check_panic "$result" "39"; then
        return
    fi

    if [[ $exit_status -ne 0 ]]; then
        print_fail "Test case 39: Issue with changed names of files: Expected exit status 0, but got $exit_status."
        test_failed=true
        return
    fi

    verify_output "." "$result" "39"
    
}


# Test case 39.2
test_incorrect_value_of_flags_2() {
    result=$(./creditcard issue --brands=issuers.txt 2>&1)
    exit_status=$?

    if ! check_panic "$result" "39.2"; then
        return
    fi

    if [[ $exit_status -ne 1 ]]; then
        print_fail "Test case 39.2: issue with no arguments: Expected exit status 1, but got $exit_status."
        test_failed=true
        return
    fi

    verify_output "." "$result" "39.2"
    
}



echo "Running test cases for creditcard..."
echo

test_validate_single_valid
test_validate_single_invalid
test_validate_multiple_31
test_validate_multiple
test_validate_stdin
test_generate_and_validate_stdin
test_invalid_validation_multiple
test_invalid_generate_pattern
test_invalid_generate_pattern_asterisks
test_generate_and_fetch_info_9_1
test_generate_and_fetch_info_9_2
test_generate_and_fetch_info
test_no_params
test_random_card_generation
test_validate_empty_string
test_generate_invalid_pattern_no_asterisks
test_generate_random_card_for_brand_issuer
test_validate_invalid_format
test_generate_random_card_with_complex_pattern
test_generate_and_validate_random_card
test_generate_card_without_asterisks
test_empty_stdin_validation
test_generate_card_with_pick
test_generate_invalid_pattern
test_generate_duplicate_pattern
test_generate_multiple_asterisks
test_generate_invalid_character
test_generate_and_validate
test_generate_card_of_fixed_length
test_generate_and_fetch_info_valid
test_generate_validate_and_fetch_info_invalid
test_invalid_command_order
test_generate_card_with_custom_brands_and_issuers
test_generate_card_with_empty_files
test_generate_card_with_custom_brands_and_issuers_empty
test_generate_card_with_custom_brands_and_issuers_empty_2
test_generate_card_with_custom_brands_and_issuers_with_str
test_generate_card_with_custom_brands_and_issuers_incorrect_length
test_generate_specific_pattern
test_validate_with_spaces
test_validate_with_no_quotes
test_incorrect_value_of_flags
test_incorrect_value_of_flags_2
test_gofmt




wait

if [ "$test_failed" = true ]; then
    print_fail "Some tests failed  |  To display all test cases, run \033[1m\033[32m./example.sh list\033[0m"
else
    print_pass "All test cases completed successfully"
fi
echo -e "\n\e[1m\e[34m+-------------------------------------------+\e[0m"
echo -e "\e[1m\e[34m|       The tool was made by mromanul.      |\e[0m"
echo -e "\e[1m\e[34m+-------------------------------------------+\e[0m\n"


