use std::convert::TryInto;

use common;

fn main() {


    let value = vec![500, 100, 50, 10, 5, 1];

    // Get input
    println!("Type a number: ");
    let x: u64 = common::read_input_u64();

    let num: usize = 6;

    println!("Type a number of each coin: ");
    let mut data_a = Vec::with_capacity(num);
    data_a.resize(num, 0);
    for i in 0..num {data_a[i] = common::read_input_u64();}

    // Check input data
    println!("Check input data:");
    for val in data_a.iter() { println!("{}", val);}

    // Greedy method
    let result = 0;
    for i in 0..num
    {
        // The number of coin in case with no number limit
        let add = x / value[i];

        // Considering the number limit
        if add > data_a[i]
        {
            add = data_a[i];
        }

        // Calculate the rest of cost and add number of coins
        x = x - value[i] * add;
        result = result + add; 
    }

    println!("{}", result);

}