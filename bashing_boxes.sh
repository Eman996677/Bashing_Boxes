#!/bin/bash




#!/bin/bash

Random_Object=("Black" "Red" "Blue" "White" "Green" "Yellow" "Purple" "Pink" "Orange" "Brown")

print_list() {
    echo "List of items:"
    echo "${Random_Object[@]}"
}

print_item() {
    read -p "Which item would you like to use? (0-9): " index
    if [[ $index -ge 0 && $index -lt ${#Random_Object[@]} ]]; then
        echo "Your item is: ${Random_Object[$index]}"
    else
        echo "Invalid index."
    fi
}

Add_item() {
    read -p "Enter item to add: " new_item
    Random_Object+=("$new_item")
    echo "Item '$new_item' added."
    echo "${Random_Object[@]}"
}

remove_last_item() {
    unset 'Random_Object[-1]'  
    echo "The list of items now is:"
    echo "${Random_Object[@]}"
}

remove_item_from_position() {
    read -p "What item would you like to remove? (0-9): " answer
    if [[ $answer -ge 0 && $answer -lt ${#Random_Object[@]} ]]; then
        unset "Random_Object[$answer]"
        echo "Item at index $answer removed."
        echo "${Random_Object[@]}"
    else
        echo "Invalid index."
    fi
}
Save_Current_Files(){


}
Load_previous_saved_box(){


}
List_exisiting_saved_box(){


}

while true; do
    echo ""
    echo "Menu"
    echo "1) Print list"
    echo "2) Print out a specific item at a specific position"
    echo "3) Add item"
    echo "4) Remove the last item"
    echo "5) Remove a specific item from a specific position"
    echo "6) Exit"
    echo ""
    
    read -p "Please select an option: " answer

    case $answer in 
        1) print_list ;;
        2) print_item ;;
        3) Add_item ;;
        4) remove_last_item ;;
        5) remove_item_from_position ;;
        6)"" 
            echo "Thanks for Playing!"
            exit ;;
        *) 
            echo "Invalid Choice" ;;
    esac
done

















