# Construct Insights from an NDS With the `[]`s

## Introduction

In this lab we're going to generate our first insight: how many pieces are in
the vending machine. You're then going to complete a lab where we calculate how
much money the directors' movies made.

To accomplish this, we're going to continue following the strategy we described
a few lessons ago:

> 2. Use [] to verify your understanding from Step 1
>   * Print values to verify your understanding
>   * Leave code comments and documentation for yourself

The good thing is that there's nothing new to learn here. Based on what we saw
in the NDS and what you know about REPETITION and `Array` syntax, we have all we
need! Let's answer the question: "***How many pieces of snacks are in this
vending machine?***"

## Building on NDS Exploring Code

In the previous lesson we noted that code you write to explore an NDS is rarely
wasted.

```ruby
vm = [[[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies", :pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip Cookies", :pieces=>3}], [{:name=>"Tooth-Melters", :pieces=>12}, {:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters", :pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}], [{:name=>"Gummy Sour Apple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy Apple", :pieces=>1}]], [[{:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange Drink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}], [{:name=>"Mints", :pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US Mints", :pieces=>99}]]]


row_index = 0
while row_index < vm.length do
  puts "Row #{row_index} has #{vm[row_index]} columns"

  column_index = 0
  while column_index < vm[row_index].length do
    coord = "#{row_index}, #{column_index}"
    inner_len = vm[row_index][column_index].length
    # Remember \t is a TAB character for indentation
    puts "\tCoordinate [#{coord}] points to an #{vm[row_index][column_index].class} of length #{inner_len}"

    inner_index = 0
    while inner_index < inner_len do
      puts "\t\t (#{coord}, #{inner_len}) is: #{vm[row_index][column_index][inner_index]}"
      inner_index += 1
    end

    column_index += 1
  end

  row_index += 1
end
```

Outputs:

```text
Row 0 has [[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies", :pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip Cookies", :pieces=>3}], [{:name=>"Tooth-Melters", :pieces=>12}, {:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters", :pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}], [{:name=>"Gummy Sour Apple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy Apple", :pieces=>1}]] columns
	Coordinate [0, 0] points to an Array of length 4
		 (0, 0, 4) is: {:name=>"Vanilla Cookies", :pieces=>3}
		 (0, 0, 4) is: {:name=>"Pistachio Cookies", :pieces=>3}
		 (0, 0, 4) is: {:name=>"Chocolate Cookies", :pieces=>3}
		 (0, 0, 4) is: {:name=>"Chocolate Chip Cookies", :pieces=>3}
	Coordinate [0, 1] points to an Array of length 4
		 (0, 1, 4) is: {:name=>"Tooth-Melters", :pieces=>12}
		 (0, 1, 4) is: {:name=>"Tooth-Destroyers", :pieces=>12}
		 (0, 1, 4) is: {:name=>"Enamel Eaters", :pieces=>12}
		 (0, 1, 4) is: {:name=>"Dentist's Nighmare", :pieces=>20}
	Coordinate [0, 2] points to an Array of length 3
		 (0, 2, 3) is: {:name=>"Gummy Sour Apple", :pieces=>3}
		 (0, 2, 3) is: {:name=>"Gummy Apple", :pieces=>5}
		 (0, 2, 3) is: {:name=>"Gummy Moldy Apple", :pieces=>1}
Row 1 has [[{:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange Drink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}], [{:name=>"Mints", :pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US Mints", :pieces=>99}]] columns
	Coordinate [1, 0] points to an Array of length 3
		 (1, 0, 3) is: {:name=>"Grape Drink", :pieces=>1}
		 (1, 0, 3) is: {:name=>"Orange Drink", :pieces=>1}
		 (1, 0, 3) is: {:name=>"Pineapple Drink", :pieces=>1}
	Coordinate [1, 1] points to an Array of length 3
		 (1, 1, 3) is: {:name=>"Mints", :pieces=>13}
		 (1, 1, 3) is: {:name=>"Curiously Toxic Mints", :pieces=>1000}
		 (1, 1, 3) is: {:name=>"US Mints", :pieces=>99}
```

Based on this code and its output, we can slowly step toward a model of how to
get the piece counts we need. As part of our strategy we're still printing out
useful "debug" data to the screen. In that debug data we see a way forward.
Instead of printing out:

`(1, 0, 3) is: {:name=>"Grape Drink", :pieces=>1}`

we can take the value pointed to by `:pieces` and add it to a grand total.
We'll build on the code we just demonstrated above, and add a few code comments
to help us remember what's happening inside our code.

```ruby
vm = [[[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies", :pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip Cookies", :pieces=>3}], [{:name=>"Tooth-Melters", :pieces=>12}, {:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters", :pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}], [{:name=>"Gummy Sour Apple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy Apple", :pieces=>1}]], [[{:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange Drink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}], [{:name=>"Mints", :pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US Mints", :pieces=>99}]]]


grand_piece_total = 0
row_index = 0
while row_index < vm.length do
  column_index = 0
  while column_index < vm[row_index].length do
    inner_len = vm[row_index][column_index].length
    inner_index = 0
    while inner_index < inner_len do
      # Explanation!
      # vm[row][column][spinner]
      # spinner is full of Hashes with keys :pieces and :name
      grand_piece_total += vm[row_index][column_index][inner_index][:pieces]
      inner_index += 1
    end
    column_index += 1
  end
  row_index += 1
end

p grand_piece_total #=> 1192
```

Look at that! It's an _insight_! There are `1192` pieces!

## Lab

In this lab you're going to work through the directors database and create a
`Hash` that records the director's name as a key, and the total grosses of all of their
movies as the value. For example:

```ruby
hash = {
  "1st Director's Name"=>1234567890,
  "2nd Director's Name"=>1234577890,
  "3rd Director's Name"=>1234709136,
  ...
}
```

## Conclusion

In this lesson, we used the "raw" or "basic" `Array` and `Hash` methods to
retrieve data out of an NDS. We even generated an insight: "number of pieces in
the vending machine." Not bad!

But our code is notably lacking any methods. We've not done anything to make
our code _abstract_. The code we've written gets the job done, but all that
`[]` everywhere is hard for human eyes to read. Furthermore, without our
helpful comment that explains:

```ruby
# vm[row][column][spinner]
# spinner is full of Hashes with keys :pieces and :name
```

our code is very hard to read, understand, and maintain. To make this code
better _for other humans_, we'll turn to step three of our strategy.