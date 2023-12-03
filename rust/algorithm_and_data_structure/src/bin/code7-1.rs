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
    let mut result = 0;
    let mut x_updated = x;
    for i in 0..num
    {
        // The number of coin in case with no number limit
        let mut add = x_updated / value[i];

        // Considering the number limit
        if add > data_a[i]
        {
            add = data_a[i];
        }

        println!("Coin: {}, number of coins added: {}", value[i], add);

        // Calculate the rest of cost and add number of coins
        x_updated = x_updated - value[i] * add;
        result = result + add; 
    }

    println!("Total number of coins needed: {}", result);

}