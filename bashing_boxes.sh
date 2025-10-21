#!/bin/bash




Random_Object=("Napkin" "Shower" "Necklace" "Snow blower" "Cookie jar" "Crib" "Saucepan" "Stove" "Cooler" "Corn")
 
 print_list() {
    echo "List of items:"
    echo "${Random_Object[@]}"
}
 print_item() {
    read -p "Which item would you like to use? (0-9): " index
    echo "Your item is: ${Random_Object[$index]}"
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
Exit() {
    
    :
}


echo ""
echo "Menu"
echo "Print_list 1"
echo "Print out a specific item at a specific position 2"
echo "Add item 3"
echo "Remove the last item 4"
echo "Remove a specific item from a specific position 5"
echo "Exit 6"
echo ""

read -p "What option do you want to choose? (1-6): " answer

if [[ "$answer" == "1" ]]; then
    print_list
elif [[ "$answer" == "2" ]]; then
    print_item
elif [[ "$answer" == "3" ]]; then
    Add_item
elif [[ "$answer" == "4" ]]; then
    remove_last_item
elif [[ "$answer" == "5" ]]; then
    remove_item_from_position
elif [[ "$answer" == "6" ]]; then 
    echo "Thanks for playing!"
    exit
fi




