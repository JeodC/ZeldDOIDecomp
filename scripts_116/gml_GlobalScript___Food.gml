global.FoodNames = ["Cherries", "Blueberries", "Strawberry", "Kiwi", "Candy", "Lollypop", "Mushroom", "Apple", "Orange", "Pear", "Banana", "Carrot", "Potato", "Avocado", "Corn", "Watermelon", "Bananas", "Nuts", "Egg", "Cookie", "Milk", "Chocolate Milk", "Muffin", "Croissant", "Cheese", "Drumstick", "Pink Donut", "Chocolate Donut", "Popsicle", "Ice Cream Bar", "Energy Bar", "Lemon Tart", "Strawberry Cake Slice", "Chocolate Cake Slice", "Bacon & Eggs", "Sushi", "Fish", "Sandwich", "Broth", "Tomato Soup", "Salad", "Ramen", "Chili", "Pizza", "Hero Sandwich", "Burger", "Spaghetti", "Ham", "Strawberry Cake", "Chocolate Cake", "Chicken", "Golden Egg"];
global.FoodNames_Plural = ["Cherries", "Blueberries", "Strawberries", "Kiwis", "Candies", "Lollypops", "Mushrooms", "Apples", "Oranges", "Pears", "Bananas", "Carrots", "Potatoes", "Avocados", "Corns", "Watermelons", "Bananas", "Nuts", "Eggs", "Cookies", "Milks", "Chocolate Milks", "Muffins", "Croissants", "Cheeses", "Drumsticks", "Pink Donuts", "Chocolate Donuts", "Popsicles", "Ice Cream Bars", "Energy Bars", "Lemon Tarts", "Strawberry Cake Slices", "Chocolate Cake Slices", "Bacon & Eggs", "Sushi", "Fish", "Sandwiches", "Broths", "Tomato Soups", "Salads", "Ramen", "Chili", "Pizzas", "Hero Sandwiches", "Burgers", "Spaghetti", "Hams", "Strawberry Cakes", "Chocolate Cakes", "Chickens", "Golden Eggs"];
global.PopNames = ["Popsi", "Kitty Cola", "Gator Gush", "Grape Rush", "Alien NRG", "Mangoba", "Pinky Drinky", "Blue Goo", "Power Thirst", "Crantastic", "Omega Juice", "Berry Blast", "Brute Beer", "Orange Burst", "Tropic Sip", "Creamy Crush", "Dr.Drank", "Island Fizz", "Melon Slurp", "Bug Chug", "Kwench", "Burple", "Brite", "Quick Buzz", "Buzz Ale", "Korok Delight", "Minish Mix"];
global.PopFlavors = array_length(global.PopNames);
global.FoodClasses = [[UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_6, UnknownEnum.Value_4, UnknownEnum.Value_5], [UnknownEnum.Value_7, UnknownEnum.Value_8, UnknownEnum.Value_9, UnknownEnum.Value_10, UnknownEnum.Value_11, UnknownEnum.Value_12, UnknownEnum.Value_13, UnknownEnum.Value_17, UnknownEnum.Value_18, UnknownEnum.Value_19, UnknownEnum.Value_20, UnknownEnum.Value_38], [UnknownEnum.Value_16, UnknownEnum.Value_15, UnknownEnum.Value_14, UnknownEnum.Value_21, UnknownEnum.Value_22, UnknownEnum.Value_23, UnknownEnum.Value_24, UnknownEnum.Value_25, UnknownEnum.Value_26, UnknownEnum.Value_27, UnknownEnum.Value_28, UnknownEnum.Value_29, UnknownEnum.Value_31, UnknownEnum.Value_39, UnknownEnum.Value_40], [UnknownEnum.Value_30, UnknownEnum.Value_32, UnknownEnum.Value_33, UnknownEnum.Value_34, UnknownEnum.Value_35, UnknownEnum.Value_36, UnknownEnum.Value_37, UnknownEnum.Value_41, UnknownEnum.Value_42, UnknownEnum.Value_43], [UnknownEnum.Value_44, UnknownEnum.Value_45, UnknownEnum.Value_46, UnknownEnum.Value_47, UnknownEnum.Value_48, UnknownEnum.Value_49, UnknownEnum.Value_50]];

function FoodHearts(arg0)
{
    switch (arg0)
    {
        default:
            for (var _FoodClassIndex = 0; _FoodClassIndex < 5; _FoodClassIndex++)
            {
                var _FoodArray = global.FoodClasses[_FoodClassIndex];
                
                if (array_contains(_FoodArray, arg0))
                    return 2 + _FoodClassIndex;
            }
            
            break;
        
        case UnknownEnum.Value_51:
            return global.Challenges[UnknownEnum.Value_0] ? 5 : 16;
    }
}

function Food_PickItem(arg0)
{
    var _FoodArray = global.FoodClasses[arg0];
    var _FoodItems = array_length(_FoodArray);
    return global.FoodClasses[arg0][irandom(_FoodItems - 1)];
}

function Food_PickClass(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_2:
            return choose(1, 2, 3, 4);
        
        case UnknownEnum.Value_4:
            return choose(1, 2, 2, 3, 3, 4, 4);
        
        case UnknownEnum.Value_5:
            return choose(2, 3);
        
        case UnknownEnum.Value_6:
            return choose(3, 4);
        
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_8:
            return 4;
        
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_16:
            return 0;
        
        case UnknownEnum.Value_17:
            return choose(0, 0, 0, 0, 1);
        
        case UnknownEnum.Value_18:
            return choose(0, 0, 1, 1, 2);
    }
    
    return choose(0, 0, 1);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_34,
    Value_35,
    Value_36,
    Value_37,
    Value_38,
    Value_39,
    Value_40,
    Value_41,
    Value_42,
    Value_43,
    Value_44,
    Value_45,
    Value_46,
    Value_47,
    Value_48,
    Value_49,
    Value_50,
    Value_51
}
