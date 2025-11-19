#!/bin/bash

Random_Object=("Grey" "Black" "Red" "Blue" "White" "Green" "Yellow" "Purple" "Pink" "Orange" "Brown")
answer="Error: user input not captured"
object_pool=()

object_pool_file="warehouse_of_object.txt"


# Function prints out the full array
print_list() {
    echo "List of items:"
    for item in "${Random_Object[@]}"; do
        echo "$item"
    done
}

# Function prints out the word that matches with the number picked by the user (0 being the first one and 9 being the last one)
print_item() {
    read -p "Which item would you like to use? (0-9): " index
    if [[ $index -ge 0 && $index -lt ${#Random_Object[@]} ]]; then
        echo "Your item is: ${Random_Object[$index]}"
    else
        echo "Invalid index."
    fi
}

# This function adds whatever the user puts then prints out my array with the added word
Add_item() {
    read -p "Enter item to add: " new_item
    Random_Object+=("$new_item")
    echo "Item '$new_item' added."
    echo "${Random_Object[@]}"
}

# This function removes the last word in the array then prints out the new list without the last word
remove_last_item() {
    unset "Random_Object[${#Random_Object[@]}-1]"
    echo "The list of items now is:"
    echo "${Random_Object[@]}"
}

# This function removes the word that matches with the number that the user picks then prints out a new list with the word removed
remove_item_from_position() {
    read -p "What item would you like to remove? (0-9): " item_to_remove
    if [[ $item_to_remove -ge 0 && $item_to_remove -lt ${#Random_Object[@]} ]]; then
        unset "Random_Object[$item_to_remove]"
        echo "Item at index $item_to_remove removed."
        echo "${Random_Object[@]}"
    else
        echo "Please choose a number between (0-9)"
    fi
}

# This function checks to see if you put in a valid option for the code then prints out and creates the file while putting in the Data directory  
Save_Current_Files() {
    echo "Enter a name for the save file:"
    read filename
    if [ -z "$filename" ]; then
        echo "Invalid filename."
        return
    fi

    mkdir -p "Data"
    echo "Saving box to data/$filename.txt..."
    printf "%s\n" "${Random_Object[@]}" > "Data/$filename.txt"
    echo "Box saved"
}

# This function loads a previous already created file and loads them with the array 
Load_previous_saved_box() {
    echo "Choose a file to load or type 'list' to see available files:"
    read filename

    if [ "$filename" == "list" ]; then
        List_exisiting_saved_box
        return
    fi

    if [ -f "Data/$filename.txt" ]; then
        echo "Loading box from $filename..."
        mapfile -t Random_Object < "Data/$filename.txt"
        echo "Box loaded successfully!"
    else
        echo "File does not exist. Please try again."
    fi
}

# This function checks the Data folder for saved boxes
List_exisiting_saved_box() {
    echo "Saved boxes:"
    if [ "$(ls -A Data)" ]; then 
        ls "Data"/*.txt
    else
        echo "No saved boxes found."
    fi
}

# This function removes saved files  
Delete_saved_box() {
    echo "Enter the filename to delete (without .txt extension):"
    read filename
    if [ -f "Data/$filename.txt" ]; then
        rm "Data/$filename.txt"
        echo "Box $filename deleted successfully!"
    else
        echo "File not found!"
    fi
}

# Load object pool from file
load_object_pool() {
    object_pool=()  # Clear current object pool

    if [ ! -f "$object_pool_file" ]; then
        echo "File not found: $object_pool_file"
        return 1  # Return failure if the file doesn't exist
    fi 

    while read -r line; do 
        if [[ -z "$line" || "$line" == \#* ]]; then 
            continue  # Skip empty lines or comments
        fi 
        object_pool+=("$line")
    done < "$object_pool_file"

    if [ ${#object_pool[@]} -eq 0 ]; then
        echo "Error: object pool is empty after loading. Check the file content."
    else
        echo "Object pool loaded successfully with ${#object_pool[@]} items."
    fi
}

generate_random_box() {
    local size=$1
    echo "Generating random box with $size items."
    
    if [ ${#object_pool[@]} -eq 0 ]; then
        echo "Error: object pool is empty. Please load the object pool first."
        return 1  # Exit the function if object pool is empty
    fi

    random_box=()

    for (( i=0; i<size; i++ )); do
        random_box+=("${object_pool[$((RANDOM % ${#object_pool[@]}))]}")  # Select a random item
    done

    echo "Random box generated:"
    echo "${random_box[@]}"
}


# Prompt for box size and generate a random box
prompt_for_box_size() {
    read -p "What size do you want the box to be? " box_size
    echo "Size selected: $box_size"
    
    generate_random_box "$box_size"
}


# This function checks if you want to save before exiting
exit_prompt() {
    echo "Would you like to save before exiting? (y/n)"
    read answer
    if [ "$answer" == "y" ]; then
        Save_Current_Files
    fi
    echo "Goodbye!"
    exit 0
}

# This function displays the main menu
display_main_menu() {
    echo -e "
   Menu
    
    1) Print list

    2) Print out a specific item at a specific position

    3) Add item

    4) Remove the last item

    5) Remove a specific item from a specific position

    6) Save current box to file

    7) Load a saved box

    8) List existing saved boxes

    9) Delete a saved box
   
    10) prompt_for_box_size

    11) load_object_pool 

    12) Exit"
    
    get_user_input "Please select an option: "
    check_main_menu_options
}

# This function gets the user's input and handles the prompt
get_user_input() {
    display_text="${1:-Please select an option: }"
    read -p "$display_text" answer
}

# This function holds the case structure to call the appropriate function based on user choice
check_main_menu_options() {
    case $answer in
        1) print_list ;;
        2) print_item ;;
        3) Add_item ;;
        4) remove_last_item ;;
        5) remove_item_from_position ;;
        6) Save_Current_Files ;;
        7) Load_previous_saved_box ;;
        8) List_exisiting_saved_box ;;
        9) Delete_saved_box ;;
        10) prompt_for_box_size ;;
        11) load_object_pool ;;
        12) exit_prompt ;;
        *) echo "Invalid Choice: $answer" 
           display_main_menu
           ;;
    esac
}

# Main script starts here
display_main_menu
