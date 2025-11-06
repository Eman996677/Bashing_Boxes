#!/bin/bash

Random_Object=( "Grey" "Black" "Red" "Blue" "White" "Green" "Yellow" "Purple" "Pink" "Orange" "Brown")
answer="Error: user input not captured"

echo ${Random_Object[@]}
echo ${Random_Object[3]}
echo ${#Random_Object[@]}
    


#Function prints out the full array
print_list() {
    echo "List of items:"
    echo "${Random_Object[@]}"
}

#Function prints out the word that matches with the number picked by the user 0 being the first one and 9 being the last one
print_item() {
    read -p "Which item would you like to use? (0-9): " index
    if [[ $index -ge 0 && $index -lt ${#Random_Object[@]} ]]; then
        echo "Your item is: ${Random_Object[$index]}"
    else
        echo "Invalid index."
    fi
}

#This function adds whatever the users puts then prints out my array with the added word
Add_item() {
    read -p "Enter item to add: " new_item
    Random_Object+=("$new_item")
    echo "Item '$new_item' added."
    echo "${Random_Object[@]}"
}

#This function removes the last word in the array then prints out the new list without the last word
remove_last_item() {
    unset 'Random_Object[-1]'
    echo "The list of items now is:"
    echo "${Random_Object[@]}"
}

#This function removes the word that matches with the number that the user picks then prints out a new list with the word removed
remove_item_from_position() {
    read -p "What item would you like to remove? (0-9): " answer
    if [[ $answer -ge 0 && $answer -lt ${#Random_Object[@]} ]]; then
        unset "Random_Object[$answer]"
        echo "Item at index $answer removed."
        echo "${Random_Object[@]}"
    else
        echo "Please chose a number between (0-9)"
    fi
}

#This function checks to see if you put in a valid option for the code then prints out and creates the file while putting in the Data directory  
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

#This function 
Load_previous_saved_box() {
    echo "Choose a file to load from (or type 'list' to see saved files):"
    read filename

    if [ "$filename" == "list" ]; then
        List_exisiting_saved_box
        Load_previous_saved_box
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


List_exisiting_saved_box() {
    echo "Saved boxes:"
    if [ "$(ls -A Data)" ]; then
        ls "Data"/*.txt
    else
        echo "No saved boxes found."
    fi
}

 
Delete_saved_box() {
    echo "Enter the filename to delete (without extension):"
    read filename
    if [ -f "Data/$filename.txt" ]; then
        rm "Data/$filename.txt"
        echo "Box $filename deleted successfully!"
    else
        echo "File not found!"
    fi
}


exit_prompt() {
    echo "Would you like to save before exiting? (y/n)"
    read answer
    if [ "$answer" == "y" ]; then
        Save_Current_Files
    fi
    echo "Goodbye!"
    exit 0
}

display_main_menu(){
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

    10) Exit"
    

    get_user_input
    check_main_menu_options
}

get_user_input(){
    read -p "Please select an option: " answer
}

check_main_menu_options(){
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
        10) exit_prompt ;;
        *)  echo "Invalid Choice: " $answer
            display_main_menu
            ;;
    esac
}


display_main_menu


















